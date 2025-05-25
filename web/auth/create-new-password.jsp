<%-- 
    Document   : create-new-password
    Created on : May 24, 2025, 11:51:00 PM
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
            <h2>Thiết lập mật khẩu mới</h2>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">${errorMessage}</p>
            </c:if>
                
            <!-- Hiển thị thông báo thành công nếu có -->
            <c:if test="${not empty successMessage}">
                <p style="color: green;">${successMessage}</p>
            </c:if>
                <h5>Mật khẩu của bạn phải có độ dài từ 6-32 ký tự, đồng thời bao gồm cả chữ số, chữ cái và ký tự đặc biệt (!$@%).</h5>
                Tài khoản bạn đang yêu cầu reset:
                <h4>${username}</h4>

            <!-- Form gửi đến Servlet -->
            <form action="create-new-password" method="post">
                <input type="text" name="username" value="${username}" hidden>
                <input type="password" name="new-password" placeholder="Mật khẩu mới" required>
                <input type="password" name="confirm-new-password" placeholder="Xác nhận mật khẩu mới" required>
                <button type="submit">Xác nhận mã OTP</button>
            </form>
            <a href="<%= request.getContextPath() %>/login">Bạn đã có tài khoản?</a>
        </div>
    </div>

    <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>



