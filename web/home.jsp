<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dto.User_Role" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ thống Quản lý Xây dựng - Trang chủ</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    </head>
    <body>
        <div id="dashboard">
            <div class="header">
                <h1><i class="fas fa-hard-hat"></i> Hệ thống Quản lý Xây dựng</h1>
                <div class="actions">
                    <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                    <div class="user-info">
                        <i class="fas fa-user-circle"></i>
                        <div class="tooltip">
                            <p class="position">Quản lý</p>
                            <p>${not empty sessionScope.user ? sessionScope.user.fullName : 'Chưa đăng nhập'}</p>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
                        <button type="submit" class="logout-button" onclick="logout()">Đăng xuất</button>
                    </form>
                </div>
            </div>
            <div class="sidebar" id="sidebar">
                <h3><i class="fas fa-tools"></i> Menu</h3>
                <ul>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-users"></i> Quản lý người dùng</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/Userctr?service=listAllUser">Xem danh sách người dùng</a>
                            <a href="#" onclick="showContent('addUser', this)">Thêm mới người dùng</a>
                            <a href="#" onclick="showContent('editUser', this)">Sửa thông tin người dùng</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-user"></i> Thông tin cá nhân</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/Profile">Xem thông tin cá nhân</a>
                            <a href="#" onclick="showContent('changePasswordSection', this)">Thay đổi mật khẩu</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-folder"></i> Quản lý danh mục vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('categoryListSection', this)">Xem danh mục vật tư</a>
                            <a href="#" onclick="showContent('addCategory', this)">Thêm mới danh mục vật tư</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-toggle" onclick="toggleDropdown(this)">
                            <span><i class="fas fa-boxes"></i> Quản lý vật tư</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="dropdown-content">
                            <a href="#" onclick="showContent('materialList', this)">Xem danh sách vật tư</a>
                            <a href="#" onclick="showContent('addMaterial', this)">Thêm mới vật tư</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content" id="contentArea">
                <!-- Welcome Section -->
                <div class="content-card" id="welcomeSection">
                    <h2>Chào mừng đến với Hệ thống Quản lý</h2>
                    <p>Vui lòng chọn chức năng từ menu bên trái.</p>
                </div>

                <!-- Include Personal Information and Change Password Sections -->
<!--                <div class="content-card hidden" id="profileSection">
                    <h2>Thông tin cá nhân</h2>
                    <div class="profile-card">
                        <h3><i class="fas fa-user-circle"></i> Hồ sơ cá nhân</h3>
                        <%
                            User_Role userRole = (User_Role) session.getAttribute("userRole");
                            if (userRole != null) {
                        %>
                        <div class="info-row">
                            <label>Họ và tên:</label>
                            <span><%= userRole.getLastName() + " " + userRole.getFirstName() %></span>
                        </div>
                        <div class="info-row">
                            <label>Email:</label>
                            <span><%= userRole.getUsername() %></span>
                        </div>
                        <div class="info-row">
                            <label>Số điện thoại:</label>
                            <span><%= userRole.getPhoneNum() %></span>
                        </div>
                        <div class="info-row">
                            <label>Địa chỉ:</label>
                            <span><%= userRole.getAddress()%></span>
                        </div>
                        <div class="info-row">
                            <label>Vai trò:</label>
                            <span><%= userRole.getRoleName() %></span>
                        </div>
                        <button onclick="openEditModal()">Thay đổi</button>
                        <% } else { %>
                        <p>Không tìm thấy thông tin người dùng. Vui lòng đăng nhập lại.</p>
                        <% } %>
                    </div>
                </div>

                 Password Change Section 
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

                 Edit Modal 
                <div id="editModalOverlay" class="modal-overlay"></div>
                <div id="editModal" class="modal">
                    <span class="close" onclick="closeEditModal()">×</span>
                    <h3>Chỉnh sửa thông tin cá nhân</h3>
                    <form action="updateProfile" method="post">
                        <div class="form-row">
                            <label for="editLastName">Họ:</label>
                            <input type="text" id="editLastName" name="editLastName" value="<%=  userRole.getLastName()  %>">
                        </div>
                        <div class="form-row">
                            <label for="editFirstName">Tên:</label>
                            <input type="text" id="editFirstName" name="editFirstName" value="<%= userRole.getFirstName()  %>">
                        </div>
                        <div class="form-row">
                            <label for="editPhone">Số điện thoại:</label>
                            <input type="tel" id="editPhone" name="editPhone" value="<%= userRole.getPhoneNum()  %>">
                        </div>
                        <div class="form-row">
                            <label for="editAddress">Địa chỉ:</label>
                            <input type="text" id="editAddress" name="editAddress" value="<%= userRole.getAddress()  %>">
                        </div>
                        <button type="submit">Lưu thay đổi</button>
                    </form>
                </div>-->

                <!-- Material Categories Section -->
                <div class="content-card hidden" id="categoryListSection">
                    <h2>Danh mục vật tư</h2>
                    <ul class="category-list">
                        <li>
                            <a href="#" onclick="showContent('categoryBuaSection', this)">
                                <img src="img/bua.jpg" alt="Búa" class="category-image">
                                Búa
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryGachSection', this)">
                                <img src="img/gach.jpg" alt="Gạch" class="category-image">
                                Gạch
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryBaySection', this)">
                                <img src="img/bay.jpeg" alt="Bay" class="category-image">
                                Bay
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryKimSection', this)">
                                <img src="img/kim.jpg" alt="Kìm" class="category-image">
                                Kìm
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryDinhSection', this)">
                                <img src="img/dinh.png" alt="Đinh" class="category-image">
                                Đinh
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryCatSection', this)">
                                <img src="img/cat.jpg" alt="Cát" class="category-image">
                                Cát
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryDaSection', this)">
                                <img src="img/da.jpg" alt="Đá" class="category-image">
                                Đá
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryXiMangSection', this)">
                                <img src="img/xi_mang.png" alt="Xi măng" class="category-image">
                                Xi măng
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryGoSection', this)">
                                <img src="img/go.jpg" alt="Gỗ" class="category-image">
                                Gỗ
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categorySatSection', this)">
                                <img src="img/sat.jpg" alt="Sắt" class="category-image">
                                Sắt
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryThepSection', this)">
                                <img src="img/thep.jpg" alt="Thép" class="category-image">
                                Thép
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryOngNuocSection', this)">
                                <img src="img/ong_nuoc.jpg" alt="Ống nước" class="category-image">
                                Ống nước
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryDayDienSection', this)">
                                <img src="img/day_dien.jpg" alt="Dây điện" class="category-image">
                                Dây điện
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categorySonSection', this)">
                                <img src="img/son.jpg" alt="Sơn" class="category-image">
                                Sơn
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryGachMenSection', this)">
                                <img src="img/gach_men.jpg" alt="Gạch men" class="category-image">
                                Gạch men
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryVuaSection', this)">
                                <img src="img/vua.jpg" alt="Vữa" class="category-image">
                                Vữa
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryKinhSection', this)">
                                <img src="img/kinh.jpg" alt="Kính" class="category-image">
                                Kính
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryDungCuCamTaySection', this)">
                                <img src="img/chainsaw.jpg" alt="Dụng cụ cầm tay" class="category-image">
                                Dụng cụ cầm tay
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryGianGiaoSection', this)">
                                <img src="img/scaffolding.jpg" alt="Giàn giáo" class="category-image">
                                Giàn giáo
                            </a>
                        </li>
                        <li>
                            <a href="#" onclick="showContent('categoryMayHanSection', this)">
                                <img src="img/welding-machine.jpg" alt="Máy hàn" class="category-image">
                                Máy hàn
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Búa -->
                <div class="content-card hidden" id="categoryBuaSection">
                    <h2>Búa</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/hammer-nail.jpg" alt="Búa đóng đinh" class="product-image">
                            Búa đóng đinh
                        </li>
                        <li>
                            <img src="img/hammer-tap.jpg" alt="Búa gõ" class="product-image">
                            Búa gõ
                        </li>
                        <li>
                            <img src="img/hammer-rubber.jpg" alt="Búa cao su" class="product-image">
                            Búa cao su
                        </li>
                        <li>
                            <img src="img/hammer-blacksmith.jpg" alt="Búa thợ rèn" class="product-image">
                            Búa thợ rèn
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Gạch -->
                <div class="content-card hidden" id="categoryGachSection">
                    <h2>Gạch</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/red-brick.jpg" alt="Gạch đỏ" class="product-image">
                            Gạch đỏ
                        </li>
                        <li>
                            <img src="img/concrete-brick.jpg" alt="Gạch bê tông" class="product-image">
                            Gạch bê tông
                        </li>
                        <li>
                            <img src="img/tile-brick.jpg" alt="Gạch men" class="product-image">
                            Gạch men
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Bay -->
                <div class="content-card hidden" id="categoryBaySection">
                    <h2>Bay</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/trowel-build.jpg" alt="Bay xây" class="product-image">
                            Bay xây
                        </li>
                        <li>
                            <img src="img/trowel-plaster.jpg" alt="Bay trát" class="product-image">
                            Bay trát
                        </li>
                        <li>
                            <img src="img/trowel-finish.jpg" alt="Bay hoàn thiện" class="product-image">
                            Bay hoàn thiện
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Kìm -->
                <div class="content-card hidden" id="categoryKimSection">
                    <h2>Kìm</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/pliers-cutting.jpg" alt="Kìm cắt" class="product-image">
                            Kìm cắt
                        </li>
                        <li>
                            <img src="img/needle-nose-pliers.jpg" alt="Kìm mũi nhọn" class="product-image">
                            Kìm mũi nhọn
                        </li>
                        <li>
                            <img src="img/pliers-multifunction.jpg" alt="Kìm đa năng" class="product-image">
                            Kìm đa năng
                        </li>
                        <li>
                            <img src="img/pliers-crimping.jpg" alt="Kìm bấm" class="product-image">
                            Kìm bấm
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Đinh -->
                <div class="content-card hidden" id="categoryDinhSection">
                    <h2>Đinh</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/iron-nails.jpg" alt="Đinh sắt" class="product-image">
                            Đinh sắt
                        </li>
                        <li>
                            <img src="img/steel-nails.jpg" alt="Đinh thép" class="product-image">
                            Đinh thép
                        </li>
                        <li>
                            <img src="img/screws.jpg" alt="Đinh vít" class="product-image">
                            Đinh vít
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Cát -->
                <div class="content-card hidden" id="categoryCatSection">
                    <h2>Cát</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/building-sand.jpg" alt="Cát xây" class="product-image">
                            Cát xây
                        </li>
                        <li>
                            <img src="img/fill-sand.jpg" alt="Cát san lấp" class="product-image">
                            Cát san lấp
                        </li>
                        <li>
                            <img src="img/yellow-sand.jpg" alt="Cát vàng" class="product-image">
                            Cát vàng
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Đá -->
                <div class="content-card hidden" id="categoryDaSection">
                    <h2>Đá</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/stone-1x2.jpg" alt="Đá 1x2" class="product-image">
                            Đá 1x2
                        </li>
                        <li>
                            <img src="img/stone-4x6.jpg" alt="Đá 4x6" class="product-image">
                            Đá 4x6
                        </li>
                        <li>
                            <img src="img/stone-dust.jpg" alt="Đá mi" class="product-image">
                            Đá mi
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Xi măng -->
                <div class="content-card hidden" id="categoryXiMangSection">
                    <h2>Xi măng</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/white-cement.jpg" alt="Xi măng trắng" class="product-image">
                            Xi măng trắng
                        </li>
                        <li>
                            <img src="img/black-cement.jpg" alt="Xi măng đen" class="product-image">
                            Xi măng đen
                        </li>
                        <li>
                            <img src="img/cement-pcb40.jpg" alt="Xi măng PCB40" class="product-image">
                            Xi măng PCB40
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Gỗ -->
                <div class="content-card hidden" id="categoryGoSection">
                    <h2>Gỗ</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/pine-wood.jpg" alt="Gỗ thông" class="product-image">
                            Gỗ thông
                        </li>
                        <li>
                            <img src="img/lim-wood.jpg" alt="Gỗ lim" class="product-image">
                            Gỗ lim
                        </li>
                        <li>
                            <img src="img/oak-wood.jpg" alt="Gỗ sồi" class="product-image">
                            Gỗ sồi
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Sắt -->
                <div class="content-card hidden" id="categorySatSection">
                    <h2>Sắt</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/iron-phi6.jpg" alt="Sắt phi 6" class="product-image">
                            Sắt phi 6
                        </li>
                        <li>
                            <img src="img/iron-phi8.jpg" alt="Sắt phi 8" class="product-image">
                            Sắt phi 8
                        </li>
                        <li>
                            <img src="img/iron-box.jpg" alt="Sắt hộp" class="product-image">
                            Sắt hộp
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Thép -->
                <div class="content-card hidden" id="categoryThepSection">
                    <h2>Thép</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/steel-round.jpg" alt="Thép tròn" class="product-image">
                            Thép tròn
                        </li>
                        <li>
                            <img src="img/steel-square.jpg" alt="Thép vuông" class="product-image">
                            Thép vuông
                        </li>
                        <li>
                            <img src="img/steel-hot-rolled.jpg" alt="Thép cán nóng" class="product-image">
                            Thép cán nóng
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Ống nước -->
                <div class="content-card hidden" id="categoryOngNuocSection">
                    <h2>Ống nước</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/pvc-pipe.jpg" alt="Ống PVC" class="product-image">
                            Ống PVC
                        </li>
                        <li>
                            <img src="img/ppr-pipe.jpg" alt="Ống PPR" class="product-image">
                            Ống PPR
                        </li>
                        <li>
                            <img src="img/hdpe-pipe.jpg" alt="Ống HDPE" class="product-image">
                            Ống HDPE
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Dây điện -->
                <div class="content-card hidden" id="categoryDayDienSection">
                    <h2>Dây điện</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/single-wire.jpg" alt="Dây đơn" class="product-image">
                            Dây đơn
                        </li>
                        <li>
                            <img src="img/double-wire.jpg" alt="Dây đôi" class="product-image">
                            Dây đôi
                        </li>
                        <li>
                            <img src="img/cable-wire.jpg" alt="Dây cáp" class="product-image">
                            Dây cáp
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Sơn -->
                <div class="content-card hidden" id="categorySonSection">
                    <h2>Sơn</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/water-paint.jpg" alt="Sơn nước" class="product-image">
                            Sơn nước
                        </li>
                        <li>
                            <img src="img/oil-paint.jpg" alt="Sơn dầu" class="product-image">
                            Sơn dầu
                        </li>
                        <li>
                            <img src="img/waterproof-paint.jpg" alt="Sơn chống thấm" class="product-image">
                            Sơn chống thấm
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Gạch men -->
                <div class="content-card hidden" id="categoryGachMenSection">
                    <h2>Gạch men</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/floor-tile.jpg" alt="Gạch lát nền" class="product-image">
                            Gạch lát nền
                        </li>
                        <li>
                            <img src="img/wall-tile.jpg" alt="Gạch ốp tường" class="product-image">
                            Gạch ốp tường
                        </li>
                        <li>
                            <img src="img/mosaic-tile.jpg" alt="Gạch mosaic" class="product-image">
                            Gạch mosaic
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Vữa -->
                <div class="content-card hidden" id="categoryVuaSection">
                    <h2>Vữa</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/mortar-build.jpg" alt="Vữa xây" class="product-image">
                            Vữa xây
                        </li>
                        <li>
                            <img src="img/mortar-plaster.jpg" alt="Vữa trát" class="product-image">
                            Vữa trát
                        </li>
                        <li>
                            <img src="img/mortar-self-leveling.jpg" alt="Vữa tự chảy" class="product-image">
                            Vữa tự chảy
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Kính -->
                <div class="content-card hidden" id="categoryKinhSection">
                    <h2>Kính</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/tempered-glass.jpg" alt="Kính cường lực" class="product-image">
                            Kính cường lực
                        </li>
                        <li>
                            <img src="img/regular-glass.jpg" alt="Kính thường" class="product-image">
                            Kính thường
                        </li>
                        <li>
                            <img src="img/frosted-glass.jpg" alt="Kính mờ" class="product-image">
                            Kính mờ
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Dụng cụ cầm tay -->
                <div class="content-card hidden" id="categoryDungCuCamTaySection">
                    <h2>Dụng cụ cầm tay</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/hand-saw.jpg" alt="Cưa tay" class="product-image">
                            Cưa tay
                        </li>
                        <li>
                            <img src="img/chainsaw.jpg" alt="Cưa máy" class="product-image">
                            Cưa máy
                        </li>
                        <li>
                            <img src="img/hand-drill.jpg" alt="Khoan tay" class="product-image">
                            Khoan tay
                        </li>
                        <li>
                            <img src="img/tape-measure.jpg" alt="Thước dây" class="product-image">
                            Thước dây
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Giàn giáo -->
                <div class="content-card hidden" id="categoryGianGiaoSection">
                    <h2>Giàn giáo</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/scaffolding-frame.jpg" alt="Giàn giáo khung" class="product-image">
                            Giàn giáo khung
                        </li>
                        <li>
                            <img src="img/scaffolding-wedge.jpg" alt="Giàn giáo nêm" class="product-image">
                            Giàn giáo nêm
                        </li>
                        <li>
                            <img src="img/scaffolding-mobile.jpg" alt="Giàn giáo di động" class="product-image">
                            Giàn giáo di động
                        </li>
                    </ul>
                </div>

                <!-- Material Category: Máy hàn -->
                <div class="content-card hidden" id="categoryMayHanSection">
                    <h2>Máy hàn</h2>
                    <a href="#" onclick="showContent('categoryListSection', this)">Quay lại danh mục</a>
                    <ul class="product-list">
                        <li>
                            <img src="img/welding-machine.jpg" alt="Máy hàn Hồng Ký HK-200H" class="product-image">
                            Máy hàn Hồng Ký HK-200H
                        </li>
                        <li>
                            <img src="img/welding-tig.jpg" alt="Máy hàn TIG" class="product-image">
                            Máy hàn TIG
                        </li>
                        <li>
                            <img src="img/welding-mig.jpg" alt="Máy hàn MIG" class="product-image">
                            Máy hàn MIG
                        </li>
                    </ul>
                </div>

                <!-- Placeholder for static sections -->
                <div class="content-card hidden" id="genericSection"></div>
            </div>
        </div>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
    </body>
</html>