/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;
/**
 *
 * @author ToiLaDuyGitHub
 */
public class RoleDAO {
   // Lấy danh sách các role (trừ role Quản lý kho - RoleID: 1)
    public List<Role> getRolesForDecentralization() throws SQLException{
        List<Role> roles = new ArrayList<>();
        String query = "SELECT RoleID, RoleName FROM roles WHERE RoleID IN (2, 3, 4)"; // Chỉ lấy Nhân viên kho, Giám đốc, Nhân viên
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int roleID = rs.getInt("RoleID");
                String roleName = rs.getString("RoleName");
                roles.add(new Role(roleID, roleName));
            }
        }
        return roles;
    }
}
