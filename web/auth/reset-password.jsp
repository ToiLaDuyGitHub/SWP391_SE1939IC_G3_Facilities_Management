<%-- 
    Document   : resetpassword
    Created on : May 23, 2025, 6:52:24 AM
    Author     : ToiLaDuyGitHub
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset mật khẩu - Hệ thống quản lý xây dựng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div id="loginPage">
        <div class="login-container">
            <h2>Reset mật khẩu</h2>
            <p>Vui lòng nhập gmail đã được đăng ký<br/>
                trên hệ thống để tạo lệnh reset mật khẩu</p>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">${errorMessage}</p>
            </c:if>

            <!-- Form gửi đến Servlet -->
            <form action="reset-password" method="post">
                <input type="text" name="username" placeholder="Gmail của bạn..." required>
                <button type="submit">Yêu cầu reset mật khẩu</button>
            </form>

            <a href="<%= request.getContextPath() %>/login">Bạn đã có tài khoản?</a>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>



