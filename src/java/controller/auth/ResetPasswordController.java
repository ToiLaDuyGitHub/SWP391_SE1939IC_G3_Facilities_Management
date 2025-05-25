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
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.User;
import util.ResetPassword;

/**
 *
 * @author ToiLaDuyGitHub
 */
@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    private UserDAO userDAO;
    private ResetPassword resetPassword;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        resetPassword = new ResetPassword();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        User user = userDAO.getUsersResetOTPTime(username);
        if (user == null) {
            request.setAttribute("errorMessage", "Gmail bạn đã nhập<br/>không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }
        if (user != null && user.getResetOTPTime() != null
                && Duration.between(user.getResetOTPTime().minusHours(7), LocalDateTime.now()).toMinutes() < 5) {
            //Do LocalDateTime sử dụng múi giờ GMT+7, tuy nhiên dữ liệu từ DB lại quay lại GMT+0 nên phải trừ đi
            LocalDateTime timeToRequestAgain = user.getResetOTPTime().minusHours(7).plusMinutes(5);
            // Định dạng thời gian dễ đọc hơn
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            String formattedTime = timeToRequestAgain.format(formatter);

            request.setAttribute("errorMessage", "Bạn đã yêu cầu một mã Reset OTP gần đây. Vui lòng sử dụng mã đã được gửi vào "
                    + "gmail của bạn, hoặc đợi đến " + formattedTime + " để có thể yêu cầu một mã mới.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/auth/reset-password-otp.jsp").forward(request, response);
            return; // Quan trọng: Dừng xử lý tiếp
        }
        // Thêm vào đầu controller
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String resetOTP = resetPassword.generateRandomString();
        userDAO.updateResetOTP(username, resetOTP);
        resetPassword.sendEmail(username, resetOTP);
        request.setAttribute("successMessage", "Một mã OTP đã được gửi tới gmail của bạn. Vui lòng nhập mã để xác nhận tài khoản thuộc về bạn.");
        request.setAttribute("username", username);
        request.getRequestDispatcher("/auth/reset-password-otp.jsp").forward(request, response);
        return;
    }
}
