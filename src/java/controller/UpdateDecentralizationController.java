package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.FeatureDAO;
import dao.RoleDAO;
import model.Feature;
import model.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(urlPatterns = {"/UpdateDecentralization"})
public class UpdateDecentralizationController extends HttpServlet {

    private FeatureDAO featureDAO;
    private RoleDAO roleDAO;

    @Override
    public void init() throws ServletException {
        featureDAO = new FeatureDAO();
        roleDAO = new RoleDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateDecentralizationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateDecentralizationController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        processRequest(request, response);
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
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }
        try {
            // Lấy danh sách chức năng và vai trò
            List<Feature> features = featureDAO.getAllFeatures();
            List<Role> roles = roleDAO.getRolesForDecentralization();
            boolean hasChanges = false;
            // Duyệt qua tất cả các tổ hợp feature và role
            for (Feature feature : features) {
                for (Role role : roles) {
                    String paramName = "permission_" + feature.getUrlID() + "_" + role.getRoleID();
                    boolean isChecked = request.getParameter(paramName) != null; // Checkbox được tích nếu param tồn tại
                    boolean hasPermission = featureDAO.hasPermission(feature.getUrlID(), role.getRoleID());

                    // So sánh trạng thái checkbox với dữ liệu trong DB
                    if (isChecked != hasPermission) {
                        hasChanges = true;
                        if (isChecked) {//thêm quyền
                            featureDAO.addPermission(feature.getUrlID(), role.getRoleID());
                        } else {//xóa quyền
                            featureDAO.removePermission(feature.getUrlID(), role.getRoleID());
                        }
                    }
                }
            }
            if (hasChanges) {
                session.setAttribute("successMessage", "Cập nhật phân quyền thành công!");
            } else {
                session.setAttribute("infoMessage", "Không có thay đổi nào được thực hiện.");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
        // Chuyển hướng về Decentralization để tải lại dữ liệu mới
        response.sendRedirect(request.getContextPath() + "/Decentralization");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
