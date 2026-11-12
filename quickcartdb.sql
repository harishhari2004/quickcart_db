-- QUICKCART SQL CASE STUDY
-- Team: Team 
-- Members:Jibin,Hari
-- Database: MySQL

-- MISSION 1: DATA EXPLORATION

USE QuickCartDB;
select * from customers;
select * from products;
select * from products;
select count(*) AS total_customers from customers;
select count(*) AS total_products from products;
select count(*) AS total_orders from orders;
select distinct category from products;
select * from products where stock_quantity<10;
select * from orders where order_status ='cancelled';
select * from customers where city = 'Trivandrum';


-- MISSION 2: SALES ANALYSIS

select * from products where unit_price = (select MAX(unit_price) from products);
select * from products where unit_price = (select MIN(unit_price) from products);
select sum(quantity) AS total_quantity_sold from order_items;
select sum(quantity * selling_price) AS total_sales from order_items;
select avg(selling_price) AS average_selling_price from order_items; 
select order_status,count(*) AS total_orders from orders group by order_status;


-- MISSION 3: CUSTOMER ANALYSIS

select orders.order_id,customers.customer_name,orders.order_date,orders.order_status from orders 
inner join customers on orders.customer_id = customers.customer_id;

select customers.customer_name, count(orders.order_id) AS total_orders from customers 
left join orders on customers.customer_id = orders.customer_id group by customers.customer_name;

select customers.customer_name,sum(payments.amount) AS total_spent from customers  join orders ON customers.customer_id = orders.customer_id 
join payments  ON orders.order_id = payments.order_id
group by customers.customer_name;

select customers.customer_name,sum(payments.amount) AS total_spent from customers join orders
ON customers.customer_id = orders.customer_id join payments ON orders.order_id = payments.order_id
group by customers.customer_name order by total_spent DESC limit 1;

select * from customers
left join orders on customers.customer_id = orders.customer_id where orders.order_id is null;

select customers.customer_name,count(orders.order_id) AS total_orders from Customers join orders ON customers.customer_id = orders.customer_id
group by customers.customer_name having count(orders.order_id) >=2;

select AVG(amount) AS average_order_value from payments;

select city,count(*) AS customer_count from customers group by city
order by customer_count DESC LIMIT 1;

select * from customers where registration_date < '2025-04-01';

select customers.customer_name,count(orders.order_id) AS orders_count from customers  join orders ON customers.customer_id = orders.customer_id
group by customers.customer_name HAVING COUNT(orders.order_id) > 1;




-- MISSION 4: PAYMENT ANALYSIS

select orders.order_id,orders.order_status,payments.payment_status
from orders join payments ON orders.order_id = payments.order_id;

select * from payments where payment_status <> 'Paid';

select *from orders where order_status = 'Cancelled';

select payment_method,sum(amount) AS total_amount from payments group by payment_method;

select payment_status,count(*) AS total from payments group by payment_status;

select orders.order_id,orders.order_status,payments.payment_status from orders 
join payments ON orders.order_id = orders.order_id
where orders.order_status = 'Delivered' AND payments.payment_status <> 'Paid';

select payment_method,count(*) AS Usage_Count from payments
group by payment_method
order by usage_count DESC 
LIMIT 1;