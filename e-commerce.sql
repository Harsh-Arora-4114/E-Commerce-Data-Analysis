CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(50),
Email VARCHAR(50),
Country VARCHAR(50)
);

CREATE TABLE Suppliers(
SupplierID INT PRIMARY KEY,
SupplierName VARCHAR(50),
ContactName VARCHAR(50),
Country VARCHAR(50)
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
SupplierID INT,
Category VARCHAR(50),
Stock INT,
Price DECIMAL(10, 2),
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
Status VARCHAR(50),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE OrderDetails(
OrderDetailsID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
Price DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

INSERT INTO Customers(CustomerID, CustomerName, Email, Country)
VALUES
(1,"John Doe","john@example.com","USA"),
(2,"Jane Smith","jane@example.com","Canada");

INSERT INTO Suppliers(SupplierID, SupplierName, ContactName, Country)
VALUES
(1,"ABC Supplies","Alice Johnson","USA"),
(2,"XYZ Corp","Bob Brown","China");

INSERT INTO Products(ProductID, ProductName, SupplierID, Category, Stock, Price)
VALUES
(1,"Laptop",1 ,"Electronics",2,"1000.00"),
(2,"Smartphone",2 ,"Electronics",4,"500.00");

INSERT INTO Orders(OrderID, CustomerID, OrderDate, Status)
VALUES
(1, 1, "2023-06-01", "Shipped"),
(2, 2, "2023-06-05", "Pending");

INSERT INTO OrderDetails(OrderDetailsID, OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 1, 1000.00),
(2, 2, 2, 2, 500.00);

-- Total Sales per Customer
SELECT C.CustomerName, SUM(OD.Quantity * OD.Price) as TotalSales
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerName;

-- Top Selling Products
SELECT P.ProductName, SUM(OD.Quantity) AS TotalQuantitySold
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

-- Sales Trend Over Time
SELECT O.OrderDate, SUM(OD.Quantity * OD.Price) AS DailySales
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderDate
ORDER BY O.OrderDate;

-- Average Order value
SELECT AVG(TotalOrderValue) AS AverageOrderValue
FROM(
SELECT O.OrderID, SUM(OD.Quantity * OD.Price) AS TotalOrderValue
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID
)AS OrderValues;

-- Inventory Management (Products Below a Certain Stock Level)
SELECT ProductName, Stock
FROM Products
WHERE Stock > 2;

