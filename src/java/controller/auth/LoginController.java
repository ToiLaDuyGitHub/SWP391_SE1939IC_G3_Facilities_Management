/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.dto.User_Role;
import util.PasswordUtil;

/**
 *
 * @author ToiLaDuyGitHub
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserDAO userDAO;
    private PasswordUtil passwordUtil;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        passwordUtil = new PasswordUtil();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 1. Validate input
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }
        
        // 2. Kiểm tra thông tin đăng nhập
        boolean isValidUser = UserDAO.validateUser(username, password);
        
        if (isValidUser) {
            // 3. Tạo session và chuyển hướng
            User_Role userRole = userDAO.getUserWithRole(username);
            HttpSession session = request.getSession();
            session.setAttribute("userRole", userRole);
            session.setAttribute("username", username);
            response.sendRedirect("./home");
            return;
        } else {
            // 4. Thông báo lỗi
            request.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }
        
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        return;
    }
}
