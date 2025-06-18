/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.ExportRequest;
import model.ExportRequestMaterial;
import util.DBUtil;

/**
 *
 * @author ADMIN
 */
public class RequestDao {
    // Tìm UserID của giám đốc (RoleID = 3)
    public int getDirectorUserID() throws SQLException {
        String sql = "SELECT UserID FROM users WHERE RoleID = 3 LIMIT 1";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("UserID");
            }
        }
        return -1; // Trả về -1 nếu không tìm thấy giám đốc
    }

    // Lưu thông tin đơn xuất kho vào bảng exportrequests
    public int createExportRequest(ExportRequest request) throws SQLException {
    String sql = "INSERT INTO exportrequests (CreatedByID, ApprovedByID, Note, Status) VALUES (?, ?, ?, ?)";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
        int directorID = getDirectorUserID();
        if (directorID == -1) {
            throw new SQLException("Không tìm thấy giám đốc để gán người duyệt.");
        }
        stmt.setInt(1, request.getCreatedByID());
        stmt.setInt(2, directorID);
        stmt.setString(3, request.getNote());
        stmt.setInt(4, request.getStatus());
        int rowsAffected = stmt.executeUpdate();
        System.out.println("Rows affected in exportrequests: " + rowsAffected);
        try (ResultSet rs = stmt.getGeneratedKeys()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi tạo ExportRequest: " + e.getMessage());
        e.printStackTrace();
        throw e;
    }
    return -1;
}

    // Lưu danh sách vật tư và số lượng vào bảng exportrequestmaterials
    public void saveExportRequestMaterials(List<ExportRequestMaterial> materials) throws SQLException {
        String sql = "INSERT INTO exportrequestmaterials (ExportRequestID, MaterialID, Quantity) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (ExportRequestMaterial material : materials) {
                stmt.setInt(1, material.getExportRequestID());
                stmt.setInt(2, material.getMaterialID());
                stmt.setInt(3, material.getQuantity());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }
}
