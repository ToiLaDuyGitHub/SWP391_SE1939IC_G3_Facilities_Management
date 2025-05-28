<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Material List Section -->
<div class="content-card hidden" id="materialListSection">
    <h2>Danh sách Vật tư</h2>
    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
    <table class="material-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên vật tư</th>
                <th>Danh mục</th>
                <th>Tên nhà cung cấp</th>
                <th>Số lượng</th>
                <th>Tình trạng</th>
                <th>Hình ảnh</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Búa đóng đinh</td>
                <td>Búa</td>
                <td>Công ty TNHH Xây dựng ABC</td>
                <td>50</td>
                <td>Mới: 2, Dùng: 7, Hỏng: 1</td>
                <td><img src="img/hammer-nail.jpg" alt="Búa đóng đinh" class="product-image"></td>
            </tr>
            <tr>
                <td>2</td>
                <td>Gạch đỏ</td>
                <td>Gạch</td>
                <td>Công ty Vật liệu XYZ</td>
                <td>1000</td>
                <td></td> <!-- Để trống tình trạng -->
                <td><img src="img/red-brick.jpg" alt="Gạch đỏ" class="product-image"></td>
            </tr>
            <tr>
                <td>3</td>
                <td>Xi măng PCB40</td>
                <td>Xi măng</td>
                <td>Công ty Xi măng Hà Nội</td>
                <td>200</td>
                <td>Mới: 180, Dùng: 15, Hỏng: 5</td>
                <td><img src="img/cement-pcb40.jpg" alt="Xi măng PCB40" class="product-image"></td>
            </tr>
            <tr>
                <td>4</td>
                <td>Ống PVC</td>
                <td>Ống nước</td>
                <td>Công ty Nhựa Tiền Phong</td>
                <td>150</td>
                <td></td> <!-- Để trống tình trạng -->
                <td><img src="img/pvc-pipe.jpg" alt="Ống PVC" class="product-image"></td>
            </tr>
        </tbody>
    </table>
</div>