CREATE DATABASE IF NOT EXISTS `facilitiesmanagementdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `facilitiesmanagementdb`;

CREATE TABLE `categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(100) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `roles` (`RoleID`, `RoleName`) VALUES 
(1,'Quản lý kho'),
(2,'Nhân viên kho'),
(3,'Giám đốc công ty'),
(4,'Nhân viên công ty');

CREATE TABLE `suppliers` (
  `SupplierID` int NOT NULL AUTO_INCREMENT,
  `SupplierName` varchar(150) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNum` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `subcategories` (
  `SubcategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryID` int DEFAULT NULL,
  `SubcategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`SubcategoryID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `facilityconditions` (
  `FacilityID` int NOT NULL,
  `NewQuantity` int DEFAULT '0',
  `UsableQuantity` int DEFAULT '0',
  `BrokenQuantity` int DEFAULT '0',
  PRIMARY KEY (`FacilityID`),
  CONSTRAINT `facilityconditions_ibfk_1` FOREIGN KEY (`FacilityID`) REFERENCES `facilities` (`FacilityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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