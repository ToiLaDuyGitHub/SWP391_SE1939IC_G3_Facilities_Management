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
            <h2>Nhập mã OTP để reset</h2>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">${errorMessage}</p>
            </c:if>
                
            <!-- Hiển thị thông báo thành công nếu có -->
            <c:if test="${not empty successMessage}">
                <p style="color: green;">${successMessage}</p>
            </c:if>
                Tài khoản bạn đang yêu cầu reset:
                <h4>${username}</h4>

            <!-- Form gửi đến Servlet -->
            <form action="reset-otp" method="post">
                <input type="text" name="username" value="${username}" hidden>
                <input type="text" name="resetOTP" placeholder="Mã OTP..." required>
                <button type="submit">Xác nhận mã OTP</button>
            </form>
            <a href="<%= request.getContextPath() %>/login">Bạn đã có tài khoản?</a>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>



