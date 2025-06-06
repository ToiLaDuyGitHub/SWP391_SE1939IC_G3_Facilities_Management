/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.Material;
import util.DBUtil;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Category;
import model.MaterialCondition;
import model.SubCategory;
import model.Supplier;

/**
 *
 * @author Admin
 */
public class MaterialDAO {

    public List<Material> getAllMaterials() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT f.MaterialID, f.MaterialName, f.Quantity, f.Image, f.Detail, " +
                     "c.CategoryID, c.CategoryName, " +
                     "sc.SubcategoryID, sc.SubcategoryName, " +
                     "s.SupplierID, s.SupplierName, " +
                     "fc.NewQuantity, fc.UsableQuantity, fc.BrokenQuantity " +
                     "FROM materials f " +
                     "LEFT JOIN categories c ON f.CategoryID = c.CategoryID " +
                     "LEFT JOIN subcategories sc ON f.SubcategoryID = sc.SubcategoryID " +
                     "LEFT JOIN suppliers s ON f.SupplierID = s.SupplierID " +
                     "LEFT JOIN materialconditions fc ON f.MaterialID = fc.MaterialID";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Material material = new Material();

                material.setMaterialID(rs.getInt("MaterialID"));
                material.setMaterialName(rs.getString("MaterialName"));
                material.setCategory(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
                material.setSubcategory(new SubCategory(rs.getInt("SubcategoryID"), rs.getInt("CategoryID"), rs.getString("SubcategoryName")));
                material.setSupplierID(new Supplier(rs.getInt("SupplierID"), rs.getString("SupplierName"), null, null));
                material.setQuantity(rs.getInt("Quantity"));
                material.setImage(rs.getString("Image"));
                material.setDetail(rs.getString("Detail"));

                MaterialCondition condition = new MaterialCondition(
                    rs.getInt("MaterialID"),
                    rs.getInt("NewQuantity"),
                    rs.getInt("UsableQuantity"),
                    rs.getInt("BrokenQuantity")
                );
                material.setCondition(condition);

                list.add(material);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm vật tư mới
    public void addMaterial(String MaterialName, int SubcategoryID, String SupplierName,
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
            String insertMaterialSQL = "INSERT INTO materials (MaterialName, CategoryID, SubcategoryID, SupplierID, Image, Quantity) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertMaterialSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, MaterialName);
            stmt.setInt(2, CategoryID);
            stmt.setInt(3, SubcategoryID);
            stmt.setInt(4, supplierId);
            stmt.setString(5, Image);
            stmt.setInt(6, totalQuantity);
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            int materialId = 0;
            if (rs.next()) {
                materialId = rs.getInt(1);
            }
            rs.close();
            stmt.close();

            // Thêm trạng thái vật tư
            String insertConditionSQL = "INSERT INTO materialconditions (MaterialID, NewQuantity, UsableQuantity, BrokenQuantity) VALUES (?, ?, ?, 0)";
            stmt = conn.prepareStatement(insertConditionSQL);
            stmt.setInt(1, materialId);
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
    public Material getMaterialByName(String materialName) {
    String sql = "SELECT f.*, c.CategoryName, sc.SubcategoryName, sup.SupplierName, sup.Address, sup.PhoneNum, fc.NewQuantity, fc.UsableQuantity, fc.BrokenQuantity "
            + "FROM materials f "
            + "LEFT JOIN categories c ON f.CategoryID = c.CategoryID "
            + "LEFT JOIN subcategories sc ON f.SubcategoryID = sc.SubcategoryID "
            + "LEFT JOIN suppliers sup ON f.SupplierID = sup.SupplierID "
            + "LEFT JOIN materialconditions fc ON f.MaterialID = fc.MaterialID "
            + "WHERE TRIM(LOWER(f.MaterialName)) = ?";

    try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, materialName);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Material material = new Material();
            material.setMaterialID(rs.getInt("MaterialID"));
            material.setMaterialName(rs.getString("MaterialName"));
            material.setCategory(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
            material.setSubcategory(new SubCategory(rs.getInt("SubcategoryID"), rs.getInt("CategoryID"), rs.getString("SubcategoryName")));
            material.setSupplierID(new Supplier(rs.getInt("SupplierID"), rs.getString("SupplierName"), rs.getString("Address"), rs.getString("PhoneNum")));
            material.setQuantity(rs.getInt("Quantity"));
            material.setImage(rs.getString("Image"));

            // Gán đối tượng MaterialCondition
            MaterialCondition condition = new MaterialCondition(
                    rs.getInt("MaterialID"),
                    rs.getInt("NewQuantity"),
                    rs.getInt("UsableQuantity"),
                    rs.getInt("BrokenQuantity")
            );
            material.setCondition(condition); // Gán đối tượng thay vì chuỗi
            return material;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
    
    
    public List<Material> suggestMaterialsByName(String materialName) {
    List<Material> materials = new ArrayList<>();
    String sql = "SELECT f.*, c.CategoryName, sc.SubcategoryName, sup.SupplierName, sup.Address, sup.PhoneNum, fc.NewQuantity, fc.UsableQuantity, fc.BrokenQuantity "
            + "FROM materials f "
            + "LEFT JOIN categories c ON f.CategoryID = c.CategoryID "
            + "LEFT JOIN subcategories sc ON f.SubcategoryID = sc.SubcategoryID "
            + "LEFT JOIN suppliers sup ON f.SupplierID = sup.SupplierID "
            + "LEFT JOIN materialconditions fc ON f.MaterialID = fc.MaterialID "
            + "WHERE TRIM(LOWER(f.MaterialName)) LIKE ?";

    try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, materialName.trim().toLowerCase() + "%"); // Tìm các tên bắt đầu bằng từ khóa
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Material material = new Material();
            material.setMaterialID(rs.getInt("MaterialID"));
            material.setMaterialName(rs.getString("MaterialName"));
            material.setCategory(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName")));
            material.setSubcategory(new SubCategory(rs.getInt("SubcategoryID"), rs.getInt("CategoryID"), rs.getString("SubcategoryName")));
            material.setSupplierID(new Supplier(rs.getInt("SupplierID"), rs.getString("SupplierName"), rs.getString("Address"), rs.getString("PhoneNum")));
            material.setQuantity(rs.getInt("Quantity"));
            material.setImage(rs.getString("Image"));

            MaterialCondition condition = new MaterialCondition(
                    rs.getInt("MaterialID"),
                    rs.getInt("NewQuantity"),
                    rs.getInt("UsableQuantity"),
                    rs.getInt("BrokenQuantity")
            );
            material.setCondition(condition);
            materials.add(material);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return materials;
}
    
    // Cập nhật thông tin vật tư trong cơ sở dữ liệu
    public void updateMaterial(int materialID, String materialName, int subcategoryID, String supplierName,
            String supplierAddress, String supplierPhone, String imageUrl, int totalQuantity,
            int newQuantity, int usableQuantity, int brokenQuantity) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // 1. Lấy SupplierID và CategoryID hiện tại của vật tư
            String getMaterialSQL = "SELECT SupplierID, CategoryID FROM materials WHERE MaterialID = ?";
            stmt = conn.prepareStatement(getMaterialSQL);
            stmt.setInt(1, materialID);
            rs = stmt.executeQuery();
            int supplierID = 0;
            int categoryID = 0;
            if (rs.next()) {
                supplierID = rs.getInt("SupplierID");
                categoryID = rs.getInt("CategoryID");
            } else {
                throw new SQLException("Không tìm thấy vật tư với MaterialID: " + materialID);
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

            // 4. Cập nhật thông tin vật tư trong bảng materials
            String updateMaterialSQL = "UPDATE materials SET MaterialName = ?, CategoryID = ?, SubcategoryID = ?, SupplierID = ?, Image = ?, Quantity = ? WHERE MaterialID = ?";
            stmt = conn.prepareStatement(updateMaterialSQL);
            stmt.setString(1, materialName);
            stmt.setInt(2, categoryID);
            stmt.setInt(3, subcategoryID);
            stmt.setInt(4, supplierID);
            stmt.setString(5, imageUrl);
            stmt.setInt(6, totalQuantity);
            stmt.setInt(7, materialID);
            stmt.executeUpdate();
            stmt.close();

            // 5. Cập nhật trạng thái vật tư trong bảng materialconditions
            String updateConditionSQL = "UPDATE materialconditions SET NewQuantity = ?, UsableQuantity = ?, BrokenQuantity = ? WHERE MaterialID = ?";
            stmt = conn.prepareStatement(updateConditionSQL);
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, usableQuantity);
            stmt.setInt(3, brokenQuantity);
            stmt.setInt(4, materialID);
            stmt.executeUpdate();
            stmt.close();

            conn.commit(); // Xác nhận giao dịch nếu mọi thứ thành công
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); 
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
    public void deleteMaterial(int materialID) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            
            // 1. Lấy SupplierID của vật tư
            String getSupplierSQL = "SELECT SupplierID FROM materials WHERE MaterialID = ?";
            stmt = conn.prepareStatement(getSupplierSQL);
            stmt.setInt(1, materialID);
            rs = stmt.executeQuery();
            int supplierID = 0;
            if (rs.next()) {
                supplierID = rs.getInt("SupplierID");
            } else {
                throw new SQLException("Không tìm thấy vật tư với MaterialID: " + materialID);
            }
            rs.close();
            stmt.close();

            // 2. Xóa các bản ghi liên quan trong bảng records
            String deleteRecordsSQL = "DELETE FROM records WHERE MaterialID = ?";
            stmt = conn.prepareStatement(deleteRecordsSQL);
            stmt.setInt(1, materialID);
            stmt.executeUpdate();
            stmt.close();

            // 3. Xóa trạng thái vật tư trong bảng materialconditions
            String deleteConditionSQL = "DELETE FROM materialconditions WHERE MaterialID = ?";
            stmt = conn.prepareStatement(deleteConditionSQL);
            stmt.setInt(1, materialID);
            stmt.executeUpdate();
            stmt.close();

            // 4. Xóa vật tư trong bảng materials
            String deleteMaterialSQL = "DELETE FROM materials WHERE MaterialID = ?";
            stmt = conn.prepareStatement(deleteMaterialSQL);
            stmt.setInt(1, materialID);
            stmt.executeUpdate();
            stmt.close();

            // 5. Kiểm tra xem Supplier có còn được tham chiếu bởi vật tư nào khác không
            String checkSupplierSQL = "SELECT COUNT(*) FROM materials WHERE SupplierID = ?";
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
