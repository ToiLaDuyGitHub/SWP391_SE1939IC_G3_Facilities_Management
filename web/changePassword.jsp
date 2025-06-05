<%-- 
    Document   : Profile
    Created on : May 27, 2025, 10:21:17 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.dto.User_Role" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Trang chủ</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="content" id="contentArea">
                <div class="content-card" id="changePasswordSection">
                    <h2 class="fas fa-lock"> Thay đổi mật khẩu</h2>
                    <div class="profile-card">
                        <form action="change-password" method="post">
                            <div class="form-row">
                                <label for="currentPassword">Mật khẩu hiện tại:</label>
                                <input type="password" id="currentPassword" name="currentPassword" required>
                            </div>
                            <div class="form-row">
                                <label for="newPassword">Mật khẩu mới:</label>
                                <input type="password" id="newPassword" name="newPassword" required>
                            </div>
                            <div class="form-row">
                                <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required>
                            </div>
                            <button type="submit">Thay đổi mật khẩu</button>
                            <c:if test="${not empty requestScope.error}">
                                <p class="error-message" style="color: red;">${requestScope.error}</p>
                            </c:if>
                            <c:if test="${not empty requestScope.success}">
                                <p class="success-message" style="color: green;">${requestScope.success}</p>
                            </c:if>
                        </form>
                    </div>
                </div>
                <div class="content-card hidden" id="genericSection"></div>
            </div>
            <!-- Placeholder for static sections -->
            <div class="content-card hidden" id="genericSection"></div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
            const profileSection = document.getElementById('changePasswordSection');
                    if (profileSection) {
            profileSection.classList.remove('hidden');
            }
        </script>
    </body>
</html>
