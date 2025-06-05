/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.MaterialDAO;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name="DeleteMaterialController", urlPatterns={"/delete-material"})
public class DeleteMaterialController extends HttpServlet {
   
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
       MaterialDAO materialDAO = new MaterialDAO();
        try {
            // Lấy materialID từ yêu cầu
            int materialID = Integer.parseInt(request.getParameter("materialID"));

            // Xóa vật tư bằng DAO
            materialDAO.deleteMaterial(materialID);

            // Chuyển hướng đến trang danh sách vật tư với thông báo thành công
            request.getSession().setAttribute("successMessage", "Xóa vật tư thành công!");
            response.sendRedirect(request.getContextPath() + "/EditMaterial.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            // Chuyển hướng với thông báo lỗi nếu việc xóa thất bại
            request.getSession().setAttribute("errorMessage", "Không thể xóa vật tư: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/EditMaterial?searchMaterial=" + request.getParameter("materialName"));
        } catch (NumberFormatException e) {
            // Xử lý định dạng materialID không hợp lệ
            request.getSession().setAttribute("errorMessage", "ID vật tư không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/EditMaterial?searchMaterial=" + request.getParameter("materialName"));
        }
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
