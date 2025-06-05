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
@WebServlet(name="SearchMaterialController", urlPatterns={"/search-material"})
public class SearchMaterialController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
        MaterialDAO materialDAO = new MaterialDAO();
        SubCategoryDAO subCategory = new SubCategoryDAO();
        try {

            List<SubCategory> subcategoryList = subCategory.getAllSubCategories();
            request.setAttribute("subcategoryList", subcategoryList);
            
        } catch (Exception e) {
        }
        String MaterialName = request.getParameter("searchMaterial");
        // Kiểm tra nếu tên vật tư không rỗng
        if (MaterialName != null && !MaterialName.trim().isEmpty()) {
            // Gọi DAO để tìm vật tư theo tên
            Material material = materialDAO.getMaterialByName(MaterialName);

            // Nếu tìm thấy vật tư, đặt vào request để hiển thị trên JSP
            if (material != null) {
                request.setAttribute("material", material);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy vật tư với tên: " + MaterialName);
                
            }
        }
        request.getRequestDispatcher("/EditMaterial.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       doGet(request, response);
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
