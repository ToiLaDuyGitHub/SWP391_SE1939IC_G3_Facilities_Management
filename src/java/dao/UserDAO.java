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
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Vector;
import model.User;
import model.dto.User_Role;
import util.DBUtil;
import util.PasswordUtil;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class UserDAO {

    private Argon2 argon2;

    public UserDAO() {
        argon2 = Argon2Factory.create();
    }

    // Lấy thông tin người dùng và vai trò
    public User_Role getUserWithRole(String username) {
        String sql = "SELECT u.FirstName, u.LastName, u.Username, u.PhoneNum, u.Address, r.RoleName "
                + "FROM users u "
                + "LEFT JOIN roles r ON u.RoleID = r.RoleID "
                + "WHERE u.Username = ?";

        try (
                Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String firstName = rs.getString("FirstName");
                    String lastName = rs.getString("LastName");
                    String userName = rs.getString("Username");
                    String phoneNum = rs.getString("PhoneNum");
                    String address = rs.getString("Address");
                    String roleName = rs.getString("RoleName");
                    return new User_Role(userName, firstName, lastName, phoneNum, address, roleName);
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

    public void changePassword(String username, String passwordHash) {
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

    public Vector<User> getAllUser() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "select * from [users]";
        try {
            Connection conn = DBUtil.getConnection();
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int userID = rs.getInt("userID");
                String username = rs.getString("username");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                int roleID = rs.getInt("roleID");
                String phoneNum = rs.getString("phoneNum");
                boolean isActive = rs.getBoolean("isActive");

                User u = new User(userID, username, firstName, lastName, phoneNum, isActive);
                users.add(u);
            }
            return users;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
     public Vector<User> getUserByName(String name) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> customers = new Vector<>();
        String sql = "select * from [user]\n"
                + "where role_id = 1 and [fullname] LIKE ?";
        try {
            Connection conn = DBUtil.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            
            while (rs.next()) {
                User u= new User();
                u.setUserID(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setFirstName(rs.getString("firstName"));
                u.setLastName(rs.getString("lastName"));
                u.setPhoneNum(rs.getString("phoneNum"));
                u.setRoleID(rs.getInt("roleID"));
                u.setIsActive(rs.getBoolean("IsActive"));
                System.out.println(u);

                customers.add(u);
            }
            return customers;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } 
        return null;
    }


         public int insertUser(User u) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int generatedId = -1;

        String sql = "INSERT INTO [dbo].[product]\n"
                + "           ([name]\n"
                + "           ,[price]\n"
                + "           ,[quantity]\n"
                + "           ,[description]\n"
                + "           ,[image_url]\n"
                + "           ,[brand_id]\n"
                + "           ,[release_date])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBUtil.getConnection();
            stm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setInt(1,u.getUserID());
            stm.setString(2, u.getUsername());
            stm.setString(3, u.getFirstName());
            stm.setString(4, u.getLastName());
            stm.setString(5, u.getPhoneNum());
            stm.setInt(6, u.getRoleID());
            stm.setBoolean(7, u.isIsActive());
            stm.executeUpdate();

            //get generatedId
            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return generatedId;
    }
         
     public void updateProduct(User u, int pid) {
        PreparedStatement stm = null;

        String sql = "UPDATE [dbo].[product]\n"
                + "   SET [name] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[quantity] = ?\n"
                + "      ,[release_date] = ?\n"
                + " WHERE id = ?";
        try {
            Connection conn = DBUtil.getConnection();
            stm = conn.prepareStatement(sql);
             stm.setInt(1,u.getUserID());
            stm.setString(2, u.getUsername());
            stm.setString(3, u.getFirstName());
            stm.setString(4, u.getLastName());
            stm.setString(5, u.getPhoneNum());
            stm.setInt(6, u.getRoleID());
            stm.setBoolean(7, u.isIsActive());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }     
    //update thông tin các nhân người dùng
    public void updateUserProfile(String username, String firstName, String lastName, String phone, String address) throws SQLException {
        // Kiểm tra dữ liệu đầu vào
        if (firstName == null || firstName.trim().isEmpty()) {
            throw new IllegalArgumentException("Họ không được để trống.");
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            throw new IllegalArgumentException("Tên không được để trống.");
        }
        if (phone == null || phone.trim().isEmpty() || !isValidPhone(phone)) {
            throw new IllegalArgumentException("Số điện thoại không hợp lệ (phải có 10-11 chữ số và bắt đầu bằng 0).");
        }
        if (address == null || address.trim().isEmpty()) {
            throw new IllegalArgumentException("Địa chỉ không được để trống.");
        }

        // Câu lệnh SQL để cập nhật thông tin người dùng
        String sql = "UPDATE users SET FirstName = ?, LastName = ?, PhoneNum = ?, Address = ? WHERE Username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Gán giá trị cho các tham số
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.setString(5, username);

            // Thực thi câu lệnh cập nhật
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Cập nhật thông tin thất bại, không tìm thấy user: " + username);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Hàm kiểm tra số điện thoại hợp lệ
    private boolean isValidPhone(String phone) {
        if (phone == null) {
            return false;
        }
        // Kiểm tra độ dài: phải từ 10 đến 11 chữ số
        if (phone.length() < 10 || phone.length() > 11) {
            return false;
        }
        // Kiểm tra bắt đầu bằng 0
        if (!phone.startsWith("0")) {
            return false;
        }
        // Kiểm tra tất cả ký tự là số (0-9)
        for (char c : phone.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }
}

