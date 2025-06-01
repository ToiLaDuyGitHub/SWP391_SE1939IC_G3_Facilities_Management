package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class Manager_UserController extends HttpServlet {
    private static final String HOME_URL = "home.jsp";

    @Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String service = req.getParameter("service");
    if (service == null || service.trim().isEmpty()) {
        service = "listAllUser";
    }

    UserDAO userDAO = new UserDAO();
    List<User> users;

    switch (service) {
        case "listAllUser":
            users = userDAO.getAllUser();
            req.setAttribute("manageUser", "YES");
            req.setAttribute("allUser", users);
            break;

        case "searchByKeywords":
            String keywords = req.getParameter("keywords");
            if (keywords == null) {
                keywords = "";
            }
            req.setAttribute("keywords", keywords.trim());
            req.setAttribute("manageUser", "YES");
            users = userDAO.getUserByName(keywords.trim());
            if (users == null || users.isEmpty()) {
                req.setAttribute("notFoundUser", "Không tìm thấy người dùng với từ khóa: " + keywords);
                users = new ArrayList<>();
            }
            req.setAttribute("allUser", users);
            break;

        case "userDetail":
            String userIdStr = req.getParameter("userId");
            if (userIdStr != null && !userIdStr.isEmpty()) {
                try {
                    int userId = Integer.parseInt(userIdStr);
                    User detailUser = userDAO.getUserById(userId);
                    if (detailUser != null) {
                        req.setAttribute("detailUser", detailUser);
                        req.setAttribute("manageUser", "YES");
                    } else {
                        req.setAttribute("error", "Không tìm thấy người dùng với ID: " + userId);
                    }
                } catch (NumberFormatException e) {
                    req.setAttribute("error", "ID người dùng không hợp lệ: " + userIdStr);
                }
            } else {
                req.setAttribute("error", "Thiếu tham số userId");
            }
            break;

        default:
            users = userDAO.getAllUser();
            req.setAttribute("manageUser", "YES");
            req.setAttribute("allUser", users);
            break;
    }

    req.getRequestDispatcher(HOME_URL).forward(req, resp);
}
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String action = req.getParameter("action");
    UserDAO userDAO = new UserDAO();

    if ("add".equals(action)) {
        // Logic thêm người dùng (giữ nguyên)
    } else if ("edit".equals(action)) {
        // Logic sửa người dùng (giữ nguyên)
    } else if ("updateStatus".equals(action)) {
        // Lấy tham số từ form
        String userIdStr = req.getParameter("userId");
        String isActiveStr = req.getParameter("isActive");

        if (userIdStr != null && isActiveStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                boolean isActive = Boolean.parseBoolean(isActiveStr); // Chuyển đổi "true" hoặc "false" thành boolean

                // Lấy thông tin người dùng từ cơ sở dữ liệu
                User user = userDAO.getUserById(userId);
                if (user != null) {
                    // Cập nhật trạng thái
                    user.setIsActive(isActive);
                    userDAO.updateUser(user, userId); // Gọi phương thức updateUser trong UserDAO
                    req.setAttribute("message", "Cập nhật trạng thái thành công!");
                } else {
                    req.setAttribute("error", "Không tìm thấy người dùng với ID: " + userId);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID người dùng không hợp lệ: " + userIdStr);
            }
        } else {
            req.setAttribute("error", "Thiếu tham số userId hoặc isActive");
        }
    }

    // Sau khi xử lý action, lấy lại danh sách người dùng và chuyển tiếp về home.jsp
    List<User> users = userDAO.getAllUser();
    req.setAttribute("allUser", users);
    req.setAttribute("manageUser", "YES");
    req.getRequestDispatcher(HOME_URL).forward(req, resp);
}
}