# E-Commerce Database

## Overview
This SQL script sets up a relational database for an e-commerce platform. It includes tables for customers, suppliers, products, orders, and order details, along with queries to analyze sales, top-selling products, and inventory management.

## Database Schema
### Tables
1. **Customers** - Stores customer details.
2. **Suppliers** - Stores supplier details.
3. **Products** - Stores product information and references suppliers.
4. **Orders** - Stores customer orders and their statuses.
5. **OrderDetails** - Stores detailed order information, including quantity and price.

### Relationships
- **Products** references **Suppliers** (`SupplierID`).
- **Orders** references **Customers** (`CustomerID`).
- **OrderDetails** references **Orders** (`OrderID`) and **Products** (`ProductID`).

## Setup Instructions
1. **Create the Database and Tables**
   ```sql
   CREATE DATABASE ecommerce;
   USE ecommerce;
   ```
2. **Run the provided SQL script to create tables and insert sample data.**

## Queries Included
- **Total Sales per Customer**: Calculates total revenue per customer.
- **Top Selling Products**: Identifies the most sold products.
- **Sales Trend Over Time**: Analyzes daily revenue.
- **Average Order Value**: Computes the average value of orders.
- **Inventory Management**: Lists products with stock greater than 2.

## Example Usage
### Retrieving Total Sales per Customer
```sql
SELECT C.CustomerName, SUM(OD.Quantity * OD.Price) as TotalSales
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerName;
```

### Checking Inventory Levels
```sql
SELECT ProductName, Stock
FROM Products
WHERE Stock > 2;
```

## Contributions
Feel free to fork this repository, submit issues, or make pull requests.

## License
This project is licensed under the MIT License.

## Author
Developed by Harsh Arora


