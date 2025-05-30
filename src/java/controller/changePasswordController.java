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
import util.PasswordUtil;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "changePasswordController", urlPatterns = {"/changePassword"})
public class changePasswordController extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP GET method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP POST method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User_Role userRole = (User_Role) session.getAttribute("userRole");

        // Kiểm tra người dùng đã đăng nhập chưa
        if (session == null || session.getAttribute("userRole") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String username = userRole.getUsername();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra các trường đầu vào không rỗng
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường mật khẩu.");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới và xác nhận mật khẩu có khớp không
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Validate input
        String errorMessage = validatePassword(newPassword);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Verify current password
        boolean isValid = UserDAO.validateUser(username, currentPassword);
        if (!isValid) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }
        // Hash new password
        String passwordHash = PasswordUtil.hashPassword(newPassword);
        UserDAO userDAO = new UserDAO();
        // Update password in database
        userDAO.changePassword(username, passwordHash);
        // Success message
        request.setAttribute("success", "Thay đổi mật khẩu thành công!");
        request.setAttribute("userRole", userRole);
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }

    // Validate password according to requirements
    private String validatePassword(String password) {
        // Check length (minimum 8 characters)
        if (password.length() < 8) {
            return "Mật khẩu phải có ít nhất 8 ký tự.";
        }

        // Check for uppercase letter
        if (!hasUppercase(password)) {
            return "Mật khẩu phải chứa ít nhất một chữ cái in hoa.";
        }

        // Check for lowercase letter
        if (!hasLowercase(password)) {
            return "Mật khẩu phải chứa ít nhất một chữ cái thường.";
        }

        // Check for special character
        if (!hasSpecialCharacter(password)) {
            return "Mật khẩu phải chứa ít nhất một ký tự đặc biệt (ví dụ: !@#$%^&*).";
        }

        // Check for both letters and numbers
        if (!hasLetterAndNumber(password)) {
            return "Mật khẩu phải chứa cả chữ cái và số.";
        }

        return null; // Password is valid
    }

    // Check if password contains uppercase letter
    private boolean hasUppercase(String password) {
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                return true;
            }
        }
        return false;
    }

    // Check if password contains lowercase letter
    private boolean hasLowercase(String password) {
        for (char c : password.toCharArray()) {
            if (Character.isLowerCase(c)) {
                return true;
            }
        }
        return false;
    }

    // Check if password contains special character
    private boolean hasSpecialCharacter(String password) {
        String specialCharacters = "!@#$%^&*()_+-=[]{}|;:,.<>?~`";
        for (char c : password.toCharArray()) {
            if (specialCharacters.indexOf(c) != -1) {
                return true;
            }
        }
        return false;
    }

    // Check if password contains both letters and numbers
    private boolean hasLetterAndNumber(String password) {
        boolean hasLetter = false;
        boolean hasNumber = false;

        for (char c : password.toCharArray()) {
            if (Character.isLetter(c)) {
                hasLetter = true;
            }
            if (Character.isDigit(c)) {
                hasNumber = true;
            }
            if (hasLetter && hasNumber) {
                return true;
            }
        }
        return false;
    }
}