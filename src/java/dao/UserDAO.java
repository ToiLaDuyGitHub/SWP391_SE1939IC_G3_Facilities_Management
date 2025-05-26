/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Calendar;
import model.User;
import model.dto.User_Role;
import util.DBUtil;
import util.PasswordUtil;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class UserDAO {
    private Argon2 argon2;
    
    public UserDAO(){
        argon2 = Argon2Factory.create();
    }

    // Lấy thông tin người dùng và vai trò
    public User_Role getUserWithRole(String username) {
        String sql = "SELECT u.FirstName, u.LastName, u.Username, u.PhoneNum, r.RoleName " +
                     "FROM users u " +
                     "LEFT JOIN roles r ON u.RoleID = r.RoleID " +
                     "WHERE u.Username = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String firstName = rs.getString("FirstName");
                    String lastName = rs.getString("LastName");
                    String userName = rs.getString("Username");
                    String phoneNum = rs.getString("PhoneNum");
                    String roleName = rs.getString("RoleName");

                    return new User_Role(userName, firstName, lastName, phoneNum, roleName);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    // Kiểm tra thông tin đăng nhập
    public static boolean validateUser(String username, String rawPassword) {
        String sql = "SELECT PasswordHash FROM users WHERE username = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("PasswordHash");
                    return PasswordUtil.verifyPassword(storedHash, rawPassword);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Lấy thông tin thời gian resetotp của người dùng
    public static User getUsersResetOTPTime(String username) {
        String sql = "SELECT ResetOTPTime FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Timestamp timestamp = rs.getTimestamp("ResetOTPTime");
                    LocalDateTime resetOTPTime = timestamp != null ? timestamp.toLocalDateTime() : null;
                    return new User(username, resetOTPTime);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateResetOTP(String username, String resetOTP) {
        String sql = "UPDATE users SET ResetOTP = ?, ResetOTPTime = ? WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set các tham số
            stmt.setString(1, resetOTP);
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.HOUR, 7); // Add 7 hours due to GMT+7
            Timestamp expiryTime = new Timestamp(calendar.getTimeInMillis());
            stmt.setTimestamp(2, expiryTime);
            stmt.setString(3, username);

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Cập nhật OTP thất bại, không tìm thấy user: " + username);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkUsernameAndResetOTP(String username, String resetOTP) {
        String sql = "SELECT UserID FROM users WHERE Username = ? AND ResetOTP = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, resetOTP);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void changePassword(String username, String passwordHash){
        String sql = "update users set PasswordHash = ? where Username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set các tham số
            stmt.setString(1, passwordHash);
            stmt.setString(2, username);
            
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Cập nhật mật khẩu thất bại, không tìm thấy user: " + username);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
