<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<!-- Danh sách người dùng -->
<div class="content-card hidden" id="userList">
    <h2><i class="fas fa-users"></i> Danh sách người dùng</h2>
    <!-- Form tìm kiếm và lọc -->
    <form action="<%= request.getContextPath() %>/Userctr" method="get" class="search-form">
        <input type="hidden" name="service" value="searchByKeywords">
        <input type="text" name="keywords" placeholder="Nhập tên người dùng..." value="<%= request.getAttribute("keywords") != null ? request.getAttribute("keywords") : "" %>">
        <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
        <!-- Lọc theo Role -->
        <select name="roleFilter" onchange="this.form.submit()">
            <option value="">Tất cả vai trò</option>
            <option value="1" <%= "1".equals(request.getParameter("roleFilter")) ? "selected" : "" %>>Khách hàng</option>
            <option value="2" <%= "2".equals(request.getParameter("roleFilter")) ? "selected" : "" %>>Quản trị viên</option>
        </select>
        <!-- Lọc theo Trạng thái -->
        <select name="statusFilter" onchange="this.form.submit()">
            <option value="">Tất cả trạng thái</option>
            <option value="true" <%= "true".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Hoạt động</option>
            <option value="false" <%= "false".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Không hoạt động</option>
        </select>
    </form>

    <!-- Thông báo nếu không tìm thấy -->
    <% if (request.getAttribute("notFoundUser") != null) { %>
        <div class="alert alert-warning">
            <%= request.getAttribute("notFoundUser") %>
        </div>
    <% } %>

    <!-- Thông báo lỗi nếu có -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <!-- Thông báo thành công nếu có -->
    <% if (request.getAttribute("message") != null) { %>
        <div class="alert alert-success">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <!-- Bảng danh sách người dùng -->
    <% List<User> allUser = (List<User>) request.getAttribute("allUser");
       if (allUser != null && !allUser.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Họ</th>
                    <th>Tên</th>
                    <th>Số điện thoại</th>
                    <th>Trạng thái</th>
                    <th>Cập nhật trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : allUser) { %>
                    <tr onclick="window.location='<%= request.getContextPath() %>/Userctr?service=userDetail&userId=<%= user.getUserID() %>'" style="cursor: pointer;">
                        <td><%= user.getUserID() %></td>
                        <td><%= user.getUsername() %></td>
                        <td><%= user.getFirstName() %></td>
                        <td><%= user.getLastName() %></td>
                        <td><%= user.getPhoneNum() %></td>
                        <td><%= user.isIsActive() ? "Hoạt động" : "Không hoạt động" %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/Userctr" method="post">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="userId" value="<%= user.getUserID() %>">
                                <input type="radio" name="isActive" value="true" <%= user.isIsActive() ? "checked" : "" %> onchange="this.form.submit()"> Hoạt động
                                <input type="radio" name="isActive" value="false" <%= !user.isIsActive() ? "checked" : "" %> onchange="this.form.submit()"> Không hoạt động
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>Không có người dùng nào.</p>
    <% } %>
</div>

<!-- Thêm người dùng -->
<div class="content-card hidden" id="addUser">
    <h2>Thêm Người Dùng Mới</h2>
    <div class="profile-card">
        <h3><i class="fas fa-user-plus"></i> Thêm Người Dùng</h3>
        <form action="<%= request.getContextPath() %>/Userctr" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-row">
                <label for="username">Tên đăng nhập:</1034>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-row">
                <label for="firstName">Họ:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            <div class="form-row">
                <label for="lastName">Tên:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            <div class="form-row">
                <label for="phoneNum">Số điện thoại:</label>
                <input type="text" id="phoneNum" name="phoneNum" required>
            </div>
            <div class="form-row">
                <label for="roleID">ID Vai trò:</label>
                <input type="number" id="roleID" name="roleID" required>
            </div>
            <div class="form-row">
                <label for="isActive">Kích hoạt:</label>
                <input type="checkbox" id="isActive" name="isActive" value="true">
            </div>
            <button type="submit">Thêm Người Dùng</button>
        </form>
    </div>
</div>

<!-- Chi tiết người dùng -->
<div class="content-card hidden" id="userDetail">
    <h2>Chi tiết Người Dùng</h2>
    <div class="profile-card">
        <h3><i class="fas fa-user"></i> Thông tin chi tiết</h3>
        <%
            User detailUser = (User) request.getAttribute("detailUser");
            if (detailUser != null) {
        %>
            <div class="form-row">
                <label>ID:</label>
                <span><%= detailUser.getUserID() %></span>
            </div>
            <div class="form-row">
                <label>Tên đăng nhập:</label>
                <span><%= detailUser.getUsername() %></span>
            </div>
            <div class="form-row">
                <label>Họ:</label>
                <span><%= detailUser.getFirstName() %></span>
            </div>
            <div class="form-row">
                <label>Tên:</label>
                <span><%= detailUser.getLastName() %></span>
            </div>
            <div class="form-row">
                <label>Số điện thoại:</label>
                <span><%= detailUser.getPhoneNum() %></span>
            </div>
            <div class="form-row">
                <label>Vai trò ID:</label>
                <span><%= detailUser.getRoleID() %></span>
            </div>
            <div class="form-row">
                <label>Trạng thái:</label>
                <span><%= detailUser.isIsActive() ? "Hoạt động" : "Không hoạt động" %></span>
            </div>
            <button onclick="window.location='<%= request.getContextPath() %>/Userctr?service=listAllUser'">Quay lại</button>
        <%
            }
        %>
    </div>
</div>