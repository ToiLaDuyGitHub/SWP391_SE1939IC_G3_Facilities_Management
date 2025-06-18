/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MaterialDAO;
import dao.SubCategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Material;
import model.SubCategory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManageMaterialController", urlPatterns = {"/manage-material"})
public class ManageMaterialController extends HttpServlet {

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
// Tạo đối tượng MaterialDAO
        MaterialDAO materialDAO = new MaterialDAO();
        SubCategoryDAO subCategoryDAO = new SubCategoryDAO();
        List<Material> list = null;
        List<SubCategory> list1sub = null;

        try {
            // Gọi phương thức getAllMaterials() để lấy toàn bộ danh sách vật tư
            list = materialDAO.getAllMaterials();
            list1sub = subCategoryDAO.getAllSubcategories();
            request.setAttribute("materials", list);
            request.setAttribute("subcategoryList", list1sub);
             request.getRequestDispatcher("materialList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("error", "Không thể tải danh sách vật tư: " + e.getMessage());
            request.getRequestDispatcher("materialList.jsp").forward(request, response);
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
       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
