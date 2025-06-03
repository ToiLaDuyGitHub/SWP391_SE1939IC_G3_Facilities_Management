package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import model.User;
import model.dto.User_Role;

public class Manager_UserController extends HttpServlet {
    private static final String HOME_URL = "home.jsp";

 private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String service = req.getParameter("service");
        if (service == null || service.trim().isEmpty()) {
            service = "listAllUser";
        }

        UserDAO userDAO = new UserDAO();

        switch (service) {
            case "listAllUser":
                List<User_Role> usersWithRoles = userDAO.getAllUsersWithRoles();
                req.setAttribute("manageUser", "YES");
                req.setAttribute("allUser", usersWithRoles);
                break;

            case "searchByKeywords":
                String keywords = req.getParameter("keywords");
                String roleFilter = req.getParameter("roleFilter");
                String statusFilter = req.getParameter("statusFilter");
                if (keywords == null) {
                    keywords = "";
                }
                req.setAttribute("keywords", keywords.trim());
                req.setAttribute("roleFilter", roleFilter);
                req.setAttribute("statusFilter", statusFilter);
                req.setAttribute("manageUser", "YES");
                List<User_Role> filteredUsers = userDAO.getFilteredUsersWithRoles(keywords.trim(), roleFilter, statusFilter);
                if (filteredUsers == null || filteredUsers.isEmpty()) {
                    req.setAttribute("notFoundUser", "Không tìm thấy người dùng với từ khóa: " + keywords);
                }
                req.setAttribute("allUser", filteredUsers);
                break;

            default:
                req.setAttribute("error", "Yêu cầu không hợp lệ");
                List<User_Role> defaultUsers = userDAO.getAllUsersWithRoles();
                req.setAttribute("allUser", defaultUsers);
                req.setAttribute("manageUser", "YES");
                break;
        }
        if ("userDetail".equals(service)) {
            String userIdStr = req.getParameter("userId");
            if (userIdStr != null && !userIdStr.isEmpty()) {
                try {
                    int userId = Integer.parseInt(userIdStr);
                    User_Role detailUser = userDAO.getUserByIdWithRole(userId);
                    if (detailUser != null) {
                        req.setAttribute("detailUser", detailUser);
                    } else {
                        req.setAttribute("error", "Không tìm thấy người dùng với ID: " + userId);
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "ID người dùng không hợp lệ: " + userIdStr);
                }
            } else {
                req.setAttribute("error", "Thiếu tham số userId");
            }
            req.getRequestDispatcher("/Admin_UserManager.jsp").forward(req, resp);
        }
    

        req.getRequestDispatcher(HOME_URL).forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String action = req.getParameter("action");
    UserDAO userDAO = new UserDAO();

    if ("updateStatus".equals(action)) {
        String userIdStr = req.getParameter("userId");
        String isActiveStr = req.getParameter("isActive");
        String keywords = req.getParameter("keywords");
        String roleFilter = req.getParameter("roleFilter");
        String statusFilter = req.getParameter("statusFilter");

        if (userIdStr != null && isActiveStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                boolean isActive = Boolean.parseBoolean(isActiveStr);
                userDAO.updateUserStatus(userId, isActive);

                // Chuyển hướng về danh sách người dùng với bộ lọc hiện tại
                String redirectUrl = "Userctr?service=searchByKeywords";
                if (keywords != null && !keywords.isEmpty()) {
                    redirectUrl += "&keywords=" + URLEncoder.encode(keywords, "UTF-8");
                }
                if (roleFilter != null && !roleFilter.isEmpty()) {
                    redirectUrl += "&roleFilter=" + roleFilter;
                }
                if (statusFilter != null && !statusFilter.isEmpty()) {
                    redirectUrl += "&statusFilter=" + statusFilter;
                }
                resp.sendRedirect(redirectUrl);
                return;
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID người dùng không hợp lệ");
            }
        } else {
            req.setAttribute("error", "Thiếu tham số");
        }
    }

    // Xử lý các hành động khác (add, edit, v.v.)
    List<User_Role> users = userDAO.getAllUsersWithRoles();
    req.setAttribute("allUser", users);
    req.setAttribute("manageUser", "YES");
    req.getRequestDispatcher(HOME_URL).forward(req, resp);
    }
}