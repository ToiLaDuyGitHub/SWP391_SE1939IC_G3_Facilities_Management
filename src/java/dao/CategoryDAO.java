/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Category;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class CategoryDAO extends DBUtil {

    // Helper method để tạo Category object từ ResultSet
    private Category getFromResultSet(ResultSet rs) throws SQLException {
        int categoryID = rs.getInt("CategoryID");
        String categoryName = rs.getString("CategoryName");
        return new Category(categoryID, categoryName);
    }

    // Lấy tất cả categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName FROM categories";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                categories.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Lấy category theo ID
    public Category getCategoryByID(int categoryID) {
        String sql = "SELECT CategoryID, CategoryName FROM categories WHERE CategoryID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return getFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm category mới
    public boolean insertCategory(Category category) {
        String sql = "INSERT INTO categories (CategoryName) VALUES (?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getCategoryName());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật category
    public boolean updateCategory(Category category) {
        String sql = "UPDATE categories SET CategoryName = ? WHERE CategoryID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getCategoryID());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa category
    public boolean deleteCategory(int categoryID) {
        String sql = "DELETE FROM categories WHERE CategoryID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra category có tồn tại không
    public boolean categoryExists(int categoryID) {
        String sql = "SELECT COUNT(*) FROM categories WHERE CategoryID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra tên category đã tồn tại chưa
    public boolean categoryNameExists(String categoryName) {
        String sql = "SELECT COUNT(*) FROM categories WHERE CategoryName = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, categoryName);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy tổng số categories
    public int getTotalCategories() {
        String sql = "SELECT COUNT(*) FROM categories";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tìm categories theo tên (partial search)
    public List<Category> searchCategoriesByName(String searchTerm) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName FROM categories WHERE CategoryName LIKE ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                categories.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Lấy categories với phân trang
    public List<Category> getCategoriesWithPagination(int offset, int limit) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName FROM categories LIMIT ? OFFSET ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                categories.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // === Hàm main để test CategoryDAO ===
    public static void main(String[] args) {
        CategoryDAO categoryDAO = new CategoryDAO();
        System.out.println("=== BẮT ĐẦU TEST CATEGORY DAO ===\n");

        // Test 1: Lấy tổng số categories ban đầu
        System.out.println("1. Kiểm tra tổng số categories ban đầu:");
        int totalCategories = categoryDAO.getTotalCategories();
        System.out.println("Tổng số categories: " + totalCategories);
        System.out.println();

        // Test 2: Lấy tất cả categories
        System.out.println("2. Lấy tất cả categories:");
        List<Category> allCategories = categoryDAO.getAllCategories();
        if (allCategories.isEmpty()) {
            System.out.println("Chưa có category nào trong database.");
        } else {
            for (Category category : allCategories) {
                System.out.println("ID: " + category.getCategoryID() + " - Name: " + category.getCategoryName());
            }
        }
        System.out.println();

        // Test 3: Thêm categories mới
        System.out.println("3. Thêm categories mới:");
        Category newCategory1 = new Category(0, "Điện tử");
        Category newCategory2 = new Category(0, "Nội thất");
        Category newCategory3 = new Category(0, "Y tế");

        boolean insert1 = categoryDAO.insertCategory(newCategory1);
        boolean insert2 = categoryDAO.insertCategory(newCategory2);
        boolean insert3 = categoryDAO.insertCategory(newCategory3);

        System.out.println("Thêm 'Điện tử': " + (insert1 ? "Thành công" : "Thất bại"));
        System.out.println("Thêm 'Nội thất': " + (insert2 ? "Thành công" : "Thất bại"));
        System.out.println("Thêm 'Y tế': " + (insert3 ? "Thành công" : "Thất bại"));
        System.out.println();

        // Test 4: Kiểm tra tổng số categories sau khi thêm
        System.out.println("4. Tổng số categories sau khi thêm:");
        totalCategories = categoryDAO.getTotalCategories();
        System.out.println("Tổng số categories: " + totalCategories);
        System.out.println();

        // Test 5: Lấy tất cả categories sau khi thêm
        System.out.println("5. Danh sách categories sau khi thêm:");
        allCategories = categoryDAO.getAllCategories();
        for (Category category : allCategories) {
            System.out.println("ID: " + category.getCategoryID() + " - Name: " + category.getCategoryName());
        }
        System.out.println();

        // Test 6: Lấy category theo ID
        System.out.println("6. Test lấy category theo ID:");
        if (!allCategories.isEmpty()) {
            int testID = allCategories.get(0).getCategoryID();
            Category foundCategory = categoryDAO.getCategoryByID(testID);
            if (foundCategory != null) {
                System.out.println("Tìm thấy category ID " + testID + ": " + foundCategory.getCategoryName());
            } else {
                System.out.println("Không tìm thấy category với ID " + testID);
            }
        }
        System.out.println();

        // Test 7: Kiểm tra category có tồn tại
        System.out.println("7. Test kiểm tra category tồn tại:");
        if (!allCategories.isEmpty()) {
            int existingID = allCategories.get(0).getCategoryID();
            int nonExistingID = 99999;
            
            System.out.println("Category ID " + existingID + " tồn tại: " + categoryDAO.categoryExists(existingID));
            System.out.println("Category ID " + nonExistingID + " tồn tại: " + categoryDAO.categoryExists(nonExistingID));
        }
        System.out.println();

        // Test 8: Kiểm tra tên category tồn tại
        System.out.println("8. Test kiểm tra tên category tồn tại:");
        System.out.println("Tên 'Điện tử' tồn tại: " + categoryDAO.categoryNameExists("Điện tử"));
        System.out.println("Tên 'Không tồn tại' tồn tại: " + categoryDAO.categoryNameExists("Không tồn tại"));
        System.out.println();

        // Test 9: Tìm kiếm categories theo tên
        System.out.println("9. Test tìm kiếm categories theo tên:");
        List<Category> searchResults = categoryDAO.searchCategoriesByName("tử");
        System.out.println("Kết quả tìm kiếm 'tử':");
        for (Category category : searchResults) {
            System.out.println("ID: " + category.getCategoryID() + " - Name: " + category.getCategoryName());
        }
        System.out.println();

        // Test 10: Test phân trang
        System.out.println("10. Test phân trang:");
        List<Category> paginatedCategories = categoryDAO.getCategoriesWithPagination(0, 2);
        System.out.println("2 categories đầu tiên:");
        for (Category category : paginatedCategories) {
            System.out.println("ID: " + category.getCategoryID() + " - Name: " + category.getCategoryName());
        }
        System.out.println();

        // Test 11: Cập nhật category
        System.out.println("11. Test cập nhật category:");
        if (!allCategories.isEmpty()) {
            Category categoryToUpdate = allCategories.get(0);
            String oldName = categoryToUpdate.getCategoryName();
            categoryToUpdate.setCategoryName(oldName + " (Updated)");
            
            boolean updateResult = categoryDAO.updateCategory(categoryToUpdate);
            System.out.println("Cập nhật category ID " + categoryToUpdate.getCategoryID() + ": " + 
                             (updateResult ? "Thành công" : "Thất bại"));
            
            // Kiểm tra kết quả cập nhật
            Category updatedCategory = categoryDAO.getCategoryByID(categoryToUpdate.getCategoryID());
            if (updatedCategory != null) {
                System.out.println("Tên mới: " + updatedCategory.getCategoryName());
            }
        }
        System.out.println();

        // Test 12: Xóa category
        System.out.println("12. Test xóa category:");
        allCategories = categoryDAO.getAllCategories();
        if (!allCategories.isEmpty()) {
            Category categoryToDelete = allCategories.get(allCategories.size() - 1);
            int deleteID = categoryToDelete.getCategoryID();
            
            boolean deleteResult = categoryDAO.deleteCategory(deleteID);
            System.out.println("Xóa category ID " + deleteID + ": " + 
                             (deleteResult ? "Thành công" : "Thất bại"));
            
            // Kiểm tra xem đã xóa chưa
            System.out.println("Kiểm tra category đã xóa còn tồn tại: " + categoryDAO.categoryExists(deleteID));
        }
        System.out.println();

        // Test 13: Kiểm tra tổng số categories cuối cùng
        System.out.println("13. Tổng số categories cuối cùng:");
        totalCategories = categoryDAO.getTotalCategories();
        System.out.println("Tổng số categories: " + totalCategories);
        System.out.println();

        // Test 14: Danh sách categories cuối cùng
        System.out.println("14. Danh sách categories cuối cùng:");
        allCategories = categoryDAO.getAllCategories();
        for (Category category : allCategories) {
            System.out.println("ID: " + category.getCategoryID() + " - Name: " + category.getCategoryName());
        }

        System.out.println("\n=== KẾT THÚC TEST CATEGORY DAO ===");
    }
} 