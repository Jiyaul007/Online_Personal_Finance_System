
💰 Personal Finance Management System

Java Swing + JDBC + MySQL | B.Tech (CSE) Project

The Personal Finance Management System is a modern desktop application built using Java Swing, MySQL, and JDBC.
It helps users efficiently track income, expenses, budgets, savings targets, and financial history, with clean charts and a smooth user interface.

This project is designed for academic submission and real-world usability, with a strong focus on UI, clean structure, and database reliability. 



🚀 Features
✅ User Authentication

Secure Login & Signup screens

User session management

MySQL-based credential storage

✅ Home Dashboard

Total balance overview

Recent transactions

Monthly financial summary

Savings progress bar for current month

✅ Manage Accounts

Add, edit, and manage multiple bank/wallet accounts within the application. 



✅ Track Income & Expenses

Separate tabs for income and expenses

Easy form-based entry

Integrated date picker using JCalendar

Categories & amount input

Stored permanently in MySQL

✅ Interactive Charts

Monthly Income vs Expense

Implemented using XChart

Auto-updated based on user inputs




✅ Financial History

Complete transaction history

Filter by date, category, or type

Clean table-based UI

🎯 Savings Target Progress

Set monthly savings goals

Progress bar UI

Automatic indicator of progress every month




🎨 Premium GUI Features

Neat layout using AbsoluteLayout

Modern, clean dashboard design

Professional icons & graphics

Well-structured page navigation

🛠 Tech Stack
Component	Technology
UI	Java Swing
Database	MySQL
Backend Connectivity	JDBC (MySQL Connector)
Charting	XChart
Date Picker	JCalendar
IDE Used	Apache NetBeans
Architecture	Modular Java + OOP



📁 Project Folder Structure
Personal-Finance-Management/
│
├── src/
│   ├── Chart/
│   │   └── IncomeExpenseChart.java
│   ├── Database/
│   │   ├── DatabaseManager.java
│   │   └── UserSession.java
│   ├── Home/
│   │   ├── HomePage.form
│   │   └── HomePage.java
│   ├── Icon/
│   │   └── icons.png...
│   ├── Login/
│   │   ├── Login.form
│   │   ├── Login.java
│   │   ├── SignUp.form
│   │   └── SignUp.java
│   └── personalfinancemanagement/
│       └── PersonalFinanceManagement.java
│
├── images/
│   └── (App screenshots)
│
└── database_setup/
    └── README + SQL schema




🗄 Database Schema (MySQL)

Your project uses multiple tables (users, accounts, income, expenses, budgets, etc.)

Example core table:

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    password VARCHAR(255)
);


Other tables include:

accounts

income

expenses

budget

transactions




⚙ Backend Status — Completed ✔

✔ User Login / Signup
✔ Home Dashboard
✔ Account Module
✔ Add Income
✔ Add Expense
✔ Budget Module
✔ Interactive Charts
✔ MySQL Connectivity
✔ Exception Handling
✔ Clean Modular Code
✔ UI Completed with forms + Java classes

Your app is fully functional and ready for practical demonstration and submission. 


▶ How to Run This Project
1. Install Requirements

Java JDK 17+

Apache NetBeans IDE

MySQL Server + MySQL Workbench

MySQL Connector/J (JAR included)

XChart, JCalendar (already in the project libs)

2. Import Project in NetBeans

Open NetBeans

Click File → Open Project

Select:

Personal_Finance_Management/

3. Set Up Database

Go to:

database_setup/


Run the SQL file using MySQL Workbench.
Update your MySQL username & password in DatabaseManager.java.




4. Run the Application

Open:

src/personalfinancemanagement/PersonalFinanceManagement.java


Press Shift + F6 → Run Project

📄 License

This project is created for academic purposes under Galgotias University / B.Tech CSE, and can be used, submitted, or extended for learning.

✨ Thank You for Checking Out the Project!
