/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FacilityDAO;
import dao.SubCategoryDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.SubCategory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddFacilityControl", urlPatterns = {"/AddFacility"})
@MultipartConfig
public class AddFacilityController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SubCategoryDAO subCategory = new SubCategoryDAO();
        try {

            List<SubCategory> subcategoryList = subCategory.getAllSubCategories();
            request.setAttribute("subcategoryList", subcategoryList);
            request.getRequestDispatcher("addFacility.jsp").forward(request, response);
        } catch (Exception e) {
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FacilityDAO facilityDAO = new FacilityDAO();
        try {
            // Lấy thông tin từ form
            String FacilityName = request.getParameter("FacilityName");
            String SupplierName = request.getParameter("SupplierName");
            String Address = request.getParameter("Address");
            String PhoneNum = request.getParameter("PhoneNum");
            String subcategoryIdStr = request.getParameter("SubcategoryID");
            String newQuantityStr = request.getParameter("NewQuantity");
            String usableQuantityStr = request.getParameter("UsableQuantity");

            // Kiểm tra tham số
            if (subcategoryIdStr == null || newQuantityStr == null || usableQuantityStr == null
                    || subcategoryIdStr.isEmpty() || newQuantityStr.isEmpty() || usableQuantityStr.isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                request.getRequestDispatcher("addFacility.jsp").forward(request, response);
                return;
            }

            int SubcategoryID = Integer.parseInt(subcategoryIdStr);
            int NewQuantity = Integer.parseInt(newQuantityStr);
            int UsableQuantity = Integer.parseInt(usableQuantityStr);

            // Tính tổng số lượng
            int totalQuantity = NewQuantity + UsableQuantity;

            // Xử lý upload file ảnh
            Part filePart = request.getPart("Image");
            String imagePath = null;
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                imagePath = "uploads/" + fileName;
                filePart.write(uploadPath + java.io.File.separator + fileName);
            }

            // Thêm vật tư mới vào cơ sở dữ liệu
            facilityDAO.addFacility(FacilityName, SubcategoryID, SupplierName,
                    Address, PhoneNum, imagePath, totalQuantity,
                    NewQuantity, UsableQuantity);

            // Thiết lập thông báo thành công và tải lại danh sách danh mục
            request.setAttribute("successMessage", "Vật tư đã được thêm thành công!");
            SubCategoryDAO subCategory = new SubCategoryDAO();
            List<SubCategory> subcategoryList = subCategory.getAllSubCategories();
            request.setAttribute("subcategoryList", subcategoryList);
            request.getRequestDispatcher("addFacility.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể thêm vật tư: " + e.getMessage());
            request.getRequestDispatcher("addFacility.jsp").forward(request, response);
        }
    }

}

/**
 * Returns a short description of the servlet.
 *
 * @return a String containing servlet description
 */
