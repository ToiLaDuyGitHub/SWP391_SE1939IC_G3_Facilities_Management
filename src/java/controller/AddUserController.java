package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import java.io.IOException;
import util.CreateUserMail;
import util.PasswordUtil;
import util.ResetPassword;

@WebServlet(name = "AddUserController", urlPatterns = {"/add-user"})
public class AddUserController extends HttpServlet {

    private static final String SUCCESS_URL = "home.jsp"; // Trang hiển thị danh sách người dùng
    private static final String ERROR_URL = "addUser.jsp"; // Trang form thêm người dùng (nếu lỗi)

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("add".equals(action)) {
            try {
                // Lấy dữ liệu từ form
                String username = req.getParameter("username");
                String firstName = req.getParameter("firstName");
                String lastName = req.getParameter("lastName");
                String phoneNum = req.getParameter("phoneNum");
                String address = req.getParameter("address");
                int roleID = Integer.parseInt(req.getParameter("roleID"));

                // Kiểm tra dữ liệu đầu vào
                if (username == null || username.trim().isEmpty()) {
                    req.setAttribute("error", "Tên đăng nhập không được để trống!");
                    req.getRequestDispatcher(ERROR_URL).forward(req, resp);
                    return;
                }

                String password = ResetPassword.generateRandomString();
                String passwordHash = PasswordUtil.hashPassword(password);
                
                // Tạo đối tượng User
                User newUser = new User(0, username, passwordHash, firstName, lastName, phoneNum, address, roleID);

                // Thêm người dùng vào cơ sở dữ liệu
                int newUserId = userDAO.insertUser(newUser);
                if (newUserId != -1) {
                    req.setAttribute("message", "Thêm người dùng thành công!");
                    // Lấy lại danh sách người dùng để hiển thị
                    req.setAttribute("allUser", userDAO.getAllUsersWithRoles());
                    req.setAttribute("manageUser", "YES");
                    CreateUserMail.sendEmail(username, password);
                    req.getRequestDispatcher(SUCCESS_URL).forward(req, resp);
                } else {
                    req.setAttribute("error", "Không thể thêm người dùng!");
                    req.getRequestDispatcher(ERROR_URL).forward(req, resp);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Vai trò không hợp lệ!");
                req.getRequestDispatcher(ERROR_URL).forward(req, resp);
            } catch (Exception e) {
                req.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
                req.getRequestDispatcher(ERROR_URL).forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Hành động không hợp lệ!");
            req.getRequestDispatcher(ERROR_URL).forward(req, resp);
        }
        
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hiển thị form thêm người dùng
        
        req.getRequestDispatcher(ERROR_URL).forward(req, resp);
    }
}