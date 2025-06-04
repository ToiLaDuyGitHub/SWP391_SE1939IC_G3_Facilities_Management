package controller.manager;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Category;
import model.SubCategory;
import dao.CategoryDAO;
import dao.SubCategoryDAO;

@WebServlet("/manage-category")
public class ManageCategoryController extends HttpServlet {

    private CategoryDAO categoryDAO;
    private SubCategoryDAO subcategoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
        subcategoryDAO = new SubCategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Lấy message từ session nếu có
        HttpSession session = request.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }
        
        if (action == null || action.equals("list")) {
            // Lấy tất cả categories và subcategories
            List<Category> categories = categoryDAO.getAllCategories();
            List<Object[]> subcategoriesWithCategoryInfo = subcategoryDAO.getSubcategoriesWithCategoryInfo();
            
            // Set attributes để chuyển đến JSP
            request.setAttribute("categories", categories);
            request.setAttribute("subcategoriesWithInfo", subcategoriesWithCategoryInfo);
            request.setAttribute("totalCategories", categoryDAO.getTotalCategories());
            request.setAttribute("totalSubcategories", subcategoryDAO.getTotalSubcategories());
            
            // Forward đến JSP
            request.getRequestDispatcher("/danhmucvattu/danh-muc-list.jsp").forward(request, response);
            
        } else if (action.equals("addForm")) {
            // Hiển thị form thêm danh mục
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/danhmucvattu/add-category.jsp").forward(request, response);
            
        } else if (action.equals("getCategoryById")) {
            // Lấy category theo ID
            String categoryIdStr = request.getParameter("categoryId");
            if (categoryIdStr != null) {
                try {
                    int categoryId = Integer.parseInt(categoryIdStr);
                    Category category = categoryDAO.getCategoryByID(categoryId);
                    List<SubCategory> subcategories = subcategoryDAO.getSubcategoriesByCategoryID(categoryId);
                    
                    request.setAttribute("selectedCategory", category);
                    request.setAttribute("subcategories", subcategories);
                    request.getRequestDispatcher("/danhmucvattu/category-detail.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/manage-category");
                }
            }
            
        } else if (action.equals("search")) {
            // Tìm kiếm categories
            String searchTerm = request.getParameter("searchTerm");
            List<Category> searchResults;
            List<Object[]> subcategoriesWithCategoryInfo = subcategoryDAO.getSubcategoriesWithCategoryInfo();
            
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                searchResults = categoryDAO.searchCategoriesByName(searchTerm.trim());
            } else {
                searchResults = categoryDAO.getAllCategories();
            }
            
            request.setAttribute("categories", searchResults);
            request.setAttribute("subcategoriesWithInfo", subcategoriesWithCategoryInfo);
            request.setAttribute("totalCategories", categoryDAO.getTotalCategories());
            request.setAttribute("totalSubcategories", subcategoryDAO.getTotalSubcategories());
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("/danhmucvattu/danh-muc-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/manage-category");
            return;
        }
        
        switch (action) {
            case "addCategory":
                handleAddCategory(request, response);
                break;
            case "updateCategory":
                handleUpdateCategory(request, response);
                break;
            case "deleteCategory":
                handleDeleteCategory(request, response);
                break;
            case "addSubcategory":
                handleAddSubcategory(request, response);
                break;
            case "updateSubcategory":
                handleUpdateSubcategory(request, response);
                break;
            case "deleteSubcategory":
                handleDeleteSubcategory(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/manage-category");
                break;
        }
    }
    
    private void handleAddCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName != null && !categoryName.trim().isEmpty()) {
            // Kiểm tra tên category đã tồn tại chưa
            if (categoryDAO.categoryNameExists(categoryName.trim())) {
                session.setAttribute("errorMessage", "Tên danh mục đã tồn tại!");
            } else {
                Category newCategory = new Category(0, categoryName.trim());
                boolean success = categoryDAO.insertCategory(newCategory);
                
                if (success) {
                    session.setAttribute("successMessage", "Thêm danh mục thành công!");
                } else {
                    session.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm danh mục!");
                }
            }
        } else {
            session.setAttribute("errorMessage", "Tên danh mục không được để trống!");
        }
        
        // Redirect về trang danh sách
        response.sendRedirect(request.getContextPath() + "/manage-category");
    }
    
    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String categoryIdStr = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        
        if (categoryIdStr != null && categoryName != null && !categoryName.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                Category category = new Category(categoryId, categoryName.trim());
                boolean success = categoryDAO.updateCategory(category);
                
                if (success) {
                    session.setAttribute("successMessage", "Cập nhật danh mục thành công!");
                } else {
                    session.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật danh mục!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID danh mục không hợp lệ!");
            }
        } else {
            session.setAttribute("errorMessage", "Thông tin danh mục không hợp lệ!");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-category");
    }
    
    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String categoryIdStr = request.getParameter("categoryId");
        
        if (categoryIdStr != null) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                
                // Kiểm tra xem category có subcategories không
                int subcategoryCount = subcategoryDAO.getSubcategoryCountByCategoryID(categoryId);
                if (subcategoryCount > 0) {
                    session.setAttribute("errorMessage", "Không thể xóa danh mục có chứa danh mục con!");
                } else {
                    boolean success = categoryDAO.deleteCategory(categoryId);
                    
                    if (success) {
                        session.setAttribute("successMessage", "Xóa danh mục thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Có lỗi xảy ra khi xóa danh mục!");
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID danh mục không hợp lệ!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-category");
    }
    
    private void handleAddSubcategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String categoryIdStr = request.getParameter("categoryId");
        String subcategoryName = request.getParameter("subcategoryName");
        
        if (categoryIdStr != null && subcategoryName != null && !subcategoryName.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                
                // Kiểm tra tên subcategory đã tồn tại trong category chưa
                if (subcategoryDAO.subcategoryNameExistsInCategory(categoryId, subcategoryName.trim())) {
                    session.setAttribute("errorMessage", "Tên danh mục con đã tồn tại trong danh mục này!");
                } else {
                    SubCategory newSubcategory = new SubCategory(categoryId, subcategoryName.trim());
                    boolean success = subcategoryDAO.insertSubcategory(newSubcategory);
                    
                    if (success) {
                        session.setAttribute("successMessage", "Thêm danh mục con thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm danh mục con!");
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID danh mục không hợp lệ!");
            }
        } else {
            session.setAttribute("errorMessage", "Thông tin danh mục con không hợp lệ!");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-category");
    }
    
    private void handleUpdateSubcategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String subcategoryIdStr = request.getParameter("subcategoryId");
        String categoryIdStr = request.getParameter("categoryId");
        String subcategoryName = request.getParameter("subcategoryName");
        
        if (subcategoryIdStr != null && categoryIdStr != null && subcategoryName != null && !subcategoryName.trim().isEmpty()) {
            try {
                int subcategoryId = Integer.parseInt(subcategoryIdStr);
                int categoryId = Integer.parseInt(categoryIdStr);
                
                SubCategory subcategory = new SubCategory(subcategoryId, categoryId, subcategoryName.trim());
                boolean success = subcategoryDAO.updateSubcategory(subcategory);
                
                if (success) {
                    session.setAttribute("successMessage", "Cập nhật danh mục con thành công!");
                } else {
                    session.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật danh mục con!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID không hợp lệ!");
            }
        } else {
            session.setAttribute("errorMessage", "Thông tin danh mục con không hợp lệ!");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-category");
    }
    
    private void handleDeleteSubcategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String subcategoryIdStr = request.getParameter("subcategoryId");
        
        if (subcategoryIdStr != null) {
            try {
                int subcategoryId = Integer.parseInt(subcategoryIdStr);
                boolean success = subcategoryDAO.deleteSubcategory(subcategoryId);
                
                if (success) {
                    session.setAttribute("successMessage", "Xóa danh mục con thành công!");
                } else {
                    session.setAttribute("errorMessage", "Có lỗi xảy ra khi xóa danh mục con!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID danh mục con không hợp lệ!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-category");
    }
}
