drop table if exists Books

create table Books (
Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre	varchar(50),
Published_Year int,
Price	numeric(10,2),
Stock int
);

select * from Books;

drop table if exists Customers;
CREate table Customers(
Customer_ID serial primary key,
Name varchar(100),	
Email	varchar(100),
Phone	varchar(15),
City	varchar(50),
Country varchar(150)
)
select * from Customers

drop table if exists orders;
create table orders(
Order_ID	serial primary key,
Customer_ID	int references Customers(Customer_ID),
Book_ID	int references Books(Book_ID),
Order_Date	DATE ,
Quantity	INT,
Total_Amount numeric(10,2)
);

select * from Books;
select * from Customers;
select * from orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from Books
where genre='Fiction';


-- 2) Find books published after the year 1950:
select* from Books
where published_year>1950;






-- 3) List all customers from the Canada:
select* from Customers
where country='Canada';


-- 4) Show orders placed in November 2023:
select * from orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';



-- 5) Retrieve the total stock of books available:
select * from Books;
SELECT SUM(stock) AS Total_Stock
From Books;


-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select name ,quantity
from customers as c
join 
orders as o
on c.customer_id=o.customer_id
where quantity >1;


-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders 
where total_amount >20;


-- 9) List all genres available in the Books table:
select distinct genre 
from Books;


-- 10) Find the book with the lowest stock:
select title,stock from Books
order by stock
limit 1;



-- 11) Calculate the total revenue generated from all orders:
select * from orders ;
select sum(total_amount)as total_revenue
from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select * from orders;
select * from Books;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b 
ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
select * from Books;
select avg(price)as average_price 
from Books
where genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;


-- 4) Find the most frequently ordered book:
select * from orders;
select * from Books;

select o.book_id,b.title,count(o.order_id)as frequently_ordered_book
from Books b
join orders o
on b.book_id= o.book_id
group by o.book_id,b.title
order by frequently_ordered_book desc
limit 1 ;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :


SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:
select b.author,sum(o.quantity)as total_quantity
from Books b
join
orders o
on b.book_id=o.book_id
group by b.author
order by total_quantity desc

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount)as amount_spent
from customers c
join orders o
on o.customer_id= c.customer_id
group by c.customer_id
order by amount_spent desc 
limit 1;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;



