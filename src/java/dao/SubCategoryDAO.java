/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.SubCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;

/**
 *
 * @author Admin
 */
public class SubCategoryDAO {

    public List<SubCategory> getAllSubCategories() throws SQLException {
        List<SubCategory> subCategories = new ArrayList<>();

        String sql = "SELECT * FROM subcategories";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SubCategory subcategory = new SubCategory();
                int subcategoryID = rs.getInt("SubcategoryID");
                int categoryID = rs.getInt("CategoryID");
                String subcategoryName = rs.getString("SubcategoryName");

                subCategories.add(new SubCategory(subcategoryID, categoryID, subcategoryName));
            }

        }
        return subCategories;
    }
  public static void main(String[] args) throws SQLException {
        SubCategoryDAO dao = new SubCategoryDAO();
         List<SubCategory> list = dao.getAllSubCategories();
        for (SubCategory o : list) {
            System.out.println(o);
      }
    }
}


