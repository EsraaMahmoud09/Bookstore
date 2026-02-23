ALTER TABLE Books
ADD CONSTRAINT CHK_Books_Price CHECK (Price >0);

ALTER TABLE Books
ADD Genre VARCHAR(20);

UPDATE Books
SET Genre = 'Fiction'
WHERE Title = 'The Great Gatsby';

UPDATE Books
SET Genre = 'Mystery'
WHERE Title = 'To Kill a Mockingbird';

UPDATE Books
SET Genre = 'Non-Fiction'
WHERE Title = '1984';

SELECT Title,Author,Genre
FROM Books
WHERE Genre = 'Fiction';

SELECT Title,Author
FROM Books;

SELECT Last_Name
FROM Customers 
ORDER BY Last_Name;

SELECT *
FROM Books
WHERE Quantity_In_Stock < 10;

SELECT COUNT(*) AS Total_Books
FROM Books;


SELECT *
FROM Sales
WHERE Sale_Date = CAST(GETDATE() AS DATE); 

UPDATE Books
SET Quantity_In_Stock =7
WHERE Title ='1984';

INSERT INTO Books(Title, Author, ISBN, Price, Published_Year, Quantity_In_Stock)
VALUES ('Pride and Prejudice', 'Jane Austen', '9780141439518', 9.99,'1813-01-01',12);

SELECT 
    C.First_Name, 
    C.Last_Name, 
    B.Title AS Book_Title,
    SD.Quantity_Purchased,
    SD.Price_At_Sale
FROM Sale_Details SD
JOIN Sales S ON SD.Sale_ID = S.Sale_ID
JOIN Customers C ON S.Customer_ID = C.Customer_ID
JOIN Books B ON SD.Book_ID = B.Book_ID;

INSERT INTO Customers(First_Name, Last_Name, Email, Phone_Number)
VALUES ('Esraa','Mahmoud','esraamahmoud@email.com','555-0109')

DELETE FROM Customers 
WHERE NOT EXISTS ( SELECT *
                   FROM Sales S
				   WHERE S.Customer_ID = Customers.Customer_ID
					);  


SELECT 
    S.Sale_ID,
    SUM(SD.Quantity_Purchased * SD.Price_At_Sale) AS Total_Amount
FROM Sales S
JOIN Sale_Details SD ON S.Sale_ID = SD.Sale_ID
GROUP BY S.Sale_ID;


