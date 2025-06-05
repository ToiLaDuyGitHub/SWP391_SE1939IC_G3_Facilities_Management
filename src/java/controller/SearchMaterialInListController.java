/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.MaterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Material;

/**
 *
 * @author Admin
 */
@WebServlet(name="SearchMaterialInListController", urlPatterns={"/search-material-in-list"})
public class SearchMaterialInListController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        MaterialDAO materialDAO = new MaterialDAO();
        String searchMaterial = request.getParameter("searchMaterial");
        List<Material> allMaterials = materialDAO.getAllMaterials(); //  Lấy toàn bộ danh sách để gợi ý

        List<Material> materials;
        if (searchMaterial == null || searchMaterial.trim().isEmpty()) {
            materials = allMaterials;
        } else {
            Material material = materialDAO.getMaterialByName(searchMaterial.trim().toLowerCase());
            materials = new ArrayList<>();
            if (material != null) {
                materials.add(material);
            } else {
                materials = allMaterials;
                request.setAttribute("errorMessage", "Không tìm thấy vật tư với tên: " + searchMaterial);
            }
        }

        request.setAttribute("materials", materials);
        request.setAttribute("allMaterialsForSuggestions", allMaterials); // Đặt attribute cho gợi ý

        request.getRequestDispatcher("/materialList.jsp").forward(request, response);
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
