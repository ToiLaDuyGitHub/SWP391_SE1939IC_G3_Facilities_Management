<%-- 
    Document   : addUser
    Created on : Jun 3, 2025, 6:31:12 PM
    Author     : Bùi Hiếu
--%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng</title>
    <style>
        .form-container { max-width: 500px; margin: 0 auto; padding: 20px; }
        .form-row { margin-bottom: 15px; }
        .form-row label { display: inline-block; width: 120px; }
        .form-row input, .form-row select { width: 250px; padding: 5px; }
        .error { color: red; }
        .button { padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    <div class="form-container hidden" id="userAdd">
        <h2>Thêm Người Dùng Mới</h2>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
        <form action="<%= request.getContextPath() %>/AddUserController" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-row">
                <label>Tên đăng nhập <span style="color: red;">*</span>:</label>
                <input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required>
            </div>
            <div class="form-row">
                <label>Mật khẩu <span style="color: red;">*</span>:</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-row">
                <label>Họ:</label>
                <input type="text" name="firstName" value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>">
            </div>
            <div class="form-row">
                <label>Tên:</label>
                <input type="text" name="lastName" value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>">
            </div>
            <div class="form-row">
                <label>Số điện thoại:</label>
                <input type="text" name="phoneNum" value="<%= request.getParameter("phoneNum") != null ? request.getParameter("phoneNum") : "" %>">
            </div>
            <div class="form-row">
                <label>Địa chỉ:</label>
                <input type="text" name="address" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
            </div>
            <div class="form-row">
                <label>Vai trò:</label>
                <select name="roleID" required>
                    <option value="">Chọn vai trò</option>
                    <option value="1" <%= "1".equals(request.getParameter("roleID")) ? "selected" : "" %>>Quản lý kho</option>
                    <option value="2" <%= "2".equals(request.getParameter("roleID")) ? "selected" : "" %>>Nhân viên kho</option>
                    <option value="3" <%= "3".equals(request.getParameter("roleID")) ? "selected" : "" %>>Giám đốc công ty</option>
                    <option value="4" <%= "4".equals(request.getParameter("roleID")) ? "selected" : "" %>>Nhân viên công ty</option>
                </select>
            </div>
            <button type="submit" class="button">Thêm Người Dùng</button>
        </form>
        <a href="<%= request.getContextPath() %>/Userctr?service=listAllUser">Quay lại danh sách</a>
    </div>
</body>
</html>
