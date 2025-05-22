/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
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
        boolean isLoggedIn = (session != null && session.getAttribute("username") != null);
        
        // Cho phép truy cập các trang công khai (login, register, CSS/JS...)
        if (path.startsWith("/css") || path.startsWith("/js") || path.startsWith("/error")) {
            chain.doFilter(request, response);
            return;
        }

        // Rule 1: Đã đăng nhập mà cố truy cập trang login/register → về home
        if (isLoggedIn && (path.startsWith("/login") || path.startsWith("/register"))) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
            return;
        }

        // Rule 2: Chưa đăng nhập mà truy cập trang cần auth → về login
        if (!isLoggedIn && !path.equals("/") && !path.startsWith("/login")) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Cho phép truy cập nếu không vi phạm rule nào
        chain.doFilter(request, response);
    }
}
