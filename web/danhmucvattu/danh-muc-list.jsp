<%-- 
    Document   : danh-muc-list
    Created on : May 24, 2025, 13:00:45 PM
    Author     : ToiLaDuyGitHub
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Danh sách danh mục vật tư</title>
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

            .category-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .category-card {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .category-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                cursor: pointer;
                background: #f8f9fa;
                border-bottom: 1px solid #eee;
            }

            .category-header:hover {
                background: #e9ecef;
            }

            .category-title {
                font-weight: 600;
                color: #333;
                margin: 0;
            }

            .category-arrow {
                transition: transform 0.3s;
            }

            .category-arrow.rotated {
                transform: rotate(180deg);
            }

            .subcategory-list {
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.3s ease-out;
                background: #fff;
            }

            .subcategory-list.expanded {
                max-height: 500px; /* Điều chỉnh theo số lượng subcategory */
            }

            .subcategory-item {
                padding: 12px 20px;
                border-bottom: 1px solid #f1f1f1;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .subcategory-item:last-child {
                border-bottom: none;
            }

            .subcategory-name {
                color: #555;
            }

            .subcategory-actions {
                display: flex;
                gap: 10px;
            }

            .action-btn {
                background: none;
                border: none;
                cursor: pointer;
                color: #6c757d;
                font-size: 14px;
            }

            .action-btn:hover {
                color: #0d6efd;
            }

            .no-categories {
                text-align: center;
                padding: 20px;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="main-content" id="mainContent">
                <div style="text-align: center; margin-bottom: 20px">
                    <h2 style="color: #0d6efd;">Danh mục vật tư</h2>
                </div>
                <div class="category-container">
                    <div class="category-card">
                        <div class="category-header" onclick="toggleCategory(this)">
                            <h3 class="category-title">Vật liệu xây dựng cơ bản</h3>
                            <i class="fas fa-chevron-down category-arrow"></i>
                        </div>
                        <div class="subcategory-list">
                            <div class="subcategory-item">
                                <span class="subcategory-name">Xi măng</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Cát</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Đá</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Gạch</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Sắt thép</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="category-card">
                        <div class="category-header" onclick="toggleCategory(this)">
                            <h3 class="category-title">Vật liệu hoàn thiện</h3>
                            <i class="fas fa-chevron-down category-arrow"></i>
                        </div>
                        <div class="subcategory-list">
                            <div class="subcategory-item">
                                <span class="subcategory-name">Gạch ốp lát</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Sơn</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Trần thạch cao</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Cửa</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Kính</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="category-card">
                        <div class="category-header" onclick="toggleCategory(this)">
                            <h3 class="category-title">Vật tư điện & nước</h3>
                            <i class="fas fa-chevron-down category-arrow"></i>
                        </div>
                        <div class="subcategory-list">
                            <div class="subcategory-item">
                                <span class="subcategory-name">Dây điện</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Ống luồn dây điện</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Thiết bị điện</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Ống nước</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Phụ kiện</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Thiết bị vệ sinh</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="category-card">
                        <div class="category-header" onclick="toggleCategory(this)">
                            <h3 class="category-title">Thiết bị máy móc & công cụ</h3>
                            <i class="fas fa-chevron-down category-arrow"></i>
                        </div>
                        <div class="subcategory-list">
                            <div class="subcategory-item">
                                <span class="subcategory-name">Máy móc thi công</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Dụng cụ cầm tay</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Thiết bị an toàn</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="category-card">
                        <div class="category-header" onclick="toggleCategory(this)">
                            <h3 class="category-title">Vật liệu chuyên dụng</h3>
                            <i class="fas fa-chevron-down category-arrow"></i>
                        </div>
                        <div class="subcategory-list">
                            <div class="subcategory-item">
                                <span class="subcategory-name">Vật liệu cách nhiệt</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Vật liệu chống thấm</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div class="subcategory-item">
                                <span class="subcategory-name">Vật liệu chịu lửa</span>
                                <div class="subcategory-actions">
                                    <button class="action-btn" title="Sửa"><i class="fas fa-edit"></i></button>
                                    <button class="action-btn" title="Xóa"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Hàm toggle mở rộng/đóng danh mục
            function toggleCategory(element) {
                const header = element.closest('.category-header');
                const card = header.parentElement;
                const arrow = header.querySelector('.category-arrow');
                const subList = card.querySelector('.subcategory-list');

                arrow.classList.toggle('rotated');
                subList.classList.toggle('expanded');
            }

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
        </script>
    </body>
</html>