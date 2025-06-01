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
import model.User;

/**
 *
 * @author ToiLaDuyGitHub
 */
@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        User user = userDAO.getUserWithResetRequest(username);
        if (user == null) {
            request.setAttribute("errorMessage", "Gmail bạn đã nhập<br/>không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }
        if (user != null && user.isIsResetRequested()) {
            request.setAttribute("errorMessage", "Tài khoản được liên kết với gmail " + username + " đã được tạo yêu cầu thay đổi"
                    + " mật khẩu trước đó. Vui lòng đợi mail cấp thông tin mật khẩu mới.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }
        boolean checkRequest = userDAO.requestResetPassword(username);
        if (checkRequest) {
            request.setAttribute("successMessage", "Tạo lệnh yêu cầu reset mật khẩu cho tài khoản " + username + " thành công. Vui lòng đợi xét duyệt để nhận mật khẩu mới.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }
        else {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tạo lệnh yêu cầu reset mật khẩu cho tài khoản " + username + ". Vui lòng thử lại.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            return;
        }
    }
}
