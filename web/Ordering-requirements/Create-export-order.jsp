<%-- 
    Document   : Create-export-order
    Created on : Jun 11, 2025, 03:45 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn Xuất Kho</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .content-card {
                max-width: 1200px;
                margin: 20px auto;
                padding: 10px;
            }
            .main-content {
                display: flex;
                gap: 20px;
                align-items: flex-start;
            }
            .main-content form {
                flex: 1;
                max-width: 700px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
                background: #fff;
            }
            table thead {
                background: #f39c12;
                color: #fff;
            }
            table th {
                padding: 12px 15px;
                min-width: 90px;
                text-align: left;
                font-weight: 600;
            }
            table td {
                padding: 12px 15px;
                border-bottom: 1px solid #e2e8f0;
                font-size: 16px;
            }
            .summary {
                flex: 0 0 200px;
                padding: 10px;
                background: #e9ecef;
                border-radius: 6px;
                text-align: left;
                max-height: 300px;
                overflow-y: auto;
            }
            .submit-btn, .add-material-btn {
                padding: 10px 20px;
                background: #28a745;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                transition: background 0.3s, transform 0.2s;
            }
            .submit-btn:hover, .add-material-btn:hover {
                background: #218838;
                transform: scale(1.05);
            }
            .delete-btn {
                padding: 8px 16px;
                background: #dc3545;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                transition: background 0.3s, transform 0.2s;
                text-decoration: none; /* Loại bỏ gạch chân mặc định của <a> */
                display: inline-block; /* Đảm bảo định dạng như button */
            }
            .delete-btn:hover {
                background: #c82333;
                transform: scale(1.05);
            }
            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                z-index: 1000;
                width: 900px;
                max-height: 80vh;
                overflow-y: auto;
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            .modal.active {
                display: block;
                opacity: 1;
            }
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            .modal-overlay.active {
                display: block;
                opacity: 1;
            }
            .close {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 24px;
                background: none;
                border: none;
                cursor: pointer;
                color: #000;
                padding: 0;
            }
            .close:hover {
                color: #dc3545;
            }
            .search-container {
                width: 100%;
                margin-bottom: 20px;
            }
            .search-container input[type="text"] {
                width: 60%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                transition: border 0.3s, box-shadow 0.3s, transform 0.2s;
                height: 31px;
                box-sizing: border-box;
            }
            .search-container input[type="text"]:focus {
                border-color: #f9a825;
                box-shadow: 0 0 8px rgba(249, 168, 37, 0.3);
                transform: scale(1.01);
                outline: none;
            }
            #contentArea {
                position: relative;
                z-index: 1;
            }
            textarea {
                width: 100%;
                min-height: 60px;
                resize: vertical;
                box-sizing: border-box;
            }
            .add-button-container {
                margin-top: 20px;
                text-align: center;
            }
            .message {
                margin-top: 10px;
                padding: 10px;
                border-radius: 5px;
                display: ${not empty successMessage or not empty errorMessage ? 'block' : 'none'};
            }
            .success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .unit-dropdown {
                width: 100px;
                padding: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="/sidebar.jsp" %>
            <div class="content" id="contentArea">
                <div class="content-card">
                    <h2>Đơn xuất kho</h2>
                    <div class="main-content">
                        <form action="${pageContext.request.contextPath}/create-export-order" method="post">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Tên vật tư</th>
                                        <th class="col-soluong">Số lượng</th>
                                        <th>Đơn vị</th>
                                        <th>Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="selectedMaterial" items="${selectedMaterials}">
                                        <tr>
                                            <td>${selectedMaterial.materialName}</td>
                                            <td><input type="number" name="quantities[${selectedMaterial.materialID}]" value="1" min="0" style="width: 50px; text-align: center;"></td>
                                            <td>
                                                <select name="units[${selectedMaterial.materialID}]" class="unit-dropdown">
                                                    <option value="${selectedMaterial.minUnit}">${selectedMaterial.minUnit}</option>
                                                    <c:if test="${not empty selectedMaterial.maxUnit}">
                                                        <option value="${selectedMaterial.maxUnit}">${selectedMaterial.maxUnit}</option>
                                                    </c:if>
                                                </select>
                                            </td>
                                            <td>
                                               <a href="${pageContext.request.contextPath}/delete-select-material?materialId=${selectedMaterial.materialID}" class="delete-btn">Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="summary">
                                <p>Người nhận: giám đốc</p>
                                <p>Số lượng vật tư: <c:out value="${selectedMaterials != null ? selectedMaterials.size() : 0}" /></p>
                                <label for="notes">Ghi chú:</label>
                                <textarea id="notes" name="notes" rows="3" placeholder="Nhập ghi chú..."></textarea>
                                <button type="submit" class="submit-btn">Gửi đơn</button>
                            </div>
                        </form>
                    </div>
                    <div class="add-button-container">
                        <button id="openModalBtn" class="add-material-btn">Thêm vật tư vào đơn</button>
                    </div>

                    <!-- Hiển thị thông báo -->
                    <div class="message ${not empty successMessage ? 'success' : (not empty errorMessage ? 'error' : '')}">
                        <c:if test="${not empty successMessage}">
                            ${successMessage}
                        </c:if>
                        <c:if test="${not empty errorMessage}">
                            ${errorMessage}
                        </c:if>
                    </div>

                    <!-- Modal -->
                    <div id="addMaterialModal" class="modal">
                        <span class="close" onclick="closeModal()">×</span>
                        <div class="search-container">
                            <input type="text" id="searchInput" placeholder="Nhập để tìm kiếm vật tư">
                        </div>
                        <form action="${pageContext.request.contextPath}/add-material-modal" method="post">
                            <input type="hidden" name="action" value="addMaterials">
                            <table id="materialTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên vật tư</th>
                                        <th>Tên nhà cung cấp</th>
                                        <th>Đơn vị</th>
                                        <th>Chọn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="material" items="${materials}">
                                        <c:set var="isSelected" value="false"/>
                                        <c:forEach var="selected" items="${selectedMaterials}">
                                            <c:if test="${selected.materialID == material.materialID}">
                                                <c:set var="isSelected" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!isSelected}">
                                            <tr>
                                                <td>${material.materialID}</td>
                                                <td>${material.materialName}</td>
                                                <td>${material.supplierName}</td>
                                                <td>${material.minUnit}</td>
                                                <td><input type="checkbox" name="materialIds" value="${material.materialID}"></td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <button type="submit" class="submit-btn">Thêm</button>
                        </form>
                    </div>
                    <div id="addMaterialModalOverlay" class="modal-overlay"></div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Lấy các phần tử
                const openModalBtn = document.getElementById('openModalBtn');
                const modal = document.getElementById('addMaterialModal');
                const overlay = document.getElementById('addMaterialModalOverlay');
                const searchInput = document.getElementById('searchInput');

                // Mở modal
                openModalBtn.onclick = function () {
                    modal.classList.add('active');
                    overlay.classList.add('active');
                }

                // Đóng modal
                function closeModal() {
                    modal.classList.remove('active');
                    overlay.classList.remove('active');
                    searchInput.value = ''; // Xóa ô tìm kiếm
                    searchMaterials(); // Hiển thị lại các vật tư chưa được chọn
                }

                // Đóng modal khi nhấn nút đóng hoặc overlay
                document.querySelectorAll('.close, #addMaterialModalOverlay').forEach(function (element) {
                    element.onclick = closeModal;
                });

                // Hàm tìm kiếm vật tư
                function searchMaterials() {
                    const keyword = searchInput.value.toLowerCase(); // Lấy từ khóa
                    const table = document.getElementById('materialTable');
                    const rows = table.getElementsByTagName('tr');

                    // Duyệt qua các hàng (bỏ hàng tiêu đề)
                    for (var i = 1; i < rows.length; i++) {
                        const cells = rows[i].cells;
                        const materialName = cells[1].textContent.toLowerCase(); // Tên vật tư
                        const supplierName = cells[2].textContent.toLowerCase(); // Nhà cung cấp
                        // Hiển thị hàng nếu khớp
                        if (materialName.includes(keyword) || supplierName.includes(keyword)) {
                            rows[i].style.display = '';
                        } else {
                            rows[i].style.display = 'none';
                        }
                    }
                }

                // Tìm kiếm khi gõ
                searchInput.onkeyup = searchMaterials;
            });
        </script>
    </body>
</html>