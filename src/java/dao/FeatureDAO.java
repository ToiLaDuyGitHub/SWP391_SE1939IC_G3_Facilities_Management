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
import model.Feature;
import util.DBUtil;

/**
 *
 * @author ADMIN
 */
public class FeatureDAO {

    // Lấy danh sách tất cả các chức năng
    public List<Feature> getAllFeatures() throws SQLException {
        List<Feature> features = new ArrayList<>();
        String query = "SELECT UrlID, UrlName FROM feature";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int urlID = rs.getInt("UrlID");
                String urlName = rs.getString("UrlName");
                features.add(new Feature(urlID, urlName, null)); // Không cần Url
            }
        }
        return features;
    }

    // Kiểm tra quyền của role đối với một chức năng
    public boolean hasPermission(int featureID, int roleID) throws SQLException {
        String query = "SELECT COUNT(*) FROM role_feature WHERE UrlID = ? AND RoleID = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, featureID);
            stmt.setInt(2, roleID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Nếu có bản ghi trong role_feature, vai trò có quyền
                }
            }
        }
        return false; // Mặc định không có quyền nếu không tìm thấy
    }

    // Thêm quyền cho role đối với một chức năng
    public void addPermission(int featureID, int roleID) throws SQLException {
        String query = "INSERT INTO role_feature (UrlID, RoleID) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, featureID);
            stmt.setInt(2, roleID);
            stmt.executeUpdate();
        }
    }

    // Xóa quyền của role đối với một chức năng
    public void removePermission(int featureID, int roleID) throws SQLException {
        String query = "DELETE FROM role_feature WHERE UrlID = ? AND RoleID = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, featureID);
            stmt.setInt(2, roleID);
            stmt.executeUpdate();
        }
    }

    // Lấy danh sách chức năng của một vai trò
    public List<Feature> getFeaturesByRole(int roleID) throws SQLException {
        List<Feature> features = new ArrayList<>();
        String query = "SELECT f.UrlID, f.UrlName, f.Url FROM feature f "
                + "JOIN role_feature rf ON f.UrlID = rf.UrlID "
                + "WHERE rf.RoleID = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, roleID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int urlID = rs.getInt("UrlID");
                    String urlName = rs.getString("UrlName");
                    String url = rs.getString("Url");
                    features.add(new Feature(urlID, urlName, url));
                }
            }
        }
        return features;
    }
}
