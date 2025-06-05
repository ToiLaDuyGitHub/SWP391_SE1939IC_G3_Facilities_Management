<%-- 
    Document   : sidebar
    Created on : Jun 3, 2025, 11:12:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.dto.User_Role" %>
<%@ page import="model.Feature" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    </head>
    <body>
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
                        <a href="${pageContext.request.contextPath}/manage-user">Xem danh sách người dùng</a>
                        <a href="${pageContext.request.contextPath}/add-user">Thêm mới người dùng</a>
                        <a href="${pageContext.request.contextPath}/reset-password-request-list">Danh sách yêu cầu reset mật khẩu</a>
                    </div>
                </li>
                <li class="dropdown">
                    <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                        <span><i class="fas fa-boxes"></i>Phân quyền</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/decentralization">Phân quyền chức năng</a>
                    </div>
                </li>

                <!-- Kiểm tra thông tin cá nhân -->
                <c:set var="hasProfile" value="false" />
                <c:forEach var="feature" items="${sessionScope.permittedFeatures}">
                    <c:if test="${fn:contains(feature.url, '/profile') || 
                                  fn:contains(feature.url, '/change-password')}">
                        <c:set var="hasProfile" value="true" />
                    </c:if>
                </c:forEach>
                
                <c:if test="${hasProfile}">
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-user"></i> Thông tin cá nhân</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <c:forEach var="feature" items="${sessionScope.permittedFeatures}">
                                <c:if test="${feature.url == '/profile'}">
                                    <a href="${pageContext.request.contextPath}/profile">Xem thông tin cá nhân</a>
                                </c:if>
                            </c:forEach>
                            
                            <c:forEach var="feature" items="${sessionScope.permittedFeatures}">
                                <c:if test="${feature.url == '/change-password'}">
                                    <a href="${pageContext.request.contextPath}/change-password">Thay đổi mật khẩu</a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </li>
                </c:if>

                <li class="dropdown">
                    <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                        <span><i class="fas fa-folder"></i> Quản lý danh mục vật tư</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/manage-category">Xem danh mục vật tư</a>
                        <a href="${pageContext.request.contextPath}/manage-category?action=addForm">Thêm mới danh mục vật tư</a>
                    </div>
                </li>
                <li class="dropdown">
                    <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                        <span><i class="fas fa-boxes"></i> Quản lý vật tư</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/manage-material" onclick="showContent('materialList', this)">Xem danh sách vật tư</a>
                        <a href="${pageContext.request.contextPath}/add-material" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                        <a href="${pageContext.request.contextPath}/edit-material"  onclick="showContent('EditMaterial', this)">Sửa thông tin vật tư</a>
                    </div>
                </li>
            </ul>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
    </body>
</html>