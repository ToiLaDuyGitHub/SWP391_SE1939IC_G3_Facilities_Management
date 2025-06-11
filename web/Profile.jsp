<%-- 
    Document   : Profile
    Created on : May 27, 2025, 10:21:17 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.dto.User_Role" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Trang chủ</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <style>
            .content-card {
                max-width: 1200px;
                margin: 20px auto; 
            }
            .success-message {
                color: green;
                margin-top: 10px;
                text-align: center;
            }
            .error-message {
                color: red;
                margin-top: 10px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div id="dashboard">
            <%@ include file="sidebar.jsp" %>
            <div class="content" id="contentArea">              
                <!-- Include Personal Information -->
                <div class="content-card hidden" id="profileSection">
                    <h2>Thông tin cá nhân</h2>
                    <div class="profile-card">
                        <h3><i class="fas fa-user-circle"></i> Hồ sơ cá nhân</h3>
                        <c:choose>
                            <c:when test="${not empty sessionScope.userRole}">
                                <div class="info-row">
                                    <label>Họ và tên:</label>
                                    <span>${sessionScope.userRole.lastName} ${sessionScope.userRole.firstName}</span>
                                </div>
                                <div class="info-row">
                                    <label>Email:</label>
                                    <span>${sessionScope.userRole.username}</span>
                                </div>
                                <div class="info-row">
                                    <label>Số điện thoại:</label>
                                    <span>${sessionScope.userRole.phoneNum}</span>
                                </div>
                                <div class="info-row">
                                    <label>Địa chỉ:</label>
                                    <span>${sessionScope.userRole.address}</span>
                                </div>
                                <div class="info-row">
                                    <label>Vai trò:</label>
                                    <span>${sessionScope.userRole.roleName}</span>
                                </div>
                                <button onclick="openEditModal()">Thay đổi</button>
                            </c:when>
                            <c:otherwise>
                                <p>Không tìm thấy thông tin người dùng. Vui lòng đăng nhập lại.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Edit Modal -->
                <div id="editModalOverlay" class="modal-overlay"></div>
                <div id="editModal" class="modal">
                    <span class="close" onclick="closeEditModal()">×</span>
                    <h3>Chỉnh sửa thông tin cá nhân</h3>
                    <form action="${pageContext.request.contextPath}/update-profile" method="post">
                        <div class="form-row">
                            <label for="editLastName">Họ:</label>
                            <input type="text" id="editLastName" name="editLastName" value="${sessionScope.userRole.lastName}">
                        </div>
                        <div class="form-row">
                            <label for="editFirstName">Tên:</label>
                            <input type="text" id="editFirstName" name="editFirstName" value="${sessionScope.userRole.firstName}">
                        </div>
                        <div class="form-row">
                            <label for="editPhone">Số điện thoại:</label>
                            <input type="tel" id="editPhone" name="editPhone" value="${sessionScope.userRole.phoneNum}">
                        </div>
                        <div class="form-row">
                            <label for="editAddress">Địa chỉ:</label>
                            <input type="text" id="editAddress" name="editAddress" value="${sessionScope.userRole.address}">
                        </div>
                        <button type="submit">Lưu thay đổi</button>
                        <c:if test="${not empty requestScope.successMessage}">
                            <p class="success-message">${requestScope.successMessage}</p>
                        </c:if>
                        <c:if test="${not empty requestScope.errorMessage}">
                            <p class="error-message">${requestScope.errorMessage}</p>
                        </c:if>
                    </form>
                </div>
                <!-- Placeholder for static sections -->
                <div class="content-card hidden" id="genericSection"></div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/script.js"></script>
        <script>
            // Tự động hiển thị profileSection khi trang Profile.jsp được tải
            document.addEventListener('DOMContentLoaded', function () {
                const profileSection = document.getElementById('profileSection');
                if (profileSection) {
                    profileSection.classList.remove('hidden');
                }
                // Tự động mở modal nếu có thông báo thành công hoặc lỗi
                <c:if test="${not empty requestScope.successMessage or not empty requestScope.errorMessage}">
                    openEditModal();
                </c:if>
            });
        </script>
    </body>
</html>