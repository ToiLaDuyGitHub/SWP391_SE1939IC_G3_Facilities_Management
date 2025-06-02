<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Trang chủ</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
        <style>
            .content-card {
                max-width: 1550px;
                
            }
            .edit-button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 5px 10px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px;
                cursor: pointer;
                border-radius: 3px;
            }
            .edit-button:hover {
                background-color: #45a049;
            }
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            .pagination a {
                color: #4a90e2;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #ddd;
                margin: 0 4px;
                border-radius: 3px;
            }
            .pagination a.active {
                background-color: #4a90e2;
                color: white;
                border: 1px solid #4a90e2;
            }
            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }
            .search-container {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }
            .search-container input[type="text"] {
                width: 50%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                font-family: Arial, sans-serif;
                transition: border 0.3s, box-shadow 0.3s, transform 0.2s;
            }
            .search-container input[type="text"]:focus {
                border-color: #f9a825;
                box-shadow: 0 0 8px rgba(249, 168, 37, 0.3);
                transform: scale(1.01);
                outline: none;
            }
            .search-container button {
                margin-left: 10px;
                padding: 12px 20px;
                background: linear-gradient(90deg, #4a90e2, #6aa8e6);
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: background 0.3s, transform 0.2s;
            }
            .search-container button:hover {
                background: linear-gradient(90deg, #6aa8e6, #4a90e2);
                transform: scale(1.02);
            }
            .error-message {
                background-color: #f44336;
                color: #fff;
                padding: 10px;
                border-radius: 6px;
                margin: 10px 0;
                display: flex;
                align-items: center;
                gap: 8px;
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
                            <a href="${pageContext.request.contextPath}/Userctr?service=listAllUser">Xem danh sách người dùng</a>
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
                        <a href="${pageContext.request.contextPath}/Decentralization">Phân quyền chức năng</a>
                    </div>
                </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-user"></i> Thông tin cá nhân</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/Profile">Xem thông tin cá nhân</a>
                            <a href="${pageContext.request.contextPath}/changePassword">Thay đổi mật khẩu</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-folder"></i> Quản lý danh mục vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/danhmucvattu/danh-muc-list.jsp" onclick="showContent('categoryListSection', this)">Xem danh mục vật tư</a>
                            <a href="#" onclick="showContent('addCategory', this)">Thêm mới danh mục vật tư</a>
                        </div>
                    </li>
                    <li class="dropdown active">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-boxes"></i> Quản lý vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/FacilityList" style="color: blue; background-color: orange;">Xem danh sách vật tư</a>
                            <a href="${pageContext.request.contextPath}/AddFacility" ">Thêm mới vật tư</a>
                            <a href="EditFacility.jsp"  onclick="showContent('EditFacility', this)">Sửa thông tin vật tư</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content" id="contentArea">
                <div class="content-card hidden" id="materialListSection">
                    <!-- Biểu mẫu tìm kiếm -->
                    <form action="${pageContext.request.contextPath}/SearchListFacility" method="get">
                        <div class="form-group">
                            <div class="search-container">
                                <input type="text" id="searchMaterial" name="searchMaterial" placeholder="Nhập tên vật tư để tìm kiếm" value="${param.searchMaterial}">
                                <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                            </div>
                        </div>
                    </form>

                    <!-- Thông báo lỗi -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <table class="material-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên vật tư</th>
                                <th>Danh mục</th>
                                <th>Tên nhà cung cấp</th>
                                <th>Số lượng</th>
                                <th>Hình ảnh</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="page" value="${param.page != null ? param.page : 1}" />
                            <c:set var="itemsPerPage" value="7" />
                            <c:set var="start" value="${(page - 1) * itemsPerPage}" />
                            <c:set var="end" value="${start + itemsPerPage - 1}" />
                            <c:set var="totalItems" value="${facilities.size()}" />
                            <c:set var="totalPages" value="${(totalItems + itemsPerPage - 1) / itemsPerPage}" />

                            <c:forEach var="facility" items="${facilities}" begin="${start}" end="${end}">
                                <tr>
                                    <td>${facility.facilityID}</td>
                                    <td>${facility.facilityName}</td>
                                    <td>${facility.category.categoryName}</td>
                                    <td>${facility.supplierID.supplierName}</td>
                                    <td>${facility.quantity}</td>
                                    <td>
                                        <c:if test="${not empty facility.image}">
                                            <img src="${facility.image}" alt="${facility.facilityName}" class="product-image">
                                        </c:if>
                                        <c:if test="${empty facility.image}">
                                            <span>Không có hình ảnh</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <button class="edit-button" onclick="openEditModal(${facility.facilityID})">Chi tiết</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination Controls -->
                    <div class="pagination">
                        <c:if test="${page > 1}">
                            <a href="${pageContext.request.contextPath}/FacilityList?page=${page - 1}">&laquo; Trước</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="${pageContext.request.contextPath}/FacilityList?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <c:if test="${page < totalPages}">
                            <a href="${pageContext.request.contextPath}/FacilityList?page=${page + 1}">Tiếp &raquo;</a>
                        </c:if>
                    </div>
                </div>

                <!-- Overlay -->
                <div id="editModalOverlay" class="modal-overlay" onclick="closeEditModal()"></div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const profileSection = document.getElementById('materialListSection');
                        if (profileSection) {
                            profileSection.classList.remove('hidden');
                        }
                    });
        </script>
    </body>
</html>