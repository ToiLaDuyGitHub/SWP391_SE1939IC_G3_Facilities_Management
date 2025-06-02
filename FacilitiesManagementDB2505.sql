/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Database: `facilitiesmanagementdb`
--
CREATE DATABASE IF NOT EXISTS `facilitiesmanagementdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `facilitiesmanagementdb`;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(100) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`RoleID`, `RoleName`) VALUES 
(1,'Quản lý kho'),
(2,'Nhân viên kho'),
(3,'Giám đốc công ty'),
(4,'Nhân viên công ty');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `SupplierID` int NOT NULL AUTO_INCREMENT,
  `SupplierName` varchar(150) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNum` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `SubcategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryID` int DEFAULT NULL,
  `SubcategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`SubcategoryID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities` (
  `FacilityID` int NOT NULL AUTO_INCREMENT,
  `FacilityName` varchar(150) NOT NULL,
  `CategoryID` int DEFAULT NULL,
  `SubcategoryID` int DEFAULT NULL,
  `SupplierID` int DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `Quantity` int DEFAULT '0',
  PRIMARY KEY (`FacilityID`),
  KEY `CategoryID` (`CategoryID`),
  KEY `SubcategoryID` (`SubcategoryID`),
  KEY `SupplierID` (`SupplierID`),
  CONSTRAINT `facilities_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`),
  CONSTRAINT `facilities_ibfk_2` FOREIGN KEY (`SubcategoryID`) REFERENCES `subcategories` (`SubcategoryID`),
  CONSTRAINT `facilities_ibfk_3` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilityconditions`
--

DROP TABLE IF EXISTS `facilityconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilityconditions` (
  `FacilityID` int NOT NULL,
  `NewQuantity` int DEFAULT '0',
  `UsableQuantity` int DEFAULT '0',
  `BrokenQuantity` int DEFAULT '0',
  PRIMARY KEY (`FacilityID`),
  CONSTRAINT `facilityconditions_ibfk_1` FOREIGN KEY (`FacilityID`) REFERENCES `facilities` (`FacilityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records` (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `FacilityID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `Type` bit(1) NOT NULL,
  `ChangeDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Note` text,
  PRIMARY KEY (`RecordID`),
  KEY `FacilityID` (`FacilityID`),
  CONSTRAINT `records_ibfk_1` FOREIGN KEY (`FacilityID`) REFERENCES `facilities` (`FacilityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `RoleID` int DEFAULT NULL,
  `PhoneNum` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `RegistrationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `ResetOTP` varchar(6) DEFAULT NULL,
  `ResetOTPTime` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `categories` (`CategoryName`) VALUES
('Búa'),
('Gạch'),
('Xi măng'),
('Ống nước'),
('Dây điện'),
('Sơn'),
('Gạch men'),
('Vữa'),
('Kính'),
('Dụng cụ cầm tay');
INSERT INTO `subcategories` (`CategoryID`, `SubcategoryName`) VALUES
(1, 'Búa đóng đinh'), (1, 'Búa gõ'), (1, 'Búa cao su'),
(2, 'Gạch đỏ'), (2, 'Gạch bê tông'), (2, 'Gạch men'),
(3, 'Xi măng trắng'), (3, 'Xi măng đen'), (3, 'Xi măng PCB40'),
(4, 'Ống PVC'), (4, 'Ống PPR'), (4, 'Ống HDPE'),
(5, 'Dây đơn'), (5, 'Dây đôi'), (5, 'Dây cáp'),
(6, 'Sơn nước'), (6, 'Sơn dầu'), (6, 'Sơn chống thấm'),
(7, 'Gạch lát nền'), (7, 'Gạch ốp tường'), (7, 'Gạch mosaic'),
(8, 'Vữa xây'), (8, 'Vữa trát'), (8, 'Vữa tự chảy'),
(9, 'Kính cường lực'), (9, 'Kính thường'), (9, 'Kính mờ'),
(10, 'Cưa tay'), (10, 'Cưa máy'), (10, 'Khoan tay');
INSERT INTO `suppliers` (`SupplierName`, `Address`, `PhoneNum`) VALUES
('Công ty TNHH Xây dựng ABC', 'Hà Nội', '0123456789'),
('Công ty Vật liệu XYZ', 'TP.HCM', '0987654321'),
('Công ty Xi măng Hà Nội', 'Hà Nội', '0912345678'),
('Công ty Nhựa Tiền Phong', 'Đà Nẵng', '0934567890'),
('Công ty Vật liệu Đông Nam', 'Cần Thơ', '0908765432');
INSERT INTO `facilities` (`FacilityName`, `CategoryID`, `SubcategoryID`, `SupplierID`, `Image`, `Quantity`) VALUES
('Búa đóng đinh 1kg', 1, 1, 1, 'img/hammer-nail.jpg', 50),
('Búa đóng đinh 2kg', 1, 1, 1, 'img/hammer-nail.jpg', 30),
('Búa gõ thép', 1, 2, 2, 'img/hammer-tap.jpg', 40),
('Búa cao su nhỏ', 1, 3, 1, 'img/hammer-rubber.jpg', 25),
('Búa cao su lớn', 1, 3, 3, 'img/hammer-rubber.jpg', 20),
('Gạch đỏ 20x10', 2, 4, 2, 'img/red-brick.jpg', 1000),
('Gạch đỏ 30x15', 2, 4, 2, 'img/red-brick.jpg', 800),
('Gạch bê tông nhẹ', 2, 5, 1, 'img/concrete-brick.jpg', 600),
('Gạch bê tông 40x20', 2, 5, 4, 'img/concrete-brick.jpg', 500),
('Gạch men 30x30', 2, 6, 3, 'img/tile-brick.jpg', 700),
('Xi măng trắng 50kg', 3, 7, 3, 'img/white-cement.jpg', 200),
('Xi măng trắng 40kg', 3, 7, 3, 'img/white-cement.jpg', 150),
('Xi măng đen 50kg', 3, 8, 3, 'img/black-cement.jpg', 300),
('Xi măng PCB40 50kg', 3, 9, 3, 'img/cement-pcb40.jpg', 250),
('Xi măng PCB40 40kg', 3, 9, 1, 'img/cement-pcb40.jpg', 180),
('Ống PVC 50mm', 4, 10, 4, 'img/pvc-pipe.jpg', 150),
('Ống PVC 100mm', 4, 10, 4, 'img/pvc-pipe.jpg', 120),
('Ống PPR 25mm', 4, 11, 5, 'img/ppr-pipe.jpg', 100),
('Ống PPR 50mm', 4, 11, 4, 'img/ppr-pipe.jpg', 80),
('Ống HDPE 100mm', 4, 12, 5, 'img/hdpe-pipe.jpg', 90),
('Dây đơn 1mm', 5, 13, 2, 'img/single-wire.jpg', 200),
('Dây đơn 2mm', 5, 13, 1, 'img/single-wire.jpg', 150),
('Dây đôi 1.5mm', 5, 14, 3, 'img/double-wire.jpg', 180),
('Dây đôi 2mm', 5, 14, 2, 'img/double-wire.jpg', 160),
('Dây cáp 4mm', 5, 15, 5, 'img/cable-wire.jpg', 100),
('Sơn nước trắng 5L', 6, 16, 2, 'img/water-paint.jpg', 50),
('Sơn nước xanh 5L', 6, 16, 1, 'img/water-paint.jpg', 40),
('Sơn dầu đỏ 1L', 6, 17, 3, 'img/oil-paint.jpg', 30),
('Sơn dầu vàng 1L', 6, 17, 4, 'img/oil-paint.jpg', 25),
('Sơn chống thấm 5L', 6, 18, 5, 'img/waterproof-paint.jpg', 60),
('Gạch lát nền 60x60', 7, 19, 3, 'img/floor-tile.jpg', 400),
('Gạch lát nền 80x80', 7, 19, 2, 'img/floor-tile.jpg', 300),
('Gạch ốp tường 30x60', 7, 20, 1, 'img/wall-tile.jpg', 350),
('Gạch mosaic xanh', 7, 21, 4, 'img/mosaic-tile.jpg', 200),
('Gạch mosaic trắng', 7, 21, 5, 'img/mosaic-tile.jpg', 150),
('Vữa xây 50kg', 8, 22, 3, 'img/mortar-build.jpg', 500),
('Vữa xây 40kg', 8, 22, 2, 'img/mortar-build.jpg', 400),
('Vữa trát 50kg', 8, 23, 1, 'img/mortar-plaster.jpg', 450),
('Vữa trát 40kg', 8, 23, 4, 'img/mortar-plaster.jpg', 350),
('Vữa tự chảy 25kg', 8, 24, 5, 'img/mortar-self-leveling.jpg', 200),
('Kính cường lực 8mm', 9, 25, 2, 'img/tempered-glass.jpg', 100),
('Kính cường lực 10mm', 9, 25, 3, 'img/tempered-glass.jpg', 80),
('Kính thường 5mm', 9, 26, 1, 'img/regular-glass.jpg', 120),
('Kính mờ 6mm', 9, 27, 4, 'img/frosted-glass.jpg', 90),
('Kính mờ 8mm', 9, 27, 5, 'img/frosted-glass.jpg', 70),
('Cưa tay 30cm', 10, 28, 1, 'img/hand-saw.jpg', 50),
('Cưa tay 40cm', 10, 28, 2, 'img/hand-saw.jpg', 40),
('Cưa máy 2000W', 10, 29, 3, 'img/chainsaw.jpg', 20),
('Cưa máy 1500W', 10, 29, 4, 'img/chainsaw.jpg', 15),
('Khoan tay 500W', 10, 30, 5, 'img/hand-drill.jpg', 30);
INSERT INTO `facilityconditions` (`FacilityID`, `NewQuantity`, `UsableQuantity`, `BrokenQuantity`) VALUES
(1, 40, 8, 2),  -- Búa đóng đinh 1kg: 50 tổng, 40 mới, 8 sử dụng được, 2 hỏng
(2, 25, 4, 1),  -- Búa đóng đinh 2kg: 30 tổng, 25 mới, 4 sử dụng được, 1 hỏng
(3, 30, 8, 2),  -- Búa gõ thép: 40 tổng, 30 mới, 8 sử dụng được, 2 hỏng
(4, 20, 4, 1),  -- Búa cao su nhỏ: 25 tổng, 20 mới, 4 sử dụng được, 1 hỏng
(5, 15, 4, 1),  -- Búa cao su lớn: 20 tổng, 15 mới, 4 sử dụng được, 1 hỏng
(6, 800, 150, 50),  -- Gạch đỏ 20x10: 1000 tổng, 800 mới, 150 sử dụng được, 50 hỏng
(7, 600, 150, 50),  -- Gạch đỏ 30x15: 800 tổng, 600 mới, 150 sử dụng được, 50 hỏng
(8, 500, 90, 10),   -- Gạch bê tông nhẹ: 600 tổng, 500 mới, 90 sử dụng được, 10 hỏng
(9, 400, 80, 20),   -- Gạch bê tông 40x20: 500 tổng, 400 mới, 80 sử dụng được, 20 hỏng
(10, 600, 80, 20);  -- Gạch men 30x30: 700 tổng, 600 mới, 80 sử dụng được, 20 hỏng