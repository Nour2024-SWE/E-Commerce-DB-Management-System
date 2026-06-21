# 🛒 E-Commerce Database Management System

[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://www.mysql.com/)
[![SQL](https://img.shields.io/badge/SQL-Database-orange.svg)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)


---

## 📖 Overview

This project simulates a real-world e-commerce platform database capable of managing:

* Customers
* Products
* Categories
* Orders
* Order Items
* Payments
* Audit Logs

The implementation follows relational database best practices, including primary keys, foreign keys, integrity constraints, indexing, reporting views, security privileges, and performance optimization.

---

## 🎯 Project Objectives

* Design a normalized e-commerce database.
* Enforce data integrity using constraints.
* Implement advanced SQL queries for business analytics.
* Create reusable reporting views.
* Develop triggers and user-defined functions.
* Improve query performance through indexing.
* Apply database security and access control mechanisms.
* Demonstrate backup and recovery procedures.

---

## ✨ Key Features

### 🗄️ Relational Database Design

* Normalized schema structure
* Primary and foreign key relationships
* Data validation using CHECK constraints
* Referential integrity enforcement

### 📦 E-Commerce Data Management

* Customer management
* Product catalog management
* Category organization
* Order processing
* Payment tracking
* Audit logging

### 📊 Business Intelligence Queries

* Revenue analysis
* Customer spending analysis
* Product performance analysis
* Customer segmentation
* Sales reporting

### 📈 Reporting Views

* Customer Spending Summary
* Monthly Revenue Report
* Active Customers Dashboard

### ⚡ Performance Optimization

* Single-column indexes
* Composite indexes
* Query optimization techniques

### 🔒 Security & Administration

* User privilege management
* Read-only reporting users
* Audit logging
* Backup and restore procedures

---

## 🏗️ Database Architecture

```text
Customers
    │
    ├──────── Orders
    │             │
    │             ├──────── Order_Items ─────── Products
    │             │                               │
    │             │                               │
    │             └──────── Payments             Categories
    │
    └──────── Audit_Log
```

---

## 📂 Database Schema

### Customers

Stores customer information including:

* Personal details
* Contact information
* Address information
* Registration date
* Account status

### Categories

Organizes products into logical groups.

Examples:

* Electronics
* Clothing
* Books
* Home & Garden
* Sports

### Products

Stores product catalog information:

* Product name
* Description
* Price
* Stock quantity
* Category assignment

### Orders

Tracks customer purchases:

* Order date
* Total amount
* Shipping information
* Order status

### Order_Items

Stores individual products purchased within each order:

* Product
* Quantity
* Unit price
* Discount

### Payments

Records transaction details:

* Payment method
* Transaction status
* Payment amount
* Transaction ID

### Audit_Log

Maintains audit records for system activity and data changes.

---

## 📊 Sample Data

The database includes realistic sample data for:

* 12 Customers
* 5 Product Categories
* Multiple Products
* Orders and Order Items
* Payment Transactions

This allows immediate testing and analysis without requiring additional setup.

---

## 🔍 SQL Operations Implemented

### Basic Queries

* Customer filtering
* Order retrieval
* Revenue calculation
* Customer classification

### Joins & Nested Queries

* Customer spending analysis
* Average order comparison
* Product utilization analysis
* Recent customer activity

### Advanced SQL Features

* CASE statements
* Aggregate functions
* Subqueries
* Window functions
* Ranking functions
* Analytical reporting

---

## 📈 Reporting Views

### Customer_Spending_Summary

Provides:

* Total spending
* Order count
* Average order value
* Spending classification
* Last purchase date

### Monthly_Revenue_Report

Provides:

* Monthly revenue
* Order volume
* Customer activity
* Product sales statistics

### Active_Customers

Tracks:

* Active customers
* Lifetime spending
* Recent activity
* Customer engagement metrics

---

## ⚙️ Triggers & Stored Functions

### Audit Trigger

Automatically records deleted orders into the audit log for tracking and compliance purposes.

### Discount Calculation Function

Implements dynamic discount calculation based on:

* Order discounts
* Customer purchase history
* Customer loyalty tier

Customer tiers include:

* Bronze
* Silver
* Gold
* Platinum

---

## 📊 Analytical Features

### Customer Segmentation

Customers are classified according to spending behavior:

* High Spender
* Medium Spender
* Low Spender
* No Purchase

### Customer Ranking

Window functions generate:

* Customer spending ranks
* Dense ranks
* Spending quartiles

### Revenue Analytics

Business reporting includes:

* Revenue trends
* Customer acquisition
* Product performance
* Sales activity

---

## ⚡ Performance Optimization

The project includes indexing strategies for:

* Customer searches
* Product lookups
* Order processing
* Payment tracking
* Reporting queries

### Implemented Index Types

* Single-column indexes
* Composite indexes
* Join optimization indexes

These significantly improve query execution performance on large datasets.

---

## 🔒 Security Features

### User Management

Creates dedicated reporting users with limited privileges.

### Access Control

Read-only permissions for reporting and analytics workloads.

### Audit Logging

Tracks access and modification events for accountability and monitoring.

---

## 💾 Backup & Recovery

The project demonstrates:

* Database backup using `mysqldump`
* Database restoration procedures
* Disaster recovery preparation

---

## 🛠️ Technologies Used

* MySQL
* SQL
* Relational Database Design
* Stored Procedures
* Triggers
* Views
* Window Functions
* Indexing Techniques
* Database Security

---

## 🎓 Learning Outcomes

This project demonstrates practical skills in:

✔ Database Design

✔ SQL Development

✔ Data Integrity Management

✔ Query Optimization

✔ Business Intelligence Reporting

✔ Security Administration

✔ Database Performance Tuning

✔ Backup and Recovery

---

## 🚀 Future Enhancements

Potential improvements include:

* Stored Procedures for Order Processing
* Inventory Management Automation
* Customer Loyalty Programs
* Real-Time Sales Dashboards
* Data Warehousing Integration
* Role-Based Access Control (RBAC)
* Advanced Analytics and Forecasting
* Database Replication and High Availability

---

## 📜 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

Developed as a comprehensive SQL and Database Systems project demonstrating enterprise-level relational database design, optimization, reporting, and administration techniques.
