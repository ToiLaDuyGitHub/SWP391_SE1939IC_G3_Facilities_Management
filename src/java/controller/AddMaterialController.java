/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MaterialDAO;
import dao.SubCategoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.SubCategory;
import model.Units;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddMaterialController", urlPatterns = {"/add-material"})
@MultipartConfig
public class AddMaterialController extends HttpServlet {

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
        MaterialDAO materialDAO = new MaterialDAO();
        try {
            List<SubCategory> subcategoryList = subCategory.getAllSubCategories();
            List<Units> unitsList = materialDAO.getAllUnits();
            request.setAttribute("subcategoryList", subcategoryList);
            request.setAttribute("unitsList", unitsList);
            request.getRequestDispatcher("addMaterial.jsp").forward(request, response);
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
        MaterialDAO materialDAO = new MaterialDAO();
        try {
            // Lấy thông tin từ form
            String materialName = request.getParameter("MaterialName");
            String supplierName = request.getParameter("SupplierName");
            String address = request.getParameter("Address");
            String phoneNum = request.getParameter("PhoneNum");
            String subcategoryIdStr = request.getParameter("SubcategoryID");
            String usableQuantityStr = request.getParameter("UsableQuantity");
             String unitMinUnit = request.getParameter("UnitID");
            String detail = request.getParameter("Detail");


            // Kiểm tra tham số
            if (materialName == null || supplierName == null || address == null || phoneNum == null ||
                subcategoryIdStr == null || usableQuantityStr == null || unitMinUnit == null ||
                materialName.isEmpty() || supplierName.isEmpty() || address.isEmpty() || phoneNum.isEmpty() ||
                subcategoryIdStr.isEmpty() || usableQuantityStr.isEmpty() || unitMinUnit.isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                SubCategoryDAO subCategoryDAO = new SubCategoryDAO();
                List<SubCategory> subcategoryList = subCategoryDAO.getAllSubCategories();
                List<Units> unitsList = materialDAO.getAllUnits();
                request.setAttribute("subcategoryList", subcategoryList);
                request.setAttribute("unitsList", unitsList);
                request.getRequestDispatcher("addMaterial.jsp").forward(request, response);
                return;
            }

            int subcategoryId = Integer.parseInt(subcategoryIdStr);
            int usableQuantity = Integer.parseInt(usableQuantityStr);
            int unitId = materialDAO.getUnitIdFromMinUnit(unitMinUnit);

            int totalQuantity = usableQuantity;

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
           materialDAO.addMaterial(materialName, subcategoryId, supplierName, address,
                   phoneNum, imagePath, detail, totalQuantity, usableQuantity, unitId);
            // Thiết lập thông báo thành công và tải lại danh sách danh mục
             request.setAttribute("successMessage", "Vật tư đã được thêm thành công!");
            SubCategoryDAO subCategoryDAO = new SubCategoryDAO();
            List<SubCategory> subcategoryList = subCategoryDAO.getAllSubCategories();
            List<Units> unitList = materialDAO.getAllUnits();
            request.setAttribute("subcategoryList", subcategoryList);
            request.setAttribute("unitList", unitList);
            request.getRequestDispatcher("addMaterial.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể thêm vật tư: " + e.getMessage());
            request.getRequestDispatcher("addMaterial.jsp").forward(request, response);
        }
    }

}

/**
 * Returns a short description of the servlet.
 *
 * @return a String containing servlet description
 */
