/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Stack;
import java.util.Vector;
import model.User;

/**
 *
 * @author Bùi Hiếu
 */
public class Manager_UserController extends HttpServlet {
    private final String ADMIN_URL = "Admin_UserManager.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Vector<User> User = (new UserDAO()).getAllUser();
        String service = req.getParameter("service");
        if (service == null) {
            service = "listAllUser";
        }

        if (service.equals("listAllUser")) {
            req.setAttribute("manageUser", "YES");
            req.setAttribute("allUser", User);
            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }

        if (service.equals("searchByKeywords")) {

            String keywords = req.getParameter("keywords");
            req.setAttribute("keywords", keywords);
            req.setAttribute("manageUser", "Yes");

            User = (new UserDAO()).getUserByName(keywords);

            if (User == null || User.isEmpty()) {
                req.setAttribute("notFoundUser", "Your keywords do not match with any Customer Name");
                User = (new UserDAO()).getAllUser();
            }
            req.setAttribute("allUser", User);
            req.getRequestDispatcher(ADMIN_URL).forward(req, resp);
        }
    }

}
