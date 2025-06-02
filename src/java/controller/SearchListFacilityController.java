/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.FacilityDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Facility;

/**
 *
 * @author Admin
 */
@WebServlet(name="SearchListFacilityController", urlPatterns={"/SearchListFacility"})
public class SearchListFacilityController extends HttpServlet {
   
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
        FacilityDAO facilityDAO = new FacilityDAO();
        List<Facility> facilities = facilityDAO.getAllFacilities();
        List<Facility> filteredFacilities = null;

        // Lấy tham số tìm kiếm
        String searchMaterial = request.getParameter("searchMaterial");

        // Nếu có từ khóa tìm kiếm, lọc danh sách vật tư
        if (searchMaterial != null && !searchMaterial.trim().isEmpty()) {
            Facility facility = facilityDAO.getFacilityByName(searchMaterial.trim().toLowerCase());
            if (facility != null) {
                filteredFacilities = new ArrayList<>();
                filteredFacilities.add(facility);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy vật tư với tên: " + searchMaterial);
            }
        }

        // Đặt danh sách vật tư để hiển thị
        request.setAttribute("facilities", facilities);
        if (filteredFacilities != null) {
            request.setAttribute("filteredFacilities", filteredFacilities);
        }

        // Chuyển tiếp đến materialList.jsp
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
