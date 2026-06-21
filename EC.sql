-- ============================================================
-- Phase 2: Relational Schema & Constraints
-- ============================================================

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    zip_code VARCHAR(20),
    registration_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Suspended'))
);

-- Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    category_id INT,
    created_date DATE NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    shipping_address VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    discount DECIMAL(5, 2) DEFAULT 0.00 CHECK (discount >= 0 AND discount <= 100),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(30) NOT NULL CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    transaction_id VARCHAR(100) UNIQUE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Create Audit_Log table for triggers
CREATE TABLE Audit_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    action VARCHAR(20) NOT NULL,
    record_id INT NOT NULL,
    old_data TEXT,
    new_data TEXT,
    changed_by VARCHAR(100),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Phase 3: Data Insertion
-- ============================================================

-- Insert Categories
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Apparel and fashion items'),
('Books', 'Books and publications'),
('Home & Garden', 'Home improvement and garden supplies'),
('Sports', 'Sports equipment and accessories');

-- Insert Customers
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code, registration_date, status) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001', '2024-01-15', 'Active'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '456 Oak Ave', 'Los Angeles', 'CA', '90001', '2024-02-20', 'Active'),
('Michael', 'Brown', 'michael.b@email.com', '555-0103', '789 Pine Rd', 'Chicago', 'IL', '60601', '2024-03-10', 'Active'),
('Emily', 'Davis', 'emily.d@email.com', '555-0104', '321 Elm St', 'Houston', 'TX', '77001', '2024-04-05', 'Active'),
('James', 'Wilson', 'james.w@email.com', '555-0105', '654 Maple Dr', 'Phoenix', 'AZ', '85001', '2024-05-12', 'Active'),
('Jessica', 'Martinez', 'jessica.m@email.com', '555-0106', '987 Cedar Ln', 'Philadelphia', 'PA', '19101', '2024-06-18', 'Active'),
('Robert', 'Taylor', 'robert.t@email.com', '555-0107', '147 Birch Blvd', 'San Antonio', 'TX', '78201', '2024-07-22', 'Active'),
('Jennifer', 'Anderson', 'jennifer.a@email.com', '555-0108', '258 Spruce Way', 'San Diego', 'CA', '92101', '2024-08-30', 'Inactive'),
('William', 'Thomas', 'william.t@email.com', '555-0109', '369 Willow Ct', 'Dallas', 'TX', '75201', '2024-09-14', 'Active'),
('Amanda', 'Garcia', 'amanda.g@email.com', '555-0110', '741 Ash St', 'San Jose', 'CA', '95101', '2024-10-01', 'Suspended'),
('Daniel', 'Miller', 'daniel.m@email.com', '555-0111', '852 Poplar Ave', 'Austin', 'TX', '78701', '2024-11-05', 'Active'),
('Lisa', 'Rodriguez', 'lisa.r@email.com', '555-0112', '963 Sycamore Rd', 'Jacksonville', 'FL', '32201', '2024-12-01', 'Active');

-- Insert Products
INSERT INTO Products (product_name, description, price, stock_quantity, category_id, created_date) VALUES
('Smartphone X', 'Latest 5G smartphone with 256GB storage', 999.99, 50, 1, '2024-01-01'),
('Laptop Pro', '14-inch laptop with M3 processor', 1299.99, 30, 1, '2024-01-15'),
('Wireless Headphones', 'Noise-cancelling Bluetooth headphones', 199.99, 100, 1, '2024-02-01'),
('Cotton T-Shirt', 'Premium cotton t-shirt, pack of 3', 29.99, 200, 2, '2024-02-15'),
('Jeans', 'Classic straight-fit denim jeans', 59.99, 150, 2, '2024-03-01'),
('Fiction Novel', 'Bestselling science fiction book', 19.99, 75, 3, '2024-03-15'),
('Cookbook', 'Healthy recipes cookbook', 34.99, 60, 3, '2024-04-01'),
('Garden Tools Set', 'Complete 10-piece garden tool set', 89.99, 40, 4, '2024-04-15'),
('Plant Pot', 'Decorative ceramic plant pot', 24.99, 120, 4, '2024-05-01'),
('Basketball', 'Official size basketball', 49.99, 80, 5, '2024-05-15'),
('Yoga Mat', 'Eco-friendly non-slip yoga mat', 39.99, 90, 5, '2024-06-01'),
('Smart Watch', 'Fitness tracker with heart rate monitor', 299.99, 45, 1, '2024-06-15');

-- Insert Orders
INSERT INTO Orders (customer_id, order_date, total_amount, status, shipping_address) VALUES
(1, '2024-06-01 10:30:00', 1199.98, 'Delivered', '123 Main St, New York, NY 10001'),
(1, '2024-07-15 14:20:00', 199.99, 'Delivered', '123 Main St, New York, NY 10001'),
(2, '2024-08-10 09:15:00', 59.99, 'Shipped', '456 Oak Ave, Los Angeles, CA 90001'),
(3, '2024-09-05 16:45:00', 29.99, 'Processing', '789 Pine Rd, Chicago, IL 60601'),
(4, '2024-09-20 11:00:00', 999.99, 'Delivered', '321 Elm St, Houston, TX 77001'),
(5, '2024-10-01 13:30:00', 34.99, 'Delivered', '654 Maple Dr, Phoenix, AZ 85001'),
(6, '2024-10-15 08:45:00', 1299.99, 'Delivered', '987 Cedar Ln, Philadelphia, PA 19101'),
(7, '2024-11-01 12:00:00', 149.99, 'Shipped', '147 Birch Blvd, San Antonio, TX 78201'),
(8, '2024-11-15 10:00:00', 19.99, 'Delivered', '258 Spruce Way, San Diego, CA 92101'),
(9, '2024-12-01 15:30:00', 89.99, 'Pending', '369 Willow Ct, Dallas, TX 75201'),
(10, '2024-12-10 09:00:00', 299.99, 'Cancelled', '741 Ash St, San Jose, CA 95101'),
(11, '2024-12-15 11:45:00', 49.99, 'Delivered', '852 Poplar Ave, Austin, TX 78701'),
(12, '2024-12-20 14:15:00', 39.99, 'Delivered', '963 Sycamore Rd, Jacksonville, FL 32201');

-- Insert Order_Items
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price, discount) VALUES
(1, 1, 1, 999.99, 0.00),
(1, 3, 1, 199.99, 0.00),
(2, 3, 1, 199.99, 0.00),
(3, 5, 1, 59.99, 0.00),
(4, 4, 1, 29.99, 0.00),
(5, 1, 1, 999.99, 0.00),
(6, 7, 1, 34.99, 0.00),
(7, 2, 1, 1299.99, 0.00),
(8, 9, 1, 24.99, 0.00),
(8, 8, 1, 89.99, 0.00),
(8, 4, 1, 29.99, 0.00),
(9, 6, 1, 19.99, 0.00),
(10, 8, 1, 89.99, 0.00),
(11, 12, 1, 299.99, 0.00),
(12, 10, 1, 49.99, 0.00),
(13, 11, 1, 39.99, 0.00);

-- Insert Payments
INSERT INTO Payments (order_id, payment_date, amount, payment_method, status, transaction_id) VALUES
(1, '2024-06-01 10:35:00', 1199.98, 'Credit Card', 'Completed', 'TXN001'),
(1, '2024-07-15 14:25:00', 199.99, 'PayPal', 'Completed', 'TXN002'),
(2, '2024-08-10 09:20:00', 59.99, 'Debit Card', 'Completed', 'TXN003'),
(3, '2024-09-05 16:50:00', 29.99, 'Credit Card', 'Pending', 'TXN004'),
(4, '2024-09-20 11:05:00', 999.99, 'Bank Transfer', 'Completed', 'TXN005'),
(5, '2024-10-01 13:35:00', 34.99, 'Credit Card', 'Completed', 'TXN006'),
(6, '2024-10-15 08:50:00', 1299.99, 'PayPal', 'Completed', 'TXN007'),
(7, '2024-11-01 12:05:00', 149.99, 'Debit Card', 'Pending', 'TXN008'),
(8, '2024-11-15 10:05:00', 19.99, 'Credit Card', 'Completed', 'TXN009'),
(9, '2024-12-01 15:35:00', 89.99, 'Bank Transfer', 'Pending', 'TXN010'),
(10, '2024-12-10 09:05:00', 299.99, 'Credit Card', 'Failed', 'TXN011');

-- ============================================================
-- Phase 4: Basic & Intermediate SQL Queries
-- ============================================================

-- 1. List all customers from a specific city
SELECT * FROM Customers 
WHERE city = 'New York';

-- 2. Display all orders sorted by date
SELECT * FROM Orders 
ORDER BY order_date DESC;

-- 3. Find the total number of orders per customer
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY order_count DESC;

-- 4. Calculate the total revenue generated
SELECT SUM(total_amount) AS total_revenue 
FROM Orders 
WHERE status != 'Cancelled';

-- 5. Categorize customers into spending groups using CASE
SELECT c.customer_id, c.first_name, c.last_name, 
       COALESCE(SUM(o.total_amount), 0) AS total_spent,
       CASE 
           WHEN COALESCE(SUM(o.total_amount), 0) >= 1000 THEN 'High Spender'
           WHEN COALESCE(SUM(o.total_amount), 0) >= 500 THEN 'Medium Spender'
           WHEN COALESCE(SUM(o.total_amount), 0) > 0 THEN 'Low Spender'
           ELSE 'No Purchase'
       END AS spending_group
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- ============================================================
-- Phase 5: Joins & Nested Queries
-- ============================================================

-- 1. Retrieve customer names with their total spending
SELECT c.customer_id, c.first_name, c.last_name, 
       COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) AS total_spending
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC;

-- 2. Identify customers who placed more orders than the average
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count) 
    FROM (
        SELECT COUNT(order_id) AS order_count
        FROM Orders
        GROUP BY customer_id
    ) AS avg_orders
)
ORDER BY order_count DESC;

-- 3. Display products that have never been ordered
SELECT p.product_id, p.product_name, p.price
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- 4. List customers who placed orders in the last 6 months
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, c.email
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
ORDER BY c.customer_id;

-- ============================================================
-- Phase 6: Views for Reporting
-- ============================================================

-- 1. Customer spending summary view
CREATE OR REPLACE VIEW Customer_Spending_Summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) AS total_spending,
    COALESCE(AVG(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) AS avg_order_value,
    DATE_FORMAT(MAX(o.order_date), '%Y-%m-%d') AS last_order_date,
    CASE 
        WHEN COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) >= 1000 THEN 'High'
        WHEN COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) >= 500 THEN 'Medium'
        WHEN COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) > 0 THEN 'Low'
        ELSE 'No Purchase'
    END AS spending_level
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city;

-- 2. Monthly revenue report view
CREATE OR REPLACE VIEW Monthly_Revenue_Report AS
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month_number,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    COALESCE(SUM(o.total_amount), 0) AS total_revenue,
    COALESCE(AVG(o.total_amount), 0) AS avg_order_value,
    COALESCE(SUM(oi.quantity), 0) AS total_items_sold,
    COUNT(DISTINCT p.product_id) AS unique_products_sold
FROM Orders o
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id
WHERE o.status != 'Cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m'), YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year DESC, month_number DESC;

-- 3. Active customers view
CREATE OR REPLACE VIEW Active_Customers AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.phone,
    c.city,
    c.state,
    c.registration_date,
    DATEDIFF(CURRENT_DATE, c.registration_date) AS days_since_registration,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) AS lifetime_spent,
    MAX(o.order_date) AS last_order_date,
    DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE c.status = 'Active'
  AND o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.phone, 
         c.city, c.state, c.registration_date
HAVING COUNT(DISTINCT o.order_id) >= 1
ORDER BY lifetime_spent DESC;

-- ============================================================
-- Phase 7: Triggers, UDFs & Performance
-- ============================================================

-- 1. Trigger that logs deleted orders into audit table
DELIMITER //
CREATE TRIGGER before_order_delete
BEFORE DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, record_id, old_data, change_date)
    VALUES (
        'Orders', 
        'DELETE', 
        OLD.order_id, 
        CONCAT('order_id:', OLD.order_id, 
               ', customer_id:', OLD.customer_id, 
               ', order_date:', OLD.order_date, 
               ', total_amount:', OLD.total_amount, 
               ', status:', OLD.status),
        NOW()
    );
END//
DELIMITER ;

-- 2. User-defined function that calculates order discounts
DELIMITER //
CREATE FUNCTION calculate_order_discount(
    p_order_id INT,
    p_customer_id INT
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_discount DECIMAL(10, 2);
    DECLARE total_orders INT;
    DECLARE lifetime_spending DECIMAL(10, 2);
    DECLARE customer_tier VARCHAR(20);
    DECLARE base_discount DECIMAL(5, 2);
    
    -- Get total discount from order items
    SELECT COALESCE(SUM(oi.quantity * oi.unit_price * (oi.discount/100)), 0)
    INTO total_discount
    FROM Order_Items oi
    WHERE oi.order_id = p_order_id;
    
    -- Get customer order count and lifetime spending
    SELECT COUNT(*), COALESCE(SUM(total_amount), 0)
    INTO total_orders, lifetime_spending
    FROM Orders
    WHERE customer_id = p_customer_id AND status != 'Cancelled';
    
    -- Determine customer tier
    IF lifetime_spending >= 5000 THEN
        SET customer_tier = 'Platinum';
        SET base_discount = 15.00;
    ELSEIF lifetime_spending >= 2000 THEN
        SET customer_tier = 'Gold';
        SET base_discount = 10.00;
    ELSEIF lifetime_spending >= 500 THEN
        SET customer_tier = 'Silver';
        SET base_discount = 5.00;
    ELSE
        SET customer_tier = 'Bronze';
        SET base_discount = 0.00;
    END IF;
    
    -- Return total discount including customer tier
    RETURN total_discount + base_discount;
END//
DELIMITER ;

-- 3. Window function to rank customers by spending
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) AS total_spending,
    RANK() OVER (ORDER BY COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) DESC) AS spending_rank,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) DESC) AS spending_dense_rank,
    NTILE(4) OVER (ORDER BY COALESCE(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 0) DESC) AS spending_quartile
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_spending DESC;

-- 4. Indexes to improve query performance
-- Index for frequently queried columns
CREATE INDEX idx_customers_city ON Customers(city);
CREATE INDEX idx_customers_status ON Customers(status);
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_orders_order_date ON Orders(order_date);
CREATE INDEX idx_orders_status ON Orders(status);
CREATE INDEX idx_order_items_order_id ON Order_Items(order_id);
CREATE INDEX idx_order_items_product_id ON Order_Items(product_id);
CREATE INDEX idx_products_category_id ON Products(category_id);
CREATE INDEX idx_products_price ON Products(price);
CREATE INDEX idx_payments_order_id ON Payments(order_id);
CREATE INDEX idx_payments_status ON Payments(status);

-- Composite index for common query patterns
CREATE INDEX idx_orders_customer_date ON Orders(customer_id, order_date);
CREATE INDEX idx_order_items_order_product ON Order_Items(order_id, product_id);

-- ============================================================
-- Phase 9: Security & Administration
-- ============================================================

-- 1. Create a database user with limited privileges
CREATE USER IF NOT EXISTS 'reporting_user'@'localhost' 
IDENTIFIED BY 'SecurePassword123!';

-- 2. Grant read-only access to specific tables
GRANT SELECT ON ecommerce.Customers TO 'reporting_user'@'localhost';
GRANT SELECT ON ecommerce.Products TO 'reporting_user'@'localhost';
GRANT SELECT ON ecommerce.Orders TO 'reporting_user'@'localhost';
GRANT SELECT ON ecommerce.Order_Items TO 'reporting_user'@'localhost';
GRANT SELECT ON ecommerce.Payments TO 'reporting_user'@'localhost';
GRANT SELECT ON ecommerce.Categories TO 'reporting_user'@'localhost';

-- 3. Perform a full database backup
-- mysqldump -u root -p ecommerce > ecommerce_backup_20250115.sql

-- 4. Restore the backup into a new database
-- CREATE DATABASE ecommerce_restored;
-- mysql -u root -p ecommerce_restored < ecommerce_backup_20250115.sql

-- 5. Implement basic audit logging or access control
CREATE TABLE Access_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    action VARCHAR(50),
    table_name VARCHAR(50),
    access_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45)
);

-- Example of audit logging procedure
DELIMITER //
CREATE PROCEDURE log_access(
    p_username VARCHAR(50),
    p_action VARCHAR(50),
    p_table_name VARCHAR(50),
    p_ip_address VARCHAR(45)
)
BEGIN
    INSERT INTO Access_Log (username, action, table_name, ip_address)
    VALUES (p_username, p_action, p_table_name, p_ip_address);
END//
DELIMITER ;

-- Grant execution privilege
GRANT EXECUTE ON PROCEDURE log_access TO 'reporting_user'@'localhost';

-- Show user privileges
SHOW GRANTS FOR 'reporting_user'@'localhost';

-- ============================================================
-- Performance Explanation
-- ============================================================
/*
Performance Impact of Indexes:

1. idx_customers_city - Speeds up queries filtering customers by city
2. idx_orders_order_date - Improves date range queries and sorting
3. idx_order_items_order_id - Accelerates joins with Order_Items table
4. idx_products_category_id - Optimizes category-based product queries
5. Composite indexes - Enhance queries with multiple conditions

Note: While indexes improve SELECT performance, they add overhead to 
INSERT, UPDATE, and DELETE operations. Monitor usage and adjust as needed.
*/