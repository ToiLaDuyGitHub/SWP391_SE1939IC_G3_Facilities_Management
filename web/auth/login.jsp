<%-- 
    Document   : login
    Created on : May 22, 2025, 6:43:55 AM
    Author     : ToiLaDuyGitHub
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Quản lý Xây dựng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div id="loginPage">
        <div class="login-container">
            <h2>Đăng nhập</h2>
            <p>Chào mừng đến với Hệ thống Quản lý Xây dựng</p>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">${errorMessage}</p>
            </c:if>

            <!-- Form gửi đến Servlet -->
            <form action="login" method="post">
                <input type="text" name="username" placeholder="Tên đăng nhập" required>
                <input type="password" name="password" placeholder="Mật khẩu" required>
                <button type="submit">Đăng nhập</button>
            </form>

            <a href="#" onclick="showContent('Quên mật khẩu')">Quên mật khẩu?</a>
            <a href="#" onclick="showContent('Thay đổi mật khẩu')">Thay đổi mật khẩu</a>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>

