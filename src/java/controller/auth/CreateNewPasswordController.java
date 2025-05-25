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
import java.io.IOException;
import util.PasswordUtil;

/**
 *
 * @author ToiLaDuyGitHub
 */
@WebServlet("/create-new-password")
public class CreateNewPasswordController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/create-new-password.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("new-password");
        String confirmNewPassword = request.getParameter("confirm-new-password");
        boolean isValidPassword = newPassword.matches("^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!$@%]).{6,32}$");
        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("errorMessage", "Xác nhận mật khẩu mới chưa khớp với mật khẩu mới. Vui lòng thiết lập lại.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/auth/create-new-password.jsp").forward(request, response);
            return;
        } else {
            if (!isValidPassword) {
                request.setAttribute("errorMessage", "Mật khẩu mới không đạt đủ yêu cầu. Vui lòng nhập mật khẩu khác đúng với yêu cầu.");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/auth/create-new-password.jsp").forward(request, response);
                return;
            }
            else {
                String passwordHash = PasswordUtil.hashPassword(newPassword);
                userDAO.changePassword(username, passwordHash);
                request.setAttribute("successMessage", "Cập nhật mật khẩu thành công. Vui lòng đăng nhập lại để truy cập vào hệ thống.");
                request.setAttribute("username", username);
                request.setAttribute("password", newPassword);
                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
                return;
            }
        }
    }
}
