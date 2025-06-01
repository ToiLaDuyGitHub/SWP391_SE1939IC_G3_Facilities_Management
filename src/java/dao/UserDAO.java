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
import java.util.ArrayList;
import java.util.List;
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

public List<User> getAllUser() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                User u = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("PhoneNum"),
                    rs.getInt("RoleID"),
                    rs.getBoolean("IsActive")
                );
                users.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public List<User> getUserByName(String name) {
        List<User> customers = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE RoleID = 1 AND (FirstName LIKE ? OR LastName LIKE ? OR CONCAT(FirstName, ' ', LastName) LIKE ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, "%" + name + "%");
            stm.setString(2, "%" + name + "%");
            stm.setString(3, "%" + name + "%");
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User u = new User(
                        rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("PhoneNum"),
                        rs.getInt("RoleID"),
                        rs.getBoolean("IsActive")
                    );
                    customers.add(u);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customers;
    }

    public int insertUser(User u) {
        String sql = "INSERT INTO users (UserID, Username, FirstName, LastName, PhoneNum, RoleID, IsActive) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stm.setInt(1, u.getUserID());
            stm.setString(2, u.getUsername());
            stm.setString(3, u.getFirstName());
            stm.setString(4, u.getLastName());
            stm.setString(5, u.getPhoneNum());
            stm.setInt(6, u.getRoleID());
            stm.setBoolean(7, u.isIsActive());
            stm.executeUpdate();

            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void updateUser(User u, int userId) {
        String sql = "UPDATE users SET Username = ?, FirstName = ?, LastName = ?, PhoneNum = ?, RoleID = ?, IsActive = ? WHERE UserID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, u.getUsername());
            stm.setString(2, u.getFirstName());
            stm.setString(3, u.getLastName());
            stm.setString(4, u.getPhoneNum());
            stm.setInt(5, u.getRoleID());
            stm.setBoolean(6, u.isIsActive());
            stm.setInt(7, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public User getUserById(int userId) {
    String sql = "SELECT * FROM users WHERE UserID = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stm = conn.prepareStatement(sql)) {
        stm.setInt(1, userId);
        try (ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                return new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("PhoneNum"),
                    rs.getInt("RoleID"),
                    rs.getBoolean("IsActive")
                );
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}
    public List<User> getFilteredUsers(String keywords, String roleFilter, String statusFilter) {
    List<User> users = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
    List<Object> params = new ArrayList<>();

    // Thêm điều kiện tìm kiếm theo từ khóa
    if (keywords != null && !keywords.trim().isEmpty()) {
        sql.append(" AND (FirstName LIKE ? OR LastName LIKE ? OR CONCAT(FirstName, ' ', LastName) LIKE ?)");
        String keywordPattern = "%" + keywords.trim() + "%";
        params.add(keywordPattern);
        params.add(keywordPattern);
        params.add(keywordPattern);
    }

    // Thêm điều kiện lọc theo vai trò
    if (roleFilter != null && !roleFilter.isEmpty()) {
        try {
            int roleId = Integer.parseInt(roleFilter);
            sql.append(" AND RoleID = ?");
            params.add(roleId);
        } catch (NumberFormatException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Invalid roleFilter: " + roleFilter, e);
        }
    }

    // Thêm điều kiện lọc theo trạng thái
    if (statusFilter != null && !statusFilter.isEmpty()) {
        if (statusFilter.equalsIgnoreCase("true") || statusFilter.equalsIgnoreCase("false")) {
            sql.append(" AND IsActive = ?");
            params.add(Boolean.parseBoolean(statusFilter));
        } else {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Invalid statusFilter: " + statusFilter);
        }
    }

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stm = conn.prepareStatement(sql.toString())) {
        // Gán các tham số cho PreparedStatement
        for (int i = 0; i < params.size(); i++) {
            stm.setObject(i + 1, params.get(i));
        }

        try (ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                User u = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("FirstName"),
                    rs.getString("LastName"),
                    rs.getString("PhoneNum"),
                    rs.getInt("RoleID"),
                    rs.getBoolean("IsActive")
                );
                users.add(u);
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error fetching filtered users", ex);
    }

    return users;
}
}