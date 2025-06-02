/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.Facility;
import util.DBUtil;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Category;
import model.FacilityCondition;
import model.SubCategory;
import model.Supplier;

/**
 *
 * @author Admin
 */
public class FacilityDAO {

    public List<Facility> getAllFacilities() {
        List<Facility> list = new ArrayList<>();
        String sql = "SELECT f.FacilityID, f.FacilityName, f.Quantity,f.Image , c.CategoryName, s.SupplierName, c.CategoryID, s.SupplierID \n"
                + "FROM facilities f \n"
                + "LEFT JOIN categories c ON f.CategoryID = c.CategoryID\n"
                + "LEFT JOIN subcategories sc ON f.SubcategoryID = sc.SubcategoryID\n"
                + "LEFT JOIN suppliers s ON f.SupplierID = s.SupplierID";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Facility facility = new Facility();

                facility.setFacilityID(rs.getInt("FacilityID"));
                facility.setFacilityName(rs.getString("FacilityName"));
                facility.setCategory(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
                facility.setSupplierID(new Supplier(rs.getInt("SupplierID"), rs.getString("SupplierName"), null, null));
                facility.setQuantity(rs.getInt("Quantity"));
//                int newQuantity = rs.getInt("NewQuantity");
//                int usableQuantity = rs.getInt("UsableQuantity");
//                int brokenQuantity = rs.getInt("BrokenQuantity");
                facility.setImage(rs.getString("Image"));
                list.add(facility);

            }
        } catch (SQLException e) {

        }
        return list;

    }

    public Facility getFacilityById(int facilityId) {
        String sql = "SELECT f.*, c.CategoryName, s.SubcategoryName, sup.SupplierName "
                + "FROM facilities f "
                + "JOIN categories c ON f.CategoryID = c.CategoryID "
                + "JOIN subcategories s ON f.SubcategoryID = s.SubcategoryID "
                + "JOIN suppliers sup ON f.SupplierID = sup.SupplierID "
                + "WHERE f.FacilityID = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            stmt.setInt(1, facilityId);

            if (rs.next()) {
                Facility facility = new Facility();
                facility.setFacilityID(rs.getInt("FacilityID"));
                facility.setFacilityName(rs.getString("FacilityName"));
                facility.setCategory(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
                facility.setSupplierID(new Supplier(rs.getInt("SupplierID"), rs.getString("SupplierName"), null, null));
                facility.setQuantity(rs.getInt("Quantity"));
                facility.setImage(rs.getString("Image"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm vật tư mới
    public void addFacility(String FacilityName, int SubcategoryID, String SupplierName,
            String Address, String PhoneNum, String Image,
            int totalQuantity, int NewQuantity, int UsableQuantity) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Lấy CategoryID từ SubcategoryID (không thể gộp bước này)
            String getCategorySQL = "SELECT CategoryID FROM subcategories WHERE SubcategoryID = ?";
            stmt = conn.prepareStatement(getCategorySQL);
            stmt.setInt(1, SubcategoryID);
            rs = stmt.executeQuery();
            int CategoryID = 0;
            if (rs.next()) {
                CategoryID = rs.getInt("CategoryID");
            } else {
                throw new SQLException("Không tìm thấy danh mục con với SubcategoryID: " + SubcategoryID);
            }
            rs.close();
            stmt.close();

            String insertSupplierSQL = "INSERT INTO suppliers (SupplierName, Address, PhoneNum) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertSupplierSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, SupplierName);
            stmt.setString(2, Address);
            stmt.setString(3, PhoneNum);
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            int supplierId = 0;
            if (rs.next()) {
                supplierId = rs.getInt(1);
            }
            rs.close();
            stmt.close();

            // Thêm vật tư
            String insertFacilitySQL = "INSERT INTO facilities (FacilityName, CategoryID, SubcategoryID, SupplierID, Image, Quantity) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertFacilitySQL, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, FacilityName);
            stmt.setInt(2, CategoryID);
            stmt.setInt(3, SubcategoryID);
            stmt.setInt(4, supplierId);
            stmt.setString(5, Image);
            stmt.setInt(6, totalQuantity);
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            int facilityId = 0;
            if (rs.next()) {
                facilityId = rs.getInt(1);
            }
            rs.close();
            stmt.close();

            // Thêm trạng thái vật tư
            String insertConditionSQL = "INSERT INTO facilityconditions (FacilityID, NewQuantity, UsableQuantity, BrokenQuantity) VALUES (?, ?, ?, 0)";
            stmt = conn.prepareStatement(insertConditionSQL);
            stmt.setInt(1, facilityId);
            stmt.setInt(2, NewQuantity);
            stmt.setInt(3, UsableQuantity);
            stmt.executeUpdate();
            stmt.close();

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e; // Ném lại ngoại lệ để Servlet xử lý
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }

    }

    // Tìm vật tư theo tên
    public Facility getFacilityByName(String facilityName) {
    String sql = "SELECT f.*, c.CategoryName, sc.SubcategoryName, sup.SupplierName, sup.Address, sup.PhoneNum, fc.NewQuantity, fc.UsableQuantity, fc.BrokenQuantity "
            + "FROM facilities f "
            + "LEFT JOIN categories c ON f.CategoryID = c.CategoryID "
            + "LEFT JOIN subcategories sc ON f.SubcategoryID = sc.SubcategoryID "
            + "LEFT JOIN suppliers sup ON f.SupplierID = sup.SupplierID "
            + "LEFT JOIN facilityconditions fc ON f.FacilityID = fc.FacilityID "
            + "WHERE TRIM(LOWER(f.FacilityName)) = ?";

    try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, facilityName);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Facility facility = new Facility();
            facility.setFacilityID(rs.getInt("FacilityID"));
            facility.setFacilityName(rs.getString("FacilityName"));
            facility.setCategory(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
            facility.setSubcategory(new SubCategory(rs.getInt("SubcategoryID"), rs.getInt("CategoryID"), rs.getString("SubcategoryName")));
            facility.setSupplierID(new Supplier(rs.getInt("SupplierID"), rs.getString("SupplierName"), rs.getString("Address"), rs.getString("PhoneNum")));
            facility.setQuantity(rs.getInt("Quantity"));
            facility.setImage(rs.getString("Image"));

            // Gán đối tượng FacilityCondition
            FacilityCondition condition = new FacilityCondition(
                    rs.getInt("FacilityID"),
                    rs.getInt("NewQuantity"),
                    rs.getInt("UsableQuantity"),
                    rs.getInt("BrokenQuantity")
            );
            facility.setCondition(condition); // Gán đối tượng thay vì chuỗi
            return facility;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
    
    // Cập nhật thông tin vật tư trong cơ sở dữ liệu
    public void updateFacility(int facilityID, String facilityName, int subcategoryID, String supplierName,
            String supplierAddress, String supplierPhone, String imageUrl, int totalQuantity,
            int newQuantity, int usableQuantity, int brokenQuantity) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Bắt đầu giao dịch để đảm bảo tính toàn vẹn dữ liệu

            // 1. Lấy SupplierID và CategoryID hiện tại của vật tư
            String getFacilitySQL = "SELECT SupplierID, CategoryID FROM facilities WHERE FacilityID = ?";
            stmt = conn.prepareStatement(getFacilitySQL);
            stmt.setInt(1, facilityID);
            rs = stmt.executeQuery();
            int supplierID = 0;
            int categoryID = 0;
            if (rs.next()) {
                supplierID = rs.getInt("SupplierID");
                categoryID = rs.getInt("CategoryID");
            } else {
                throw new SQLException("Không tìm thấy vật tư với FacilityID: " + facilityID);
            }
            rs.close();
            stmt.close();

            // 2. Lấy CategoryID từ SubcategoryID (nếu subcategoryID thay đổi)
            String getCategorySQL = "SELECT CategoryID FROM subcategories WHERE SubcategoryID = ?";
            stmt = conn.prepareStatement(getCategorySQL);
            stmt.setInt(1, subcategoryID);
            rs = stmt.executeQuery();
            if (rs.next()) {
                categoryID = rs.getInt("CategoryID");
            } else {
                throw new SQLException("Không tìm thấy danh mục con với SubcategoryID: " + subcategoryID);
            }
            rs.close();
            stmt.close();

            // 3. Cập nhật thông tin nhà cung cấp trong bảng suppliers
            String updateSupplierSQL = "UPDATE suppliers SET SupplierName = ?, Address = ?, PhoneNum = ? WHERE SupplierID = ?";
            stmt = conn.prepareStatement(updateSupplierSQL);
            stmt.setString(1, supplierName);
            stmt.setString(2, supplierAddress);
            stmt.setString(3, supplierPhone);
            stmt.setInt(4, supplierID);
            stmt.executeUpdate();
            stmt.close();

            // 4. Cập nhật thông tin vật tư trong bảng facilities
            String updateFacilitySQL = "UPDATE facilities SET FacilityName = ?, CategoryID = ?, SubcategoryID = ?, SupplierID = ?, Image = ?, Quantity = ? WHERE FacilityID = ?";
            stmt = conn.prepareStatement(updateFacilitySQL);
            stmt.setString(1, facilityName);
            stmt.setInt(2, categoryID);
            stmt.setInt(3, subcategoryID);
            stmt.setInt(4, supplierID);
            stmt.setString(5, imageUrl);
            stmt.setInt(6, totalQuantity);
            stmt.setInt(7, facilityID);
            stmt.executeUpdate();
            stmt.close();

            // 5. Cập nhật trạng thái vật tư trong bảng facilityconditions
            String updateConditionSQL = "UPDATE facilityconditions SET NewQuantity = ?, UsableQuantity = ?, BrokenQuantity = ? WHERE FacilityID = ?";
            stmt = conn.prepareStatement(updateConditionSQL);
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, usableQuantity);
            stmt.setInt(3, brokenQuantity);
            stmt.setInt(4, facilityID);
            stmt.executeUpdate();
            stmt.close();

            conn.commit(); // Xác nhận giao dịch nếu mọi thứ thành công
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Hủy bỏ giao dịch nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e; // Ném ngoại lệ để servlet xử lý
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
    // Xóa vật tư
    public void deleteFacility(int facilityID) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            
            // 1. Lấy SupplierID của vật tư
            String getSupplierSQL = "SELECT SupplierID FROM facilities WHERE FacilityID = ?";
            stmt = conn.prepareStatement(getSupplierSQL);
            stmt.setInt(1, facilityID);
            rs = stmt.executeQuery();
            int supplierID = 0;
            if (rs.next()) {
                supplierID = rs.getInt("SupplierID");
            } else {
                throw new SQLException("Không tìm thấy vật tư với FacilityID: " + facilityID);
            }
            rs.close();
            stmt.close();

            // 2. Xóa các bản ghi liên quan trong bảng records
            String deleteRecordsSQL = "DELETE FROM records WHERE FacilityID = ?";
            stmt = conn.prepareStatement(deleteRecordsSQL);
            stmt.setInt(1, facilityID);
            stmt.executeUpdate();
            stmt.close();

            // 3. Xóa trạng thái vật tư trong bảng facilityconditions
            String deleteConditionSQL = "DELETE FROM facilityconditions WHERE FacilityID = ?";
            stmt = conn.prepareStatement(deleteConditionSQL);
            stmt.setInt(1, facilityID);
            stmt.executeUpdate();
            stmt.close();

            // 4. Xóa vật tư trong bảng facilities
            String deleteFacilitySQL = "DELETE FROM facilities WHERE FacilityID = ?";
            stmt = conn.prepareStatement(deleteFacilitySQL);
            stmt.setInt(1, facilityID);
            stmt.executeUpdate();
            stmt.close();

            // 5. Kiểm tra xem Supplier có còn được tham chiếu bởi vật tư nào khác không
            String checkSupplierSQL = "SELECT COUNT(*) FROM facilities WHERE SupplierID = ?";
            stmt = conn.prepareStatement(checkSupplierSQL);
            stmt.setInt(1, supplierID);
            rs = stmt.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            stmt.close();

            // Nếu không còn vật tư nào tham chiếu đến Supplier, xóa Supplier
            if (count == 0) {
                String deleteSupplierSQL = "DELETE FROM suppliers WHERE SupplierID = ?";
                stmt = conn.prepareStatement(deleteSupplierSQL);
                stmt.setInt(1, supplierID);
                stmt.executeUpdate();
                stmt.close();
            }

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Hủy bỏ giao dịch nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e; // Ném ngoại lệ để servlet xử lý
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
}
