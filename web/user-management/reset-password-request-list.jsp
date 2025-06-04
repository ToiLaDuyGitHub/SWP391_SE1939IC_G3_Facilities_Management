<%-- 
    Document   : reset-password-request-list
    Created on : May 31, 2025, 10:56:24 PM
    Author     : ToiLaDuyGitHub
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Xem danh sách yêu cầu reset mật khẩu</title>
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
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            .table th, .table td {
                padding: 12px 15px;
                text-align: left;
                border: 1px solid #dee2e6;
            }
            .table th {
                background-color: #0d6efd;
                color: white;
            }
            .table-hover tbody tr:hover {
                background-color: #f8f9fa;
            }
            .btn-reset {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btn-reset:hover {
                background-color: #218838;
            }
            .table-responsive {
                overflow-x: auto;
            }

            /* Phần phân trang cải tiến */
            .pagination-container {
                display: inline-block;
                width: 100%;
                text-align: center;
            }
            .pagination {
                display: inline-flex;
                flex-wrap: nowrap;
                white-space: nowrap;
                gap: 4px;
                margin: 0 auto;
                padding: 0;
                justify-content: center;
            }
            .page-item {
                display: inline-block;
                margin: 0;
            }
            .page-item.disabled .btn {
                opacity: 0.6;
                pointer-events: none;
            }
            .page-item .btn {
                min-width: 40px;
                padding: 6px 12px;
                font-weight: 500;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                transition: all 0.2s;
            }
            .page-item .btn-primary {
                background-color: white;
                border-color: #0d6efd;
            }
            .page-item .btn-primary:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            .page-item.active .btn-success {
                background-color: #0d6efd;
                border-color: #0d6efd;
                color: white
            }
            .page-item.active .btn-success:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            .pagination-text {
                text-align: center;
                margin-top: 8px;
                font-size: 14px;
                color: #495057;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="/sidebar.jsp" %>
            <div class="main-content" id="mainContent">
                <div style="text-align: center; margin-bottom: 20px">
                    <h2 style="color: #0d6efd;">Danh sách yêu cầu reset mật khẩu</h2>
                </div>
                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty errorMessage}">
                    <p style="color: red; margin-bottom: 30px">${errorMessage}</p>
                </c:if>

                <!-- Hiển thị thông báo thành công nếu có -->
                <c:if test="${not empty successMessage}">
                    <p style="color: green; margin-bottom: 30px">${successMessage}</p>
                </c:if>
                <c:choose>
                    <c:when test="${empty resetReqList}">
                        <div class="alert alert-info" style="text-align: center;">
                            ${not empty message ? message : 'Không có yêu cầu reset mật khẩu nào'}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-primary">
                                    <tr>
                                        <th style="width: 5%; text-align: center;">STT</th>
                                        <th style="width: 40%; text-align: center;">Username</th>
                                        <th style="width: 25%; text-align: center;">Họ và tên đệm</th>
                                        <th style="width: 10%; text-align: center;">Tên</th>
                                        <th style="width: 20%; text-align: center;">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${resetReqList}">
                                        <tr>
                                            <td style="text-align: center;">${user.username}</td>
                                            <td style="text-align: center;">${user.username}</td>
                                            <td style="text-align: center;">${user.lastName}</td>
                                            <td style="text-align: center;">${user.firstName}</td>
                                            <td style="text-align: center;">
                                                <form action="reset-password-request-list" method="post">
                                                    <input type="hidden" name="username" value="${user.username}">
                                                    <button type="submit" class="btn-reset">Reset mật khẩu</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty resetReqList}">
                                        <tr>
                                            <td colspan="5" style="text-align: center;">Không có yêu cầu reset mật khẩu nào</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            <div class="pagination-container">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <%-- Nút đầu trang --%>
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <button class="btn btn-primary"
                                                    onclick="window.location.href = 'reset-password-request-list?page=1'"
                                                    ${currentPage == 1 ? 'disabled' : ''}>
                                                <<
                                            </button>
                                        </li>

                                        <%-- Nút trang trước --%>
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <button class="btn btn-primary"
                                                    onclick="window.location.href = 'reset-password-request-list?page=${currentPage - 1}'"
                                                    ${currentPage == 1 ? 'disabled' : ''}>
                                                <
                                            </button>
                                        </li>

                                        <%-- Các nút trang --%>
                                        <c:set var="startPage" value="${currentPage - 2}"/>
                                        <c:set var="endPage" value="${currentPage + 2}"/>

                                        <c:if test="${startPage < 1}">
                                            <c:set var="startPage" value="1"/>
                                            <c:set var="endPage" value="${startPage + 4}"/>
                                        </c:if>

                                        <c:if test="${endPage > noOfPages}">
                                            <c:set var="endPage" value="${noOfPages}"/>
                                            <c:set var="startPage" value="${endPage - 4 > 0 ? endPage - 4 : 1}"/>
                                        </c:if>

                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                            <li class="page-item ${currentPage eq i ? 'active' : ''}">
                                                <button class="btn ${currentPage eq i ? 'btn-success' : 'btn-primary'}"
                                                        onclick="window.location.href = 'reset-password-request-list?page=${i}'">
                                                    ${i}
                                                </button>
                                            </li>
                                        </c:forEach>

                                        <%-- Nút trang sau --%>
                                        <li class="page-item ${currentPage == noOfPages ? 'disabled' : ''}">
                                            <button class="btn btn-primary"
                                                    onclick="window.location.href = 'reset-password-request-list?page=${currentPage + 1}'"
                                                    ${currentPage == noOfPages ? 'disabled' : ''}>
                                                >
                                            </button>
                                        </li>

                                        <%-- Nút cuối trang --%>
                                        <li class="page-item ${currentPage == noOfPages ? 'disabled' : ''}">
                                            <button class="btn btn-primary"
                                                    onclick="window.location.href = 'reset-password-request-list?page=${noOfPages}'"
                                                    ${currentPage == noOfPages ? 'disabled' : ''}>
                                                >>
                                            </button>
                                        </li>
                                    </ul>
                                </nav>
                                <div class="pagination-text">
                                    Trang ${currentPage}/${noOfPages}
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
    </body>
</html>

