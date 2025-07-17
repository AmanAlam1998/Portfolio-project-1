select* from Books;

select * from Customers;

select * from Orders;

--1)Retrieve all books from Fiction genre--

select * from books
where Genre='Fiction';

--2) Find books published after the year 1950--

select * from books where published_year>1950;

--3)list all the customers from the canada;

select * from Customers
where country='Canada';

--4)show orders placed in the November 2023--

select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--5) Retrieve the total stocks of book available--
select sum(Stock) from books;

--6) Find the details of the most expensive books--
select * from books order by price desc limit 1;

--7) show all customers that order more than 1 quantity of book--
select c.customer_id, c.nmae,c.email,c.phone,c.city,c.country,o.books_id,
       o.order_date,o.quantity,o.total_amount
from Customers c
left join
Orders o
on c.customer_id=o.customer_id
where quantity>1
order by quantity desc
limit 10;

--8) Retrieve all orders where the total amount exceeds 20 dollars
select * from orders
where total_amount>20;

--9)list all genres available in the book table--

select distinct (genre) from books;

--10) Find the books with lowest stock

select * from books
order by Stock asc limit 10;

--11) Calculate the total revenue generated from total orders--
select sum(total_amount) as total_revenue
from orders;

--Advance Queries
--1) Retrieve the total number of books sold for each Genre--

select b.genre,sum(o.quantity)
from books b
inner join
orders o
on b.books_id=o.books_id
group by b.genre;

--2)find the average price of the books in the fanatsy genre

select avg(price) as avg_price_fanatasy
from books
where genre='Fantasy';

--3) List customers who have placed atleast 2 orders--
select * from customers;
select * from orders;

select c.customer_id,c.nmae,c.email,c.phone,c.city,c.country,
       o.quantity
from customers c
left join
orders o
on c.customer_id=o.customer_id
where quantity>=2;

select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id)>=2;

select c.customer_id,c.nmae,c.email,c.phone,c.city,c.country, count(order_id) as order_count1
from customers c
left join
orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.nmae,c.email,c.phone,c.city,c.country
having count(order_id)>=2
order by count(order_id) asc;

--4)Find the most frequently order book

select * from orders;

select b.title,b.author,b.genre,count(o.books_id) as frequency_books
from books b
left join
orders o
on b.books_id=o.books_id
group by b.title,b.author,b.genre
order by frequency_books desc
limit 15;

--5) show the top 3 most expensive books of fantasy genre--

select * from books;

select * from books
where genre='Fantasy' order by price desc
limit 3;

--6) Retrieve the total quantity of books sold by each author--

select * from books;
select* from orders;

select b.author,b.genre,sum(o.quantity) as Total_quantity_books
from orders o
left join
books b
on b.books_id=o.books_id
group by b.author,b.genre
order by Total_quantity_books desc;

--7)list the cities where customers spent over 30 dollars exist

select * from customers;

select * from orders;

select distinct c.city,o.total_amount
from orders o
join
customers c
on o.customer_id=c.customer_id
where o.total_amount>30;
--order by total_amount asc;


--8) Find the customers who spent most on orders--

select c.nmae, sum(o.total_amount)as total_spent
from orders o
join
customers c
on o.customer_id=c.customer_id
group by c.nmae 
order by total_spent desc;

--9) calculate the stock remaining after fullfilling the orders

select * from books;
select * from orders;

select b.books_id,b.title, b.genre,b.stock,o.quantity,coalesce(sum(b.stock-o.quantity),0) as Stock_left
from orders o
join
books b
on o.books_id=b.books_id
group by b.books_id, b.title, b.genre,b.stock,o.quantity
order by books_id;

select books_id,Stock from books
where books_id=163;

select books_id, quantity from orders
where books_id = 163;


