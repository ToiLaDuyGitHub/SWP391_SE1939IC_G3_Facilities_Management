-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS FacilitiesManagementDB;
USE FacilitiesManagementDB;

-- Bảng Roles
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(100) NOT NULL
);

-- Bảng Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    RoleID INT,
    PhoneNum VARCHAR(20),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Bảng Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL
);

-- Bảng Subcategories
CREATE TABLE Subcategories (
    SubcategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryID INT,
    SubcategoryName VARCHAR(100) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Bảng Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(150) NOT NULL,
    Address VARCHAR(255),
    PhoneNum VARCHAR(20)
);

-- Bảng Facilities
CREATE TABLE Facilities (
    FacilityID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityName VARCHAR(150) NOT NULL,
    CategoryID INT,
    SubcategoryID INT,
    SupplierID INT,
    Image VARCHAR(255),
    Quantity INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SubcategoryID) REFERENCES Subcategories(SubcategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Bảng FacilityConditions
CREATE TABLE FacilityConditions (
    FacilityID INT PRIMARY KEY,
    NewQuantity INT DEFAULT 0,
    UsableQuantity INT DEFAULT 0,
    BrokenQuantity INT DEFAULT 0,
    FOREIGN KEY (FacilityID) REFERENCES Facilities(FacilityID)
);

-- Bảng Records
CREATE TABLE Records (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityID INT,
    Quantity INT NOT NULL,
    Type BIT NOT NULL, -- 0: Xuất, 1: Nhập
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Note TEXT,
    FOREIGN KEY (FacilityID) REFERENCES Facilities(FacilityID)
);
