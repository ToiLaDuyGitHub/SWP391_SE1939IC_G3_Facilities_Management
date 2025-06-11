<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.dto.User_Role" %>
<%@ page import="model.Feature" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
                max-width: 1200px;
                margin: 20px auto; 
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="content" id="contentArea">
                <!-- Welcome Section -->
                <div class="content-card" id="welcomeSection">
                    <h2>Chào mừng đến với Hệ thống Quản lý</h2>
                    <p>Vui lòng chọn chức năng từ menu bên trái.</p>
                </div>
                <!-- Placeholder for static sections -->
                <div class="content-card hidden" id="genericSection"></div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
    </body>
    <script>
        window.onload = function () {
        <% if (request.getAttribute("allUser") != null) { %>
                                    document.getElementById('userList').classList.remove('hidden');
                                    document.getElementById('userDetail').classList.add('hidden');
        <% } else if (request.getAttribute("detailUser") != null) { %>
                                    document.getElementById('userList').classList.add('hidden');
                                    document.getElementById('userDetail').classList.remove('hidden');
        <% } %>
                                };
    </script>
</html>
