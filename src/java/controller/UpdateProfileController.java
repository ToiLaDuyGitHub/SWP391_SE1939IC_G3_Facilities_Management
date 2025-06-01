/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.dto.User_Role;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UpdateProfileController", urlPatterns = {"/UpdateProfile"})
public class UpdateProfileController extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfileController at " + request.getContextPath() + "</h1>");
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
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO(); // Khởi tạo UserDAO
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }
        // Lấy thông tin từ session và form
        User_Role userRole = (User_Role) session.getAttribute("userRole");
        String username = userRole.getUsername();
        String firstName = request.getParameter("editFirstName");
        String lastName = request.getParameter("editLastName");
        String phone = request.getParameter("editPhone");
        String address = request.getParameter("editAddress");
        // Kiểm tra xem có thay đổi nào trong dữ liệu hay không
        boolean isUnchanged = firstName.equals(userRole.getFirstName()) &&
                             lastName.equals(userRole.getLastName()) &&
                             phone.equals(userRole.getPhoneNum()) &&
                             address.equals(userRole.getAddress());

        if (isUnchanged) {
            // Nếu không có thay đổi, chỉ chuyển tiếp về trang Profile.jsp mà không đặt thông báo
            request.setAttribute("userRole", userRole);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
            return;
        }
        try {
            // Cập nhật thông tin người dùng qua UserDAO
            userDAO.updateUserProfile(username, firstName, lastName, phone, address);

            // Cập nhật lại thông tin trong session
            User_Role updatedUserRole = userDAO.getUserWithRole(username); // Gọi thông qua đối tượng userDAO
            session.setAttribute("userRole", updatedUserRole);

            // Đặt thông báo thành công
            request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin. Vui lòng thử lại.");
        }        
        // Chuyển tiếp về trang Profile
        request.setAttribute("userRole", userRole);
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}

