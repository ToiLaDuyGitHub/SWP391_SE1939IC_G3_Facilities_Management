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

/**
 *
 * @author ToiLaDuyGitHub
 */
@WebServlet("/reset-otp")
public class ResetOTPController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("./login").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String resetOTP = request.getParameter("resetOTP");
        if (!userDAO.checkUsernameAndResetOTP(username, resetOTP)) {
            request.setAttribute("errorMessage", "Mã Reset OTP không đúng. Vui lòng kiểm tra lại mã gần nhất đã được gửi tới gmail của bạn.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/auth/reset-password-otp.jsp").forward(request, response);
            return;
        }
        request.setAttribute("successMessage", "Xác minh tài khoản thành công.<br/>Vui lòng tạo một mật khẩu mới.");
        request.setAttribute("username", username);
        request.getRequestDispatcher("/auth/create-new-password.jsp").forward(request, response);
        return;
    }
}
