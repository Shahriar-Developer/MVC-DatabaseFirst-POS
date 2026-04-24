USE master
GO
CREATE DATABASE CafeShopManagementDB
GO

USE CafeShopManagementDB
GO

-- =========================
-- Product Category Table
-- =========================
CREATE TABLE ProductCategory (
    ProductCategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    CategoryDescription NVARCHAR(500) NULL
)
GO

-- =========================
-- Product Table
-- =========================
CREATE TABLE Product (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(200) NOT NULL,
    Unit NVARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    AvailableQuantity INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    ProductImage NVARCHAR(500) NULL,
    ProductCategoryId INT FOREIGN KEY REFERENCES ProductCategory(ProductCategoryId)
)
GO

-- =========================
-- Customer Table
-- =========================
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(200) NOT NULL,
    ContactNumber NVARCHAR(20) NOT NULL,
    ContactAddress NVARCHAR(500) NOT NULL
)
GO

-- =========================
-- Orders Table
-- =========================
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT FOREIGN KEY REFERENCES Customer(CustomerId),
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL
)
GO

-- =========================
-- Order Details Table
-- =========================
CREATE TABLE OrderDetails (
    OrderDetailsId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId) ON DELETE CASCADE,
    ProductCategoryId INT FOREIGN KEY REFERENCES ProductCategory(ProductCategoryId),
    ProductId INT FOREIGN KEY REFERENCES Product(ProductId),
    OrderQuantity INT NOT NULL,
    OrderUnit NVARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL
)
GO

-- =============================================
-- Insert Cafe Categories
-- =============================================
INSERT INTO ProductCategory (CategoryName, CategoryDescription) VALUES 
('Coffee', 'Hot and cold coffee items'),
('Tea', 'Different types of tea'),
('Snacks', 'Snacks and fast food items'),
('Bakery', 'Bakery and dessert items'),
('Beverages', 'Cold drinks and juices')
GO

-- =============================================
-- Insert Cafe Products
-- =============================================
INSERT INTO Product (ProductName, Unit, UnitPrice, AvailableQuantity, ProductImage, ProductCategoryId) VALUES 
-- Coffee
('Espresso', 'Cup', 150.00, 200, NULL, 1),
('Cappuccino', 'Cup', 200.00, 150, NULL, 1),
('Latte', 'Cup', 220.00, 150, NULL, 1),
('Cold Coffee', 'Glass', 250.00, 120, NULL, 1),

-- Tea
('Black Tea', 'Cup', 50.00, 300, NULL, 2),
('Milk Tea', 'Cup', 70.00, 300, NULL, 2),
('Green Tea', 'Cup', 80.00, 200, NULL, 2),

-- Snacks
('French Fries', 'Plate', 120.00, 100, NULL, 3),
('Chicken Burger', 'Pcs', 250.00, 80, NULL, 3),
('Sandwich', 'Pcs', 180.00, 90, NULL, 3),

-- Bakery
('Chocolate Cake', 'Slice', 150.00, 60, NULL, 4),
('Pastry', 'Pcs', 120.00, 70, NULL, 4),
('Donut', 'Pcs', 100.00, 80, NULL, 4),

-- Beverages
('Soft Drink', 'Bottle', 40.00, 300, NULL, 5),
('Lemon Juice', 'Glass', 60.00, 200, NULL, 5),
('Mineral Water', 'Bottle', 25.00, 500, NULL, 5)
GO

-- =============================================
-- Insert Customers
-- =============================================
INSERT INTO Customer (CustomerName, ContactNumber, ContactAddress) VALUES 
('Rahim Mia', '01811111111', 'Dhaka'),
('Karima Akter', '01822222222', 'Chattogram'),
('Hasan Ali', '01833333333', 'Sylhet')
GO

-- =============================================
-- Insert Orders & Order Details
-- =============================================
DECLARE @Cust1 INT = (SELECT CustomerId FROM Customer WHERE ContactNumber='01811111111')
DECLARE @Cust2 INT = (SELECT CustomerId FROM Customer WHERE ContactNumber='01822222222')

-- Order 1
INSERT INTO Orders (CustomerId, OrderDate, TotalAmount)
VALUES (@Cust1, GETDATE()-2, 470.00)
DECLARE @Order1 INT = SCOPE_IDENTITY()

INSERT INTO OrderDetails VALUES
(@Order1, 1, 1, 2, 'Cup', 150.00, 300.00),
(@Order1, 3, 9, 1, 'Pcs', 250.00, 250.00)

-- Order 2
INSERT INTO Orders (CustomerId, OrderDate, TotalAmount)
VALUES (@Cust2, GETDATE()-1, 320.00)
DECLARE @Order2 INT = SCOPE_IDENTITY()

INSERT INTO OrderDetails VALUES
(@Order2, 2, 6, 2, 'Cup', 70.00, 140.00),
(@Order2, 4, 11, 1, 'Slice', 150.00, 150.00)
GO

-- =============================================
-- View Data
-- =============================================
SELECT * FROM Customer
SELECT * FROM ProductCategory
SELECT * FROM Product
SELECT * FROM Orders
SELECT * FROM OrderDetails
