# Bookstore
Bookstore Sales Analysis  **Description:**   Designed and analyzed a relational database for a bookstore, integrating four main tables: Books, Customers, Sales, and Details.Performed complex SQL queries to extract actionable insights on sales trends, customer behavior, and inventory management. *Tools* SQL (MySQL)Data Modeling, ER Diagrams

#  PageTurners Bookstore – Database Project

A relational database system built with **Microsoft SQL Server** to manage a bookstore's books, customers, and sales transactions. This project demonstrates real-world database design and T-SQL skills including table creation, data insertion, constraints, joins, aggregations, and business logic queries.

---

##  Database Schema Overview

The database `PageTurners_Bookstore` contains **4 tables** that are all related to each other:

### 1.  `Books`
Stores all information about available books in the store.

| Column | Type | Description |
|--------|------|-------------|
| `Book_ID` | INT (PK, Identity) | Auto-generated unique ID for each book |
| `Title` | VARCHAR(50) | Book title – required |
| `Author` | VARCHAR(30) | Author name – required |
| `ISBN` | VARCHAR(30) | Unique book identifier – no duplicates allowed |
| `Price` | DECIMAL(10,2) | Book price – must be greater than 0 |
| `Published_Year` | DATE | Publication date |
| `Quantity_In_Stock` | INT | How many copies are currently in stock |
| `Genre` | VARCHAR(20) | Genre added later via ALTER TABLE (e.g. Fiction, Mystery) |

---

### 2.  `Customers`
Stores customer contact information and registration date.

| Column | Type | Description |
|--------|------|-------------|
| `Customer_ID` | INT (PK, Identity) | Auto-generated unique ID |
| `First_Name` | VARCHAR(30) | Customer first name – required |
| `Last_Name` | VARCHAR(30) | Customer last name – required |
| `Email` | VARCHAR(50) | Email address – unique per customer |
| `Phone_Number` | VARCHAR(30) | Phone number – required |
| `Registration_Date` | DATE | Auto-set to today's date when customer is added |

---

### 3.  `Sales`
Records each sales transaction, linked to a specific customer.

| Column | Type | Description |
|--------|------|-------------|
| `Sale_ID` | INT (PK, Identity) | Auto-generated unique sale ID |
| `Customer_ID` | INT (FK → Customers) | Which customer made the purchase |
| `Sale_Date` | DATE | Date of the sale |
| `Total_Amount` | DECIMAL(10,2) | Total value of the sale |

---

### 4.  `Sale_Details`
Stores the individual book line items within each sale (one row per book per sale).

| Column | Type | Description |
|--------|------|-------------|
| `Sale_Detail_ID` | INT (PK, Identity) | Auto-generated unique ID |
| `Sale_ID` | INT (FK → Sales) | Which sale this detail belongs to |
| `Book_ID` | INT (FK → Books) | Which book was purchased |
| `Quantity_Purchased` | INT | How many copies were bought |
| `Price_At_Sale` | DECIMAL(10,2) | Price of the book at the time of purchase |

---

## 🔗 Table Relationships

```
Customers ──────────< Sales >────────── Sale_Details >────────── Books
  (1 customer          (1 sale          (many books          (1 book per
  → many sales)        → many items)     per sale)            detail line)
```

- A **Customer** can have many **Sales**
- A **Sale** can have many **Sale_Details** (multiple books in one purchase)
- Each **Sale_Detail** links to one **Book**

### Entity Relationship Diagram

---

##  Project Files

```
 PageTurners_Bookstore
 ├── PageTurners_Bookstore_Create.sql   # Creates the database and all 4 tables
 ├── PageTurners_Bookstore_data.sql     # Inserts the sample data
 ├── PageTurners_Bookstore_Codes.sql    # All queries, updates, and operations
 ├── SQLQuery1.sql                      # Additional SQL queries – set 1
 ├── SQLQuery2.sql                      # Additional SQL queries – set 2
 ├── SQLQuery3.sql                      # Additional SQL queries – set 3
 ├── Churn.ipynb                        # Jupyter Notebook – data analysis
 ├── ERD diagram (database schema)
 └── Additional Table relationship
---

##  Setup Instructions

1. Open **SQL Server Management Studio (SSMS)**
2. Run `PageTurners_Bookstore_Create.sql` → creates the database + tables
3. Run `PageTurners_Bookstore_data.sql` → inserts sample books, customers, and sales
4. Run `PageTurners_Bookstore_Codes.sql` → runs all queries and operations

>  Make sure you are connected to a SQL Server instance before running the scripts.

---

##  What's Inside Each File

###  `PageTurners_Bookstore_Create.sql`
- Creates the `PageTurners_Bookstore` database
- Creates all 4 tables with:
  - **Primary Keys** on every table
  - **Foreign Keys** linking Sales → Customers, Sale_Details → Sales, Sale_Details → Books
  - **UNIQUE constraints** on `ISBN` (Books) and `Email` (Customers)
  - **DEFAULT value** on `Registration_Date` → automatically set to today using `GETDATE()`

---

###  `PageTurners_Bookstore_data.sql`
Inserts the initial sample data into the database:

**3 Books inserted:**
| Title | Author | Price | Stock |
|-------|--------|-------|-------|
| The Great Gatsby | F. Scott Fitzgerald | $12.99 | 15 |
| To Kill a Mockingbird | Harper Lee | $14.50 | 10 |
| 1984 | George Orwell | $10.99 | 8 |

**2 Customers inserted:**
| Name | Email |
|------|-------|
| John Smith | john.smith@email.com |
| Sarah Johnson | sarahJ@email.com |

**2 Sales inserted:**
| Sale | Customer | Total |
|------|----------|-------|
| Sale #1 | John Smith | $25.98 (2× Great Gatsby) |
| Sale #2 | Sarah Johnson | $14.50 (1× To Kill a Mockingbird) |

---

###  `PageTurners_Bookstore_Codes.sql`
This file contains all the SQL operations performed on the database, organized below:

---

####  DDL Operations (Modifying Structure)

| Operation | What it does |
|-----------|--------------|
| `ALTER TABLE Books ADD CONSTRAINT CHK_Books_Price` | Adds a CHECK constraint – price must always be > 0 |
| `ALTER TABLE Books ADD Genre VARCHAR(20)` | Adds a new Genre column to the Books table |

---

####  DML Operations (Modifying Data)

| Operation | What it does |
|-----------|--------------|
| `UPDATE Books SET Genre` | Sets the genre for each book (Fiction / Mystery / Non-Fiction) |
| `UPDATE Books SET Quantity_In_Stock = 7 WHERE Title = '1984'` | Updates the stock of 1984 to 7 copies |
| `INSERT INTO Books` | Adds a new book: *Pride and Prejudice* by Jane Austen |
| `INSERT INTO Customers` | Adds a new customer: Esraa Mahmoud |
| `DELETE FROM Customers WHERE NOT EXISTS (...)` | Deletes all customers who have never made a purchase |

---

####  SELECT Queries (Retrieving Data)

**1. Get all Fiction books**
```sql
SELECT Title, Author, Genre
FROM Books
WHERE Genre = 'Fiction';
```
> Returns: Title, Author, and Genre for all Fiction books

---

**2. List all books**
```sql
SELECT Title, Author
FROM Books;
```
> Returns: All books with their title and author

---

**3. List all customer last names alphabetically**
```sql
SELECT Last_Name
FROM Customers
ORDER BY Last_Name;
```
> Returns: Customer last names sorted A → Z

---

**4. Find books with low stock (less than 10 copies)**
```sql
SELECT *
FROM Books
WHERE Quantity_In_Stock < 10;
```
> Returns: Full details of books that are running low in stock

---

**5. Count total number of books in the store**
```sql
SELECT COUNT(*) AS Total_Books
FROM Books;
```
> Returns: A single number – how many book records exist in the database

---

**6. Get today's sales**
```sql
SELECT *
FROM Sales
WHERE Sale_Date = CAST(GETDATE() AS DATE);
```
> Returns: All sales that happened today

---

**7. Full purchase history (4-table JOIN)**
```sql
SELECT 
    C.First_Name, C.Last_Name,
    B.Title AS Book_Title,
    SD.Quantity_Purchased,
    SD.Price_At_Sale
FROM Sale_Details SD
JOIN Sales S ON SD.Sale_ID = S.Sale_ID
JOIN Customers C ON S.Customer_ID = C.Customer_ID
JOIN Books B ON SD.Book_ID = B.Book_ID;
```
> Returns: Customer name + book title + quantity + price for every purchase — joins all 4 tables together

---

**8. Total amount per sale**
```sql
SELECT 
    S.Sale_ID,
    SUM(SD.Quantity_Purchased * SD.Price_At_Sale) AS Total_Amount
FROM Sales S
JOIN Sale_Details SD ON S.Sale_ID = SD.Sale_ID
GROUP BY S.Sale_ID;
```
> Returns: Each Sale ID with its calculated total (quantity × price per book, summed up)

---

##  Technologies Used

- **Microsoft SQL Server**
- **T-SQL (Transact-SQL)**
- **SQL Server Management Studio (SSMS)**

---

##  Key SQL Concepts Covered

- `CREATE TABLE` with constraints (PK, FK, UNIQUE, CHECK, DEFAULT)
- `ALTER TABLE` to modify structure after creation
- `INSERT`, `UPDATE`, `DELETE` for data manipulation
- `SELECT` with `WHERE`, `ORDER BY`, `GROUP BY`
- `COUNT()` and `SUM()` aggregate functions
- `JOIN` across multiple tables (INNER JOIN × 3)
- `NOT EXISTS` subquery for conditional deletion
- `GETDATE()` and `CAST()` for date handling

---

