<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Người Dùng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
        <style>
            #dashboard {
                display: flex; /* Sử dụng Flexbox để sắp xếp sidebar và content */
                min-height: 100vh; /* Đảm bảo độ cao tối thiểu là toàn màn hình */
            }

            /* Form container */
            .form-container {
                max-width: 600px; /* Giới hạn chiều rộng form */
                margin: 0 auto; /* Căn giữa form */
                padding: 30px;
                background: #f9f9f9; /* Nền xám nhạt */
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
            }

            .form-container h2 {
                margin-top: 0;
                margin-bottom: 20px;
                font-size: 24px;
                text-align: center;
                color: #333;
            }

            .form-container h2 i {
                margin-right: 8px;
                color: #007bff; /* Icon màu xanh dương */
            }

            /* Form row */
            .form-row.add-user {
                margin-bottom: 20px;
            }

            .form-row.add-user label {
                display: block;
                margin-bottom: 8px;
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .form-row.add-user input,
            .form-row.add-user select {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }

            .form-row.add-user input:focus,
            .form-row.add-user select:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            }

            /* Button */
            button[type="submit"] {
                background-color: #007bff; /* Xanh dương */
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            button[type="submit"]:hover {
                background-color: #0056b3; /* Xanh dương đậm hơn khi hover */
            }

            /* Alert */
            .alert {
                padding: 12px;
                margin-bottom: 20px;
                border-radius: 4px;
                font-size: 14px;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* Responsive */
            @media (max-width: 768px) {
                #dashboard {
                    flex-direction: column; /* Chuyển thành cột trên màn hình nhỏ */
                }

                .sidebar {
                    width: 100%; /* Sidebar chiếm toàn bộ chiều rộng */
                    position: relative; /* Bỏ fixed */
                    height: auto;
                }

                .content {
                    margin-left: 0; /* Loại bỏ margin khi sidebar không cố định */
                    padding: 10px;
                }

                .form-container {
                    padding: 20px;
                    max-width: 100%;
                }

                .form-row.add-user label {
                    font-size: 14px;
                }

                .form-row.add-user input,
                .form-row.add-user select {
                    font-size: 13px;
                    padding: 8px;
                }

                button[type="submit"] {
                    font-size: 14px;
                    padding: 10px;
                }
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="content" id="contentArea">
                <div class="form-container" id="userAdd">
                    <h2><i class="fas fa-user-plus"></i> Thêm Người Dùng Mới</h2>
                    <% String error = (String) request.getAttribute("error"); %>
                    <% if (error != null) { %>
                    <div class="alert alert-danger"><%= error %></div>
                    <% } %>
                    <form action="<%= request.getContextPath() %>/add-user" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="form-row add-user">
                            <label for="username">Tên đăng nhập <span style="color: red;">*</span>:</label>
                            <input type="text" id="username" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required>
                        </div>
                        <div class="form-row add-user">
                            <label for="password">Mật khẩu <span style="color: red;">*</span>:</label>
                            <input type="password" id="password" name="password" required>
                        </div>
                        <div class="form-row add-user">
                            <label for="firstName">Họ:</label>
                            <input type="text" id="firstName" name="firstName" value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>">
                        </div>
                        <div class="form-row add-user">
                            <label for="lastName">Tên:</label>
                            <input type="text" id="lastName" name="lastName" value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>">
                        </div>
                        <div class="form-row add-user">
                            <label for="phoneNum">Số điện thoại:</label>
                            <input type="text" id="phoneNum" name="phoneNum" value="<%= request.getParameter("phoneNum") != null ? request.getParameter("phoneNum") : "" %>">
                        </div>
                        <div class="form-row add-user">
                            <label for="address">Địa chỉ:</label>
                            <input type="text" id="address" name="address" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                        </div>
                        <div class="form-row add-user">
                            <label for="roleID">Vai trò <span style="color: red;">*</span>:</label>
                            <select id="roleID" name="roleID" required>
                                <option value="">Chọn vai trò</option>
                                <option value="1" <%= "1".equals(request.getParameter("roleID")) ? "selected" : "" %>>Quản lý kho</option>
                                <option value="2" <%= "2".equals(request.getParameter("roleID")) ? "selected" : "" %>>Nhân viên kho</option>
                                <option value="3" <%= "3".equals(request.getParameter("roleID")) ? "selected" : "" %>>Giám đốc công ty</option>
                                <option value="4" <%= "4".equals(request.getParameter("roleID")) ? "selected" : "" %>>Nhân viên công ty</option>
                            </select>
                        </div>
                        <button type="submit">Thêm Người Dùng</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>