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
import java.util.List;
import model.User;
import util.PasswordUtil;
import util.ResetPassword;

/**
 *
 * @author ToiLaDuyGitHub
 */
@WebServlet("/reset-password-request-list")
public class ResetPasswordRequestListController extends HttpServlet {

    private UserDAO userDAO;
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1; // Mặc định trang 1
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<User> resetReqList = userDAO.getResetPasswordReqList((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int noOfRecords = userDAO.getNoOfResetPasswordRequests();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / RECORDS_PER_PAGE);
        request.setAttribute("resetReqList", resetReqList);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/user-management/reset-password-request-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        if (username == null) {
            request.getRequestDispatcher("/user-management/reset-password-request-list.jsp").forward(request, response);
        }
        String password = ResetPassword.generateRandomString();
        String passwordHash = PasswordUtil.hashPassword(password);
        User resetUser = userDAO.resetPasswordForUser(username, passwordHash);
        if (resetUser == null) {
            request.getRequestDispatcher("/user-management/reset-password-request-list.jsp").forward(request, response);
        }
        request.setAttribute("successMessage", "Reset mật khẩu cho tài khoản: " + username + " thành công!");
        ResetPassword.sendEmail(username, password);
        doGet(request, response);
    }
}
