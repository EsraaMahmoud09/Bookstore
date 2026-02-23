CREATE DATABASE PageTurners_Bookstore

USE PageTurners_Bookstore;

--Store information about books
CREATE TABLE Books(
Book_ID INT IDENTITY(1,1) NOT NULL,
Title VARCHAR(50) NOT NULL,
Author VARCHAR(30) NOT NULL,
ISBN VARCHAR(30) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Published_Year DATE NOT NULL,
Quantity_In_Stock INT NOT NULL,
CONSTRAINT PK_Books PRIMARY KEY(Book_ID),
CONSTRAINT UQ_Books UNIQUE (ISBN)
);

-- Customers
CREATE TABLE Customers(
Customer_ID INT IDENTITY(1,1) NOT NULL,
First_Name VARCHAR(30) NOT NULL,
Last_Name VARCHAR(30) NOT NULL,
Email VARCHAR(50),
Phone_Number VARCHAR(30) NOT NULL,
Registration_Date DATE DEFAULT GETDATE(),
CONSTRAINT PK_Customers PRIMARY KEY(Customer_ID),
CONSTRAINT UQ_Customers UNIQUE (Email)
);

-- Store sales transactions
CREATE TABLE Sales(
Sale_ID INT IDENTITY(1,1) NOT NULL,
Customer_ID INT NOT NULL,
Sale_Date DATE NOT NULL,
Total_Amount DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_Sales PRIMARY KEY(Sale_ID),
CONSTRAINT FK_Sales FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Store details of each sale
CREATE TABLE Sale_Details(
Sale_Detail_ID INT IDENTITY(1,1) NOT NULL,
Sale_ID INT NOT NULL,      
Book_ID INT NOT NULL,   
Quantity_Purchased INT NOT NULL,
Price_At_Sale DECIMAL(10,2) NULL,
CONSTRAINT PK_Sale_Details PRIMARY KEY(Sale_Detail_ID),
CONSTRAINT FK_Sale_Details_Sales FOREIGN KEY(Sale_ID) REFERENCES Sales(Sale_ID),
CONSTRAINT FK_Sale_Details_Books FOREIGN KEY(Book_ID) REFERENCES Books(Book_ID)
);

