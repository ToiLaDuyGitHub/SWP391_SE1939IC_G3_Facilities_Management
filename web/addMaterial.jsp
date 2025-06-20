<%-- 
    Document   : addMaterial
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
            .content-card {
                max-width: 1200px;
                margin: 20px auto; 
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
            .form-group textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                resize: vertical;
                min-height: 100px;
                transition: border 0.3s, box-shadow 0.3s, transform 0.2s;
            }
            .form-group textarea:focus {
                border-color: #f9a825;
                box-shadow: 0 0 8px rgba(249, 168, 37, 0.3);
                transform: scale(1.01);
                outline: none;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
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
                    <form id="addMaterialForm" action="add-material" method="post" enctype="multipart/form-data">
                        <div class="form-grid">
                            <!-- Cột bên trái -->
                            <div class="form-column">
                                <div class="form-group">
                                    <label for="materialName"><i class="fas fa-tag"></i> Tên vật tư:</label>
                                    <input type="text" id="materialName" name="MaterialName" placeholder="Nhập tên vật tư" required>
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
                                    <label for="usableQuantity"><i class="fas fa-box"></i> Số lượng :</label>
                                    <input type="number" id="usableQuantity" name="UsableQuantity" required placeholder="Nhập số lượng " min="0">
                                </div>
                                <div class="form-group">
                                    <label for="unit"><i class="fas fa-ruler"></i> Đơn vị:</label>
                                    <select id="unit" name="UnitID" required>
                                        <option value="" disabled selected>Chọn đơn vị</option>
                                        <c:forEach var="unit" items="${unitsList}">
                                            <option value="${unit.minUnit}">${unit.minUnit}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="detail"><i class="fas fa-info-circle"></i> Chi tiết vật tư:</label>
                                    <textarea id="detail" name="Detail" placeholder="Nhập chi tiết vật tư"></textarea>
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