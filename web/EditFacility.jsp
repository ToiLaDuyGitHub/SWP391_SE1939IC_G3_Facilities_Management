<%-- 
    Document   : UpdateFacility
    Created on : 31 thg 5, 2025, 16:46:37
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
    </head>
    <style>
         .content-card {
                max-width: 1250px;
            }
        .search-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .search-container input[type="text"] {
            width: 50%;
            padding: 12px;
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
        .image-display {
            max-width: 100%; /* Đảm bảo hình ảnh không vượt quá chiều rộng của container */
            height: auto; /* Giữ tỷ lệ khung hình của hình ảnh */
            max-height: 300px; /* Giới hạn chiều cao tối đa của hình ảnh */
            object-fit: contain; /* Đảm bảo hình ảnh được hiển thị đầy đủ mà không bị cắt */
            margin: 10px 0; /* Thêm khoảng cách trên và dưới hình ảnh */
            border-radius: 6px; /* Bo góc hình ảnh để trông đẹp hơn */
        }
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
                            <a href="${pageContext.request.contextPath}/AddFacility" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                            <a href="EditFacility.jsp" style="color: blue; background-color: orange;" onclick="showContent('EditFacility', this)">Sửa thông tin vật tư</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content">
                <div class="content-card">
                    <h2><i class="fas fa-boxes"></i> Sửa thông tin vật tư</h2>
                    <!-- Thêm thông báo cho cập nhật và xóa vật tư -->
                    <c:if test="${not empty successMessage}">
                        <div class="success-message">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="success-message">
                            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/SearchFacility" method="get">
                        <div class="form-group">
                            <div class="search-container">
                                <input type="text" id="searchMaterial" name="searchMaterial" placeholder="Nhập tên vật tư để tìm kiếm" value="${param.searchMaterial}">
                                <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                            </div>
                        </div>
                    </form>  
                    <form id="editMaterialForm" action="${pageContext.request.contextPath}/EditFacility" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="facilityID" value="${facility != null ? facility.facilityID : ''}">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="materialName"><i class="fas fa-box"></i> Tên vật tư</label>
                                <input type="text" id="materialName" name="materialName" value="${facility != null ? facility.facilityName : ''}" required>
                            </div>
                            <!-- Danh mục (dropdown để chọn danh mục con) -->
                            <div class="form-group">
                                <label for="subcategory"><i class="fas fa-folder"></i> Danh mục</label>
                                <select id="subcategory" name="subcategoryID" required>
                                    <c:forEach var="subcategory" items="${subcategoryList}">
                                        <option value="${subcategory.subcategoryID}" ${facility != null && facility.subcategory != null && facility.subcategory.subcategoryID == subcategory.subcategoryID ? 'selected' : ''}>
                                            ${subcategory.subcategoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="quantity"><i class="fas fa-sort-numeric-up"></i> Số lượng</label>
                                <input type="number" id="quantity" name="quantity" value="${facility != null ? facility.quantity : ''}">
                            </div>
                            <div class="form-group">
                                <label><i class="fas fa-info-circle"></i> Tình trạng</label>
                                <div style="display: flex; gap: 10px;">
                                    <div style="flex: 1;">
                                        <label for="statusNew">Mới</label>
                                        <input type="number" id="statusNew" name="statusNew" min="0" 
                                               value="${facility != null && facility.condition != null ? facility.condition.newQuantity : '0'}">
                                    </div>
                                    <div style="flex: 1;">
                                        <label for="statusOld">Cũ</label>
                                        <input type="number" id="statusOld" name="statusOld" min="0" 
                                               value="${facility != null && facility.condition != null ? facility.condition.usableQuantity : '0'}">
                                    </div>
                                    <div style="flex: 1;">
                                        <label for="statusDamaged">Hỏng</label>
                                        <input type="number" id="statusDamaged" name="statusDamaged" min="0" 
                                               value="${facility != null && facility.condition != null ? facility.condition.brokenQuantity : '0'}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="supplier"><i class="fas fa-truck"></i> Nhà cung cấp</label>
                                <input type="text" id="supplier" name="supplier" value="${facility != null && facility.supplierID != null ? facility.supplierID.supplierName : ''}">
                            </div>
                            <!-- Địa chỉ nhà cung cấp -->
                            <div class="form-group">
                                <label for="supplierAddress"><i class="fas fa-map-marker-alt"></i> Địa chỉ nhà cung cấp</label>
                                <input type="text" id="supplierAddress" name="supplierAddress" 
                                       value="${facility != null && facility.supplierID != null && facility.supplierID.address != null ? facility.supplierID.address : ''}">
                            </div>
                            <!-- Số điện thoại nhà cung cấp -->
                            <div class="form-group">
                                <label for="supplierPhone"><i class="fas fa-phone"></i> Số điện thoại nhà cung cấp</label>
                                <input type="text" id="supplierPhone" name="supplierPhone" 
                                       value="${facility != null && facility.supplierID != null && facility.supplierID.phoneNum != null ? facility.supplierID.phoneNum : ''}">
                            </div>
                            <div class="form-group">
                                <label for="image"><i class="fas fa-image"></i> Hình ảnh</label>
                                <img id="materialImage" class="image-display" src="${facility != null ? facility.image : ''}" alt="Hình ảnh vật tư" style="display: ${facility != null && facility.image != null ? 'block' : 'none'};">
                                <input type="file" id="image" name="image" accept="image/*">
                                <input type="hidden" id="imageUrlaceous" name="imageUrl" value="${facility != null ? facility.image : ''}">
                            </div>
                        </div>
                        <div class="form-group form-actions">
                            <button type="submit" class="submit-btn"><i class="fas fa-plus"></i> Thay đổi</button>
                        </div>
                    </form>
                    <!-- Form xóa được tách ra ngoài form chỉnh sửa -->
                    <c:if test="${not empty facility}">
                        <form action="${pageContext.request.contextPath}/DeleteFacility" method="post" style="display: inline;">
                           <div class="form-group form-actions">
                            <input type="hidden" name="facilityID" value="${facility.facilityID}">
                            <input type="hidden" name="materialName" value="${facility.facilityName}">
                            <button type="submit" class="cancel-btn"><i class="fas fa-trash"></i> Xóa vật tư</button>
                           </div> 
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
            // Xóa đoạn mã JavaScript hiển thị thông báo trước đó
            document.addEventListener('DOMContentLoaded', function () {
                const profileSection = document.getElementById('');
                if (profileSection) {
                    profileSection.classList.remove('hidden');
                }
            });
        </script>
    </body>
</html>