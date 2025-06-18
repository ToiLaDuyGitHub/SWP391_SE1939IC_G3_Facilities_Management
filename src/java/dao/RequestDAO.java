/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ExportRequest;
import model.ExportRequestMaterial;
import model.dto.RequestDTO;
import util.DBUtil;

/**
 *
 * @author ADMIN
 */
public class RequestDAO {
    public List<RequestDTO> getAllRequests() throws Exception {
        List<RequestDTO> requests = new ArrayList<>();
        String sql = "SELECT \n"
                + "    'Export' AS request_type,\n"
                + "    er.ExportRequestID AS request_id,\n"
                + "    er.RequestCode AS request_code,\n"
                + "    er.CreatedDate AS created_date,\n"
                + "    CONCAT(uc.LastName, ' ', uc.FirstName) AS created_by_name, \n"
                + "    CONCAT(ua.LastName, ' ', ua.FirstName) AS approved_by_name, \n"
                + "    er.Status AS status\n"
                + "FROM exportrequests er\n"
                + "LEFT JOIN users uc ON er.CreatedByID = uc.UserID\n"
                + "LEFT JOIN users ua ON er.ApprovedByID = ua.UserID\n"
                + "UNION\n"
                + "SELECT \n"
                + "    'Import' AS request_type,\n"
                + "    ih.ImportHistoryID AS request_id,\n"
                + "    ih.RequestCode AS request_code,\n"
                + "    ih.ImportDate AS created_date,\n"
                + "    CONCAT(uc.LastName, ' ', uc.FirstName) AS created_by_name,\n"
                + "    NULL AS approved_by_name,\n"
                + "    1 AS status\n"
                + "FROM importhistory ih\n"
                + "LEFT JOIN users uc ON ih.ImportedByID = uc.UserID\n"
                + "UNION\n"
                + "SELECT \n"
                + "    'Repair' AS request_type,\n"
                + "    rr.RepairRequestID AS request_id,\n"
                + "    rr.RequestCode AS request_code,\n"
                + "    rr.CreatedDate AS created_date,\n"
                + "    CONCAT(uc.LastName, ' ', uc.FirstName) AS created_by_name,\n"
                + "    CONCAT(ua.LastName, ' ', ua.FirstName) AS approved_by_name, \n"
                + "    rr.Status AS status\n"
                + "FROM repairrequests rr\n"
                + "LEFT JOIN users uc ON rr.CreatedByID = uc.UserID\n"
                + "LEFT JOIN users ua ON rr.ApprovedByID = ua.UserID\n"
                + "UNION\n"
                + "SELECT \n"
                + "    'Return' AS request_type,\n"
                + "    rr.ReturnRequestID AS request_id,\n"
                + "    rr.RequestCode AS request_code,\n"
                + "    rr.CreatedDate AS created_date,\n"
                + "    CONCAT(uc.LastName, ' ', uc.FirstName) AS created_by_name, \n"
                + "    CONCAT(ua.LastName, ' ', ua.FirstName) AS approved_by_name, \n"
                + "    rr.Status AS status\n"
                + "FROM returnrequests rr\n"
                + "LEFT JOIN users uc ON rr.CreatedByID = uc.UserID\n"
                + "LEFT JOIN users ua ON rr.InputByID = ua.UserID\n"
                + "UNION\n"
                + "SELECT \n"
                + "    'Purchase' AS request_type,\n"
                + "    pr.PurchaseRequestID AS request_id,\n"
                + "    pr.RequestCode AS request_code,\n"
                + "    pr.CreatedDate AS created_date,\n"
                + "    CONCAT(uc.LastName, ' ', uc.FirstName) AS created_by_name, \n"
                + "    CONCAT(ua.LastName, ' ', ua.FirstName) AS approved_by_name, \n"
                + "    pr.Status AS status\n"
                + "FROM purchaserequests pr\n"
                + "LEFT JOIN users uc ON pr.CreatedByID = uc.UserID\n"
                + "LEFT JOIN users ua ON pr.ApprovedByID = ua.UserID\n"
                + "ORDER BY created_date DESC";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RequestDTO request = new RequestDTO();
                request.setRequestType(rs.getString("request_type"));
                request.setRequestId(rs.getInt("request_id"));
                request.setRequestCode(rs.getString("request_code"));
                request.setCreatedDate(rs.getTimestamp("created_date"));
                request.setCreatedByName(rs.getString("created_by_name"));
                request.setApprovedByName(rs.getString("approved_by_name"));
                request.setStatus(rs.getInt("status"));

                String statusText;
                switch (rs.getInt("status")) {
                    case 0:
                        statusText = "Chưa duyệt";
                        break;
                    case 1:
                        statusText = "Đã duyệt";
                        break;
                    case 2:
                        statusText = "Từ chối";
                        break;
                    default:
                        statusText = "Không xác định";
                }
                request.setStatusText(statusText);

                requests.add(request);
            }
        }
        return requests;
    }
    
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
