DROP DATABASE IF EXISTS materialsmanagementdb;
CREATE DATABASE materialsmanagementdb;
USE materialsmanagementdb;
-- Bảng danh mục
CREATE TABLE categories (
  CategoryID int NOT NULL AUTO_INCREMENT,
  CategoryName varchar(100) NOT NULL,
  PRIMARY KEY (CategoryID)
);

INSERT INTO categories VALUES 
(1,'Búa'),(2,'Gạch'),(3,'Xi măng'),(4,'Ống nước'),(5,'Dây điện'),
(6,'Sơn'),(7,'Gạch men'),(8,'Vữa'),(9,'Kính'),(10,'Dụng cụ cầm tay');

-- Bảng danh mục con
CREATE TABLE subcategories (
  SubcategoryID int NOT NULL AUTO_INCREMENT,
  CategoryID int DEFAULT NULL,
  SubcategoryName varchar(100) NOT NULL,
  PRIMARY KEY (SubcategoryID),
  FOREIGN KEY (CategoryID) REFERENCES categories (CategoryID)
);

INSERT INTO subcategories VALUES 
(1,1,'Búa đóng đinh'),(2,1,'Búa gõ'),(3,1,'Búa cao su'),
(4,2,'Gạch đỏ'),(5,2,'Gạch bê tông'),(6,2,'Gạch men'),
(7,3,'Xi măng trắng'),(8,3,'Xi măng đen'),(9,3,'Xi măng PCB40'),
(10,4,'Ống PVC'),(11,4,'Ống PPR'),(12,4,'Ống HDPE'),
(13,5,'Dây đơn'),(14,5,'Dây đôi'),(15,5,'Dây cáp'),
(16,6,'Sơn nước'),(17,6,'Sơn dầu'),(18,6,'Sơn chống thấm'),
(19,7,'Gạch lát nền'),(20,7,'Gạch ốp tường'),(21,7,'Gạch mosaic'),
(22,8,'Vữa xây'),(23,8,'Vữa trát'),(24,8,'Vữa tự chảy'),
(25,9,'Kính cường lực'),(26,9,'Kính thường'),(27,9,'Kính mờ'),
(28,10,'Cưa tay'),(29,10,'Cưa máy'),(30,10,'Khoan tay');

-- Bảng nhà cung cấp
CREATE TABLE suppliers (
  SupplierID int NOT NULL AUTO_INCREMENT,
  SupplierName varchar(150) NOT NULL,
  Address varchar(255) DEFAULT NULL,
  PhoneNum varchar(20) DEFAULT NULL,
  PRIMARY KEY (SupplierID)
);

INSERT INTO suppliers VALUES 
(1,'Công ty TNHH Xây dựng ABC','Hà Nội','0123456789'),
(2,'Công ty Vật liệu XYZ','TP.HCM','0987654321'),
(3,'Công ty Xi măng Hà Nội','Hà Nội','0912345678'),
(4,'Công ty Nhựa Tiền Phong','Đà Nẵng','0934567890'),
(5,'Công ty Vật liệu Đông Nam','Cần Thơ','0908765432');

-- Bảng vật tư
CREATE TABLE materials (
  MaterialID int NOT NULL AUTO_INCREMENT,
  MaterialName varchar(150) NOT NULL,
  CategoryID int DEFAULT NULL,
  SubcategoryID int DEFAULT NULL,
  SupplierID int DEFAULT NULL,
  Image varchar(255) DEFAULT NULL,
  Quantity int DEFAULT 0,
  Detail varchar(5000) DEFAULT NULL,
  PRIMARY KEY (MaterialID),
  FOREIGN KEY (CategoryID) REFERENCES categories (CategoryID),
  FOREIGN KEY (SubcategoryID) REFERENCES subcategories (SubcategoryID),
  FOREIGN KEY (SupplierID) REFERENCES suppliers (SupplierID)
);

INSERT INTO `materials` (`MaterialID`, `MaterialName`, `CategoryID`, `SubcategoryID`, `SupplierID`, `Image`, `Quantity`, `Detail`) VALUES
(1, 'Búa đóng đinh 1kg', 1, 1, 1, 'img/hammer-nail.jpg', 50, 'Chiều dài: 30cm, Đầu búa: Thép carbon, Cán: Gỗ tự nhiên, Trọng lượng: 1kg, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(2, 'Búa đóng đinh 2kg', 1, 1, 1, 'img/hammer-nail.jpg', 30, 'Chiều dài: 35cm, Đầu búa: Thép hợp kim, Cán: Gỗ cứng, Trọng lượng: 2kg, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(3, 'Búa gõ thép', 1, 2, 2, 'img/hammer-tap.jpg', 40, 'Chiều dài: 32cm, Đầu búa: Thép không gỉ, Cán: Thép phủ cao su, Trọng lượng: 1.5kg, Nhà cung cấp: Công ty Vật liệu XYZ'),
(4, 'Búa cao su nhỏ', 1, 3, 1, 'img/hammer-rubber.jpg', 25, 'Chiều dài: 25cm, Đầu búa: Cao su tự nhiên, Cán: Gỗ, Trọng lượng: 0.5kg, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(5, 'Búa cao su lớn', 1, 3, 3, 'img/hammer-rubber.jpg', 20, 'Chiều dài: 30cm, Đầu búa: Cao su tổng hợp, Cán: Thép, Trọng lượng: 1kg, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(6, 'Gạch đỏ 20x10', 2, 4, 2, 'img/red-brick.jpg', 1000, 'Kích thước: 20x10x6cm, Chất liệu: Đất sét nung, Trọng lượng: 2kg, Nhà cung cấp: Công ty Vật liệu XYZ'),
(7, 'Gạch đỏ 30x15', 2, 4, 2, 'img/red-brick.jpg', 800, 'Kích thước: 30x15x8cm, Chất liệu: Đất sét nung, Trọng lượng: 3.5kg, Nhà cung cấp: Công ty Vật liệu XYZ'),
(8, 'Gạch bê tông nhẹ', 2, 5, 1, 'img/concrete-brick.jpg', 600, 'Kích thước: 60x20x10cm, Chất liệu: Bê tông khí chưng áp, Trọng lượng: 8kg, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(9, 'Gạch bê tông 40x20', 2, 5, 4, 'img/concrete-brick.jpg', 500, 'Kích thước: 40x20x20cm, Chất liệu: Bê tông cốt liệu, Trọng lượng: 12kg, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(10, 'Gạch men 30x30', 2, 6, 3, 'img/tile-brick.jpg', 700, 'Kích thước: 30x30x0.8cm, Chất liệu: Gốm sứ, Bề mặt: Men bóng, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(11, 'Xi măng trắng 50kg', 3, 7, 3, 'img/white-cement.jpg', 200, 'Trọng lượng: 50kg, Loại: Xi măng trắng PCW40, Ứng dụng: Trát, sơn, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(12, 'Xi măng trắng 40kg', 3, 7, 3, 'img/white-cement.jpg', 150, 'Trọng lượng: 40kg, Loại: Xi măng trắng PCW40, Ứng dụng: Trang trí, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(13, 'Xi măng đen 50kg', 3, 8, 3, 'img/black-cement.jpg', 300, 'Trọng lượng: 50kg, Loại: Xi măng đen PCB30, Ứng dụng: Xây dựng, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(14, 'Xi măng PCB40 50kg', 3, 9, 3, 'img/cement-pcb40.jpg', 250, 'Trọng lượng: 50kg, Loại: Xi măng PCB40, Ứng dụng: Kết cấu bê tông, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(15, 'Xi măng PCB40 40kg', 3, 9, 1, 'img/cement-pcb40.jpg', 180, 'Trọng lượng: 40kg, Loại: Xi măng PCB40, Ứng dụng: Xây dựng chung, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(16, 'Ống PVC 50mm', 4, 10, 4, 'img/pvc-pipe.jpg', 150, 'Đường kính: 50mm, Chiều dài: 4m, Chất liệu: Nhựa PVC, Ứng dụng: Dẫn nước, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(17, 'Ống PVC 100mm', 4, 10, 4, 'img/pvc-pipe.jpg', 120, 'Đường kính: 100mm, Chiều dài: 4m, Chất liệu: Nhựa PVC, Ứng dụng: Thoát nước, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(18, 'Ống PPR 25mm', 4, 11, 5, 'img/ppr-pipe.jpg', 100, 'Đường kính: 25mm, Chiều dài: 4m, Chất liệu: Nhựa PPR, Ứng dụng: Nước nóng, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(19, 'Ống PPR 50mm', 4, 11, 4, 'img/ppr-pipe.jpg', 80, 'Đường kính: 50mm, Chiều dài: 4m, Chất liệu: Nhựa PPR, Ứng dụng: Nước nóng, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(20, 'Ống HDPE 100mm', 4, 12, 5, 'img/hdpe-pipe.jpg', 90, 'Đường kính: 100mm, Chiều dài: 6m, Chất liệu: Nhựa HDPE, Ứng dụng: Cấp nước, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(21, 'Dây đơn 1mm', 5, 13, 2, 'img/single-wire.jpg', 200, 'Đường kính: 1mm, Chất liệu: Đồng bọc PVC, Chiều dài: 100m/cuộn, Nhà cung cấp: Công ty Vật liệu XYZ'),
(22, 'Dây đơn 2mm', 5, 13, 1, 'img/single-wire.jpg', 150, 'Đường kính: 2mm, Chất liệu: Đồng bọc PVC, Chiều dài: 100m/cuộn, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(23, 'Dây đôi 1.5mm', 5, 14, 3, 'img/double-wire.jpg', 180, 'Đường kính: 1.5mm, Chất liệu: Đồng bọc PVC, Chiều dài: 100m/cuộn, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(24, 'Dây đôi 2mm', 5, 14, 2, 'img/double-wire.jpg', 160, 'Đường kính: 2mm, Chất liệu: Đồng bọc PVC, Chiều dài: 100m/cuộn, Nhà cung cấp: Công ty Vật liệu XYZ'),
(25, 'Dây cáp 4mm', 5, 15, 5, 'img/cable-wire.jpg', 100, 'Đường kính: 4mm, Chất liệu: Đồng bọc PVC, Chiều dài: 50m/cuộn, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(26, 'Sơn nước trắng 5L', 6, 16, 2, 'img/water-paint.jpg', 50, 'Dung tích: 5L, Loại: Sơn nước, Màu: Trắng, Ứng dụng: Tường nội thất, Nhà cung cấp: Công ty Vật liệu XYZ'),
(27, 'Sơn nước xanh 5L', 6, 16, 1, 'img/water-paint.jpg', 40, 'Dung tích: 5L, Loại: Sơn nước, Màu: Xanh, Ứng dụng: Tường nội thất, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(28, 'Sơn dầu đỏ 1L', 6, 17, 3, 'img/oil-paint.jpg', 30, 'Dung tích: 1L, Loại: Sơn dầu, Màu: Đỏ, Ứng dụng: Kim loại, gỗ, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(29, 'Sơn dầu vàng 1L', 6, 17, 4, 'img/oil-paint.jpg', 25, 'Dung tích: 1L, Loại: Sơn dầu, Màu: Vàng, Ứng dụng: Kim loại, gỗ, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(30, 'Sơn chống thấm 5L', 6, 18, 5, 'img/waterproof-paint.jpg', 60, 'Dung tích: 5L, Loại: Sơn chống thấm, Ứng dụng: Tường ngoài, mái, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(31, 'Gạch lát nền 60x60', 7, 19, 3, 'img/floor-tile.jpg', 400, 'Kích thước: 60x60x0.9cm, Chất liệu: Gốm sứ, Bề mặt: Men mờ, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(32, 'Gạch lát nền 80x80', 7, 19, 2, 'img/floor-tile.jpg', 300, 'Kích thước: 80x80x1cm, Chất liệu: Gốm sứ, Bề mặt: Men bóng, Nhà cung cấp: Công ty Vật liệu XYZ'),
(33, 'Gạch ốp tường 30x60', 7, 20, 1, 'img/wall-tile.jpg', 350, 'Kích thước: 30x60x0.8cm, Chất liệu: Gốm sứ, Bề mặt: Men bóng, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(34, 'Gạch mosaic xanh', 7, 21, 4, 'img/mosaic-tile.jpg', 200, 'Kích thước: 30x30cm (vỉ), Chất liệu: Thủy tinh, Màu: Xanh, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(35, 'Gạch mosaic trắng', 7, 21, 5, 'img/mosaic-tile.jpg', 150, 'Kích thước: 30x30cm (vỉ), Chất liệu: Thủy tinh, Màu: Trắng, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(36, 'Vữa xây 50kg', 8, 22, 3, 'img/mortar-build.jpg', 500, 'Trọng lượng: 50kg, Loại: Vữa xây, Ứng dụng: Xây tường, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(37, 'Vữa xây 40kg', 8, 22, 2, 'img/mortar-build.jpg', 400, 'Trọng lượng: 40kg, Loại: Vữa xây, Ứng dụng: Xây tường, Nhà cung cấp: Công ty Vật liệu XYZ'),
(38, 'Vữa trát 50kg', 8, 23, 1, 'img/mortar-plaster.jpg', 450, 'Trọng lượng: 50kg, Loại: Vữa trát, Ứng dụng: Trát tường, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(39, 'Vữa trát 40kg', 8, 23, 4, 'img/mortar-plaster.jpg', 350, 'Trọng lượng: 40kg, Loại: Vữa trát, Ứng dụng: Trát tường, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(40, 'Vữa tự chảy 25kg', 8, 24, 5, 'img/mortar-self-leveling.jpg', 200, 'Trọng lượng: 25kg, Loại: Vữa tự chảy, Ứng dụng: San phẳng nền, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(41, 'Kính cường lực 8mm', 9, 25, 2, 'img/tempered-glass.jpg', 100, 'Độ dày: 8mm, Kích thước: 2x3m, Chất liệu: Kính cường lực, Nhà cung cấp: Công ty Vật liệu XYZ'),
(42, 'Kính cường lực 10mm', 9, 25, 3, 'img/tempered-glass.jpg', 80, 'Độ dày: 10mm, Kích thước: 2x3m, Chất liệu: Kính cường lực, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(43, 'Kính thường 5mm', 9, 26, 1, 'img/regular-glass.jpg', 120, 'Độ dày: 5mm, Kích thước: 2x3m, Chất liệu: Kính float, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(44, 'Kính mờ 6mm', 9, 27, 4, 'img/frosted-glass.jpg', 90, 'Độ dày: 6mm, Kích thước: 2x3m, Chất liệu: Kính mờ phun cát, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(45, 'Kính mờ 8mm', 9, 27, 5, 'img/frosted-glass.jpg', 70, 'Độ dày: 8mm, Kích thước: 2x3m, Chất liệu: Kính mờ phun cát, Nhà cung cấp: Công ty Vật liệu Đông Nam'),
(46, 'Cưa tay 30cm', 10, 28, 1, 'img/hand-saw.jpg', 50, 'Chiều dài lưỡi: 30cm, Chất liệu: Thép carbon, Cán: Nhựa, Nhà cung cấp: Công ty TNHH Xây dựng ABC'),
(47, 'Cưa tay 40cm', 10, 28, 2, 'img/hand-saw.jpg', 40, 'Chiều dài lưỡi: 40cm, Chất liệu: Thép hợp kim, Cán: Gỗ, Nhà cung cấp: Công ty Vật liệu XYZ'),
(48, 'Cưa máy 2000W', 10, 29, 3, 'img/chainsaw.jpg', 20, 'Công suất: 2000W, Chiều dài lưỡi: 40cm, Chất liệu: Thép, Nhà cung cấp: Công ty Xi măng Hà Nội'),
(49, 'Cưa máy 1500W', 10, 29, 4, 'img/chainsaw.jpg', 15, 'Công suất: 1500W, Chiều dài lưỡi: 35cm, Chất liệu: Thép, Nhà cung cấp: Công ty Nhựa Tiền Phong'),
(50, 'Khoan tay 500W', 10, 30, 5, 'img/hand-drill.jpg', 30, 'Công suất: 500W, Đường kính mũi khoan: 10mm, Chất liệu: Thép, Nhà cung cấp: Công ty Vật liệu Đông Nam');

-- Bảng vai trò
CREATE TABLE roles (
  RoleID int NOT NULL AUTO_INCREMENT,
  RoleName varchar(100) NOT NULL,
  PRIMARY KEY (RoleID)
);

INSERT INTO roles VALUES 
(1,'Quản lý kho'),(2,'Nhân viên kho'),(3,'Giám đốc công ty'),(4,'Nhân viên công ty');

-- Bảng người dùng
CREATE TABLE users (
  UserID int NOT NULL AUTO_INCREMENT,
  Username varchar(100) NOT NULL UNIQUE,
  PasswordHash varchar(255) NOT NULL,
  FirstName varchar(100) DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  RoleID int DEFAULT NULL,
  PhoneNum varchar(20) DEFAULT NULL,
  Address varchar(255) DEFAULT NULL,
  RegistrationDate datetime DEFAULT CURRENT_TIMESTAMP,
  IsActive bit(1) DEFAULT b'1',
  IsResetRequested bit(1) DEFAULT b'0',
  PRIMARY KEY (UserID),
  FOREIGN KEY (RoleID) REFERENCES roles (RoleID)
);

INSERT INTO users VALUES 
(1,'fms.quanlykho@gmail.com','$argon2id$v=19$m=65536,t=10,p=1$2D1D0aQkWLpddSybyDFp1w$1Y7DYMUZpG9FpqQ+aU6kjtCw/Z1jCf9g3Lk+5gsGA0s','Năng','Đào Văn',1,'0123456789',NULL,'2025-05-31 06:29:34',1, 0),
(2,'hieu@gmail.com','$argon2id$v=19$m=65536,t=10,p=1$qSjvQZrEUgwAaKMbE7XR3w$rMKJ6oMFh+z090SKl5EHdxYY7405AEUv4Yf+hr0g/ws','Hiếu','Nguyễn Trung',3,'0727627612','Phú Thọ','2025-05-31 06:30:46',1, 0),
(3,'Dat@gmail.com','$argon2id$v=19$m=65536,t=10,p=1$WFEerR/Ws/ceoRR099Jxdw$leJzVL4ea6w3Gh9yRtFrSUq06klgDB6wHmlyqXFd4iE','Đạt','Nguyễn Tien',4,'0978267271',NULL,'2025-05-31 06:31:39',1, 0),
(4,'Nang@gmail.com','$argon2id$v=19$m=65536,t=10,p=1$IZ1dWtpoxxAMwn/nEPpx6Q$w06nTEGm3NW9LS2hrNsthZqJSL+wNrNZsDfkq2zF8LY','Năng','Đào Văn',1,'0987654321','Hà Nam','2025-05-31 06:32:28',1, 0),
(5,'Vy@gmail.com','$argon2id$v=19$m=65536,t=10,p=1$GjGQixb4zQ2X5FP0KzJ/hw$sx4f2m6M0o9+cJOBFlf2SPEYWWnK6e8njADvL0eYqls','Vy','Phạm Thị Tường',2,'0123456789','Hà Nội','2025-05-31 06:33:11',1, 0),
(6,'nangdvhe187101@fpt.edu.vn','$argon2id$v=19$m=65536,t=10,p=1$RY40xq+um7ITpvKyEsLEZA$HQcjIem2kAVRyAicSWb9GzN0Drjq9mpKL+18+TCxqUs','Hệ thống','Quản trị',1,'0123456789','Nghi yên, Nghi Xuân, Hà Tĩnh','2025-06-02 05:36:42',1, 0);

-- Bảng chức năng
CREATE TABLE feature (
  UrlID int NOT NULL AUTO_INCREMENT,
  UrlName varchar(100) NOT NULL,
  Url varchar(255) NOT NULL UNIQUE,
  PRIMARY KEY (UrlID)
);

INSERT INTO feature VALUES
(1,'Xem thông tin cá nhân','/profile'),
(2,'Sửa thông tin cá nhân','/update-profile'),
(3,'Thay đổi mật khẩu','/change-password'),
(4,'Xem danh sách vật tư','/manage-material'),
(5,'Tìm kiếm vật tư','/search-material-in-list'),
(6,'Thêm mới vật tư','/add-material'),
(7,'Xem chi tiết thông tin vật tư','/search-material'),
(8,'Sửa vật tư','/edit-material'),
(9,'Xoá vật tư','/delete-material'),
(10,'Xem danh sách danh mục vật tư','/manage-category'),
(11,'Thêm danh mục vật tư','/manage-category?action=addForm'),
(12,'Xem phân quyền chức năng','/decentralization'),
(13,'(Chỉ dành cho quản trị hệ thống) Sửa phân quyền chức năng','/update-decentralization'),
(14,'(Chỉ dành cho quản trị hệ thống) Thêm mới người dùng','/add-user'),
(15,'(Chỉ dành cho quản trị hệ thống) Xem danh sách người dùng','/manage-user'),
(16,'(Chỉ dành cho quản trị hệ thống) Xem danh sách yêu cầu reset mật khẩu','/reset-password-request-list');

-- Bảng phân quyền
CREATE TABLE role_feature (
  RoleID int NOT NULL,
  UrlID int NOT NULL,
  PRIMARY KEY (RoleID,UrlID),
  FOREIGN KEY (RoleID) REFERENCES roles (RoleID),
  FOREIGN KEY (UrlID) REFERENCES feature (UrlID)
);

INSERT INTO role_feature VALUES 
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),
(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),(4,12);

-- Bảng lịch sử thay đổi
CREATE TABLE records (
  RecordID int NOT NULL AUTO_INCREMENT,
  MaterialID int DEFAULT NULL,
  Quantity int NOT NULL,
  Type bit(1) NOT NULL,
  ChangeDate datetime DEFAULT CURRENT_TIMESTAMP,
  Note text,
  PRIMARY KEY (RecordID),
  FOREIGN KEY (MaterialID) REFERENCES materials (MaterialID)
);

-- Bảng tình trạng vật tư
CREATE TABLE materialconditions (
  MaterialID int NOT NULL,
  NewQuantity int DEFAULT 0,
  UsableQuantity int DEFAULT 0,
  BrokenQuantity int DEFAULT 0,
  PRIMARY KEY (MaterialID),
  FOREIGN KEY (MaterialID) REFERENCES materials (MaterialID)
);