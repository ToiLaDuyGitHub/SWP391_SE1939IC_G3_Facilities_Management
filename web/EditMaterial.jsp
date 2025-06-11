<%-- 
    Document   : UpdateMaterial
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
            max-width: 1200px;
            margin: 20px auto;
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
        .suggestions-box {
            position: absolute;
            top: 100%; /* Đặt ngay dưới ô input */
            left: 25%; /* Căn giữa theo input (vì input có width: 50%) */
            width: 50%; /* Cùng chiều rộng với input */
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none; /* Ẩn mặc định */
        }
        .suggestion-item {
            padding: 10px;
            cursor: pointer;
            font-family: Arial, sans-serif;
            font-size: 14px;
            border-bottom: 1px solid #eee;
        }
        .suggestion-item:last-child {
            border-bottom: none;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
    </style>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="content" id="contentArea">
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


                    <form action="${pageContext.request.contextPath}/search-material" method="get">
                        <div class="form-group">
                            <div class="search-container">
                                <input type="text" id="searchMaterial" name="searchMaterial" placeholder="Nhập tên vật tư để tìm kiếm" value="${param.searchMaterial}">
                                <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                                <div id="suggestionsBox" class="suggestions-box"></div>
                            </div>
                        </div>
                    </form>  
                    <form id="editMaterialForm" action="${pageContext.request.contextPath}/edit-material" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="materialID" value="${material != null ? material.materialID : ''}">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="materialName"><i class="fas fa-box"></i> Tên vật tư</label>
                                <input type="text" id="materialName" name="materialName" value="${material != null ? material.materialName : ''}" required>
                            </div>
                            <!-- Danh mục (dropdown để chọn danh mục con) -->
                            <div class="form-group">
                                <label for="subcategory"><i class="fas fa-folder"></i> Danh mục</label>
                                <select id="subcategory" name="subcategoryID" required>
                                    <c:forEach var="subcategory" items="${subcategoryList}">
                                        <option value="${subcategory.subcategoryID}" ${material != null && material.subcategory != null && material.subcategory.subcategoryID == subcategory.subcategoryID ? 'selected' : ''}>
                                            ${subcategory.subcategoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="quantity"><i class="fas fa-sort-numeric-up"></i> Số lượng</label>
                                <input type="number" id="quantity" name="quantity" value="${material != null ? material.quantity : ''}">
                            </div>
                            <div class="form-group">
                                <label><i class="fas fa-info-circle"></i> Tình trạng</label>
                                <div style="display: flex; gap: 10px;">
                                    <div style="flex: 1;">
                                        <label for="statusNew">Mới</label>
                                        <input type="number" id="statusNew" name="statusNew" min="0" 
                                               value="${material != null && material.condition != null ? material.condition.newQuantity : '0'}">
                                    </div>
                                    <div style="flex: 1;">
                                        <label for="statusOld">Cũ</label>
                                        <input type="number" id="statusOld" name="statusOld" min="0" 
                                               value="${material != null && material.condition != null ? material.condition.usableQuantity : '0'}">
                                    </div>
                                    <div style="flex: 1;">
                                        <label for="statusDamaged">Hỏng</label>
                                        <input type="number" id="statusDamaged" name="statusDamaged" min="0" 
                                               value="${material != null && material.condition != null ? material.condition.brokenQuantity : '0'}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="supplier"><i class="fas fa-truck"></i> Nhà cung cấp</label>
                                <input type="text" id="supplier" name="supplier" value="${material != null && material.supplierID != null ? material.supplierID.supplierName : ''}">
                            </div>
                            <!-- Địa chỉ nhà cung cấp -->
                            <div class="form-group">
                                <label for="supplierAddress"><i class="fas fa-map-marker-alt"></i> Địa chỉ nhà cung cấp</label>
                                <input type="text" id="supplierAddress" name="supplierAddress" 
                                       value="${material != null && material.supplierID != null && material.supplierID.address != null ? material.supplierID.address : ''}">
                            </div>
                            <!-- Số điện thoại nhà cung cấp -->
                            <div class="form-group">
                                <label for="supplierPhone"><i class="fas fa-phone"></i> Số điện thoại nhà cung cấp</label>
                                <input type="text" id="supplierPhone" name="supplierPhone" 
                                       value="${material != null && material.supplierID != null && material.supplierID.phoneNum != null ? material.supplierID.phoneNum : ''}">
                            </div>
                            <div class="form-group">
                                <label for="image"><i class="fas fa-image"></i> Hình ảnh</label>
                                <img id="materialImage" class="image-display" src="${material != null ? material.image : ''}" alt="Hình ảnh vật tư" style="display: ${material != null && material.image != null ? 'block' : 'none'};">
                                <input type="file" id="image" name="image" accept="image/*">
                                <input type="hidden" id="imageUrlaceous" name="imageUrl" value="${material != null ? material.image : ''}">
                            </div>
                        </div>
                        <div class="form-group form-actions">
                            <button type="submit" class="submit-btn"><i class="fas fa-plus"></i> Thay đổi</button>
                        </div>
                    </form>
                    <!-- Form xóa được tách ra ngoài form chỉnh sửa -->
                    <c:if test="${not empty material}">
                        <form action="${pageContext.request.contextPath}/delete-material" method="post" style="display: inline;">
                            <div class="form-group form-actions">
                                <input type="hidden" name="materialID" value="${material.materialID}">
                                <input type="hidden" name="materialName" value="${material.materialName}">
                                <button type="submit" class="cancel-btn"><i class="fas fa-trash"></i> Xóa vật tư</button>
                            </div> 
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
            const facilities = [
            <c:forEach var="material" items="${allMaterials}" varStatus="loop">
            "${material.materialName}"${loop.last ? '' : ','}
            </c:forEach>
            ];

            document.addEventListener('DOMContentLoaded', function () {
            const searchInput = document.getElementById('searchMaterial');
                    const suggestionsBox = document.getElementById('suggestionsBox');


        </script>
    </body>
</html>