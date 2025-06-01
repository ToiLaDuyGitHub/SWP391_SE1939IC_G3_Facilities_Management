<%-- 
    Document   : Decentralization
    Created on : May 29, 2025, 2:27:13 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.dto.User_Role" %>
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
                max-width: 1000px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f4f4f4;
            }
            td:first-child {
                text-align: left;
            }
            .save-button {
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
            }
            .save-button:hover {
                background-color: #0056b3;
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
                            <a href="#" onclick="showContent('userList', this)">Xem danh sách người dùng</a>
                            <a href="#" onclick="showContent('addUser', this)">Thêm mới người dùng</a>
                            <a href="#" onclick="showContent('editUser', this)">Sửa thông tin người dùng</a>
                        </div>
                    </li>
                    <li class="dropdown active">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-boxes"></i>Phân quyền</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="Decentralization.jsp" style="color: blue; background-color: orange;" onclick="showContent('materialList', this)">Phân quyền chức năng</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-user"></i> Thông tin cá nhân</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/Profile">Xem thông tin cá nhân</a>
                            <a href="changePassword.jsp" onclick="showContent('changePasswordSection', this)">Thay đổi mật khẩu</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-folder"></i> Quản lý danh mục vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('categoryListSection', this)">Xem danh mục vật tư</a>
                            <a href="#" onclick="showContent('addCategory', this)">Thêm mới danh mục vật tư</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-boxes"></i> Quản lý vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('materialList', this)">Xem danh sách vật tư</a>
                            <a href="#" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content" id="contentArea">
                <div class="content-card" id="decentralizationSection">
                    <h2>Phân quyền chức năng</h2>
                    <div class="profile-card">
                        <form action="${pageContext.request.contextPath}/SavePermissions" method="post">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Chức năng</th>
                                        <th>Giám đốc</th>
                                        <th>Nhân viên kho</th>
                                        <th>Nhân viên</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Xem thông tin cá nhân</td>
                                        <td><input type="checkbox" name="viewPersonalInfo_director"></td>
                                        <td><input type="checkbox" name="viewPersonalInfo_warehouseStaff"></td>
                                        <td><input type="checkbox" name="viewPersonalInfo_staff"></td>
                                    </tr>
                                    <tr>
                                        <td>Thay đổi mật khẩu</td>
                                        <td><input type="checkbox" name="changePassword_director"></td>
                                        <td><input type="checkbox" name="changePassword_warehouseStaff"></td>
                                        <td><input type="checkbox" name="changePassword_staff"></td>
                                    </tr>
                                    <tr>
                                        <td>Xem thông tin user</td>
                                        <td><input type="checkbox" name="viewUserInfo_director"></td>
                                        <td><input type="checkbox" name="viewUserInfo_warehouseStaff"></td>
                                        <td><input type="checkbox" name="viewUserInfo_staff"></td>
                                    </tr>
                                    <tr>
                                        <td>Xem danh mục vật tư</td>
                                        <td><input type="checkbox" name="viewMaterialCategory_director"></td>
                                        <td><input type="checkbox" name="viewMaterialCategory_warehouseStaff"></td>
                                        <td><input type="checkbox" name="viewMaterialCategory_staff"></td>
                                    </tr>
                                    <tr>
                                        <td>Xem danh sách vật tư</td>
                                        <td><input type="checkbox" name="viewMaterialList_director"></td>
                                        <td><input type="checkbox" name="viewMaterialList_warehouseStaff"></td>
                                        <td><input type="checkbox" name="viewMaterialList_staff"></td>
                                    </tr>
                                    <tr>
                                        <td>Thêm vật tư</td>
                                        <td><input type="checkbox" name="addMaterial_director"></td>
                                        <td><input type="checkbox" name="addMaterial_warehouseStaff"></td>
                                        <td><input type="checkbox" name="addMaterial_staff"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <button type="submit" class="save-button">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>
                <!-- Placeholder for static sections -->
                <div class="content-card hidden" id="genericSection"></div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
                                // Tự động hiển thị decentralizationSection khi trang Decentralization.jsp được tải
                                document.addEventListener('DOMContentLoaded', function () {
                                    const decentralizationSection = document.getElementById('decentralizationSection');
                                    if (decentralizationSection) {
                                        decentralizationSection.classList.remove('hidden');
                                    }
                                });
        </script>               
    </body>
</html>
