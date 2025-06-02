<%-- 
    Document   : Decentralization
    Created on : May 29, 2025, 2:27:13 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.dto.User_Role" %>
<%@ page import="dao.FeatureDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Quản lý Xây dựng - Trang chủ</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    <style>
        .content-card {
            max-width: 1000px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        td:first-child {
            text-align: left;
        }
        .save-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .save-button:hover {
            background-color: #0056b3;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
        }
        .info-message {
            background-color: #e2e3e5;
            color: #383d41;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
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
                <li class="dropdown active">
                    <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                        <span><i class="fas fa-boxes"></i>Phân quyền</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/Decentralization" style="color: blue; background-color: orange;" onclick="showContent('materialList', this)">Phân quyền chức năng</a>
                    </div>
                </li>
                <li class="dropdown">
                    <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                        <span><i class="fas fa-user"></i> Thông tin cá nhân</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/Profile">Xem thông tin cá nhân</a>
                        <a href="${pageContext.request.contextPath}/changePassword" onclick="showContent('changePasswordSection', this)">Thay đổi mật khẩu</a>
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
                        <a href="#" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                    </div>
                </li>
            </ul>
        </div>
        <div class="content" id="contentArea">
            <div class="content-card" id="decentralizationSection">
                <h2>Phân quyền chức năng</h2>
                <div class="profile-card">
                    <%-- Hiển thị thông báo nếu có --%>
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="message success-message">
                            ${sessionScope.successMessage}
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>
                    <c:if test="${not empty sessionScope.infoMessage}">
                        <div class="message info-message">
                            ${sessionScope.infoMessage}
                        </div>
                        <% session.removeAttribute("infoMessage"); %>
                    </c:if>
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="message error-message">
                            ${sessionScope.errorMessage}
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/UpdateDecentralization" method="post">
                        <table>
                            <thead>
                                <tr>
                                    <th>Chức năng</th>
                                    <c:forEach var="role" items="${roles}">
                                        <th>${role.roleName}</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="feature" items="${features}">
                                    <tr>
                                        <td>${feature.urlName}</td>
                                        <c:forEach var="role" items="${roles}">
                                            <td>
                                                <input type="checkbox" name="permission_${feature.urlID}_${role.roleID}" 
                                                       <c:if test="${featureDAO.hasPermission(feature.urlID, role.roleID)}">checked</c:if>>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <button type="submit" class="save-button">Lưu thay đổi</button>
                    </form>
                </div>
            </div>
            <div class="content-card hidden" id="genericSection"></div>
        </div>
    </div>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const decentralizationSection = document.getElementById('decentralizationSection');
            if (decentralizationSection) {
                decentralizationSection.classList.remove('hidden');
            }
        });
    </script>
</body>
</html>