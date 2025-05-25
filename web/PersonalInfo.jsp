<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Personal Information Section -->
<div class="content-card hidden" id="profileSection">
    <h2>Thông tin cá nhân</h2>
    <div class="profile-card">
        <h3><i class="fas fa-user-circle"></i> Hồ sơ cá nhân</h3>
        <div class="info-row">
            <label>Họ và tên:</label>
            <span>Nguyễn Văn A</span>
        </div>
        <div class="info-row">
            <label>Email:</label>
            <span>nguyenvana@example.com</span>
        </div>
        <div class="info-row">
            <label>Số điện thoại:</label>
            <span>0123 456 789</span>
        </div>
        <div class="info-row">
            <label>Địa chỉ:</label>
            <span>123 Đường Láng, Đống Đa, Hà Nội</span>
        </div>
        <div class="info-row">
            <label>Vai trò:</label>
            <span>Quản lý</span>
        </div>
        <button onclick="openEditModal()">Thay đổi</button>
    </div>
</div>

<!-- Password Change Section -->
<div class="content-card hidden" id="changePasswordSection">
    <h2>Thay đổi mật khẩu</h2>
    <div class="profile-card">
        <h3><i class="fas fa-lock"></i> Thay đổi mật khẩu</h3>
        <form action="changePassword" method="post">
            <div class="form-row">
                <label for="currentPassword">Mật khẩu hiện tại:</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>
            <div class="form-row">
                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-row">
                <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit">Thay đổi mật khẩu</button>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModalOverlay" class="modal-overlay"></div>
<div id="editModal" class="modal">
    <span class="close" onclick="closeEditModal()">×</span>
    <h3>Chỉnh sửa thông tin cá nhân</h3>
    <form>
        <div class="form-row">
            <label for="editName">Họ và tên:</label>
            <input type="text" id="editName" name="editName" value="Nguyễn Văn A">
        </div>
        <div class="form-row">
            <label for="editEmail">Email:</label>
            <input type="email" id="editEmail" name="editEmail" value="nguyenvana@example.com">
        </div>
        <div class="form-row">
            <label for="editPhone">Số điện thoại:</label>
            <input type="tel" id="editPhone" name="editPhone" value="0123 456 789">
        </div>
        <div class="form-row">
            <label for="editAddress">Địa chỉ:</label>
            <input type="text" id="editAddress" name="editAddress" value="123 Đường Láng, Đống Đa, Hà Nội">
        </div>
        <button type="button" onclick="saveChanges()">Lưu thay đổi</button>
    </form>
</div>