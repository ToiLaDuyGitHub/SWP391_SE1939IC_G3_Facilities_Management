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
            <div class="header">
                <h1><i class="fas fa-hard-hat"></i> Hệ thống Quản lý Xây dựng</h1>
                <div class="actions">
                    <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                    <div class="user-info">
                        <i class="fas fa-user-circle"></i>
                        <div class="tooltip">
                            <p class="position">Quản lý</p>
                            <p>${not empty sessionScope.user ? sessionScope.user.fullName : 'Chưa đăng nhập'}</p>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
                        <button type="submit" class="logout-button" onclick="logout()">Đăng xuất</button>
                    </form>
                </div>
            </div>
            <div class="sidebar" id="sidebar">
                <h3><i class="fas fa-tools"></i> Menu</h3>
                <ul>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-users"></i> Quản lý người dùng</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('userList', this)">Xem danh sách người dùng</a>
                            <a href="#" onclick="showContent('addUser', this)">Thêm mới người dùng</a>
                            <a href="#" onclick="showContent('editUser', this)">Sửa thông tin người dùng</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-boxes"></i>Phân quyền</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="Decentralization.jsp" onclick="showContent('materialList', this)">Phân quyền chức năng</a>
                        </div>
                    </li>
                    <li class="dropdown active">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-user"></i> Thông tin cá nhân</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/Profile">Xem thông tin cá nhân</a>
                            <a href="${pageContext.request.contextPath}/changePassword" style="color: blue; background-color: orange;" onclick="showContent('changePasswordSection', this)">Thay đổi mật khẩu</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-folder"></i> Quản lý danh mục vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('categoryListSection', this)">Xem danh mục vật tư</a>
                            <a href="#" onclick="showContent('addCategory', this)">Thêm mới danh mục vật tư</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-boxes"></i> Quản lý vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('materialList', this)">Xem danh sách vật tư</a>
                            <a href="${pageContext.request.contextPath}/AddFacility" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content" id="contentArea">
                <div class="content-card" id="changePasswordSection">
                    <h2 class="fas fa-lock"> Thay đổi mật khẩu</h2>
                    <div class="profile-card">
                        <form action="changePassword" method="post">
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
