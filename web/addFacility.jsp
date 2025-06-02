<%-- 
    Document   : addFacility
    Created on : 1 thg 6, 2025, 01:40:09
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            /* Thêm style cho thông báo */
            .success-message {
                background-color: #4caf50;
                color: #fff;
                padding: 10px;
                border-radius: 6px;
                margin: 10px 0;
                display: flex;
                align-items: center;
                gap: 8px;
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
                            <a href="${pageContext.request.contextPath}/FacilityList" onclick="showContent('materialList', this)">Xem danh sách vật tư</a>
                            <a href="${pageContext.request.contextPath}/AddFacility" style="color: blue; background-color: orange;" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                            <a href="EditFacility.jsp"  onclick="showContent('EditFacility', this)">Sửa thông tin vật tư</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content" id="contentArea">
                <!-- Add Material Section -->
                <div class="content-card" id="addMaterialSection">
                    <h2><i class="fas fa-box-open"></i> Thêm mới vật tư</h2>
                    <!-- Thông báo cho thêm vật tư -->
                    <c:if test="${not empty successMessage}">
                        <div class="success-message">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                    <form id="addMaterialForm" action="AddFacility" method="post" enctype="multipart/form-data">
                        <div class="form-grid">
                            <!-- Cột bên trái -->
                            <div class="form-column">
                                <div class="form-group">
                                    <label for="materialName"><i class="fas fa-tag"></i> Tên vật tư:</label>
                                    <input type="text" id="materialName" name="FacilityName" placeholder="Nhập tên vật tư" required>
                                </div>
                                <div class="form-group">
                                    <label for="supplierName"><i class="fas fa-building"></i> Tên nhà cung cấp:</label>
                                    <input type="text" id="supplierName" name="SupplierName" placeholder="Nhập tên nhà cung cấp" required>
                                </div>
                                <div class="form-group">
                                    <label for="supplierAddress"><i class="fas fa-map-marker-alt"></i> Địa chỉ nhà cung cấp:</label>
                                    <input type="text" id="supplierAddress" name="Address" placeholder="Nhập địa chỉ nhà cung cấp" required>
                                </div>
                                <div class="form-group">
                                    <label for="supplierPhone"><i class="fas fa-phone"></i> Số điện thoại nhà cung cấp:</label>
                                    <input type="text" id="supplierPhone" name="PhoneNum" placeholder="Nhập số điện thoại nhà cung cấp" required>
                                </div>
                                <div class="form-group">
                                    <label for="image"><i class="fas fa-image"></i> Hình ảnh:</label>
                                    <input type="file" id="image" name="Image" accept="image/*">
                                </div>
                            </div>
                            <!-- Cột bên phải -->
                            <div class="form-column">
                                <div class="form-group">
                                    <label for="subcategory"><i class="fas fa-list"></i> Danh mục:</label>
                                    <select id="subcategory" name="SubcategoryID" required>
                                        <option value="" disabled selected>Chọn danh mục</option>
                                        <c:forEach var="subcat" items="${subcategoryList}">
                                            <option value="${subcat.subcategoryID}">${subcat.subcategoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label><i class="fas fa-box"></i> Số lượng mới:</label>
                                    <input type="number" name="NewQuantity" required placeholder="Mới" min="0">
                                </div>
                                <div class="form-group">
                                    <label><i class="fas fa-box"></i> Số lượng cũ:</label>
                                    <input type="number" name="UsableQuantity" required placeholder="Cũ" min="0">
                                </div>
                            </div>
                        </div>
                        <div class="form-group form-actions">
                            <button type="submit" class="submit-btn"><i class="fas fa-plus"></i> Thêm vật tư</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
            // Tự động hiển thị 
            document.addEventListener('DOMContentLoaded', function () {
                const profileSection = document.getElementById('addMaterialSection');
                if (profileSection) {
                    profileSection.classList.remove('hidden');
                }
            });
        </script>
    </body>
</html>