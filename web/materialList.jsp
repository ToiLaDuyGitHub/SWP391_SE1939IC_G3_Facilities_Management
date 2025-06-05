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
                                    <td>${material.quantity}</td>
                                    <td>
                                        <c:if test="${not empty material.image}">
                                            <img src="${material.image}" alt="${material.materialName}" class="product-image">
                                        </c:if>
                                        <c:if test="${empty material.image}">
                                            <span>Không có hình ảnh</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <button class="edit-button" onclick="showMaterialDetail('${material.materialName}',
                                                        '${material.category.categoryName}', '${material.subcategory.subcategoryName}',
                                                        '${material.supplierID.supplierName}', ${material.quantity},
                                                ${material.condition.newQuantity}, ${material.condition.usableQuantity},
                                                ${material.condition.brokenQuantity}, '${material.image}',
                                                        '${material.detail}')">Chi tiết</button>                                
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination Controls -->
                    <div class="pagination">
                        <c:if test="${page > 1}">
                            <a href="${pageContext.request.contextPath}/MaterialList?page=${page - 1}">&laquo; Trước</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="${pageContext.request.contextPath}/MaterialList?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <c:if test="${page < totalPages}">
                            <a href="${pageContext.request.contextPath}/MaterialList?page=${page + 1}">Tiếp &raquo;</a>
                        </c:if>
                    </div>
                </div>

                <!-- Modal chi tiết vật tư -->
                <div id="editModalOverlay" class="modal-overlay" onclick="closeEditModal()"></div>
                <div id="editModal" class="modal">
                    <span class="close" onclick="closeEditModal()">×</span>
                    <h3>Chi tiết vật tư</h3>
                    <div class="info-row">
                        <label>Tên vật tư:</label>
                        <span id="materialName"></span>
                    </div>
                    <div class="info-row">
                        <label>Danh mục:</label>
                        <span id="category"></span>
                    </div>
                    <div class="info-row">
                        <label>Danh mục con:</label>
                        <span id="subcategory"></span>
                    </div>
                    <div class="info-row">
                        <label>Nhà cung cấp:</label>
                        <span id="supplier"></span>
                    </div>
                    <div class="info-row">
                        <label>Số lượng tổng:</label>
                        <span id="quantity"></span>
                    </div>
                    <div class="info-row">
                        <label>Số lượng mới:</label>
                        <span id="newQuantity"></span>
                    </div>
                    <div class="info-row">
                        <label>Số lượng sử dụng được:</label>
                        <span id="usableQuantity"></span>
                    </div>
                    <div class="info-row">
                        <label>Số lượng hỏng:</label>
                        <span id="brokenQuantity"></span>
                    </div>
                    <div class="info-row">
                        <label>Chi tiết:</label>
                        <span id="detail"></span>
                    </div>
                    <div class="info-row">
                        <label>Hình ảnh:</label>
                        <span><img id="materialImage" src="" alt="Hình ảnh vật tư" style="display: none;"></span>
                    </div>
                </div>

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