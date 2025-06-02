<%-- 
    Document   : Admin_UserManager
    Created on : May 25, 2025, 11:50:08 PM
    Author     : Bùi Hiếu
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - Hệ thống Quản lý Xây dựng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    <style>
        /* Thêm CSS để phù hợp với giao diện home.jsp */
        .content-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
        }
        .content-card h2 {
            font-family: 'Poppins', sans-serif;
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .search-form input {
            font-family: 'Poppins', sans-serif;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            flex-grow: 1;
        }
        .search-form button {
            font-family: 'Poppins', sans-serif;
            padding: 10px 20px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-form button:hover {
            background: #0056b3;
        }
        .alert {
            font-family: 'Poppins', sans-serif;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-warning {
            background: #fff3cd;
            color: #856404;
        }
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-family: 'Poppins', sans-serif;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #007bff;
            color: #fff;
            font-weight: 600;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="content-card" id="userList">
        <h2><i class="fas fa-users"></i> Danh sách người dùng</h2>

        <!-- Form tìm kiếm -->
        <form action="${pageContext.request.contextPath}/Userctr" method="get" class="search-form">
            <input type="hidden" name="service" value="searchByKeywords">
            <input type="text" name="keywords" placeholder="Nhập tên người dùng..." value="${keywords}">
            <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
        </form>

        <!-- Thông báo nếu không tìm thấy -->
        <c:if test="${not empty notFoundUser}">
            <div class="alert alert-warning">
                ${notFoundUser}
            </div>
        </c:if>

        <!-- Thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                ${error}
            </div>
        </c:if>

        <!-- Bảng danh sách người dùng -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Họ</th>
                    <th>Tên</th>
                    <th>Số điện thoại</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${allUser}">
                    <tr>
                        <td>${user.userID}</td>
                        <td>${user.username}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.phoneNum}</td>
                        <td>${user.isActive ? 'Hoạt động' : 'Không hoạt động'}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty allUser}">
                    <tr>
                        <td colspan="6" class="no-data">Không có người dùng nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
