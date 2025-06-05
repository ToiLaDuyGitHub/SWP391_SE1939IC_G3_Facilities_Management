<%-- 
    Document   : add-category
    Created on : Jun 1, 2025, 10:52:57 PM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Thêm danh mục vật tư</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
        <style>
            .active-link {
                font-weight: 600;
                color: #0d6efd !important;
                background-color: #e9ecef;
                border-radius: 4px;
            }
            .main-content {
                margin-left: 250px;
                padding: 20px;
                transition: margin-left 0.3s;
            }

            .sidebar-collapsed + .main-content {
                margin-left: 80px;
            }

            .form-container {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                padding: 30px;
                max-width: 800px;
                margin: 0 auto;
            }

            .form-header {
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 2px solid #f1f1f1;
                padding-bottom: 20px;
            }

            .form-header h2 {
                color: #0d6efd;
                margin: 0;
                font-size: 1.8em;
            }

            .form-header p {
                color: #6c757d;
                margin: 10px 0 0 0;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
                font-size: 14px;
            }

            .form-input {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 14px;
                transition: border-color 0.3s;
                box-sizing: border-box;
            }

            .form-input:focus {
                outline: none;
                border-color: #0d6efd;
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
            }

            .form-textarea {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 14px;
                resize: vertical;
                min-height: 100px;
                font-family: inherit;
                box-sizing: border-box;
            }

            .form-textarea:focus {
                outline: none;
                border-color: #0d6efd;
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
            }

            .form-select {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 14px;
                background-color: white;
                cursor: pointer;
                box-sizing: border-box;
            }

            .form-select:focus {
                outline: none;
                border-color: #0d6efd;
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
            }

            .form-actions {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 2px solid #f1f1f1;
            }

            .btn {
                padding: 12px 30px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: #0d6efd;
                color: white;
            }

            .btn-primary:hover {
                background: #0b5ed7;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3);
            }

            .btn-success {
                background: #28a745;
                color: white;
            }

            .btn-success:hover {
                background: #218838;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .alert-success {
                color: #155724;
                background-color: #d4edda;
                border-color: #c3e6cb;
            }

            .alert-error {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
            }

            .alert-info {
                color: #0c5460;
                background-color: #d1ecf1;
                border-color: #b3d7dd;
            }

            .form-type-selector {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 25px;
            }

            .type-options {
                display: flex;
                gap: 20px;
                justify-content: center;
            }

            .type-option {
                display: flex;
                align-items: center;
                gap: 8px;
                cursor: pointer;
                padding: 10px 20px;
                border-radius: 6px;
                transition: background-color 0.3s;
            }

            .type-option:hover {
                background-color: rgba(13, 110, 253, 0.1);
            }

            .type-option input[type="radio"] {
                margin: 0;
            }

            .help-text {
                font-size: 12px;
                color: #6c757d;
                margin-top: 5px;
            }

            .required {
                color: #dc3545;
            }

            .breadcrumb {
                background: none;
                padding: 0;
                margin-bottom: 20px;
            }

            .breadcrumb-item {
                display: inline;
                color: #6c757d;
            }

            .breadcrumb-item + .breadcrumb-item::before {
                content: " / ";
                color: #6c757d;
                margin: 0 5px;
            }

            .breadcrumb-item.active {
                color: #0d6efd;
                font-weight: 600;
            }

            .breadcrumb-item a {
                color: #0d6efd;
                text-decoration: none;
            }

            .breadcrumb-item a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="/sidebar.jsp" %> 
            <div class="main-content" id="mainContent">
                <!-- Breadcrumb -->
                <nav class="breadcrumb">
                    <span class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/manage-category">
                            <i class="fas fa-folder"></i> Quản lý danh mục
                        </a>
                    </span>
                    <span class="breadcrumb-item active">Thêm mới danh mục</span>
                </nav>

                <!-- Hiển thị thông báo -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <div class="form-container">
                    <div class="form-header">
                        <h2><i class="fas fa-plus-circle"></i> Thêm mới danh mục vật tư</h2>
                        <p>Tạo danh mục chính hoặc danh mục con để phân loại vật tư xây dựng</p>
                    </div>

                    <!-- Selector loại danh mục -->
                    <div class="form-type-selector">
                        <div class="type-options">
                            <label class="type-option">
                                <input type="radio" name="categoryType" value="main" checked onchange="toggleCategoryType()">
                                <span><i class="fas fa-folder"></i> Danh mục chính</span>
                            </label>
                            <label class="type-option">
                                <input type="radio" name="categoryType" value="sub" onchange="toggleCategoryType()">
                                <span><i class="fas fa-folder-open"></i> Danh mục con</span>
                            </label>
                        </div>
                    </div>

                    <!-- Form thêm danh mục chính -->
                    <form id="mainCategoryForm" action="${pageContext.request.contextPath}/manage-category" method="post">
                        <input type="hidden" name="action" value="addCategory">
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-tag"></i> Tên danh mục chính <span class="required">*</span>
                            </label>
                            <input type="text" name="categoryName" class="form-input" 
                                   placeholder="Ví dụ: Vật liệu xây dựng cơ bản, Thiết bị máy móc..." 
                                   required maxlength="100">
                            <div class="help-text">Tên danh mục phải duy nhất và dễ hiểu</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-align-left"></i> Mô tả danh mục
                            </label>
                            <textarea name="categoryDescription" class="form-textarea" 
                                      placeholder="Mô tả chi tiết về danh mục này..."></textarea>
                            <div class="help-text">Mô tả sẽ giúp người dùng hiểu rõ hơn về danh mục</div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Tạo danh mục chính
                            </button>
                            <a href="${pageContext.request.contextPath}/manage-category" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </form>

                    <!-- Form thêm danh mục con -->
                    <form id="subCategoryForm" action="${pageContext.request.contextPath}/manage-category" method="post" style="display: none;">
                        <input type="hidden" name="action" value="addSubcategory">
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-folder"></i> Chọn danh mục chính <span class="required">*</span>
                            </label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn danh mục chính --</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryID}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                            <div class="help-text">Chọn danh mục chính mà danh mục con này thuộc về</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-tag"></i> Tên danh mục con <span class="required">*</span>
                            </label>
                            <input type="text" name="subcategoryName" class="form-input" 
                                   placeholder="Ví dụ: Xi măng, Cát, Đá, Gạch..." 
                                   required maxlength="100">
                            <div class="help-text">Tên danh mục con phải duy nhất trong danh mục chính</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-align-left"></i> Mô tả danh mục con
                            </label>
                            <textarea name="subcategoryDescription" class="form-textarea" 
                                      placeholder="Mô tả chi tiết về danh mục con này..."></textarea>
                            <div class="help-text">Mô tả sẽ giúp người dùng hiểu rõ hơn về danh mục con</div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Tạo danh mục con
                            </button>
                            <a href="${pageContext.request.contextPath}/manage-category" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </form>

                    <!-- Thông tin hướng dẫn -->
                    <div class="alert alert-info" style="margin-top: 30px;">
                        <i class="fas fa-info-circle"></i>
                        <div>
                            <strong>Lưu ý:</strong>
                            <ul style="margin: 5px 0; padding-left: 20px;">
                                <li>Danh mục chính dùng để phân loại lớn (VD: Vật liệu xây dựng, Thiết bị máy móc)</li>
                                <li>Danh mục con dùng để phân loại chi tiết hơn (VD: Xi măng, Cát, Đá)</li>
                                <li>Tên danh mục phải duy nhất và dễ hiểu</li>
                                <li>Nên tạo danh mục chính trước, sau đó tạo các danh mục con</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Hàm toggle sidebar
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                const mainContent = document.getElementById('mainContent');
                sidebar.classList.toggle('collapsed');
                mainContent.classList.toggle('sidebar-collapsed');
            }

            // Hàm toggle dropdown menu
            function toggleDropdown(element) {
                const dropdown = element.closest('.dropdown');
                dropdown.classList.toggle('active');
            }

            // Hàm chuyển đổi giữa form danh mục chính và danh mục con
            function toggleCategoryType() {
                const categoryType = document.querySelector('input[name="categoryType"]:checked').value;
                const mainForm = document.getElementById('mainCategoryForm');
                const subForm = document.getElementById('subCategoryForm');
                
                if (categoryType === 'main') {
                    mainForm.style.display = 'block';
                    subForm.style.display = 'none';
                } else {
                    mainForm.style.display = 'none';
                    subForm.style.display = 'block';
                }
            }

            // Validation form trước khi submit
            document.getElementById('mainCategoryForm').addEventListener('submit', function(e) {
                const categoryName = this.querySelector('input[name="categoryName"]').value.trim();
                if (!categoryName) {
                    e.preventDefault();
                    alert('Vui lòng nhập tên danh mục!');
                    return false;
                }
                if (categoryName.length < 2) {
                    e.preventDefault();
                    alert('Tên danh mục phải có ít nhất 2 ký tự!');
                    return false;
                }
            });

            document.getElementById('subCategoryForm').addEventListener('submit', function(e) {
                const categoryId = this.querySelector('select[name="categoryId"]').value;
                const subcategoryName = this.querySelector('input[name="subcategoryName"]').value.trim();
                
                if (!categoryId) {
                    e.preventDefault();
                    alert('Vui lòng chọn danh mục chính!');
                    return false;
                }
                if (!subcategoryName) {
                    e.preventDefault();
                    alert('Vui lòng nhập tên danh mục con!');
                    return false;
                }
                if (subcategoryName.length < 2) {
                    e.preventDefault();
                    alert('Tên danh mục con phải có ít nhất 2 ký tự!');
                    return false;
                }
            });

            // Auto-focus vào input đầu tiên khi trang load
            document.addEventListener('DOMContentLoaded', function() {
                const firstInput = document.querySelector('#mainCategoryForm input[name="categoryName"]');
                if (firstInput) {
                    firstInput.focus();
                }
            });
        </script>
    </body>
</html> 