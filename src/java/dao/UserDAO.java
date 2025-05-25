/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.mysql.cj.x.protobuf.MysqlxSql;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    // Kiểm tra thông tin đăng nhập
    public static boolean validateUser(String username, String rawPassword) {
        String sql = "SELECT PasswordHash FROM users WHERE username = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
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
    //cập nhật mật khẩu mới
    public boolean updatePassword(String username, String newPassword){
        String sql = "UPDATE users SET PasswordHash = ? WHERE Username = ?";
        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, username);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
