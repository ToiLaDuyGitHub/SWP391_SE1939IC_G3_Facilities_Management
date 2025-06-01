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

import java.util.ArrayList;
import java.util.List;
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
                User u = new User();
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
        } catch (SQLException ex) {

            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customers;
    }

    public int insertUser(User u) {
        String sql = "INSERT INTO users (UserID, Username, FirstName, LastName, PhoneNum, RoleID, IsActive) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

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
            stm.setInt(1, u.getUserID());
            stm.setString(2, u.getUsername());
            stm.setString(3, u.getFirstName());
            stm.setString(4, u.getLastName());
            stm.setString(5, u.getPhoneNum());
            stm.setInt(6, u.getRoleID());
            stm.setBoolean(7, u.isIsActive());
            stm.executeUpdate();


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

    //Retrive user and its reset password request status
    public User getUserWithResetRequest(String username) {
        String sql = "SELECT IsResetRequested FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    boolean isResetRequested = rs.getBoolean("IsResetRequested");
                    return new User(username, isResetRequested);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean requestResetPassword(String username) {
        String sql = "UPDATE users SET IsResetRequested = 1 WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public List<User> getResetPasswordReqList(int offset, int limit) {
        List<User> userList = new ArrayList<User>();
        String sql = "SELECT u.username, u.firstname, u.lastname, u.isresetrequested from Users u where u.isresetrequested = 1 LIMIT ? OFFSET ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User u = new User(rs.getString("username"),
                            rs.getString("firstname"),
                            rs.getString("lastname"),
                            rs.getBoolean("isresetrequested"));
                    userList.add(u);
                }
            }
            return userList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Triển khai đếm tổng số yêu cầu
    public int getNoOfResetPasswordRequests() {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE isresetrequested = 1";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; //
        }
    }

    public static User resetPasswordForUser(String username, String passwordHash) {
        String sql = "UPDATE Users SET PasswordHash = ?, isresetrequested = 0 WHERE username = ? AND isresetrequested = 1";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, passwordHash);
            stmt.setString(2, username);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                return null;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new User(username, false);
    }

    //Main for DAO Testing
    public static void main(String[] args) {
        User u = UserDAO.resetPasswordForUser("toiladuygg@gmail.com", "abc12345");
        System.out.println(u);
    }
}

