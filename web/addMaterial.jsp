<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Add Material Section -->
<div class="content-card hidden" id="addMaterialSection">
    <h2><i class="fas fa-box-open"></i> Thêm mới vật tư</h2>
    <a href="#" onclick="showContent('materialListSection', this)"><i class="fas fa-arrow-left"></i> Quay lại danh sách vật tư</a>
    <form id="addMaterialForm" action="addMaterial" method="post" enctype="multipart/form-data" onsubmit="handleFormSubmit(event)">
        <div class="form-grid">
            <div class="form-group">
                <label for="materialName"><i class="fas fa-tag"></i> Tên vật tư:</label>
                <input type="text" id="materialName" name="materialName" placeholder="Nhập tên vật tư" required>
            </div>
            <div class="form-group">
                <label for="category"><i class="fas fa-folder-open"></i> Danh mục:</label>
                <select id="category" name="category" required>
                    <option value="" disabled selected>Chọn danh mục</option>
                    <option value="Búa">Búa</option>
                    <option value="Gạch">Gạch</option>
                    <option value="Bay">Bay</option>
                    <option value="Kìm">Kìm</option>
                    <option value="Đinh">Đinh</option>
                    <option value="Cát">Cát</option>
                    <option value="Đá">Đá</option>
                    <option value="Xi măng">Xi măng</option>
                    <option value="Gỗ">Gỗ</option>
                    <option value="Sắt">Sắt</option>
                    <option value="Thép">Thép</option>
                    <option value="Ống nước">Ống nước</option>
                    <option value="Dây điện">Dây điện</option>
                    <option value="Sơn">Sơn</option>
                    <option value="Gạch men">Gạch men</option>
                    <option value="Vữa">Vữa</option>
                    <option value="Kính">Kính</option>
                    <option value="Dụng cụ cầm tay">Dụng cụ cầm tay</option>
                    <option value="Giàn giáo">Giàn giáo</option>
                    <option value="Máy hàn">Máy hàn</option>
                </select>
            </div>
            <div class="form-group">
                <label for="supplierName"><i class="fas fa-building"></i> Tên nhà cung cấp:</label>
                <input type="text" id="supplierName" name="supplierName" placeholder="Nhập tên nhà cung cấp" required>
            </div>
            <div class="form-group">
                <label for="quantity"><i class="fas fa-sort-numeric-up"></i> Số lượng:</label>
                <input type="number" id="quantity" name="quantity" placeholder="Nhập số lượng" min="0" required>
            </div>
            <div class="form-group">
                <label for="status"><i class="fas fa-info-circle"></i> Tình trạng:</label>
                <select id="status" name="status" required>
                    <option value="" disabled selected>Chọn tình trạng</option>
                    <option value="Mới">Mới</option>
                    <option value="Dùng">Dùng</option>
                    <option value="Hỏng">Hỏng</option>
                </select>
            </div>
            <div class="form-group">
                <label for="image"><i class="fas fa-image"></i> Hình ảnh:</label>
                <input type="file" id="image" name="image" accept="image/*">
            </div>
        </div>
        <div class="form-group form-actions">
            <button type="submit" class="submit-btn"><i class="fas fa-plus"></i> Thêm vật tư</button>
            <button type="button" class="cancel-btn" onclick="resetForm()">Hủy</button>
        </div>
    </form>
    <div id="successMessage" class="success-message hidden">
        <i class="fas fa-check-circle"></i> Vật tư đã được thêm thành công!
    </div>
</div>