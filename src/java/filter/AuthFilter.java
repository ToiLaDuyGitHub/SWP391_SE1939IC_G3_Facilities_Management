package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * @author ToiLaDuyGitHub
 */
@WebFilter("/*") // Áp dụng cho tất cả URL
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        HttpSession session = httpRequest.getSession(false);

        // Xóa materials nếu không phải create-export-order hoặc add-material-modal
        if (session != null && !path.contains("/create-export-order") && !path.contains("/add-material-modal")) {
            if (session.getAttribute("materials") != null) {
                session.removeAttribute("materials");
                System.out.println("Đã xóa session attribute 'materials' cho URL: " + path);
            }
        }
        // Kiểm tra trạng thái đăng nhập
        boolean isLoggedIn = (session != null && session.getAttribute("username") != null);

        // Cho phép truy cập các trang công khai (login, register, CSS/JS...)
        if (path.startsWith("/css") || path.startsWith("/js") || path.startsWith("/error")) {
            chain.doFilter(request, response);
            return;
        }

        // Rule 1: Đã đăng nhập mà cố truy cập trang login/register → về home
        if (isLoggedIn && (path.startsWith("/login") || path.equals("/reset-password"))) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
            return;
        }

        // Rule 2: Chưa đăng nhập mà truy cập trang cần auth → về login
        if (!isLoggedIn && !path.equals("/") && !path.startsWith("/login")
                && !path.startsWith("/reset-password") && !path.startsWith("/reset-otp")
                && !path.startsWith("/create-new-password")) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Rule 3: CHỈ kiểm tra quyền truy cập khi đã đăng nhập
//        if (isLoggedIn) {
//            List<String> permittedUrls = Optional.ofNullable((List<String>) session.getAttribute("permittedUrls"))
//                    .orElse(new ArrayList<>());
//
//            // Nếu đã đăng nhập nhưng truy cập vào những trang không được cho phép → về home
//            if (!permittedUrls.contains(path) && !path.equals("/home") && !path.equals("/logout")) {
//                httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
//                return;
//            }
//        }

        //Cho phép truy cập nếu không vi phạm rule nào
        chain.doFilter(request, response);
    }
}
