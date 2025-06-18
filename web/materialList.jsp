<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
                padding: 3px 8px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;
                margin: 2px;
                cursor: pointer;
                border-radius: 3px;
                width: 70px;
                height: 28px;
                line-height: 22px;
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
                position: relative;
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
            .cart-button {
                background-color: #ff9800;
                color: white;
                border: none;
                padding: 3px 8px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;
                margin: 2px;
                cursor: pointer;
                border-radius: 3px;
                width: 70px;
                height: 28px;
                line-height: 22px;
            }

            .cart-button:hover {
                background-color: #f57c00;
            }

            .cart-button i {
                margin-right: 3px;
                vertical-align: middle;
            }
            .delete-button {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 3px 8px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;
                margin: 2px;
                cursor: pointer;
                border-radius: 3px;
                width: 70px;
                height: 28px;
                line-height: 22px;
            }
            .delete-button:hover {
                background-color: #d32f2f;
            }
            .delete-button i {
                margin-right: 3px;
                vertical-align: middle;
            }
            
            .modal {
                max-width: 600px;
                width: 90%;
                max-height: 80vh;
                overflow-y: auto;
            }
            .modal .form-group {
                margin-bottom: 10px;
            }
            .modal .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #666;
                font-weight: 500;
                font-size: 14px;
            }
            .modal .form-group input,
            .modal .form-group select,
            .modal .form-group textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                color: #333;
                transition: border 0.3s;
            }
            .modal .form-group textarea {
                height: 100px;
                resize: vertical;
            }
            .modal .form-group input:focus,
            .modal .form-group select:focus,
            .modal .form-group textarea:focus {
                border-color: #f9a825;
                outline: none;
            }
            .modal .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }
            .modal .form-actions {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                margin-top: 15px;
            }
            .modal img {
                max-width: 100%;
                height: auto;
                margin-top: 10px;
                max-height: 150px;
            }
            
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="content" id="contentArea">
                <div class="content-card hidden" id="materialListSection">
                    <!-- Biểu mẫu tìm kiếm -->
                    <form action="${pageContext.request.contextPath}/search-material-in-list" method="get">
                        <div class="form-group">
                            <div class="search-container">
                                <input type="text" id="searchMaterial" name="searchMaterial" placeholder="Nhập tên vật tư để tìm kiếm" value="${param.searchMaterial}">
                                <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                            </div>
                        </div>
                    </form>
                                
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="success-message">
                            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                        </div>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>

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
                            <c:set var="itemsPerPage" value="6" />
                            <c:set var="start" value="${(page - 1) * itemsPerPage}" />
                            <c:set var="end" value="${start + itemsPerPage - 1}" />
                            <c:set var="totalItems" value="${materials.size()}" />
                            <c:set var="totalPages" value="${(totalItems + itemsPerPage - 1) / itemsPerPage}" />

                            <c:forEach var="material" items="${materials}" begin="${start}" end="${end}">
                                <tr>
                                    <td>${material.materialID}</td>
                                    <td>${material.materialName}</td>
                                    <td>${material.category.categoryName}</td>
                                    <td>${material.supplierID.supplierName}</td>
                                    <td>${material.quantity.totalQuantity}</td>
                                    <td>
                                        <c:if test="${not empty material.image}">
                                            <img src="${material.image}" alt="${material.materialName}" class="product-image">
                                        </c:if>
                                        <c:if test="${empty material.image}">
                                            <span>Không có hình ảnh</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <button class="edit-button" onclick="showMaterialDetail(
                                                    ${material.materialID},
                                                        '${material.materialName}',
                                                        '${material.category.categoryName}',
                                                ${material.subcategory.subcategoryID},
                                                        '${material.supplierID.supplierName}',
                                                        '${material.supplierID.address}',
                                                        '${material.supplierID.phoneNum}',
                                                ${material.quantity.totalQuantity},
                                                ${material.quantity.usableQuantity},
                                                ${material.quantity.brokenQuantity},
                                                        '${material.image}',
                                                        '${material.detail}')">Chi tiết</button>
                                       
                                         <button class="delete-button" onclick="confirmDelete(${material.materialID})"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination Controls -->
                    <div class="pagination">
                        <c:if test="${page > 1}">
                            <a href="${pageContext.request.contextPath}/manage-material?page=${page - 1}">&laquo; Trước</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="${pageContext.request.contextPath}/manage-material?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <c:if test="${page < totalPages}">
                            <a href="${pageContext.request.contextPath}/manage-material?page=${page + 1}">Tiếp &raquo;</a>
                        </c:if>
                    </div>
                </div>

                <!-- Modal chi tiết vật tư -->
                <div id="editModalOverlay" class="modal-overlay" onclick="closeEditModal()"></div>
                <div id="editModal" class="modal">
                    <span class="close" onclick="closeEditModal()">×</span>
                    <h3>Chi tiết và sửa vật tư</h3>
                    <form id="editMaterialForm" action="${pageContext.request.contextPath}/edit-material" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="materialID" id="materialID">
                        <div class="form-group">
                            <label for="materialName">Tên vật tư:</label>
                            <input type="text" id="materialName" name="materialName" required>
                        </div>
                        <div class="form-group">
                            <label for="category">Danh mục:</label>
                            <input type="text" id="category" readonly>
                        </div>
                        <div class="form-group">
                            <label for="subcategory">Danh mục con:</label>
                            <select id="subcategory" name="subcategoryID" required>
                                <c:forEach var="subcategory" items="${subcategoryList}">
                                    <option value="${subcategory.subcategoryID}">${subcategory.subcategoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="supplier">Nhà cung cấp:</label>
                            <input type="text" id="supplier" name="supplier" required>
                        </div>
                        <div class="form-group">
                            <label for="supplierAddress">Địa chỉ nhà cung cấp:</label>
                            <input type="text" id="supplierAddress" name="supplierAddress">
                        </div>
                        <div class="form-group">
                            <label for="supplierPhone">Số điện thoại nhà cung cấp:</label>
                            <input type="text" id="supplierPhone" name="supplierPhone">
                        </div>
                        <div class="form-group">
                            <label for="quantity">Số lượng tổng:</label>
                            <input type="number" id="quantity" name="quantity" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="usableQuantity">Số lượng sử dụng được:</label>
                            <input type="number" id="usableQuantity" name="statusOld" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="brokenQuantity">Số lượng hỏng:</label>
                            <input type="number" id="brokenQuantity" name="statusDamaged" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="detail">Chi tiết:</label>
                            <input type="text" id="detail" name="detail">
                        </div>
                        <div class="form-group">
                            <label for="image">Hình ảnh:</label>
                            <input type="file" id="image" name="image" accept="image/*">
                            <input type="hidden" id="imageUrl" name="imageUrl">
                            <img id="materialImage" src="" alt="Hình ảnh vật tư" style="display: none; max-width: 100%; margin-top: 10px;">
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="submit-btn"><i class="fas fa-save"></i> Lưu</button>
                            <button type="button" class="cancel-btn" onclick="closeEditModal()"><i class="fas fa-times"></i> Hủy</button>
                        </div>
                    </form>
                        
                </div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
            
            const contextPath = "<%= request.getContextPath() %>";
        </script>
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
