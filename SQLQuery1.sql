USE PageTurners_Bookstore;

INSERT INTO Books(Title, Author, ISBN, Price, Published_Year, Quantity_In_Stock)
VALUES
    ('The Great Gatsby','F. Scott Fitzgerald','9780743273565',12.99,'1925-01-01',15),
    ('To Kill a Mockingbird','Harper Lee','9780061120084',14.50,'1960-01-01',10),
    ('1984', 'George Orwell','9780451524935',10.99,'1949-01-01',8);

INSERT INTO Customers(First_Name, Last_Name, Email, Phone_Number)
VALUES
    ('John','Smith','john.smith@email.com','555-0101'),
    ('Sarah','Johnson','sarahJ@email.com','555-0102');

INSERT INTO Sales(Customer_ID, Sale_Date,Total_Amount)
VALUES
    (1, GETDATE(),25.98),
    (2, GETDATE(),14.50);

INSERT INTO Sale_Details (Sale_ID, Book_ID, Quantity_Purchased, Price_At_Sale)
VALUES
    (1,1,2,12.99),
    (2,2,1,14.50);
  


