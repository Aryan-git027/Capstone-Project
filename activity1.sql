CREATE TABLE IF NOT EXISTS Salesman(
  Salesman_id TEXT PRIMARY KEY,
  name TEXT,
  city TEXT,
  Comission TEXT
);
INSRET TWO Salesman(Salesman_id,name,city,Comission)
VALUES
  ("5001","James Hoog","New York", "0.15"),
  ("5002","Nail Knite","Paris","0.13"),
  ("5005","Pit Alex","London","0.11"),
  ("5006","Mc Lyon","Paris","0.14");

  CREATE TABLE IF NOT EXISTS Customer(
    customer_id TEXT,
    cust_name TEXT PRIMARY KEY,
    city TEXT,
    grade TEXT,
    Salesman_id TEXT
);
INSERT TWO Customer(customer_id, cust_name,city,grade,Salesman_id)
VALUES
  ("3002","nick rimando","new york","100","5001"),
  ("3007","brad davis","new york","200","5001"),
  ("3005","graham zusi","california","200","5002"),
  ("3008","julian green","london","300","5002");

  CREATE TABLE IF NOT EXISTS Orders(
    ord_no TEXT PRIMARY KEY,
    purch_amt TEXT,
    ord_date TEXT,
    customer_id TEXT,
    Salesman_id TEXT
);
INSERT INTO Orders(ord_no, purch_amt,ord_date,customer_id,Salesman_id)
VALUES
  ("70001","150.5","2012-10-5","3005","5002"),
  ("70009","270.65","2012-09-10","3001","5001"),
  ("70002","65.26","2012-12-05","3002","5003"),
  ("70004","110.5","2012-08-17","3009","5007");

-- Queries

-- Matching customers and salesman by city
SELECT customer.cust_name, salesman.name, salesman.city
FROM Customer
JOIN Salesman ON Customer.city = Salesman.city;

-- Linking customers to thier salesman
SELECT Customer.cust_name, Salesman.name
FROM Customer
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id;

-- Fetching orders where customer's city does not match salesman's city
SELECT Orders.ord_no, Customer.cust_name, Orders.customer_id, Orders.Salesman_id
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
WHERE Customer.city <> Salesman.city;

-- Fetching all orders with customer names
SELECT Orders.ord_no, Customer.cust_name
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id;

-- Customers with grades
SELECT Customer.cust_name AS "Customer","Customer.grade AS "Grade"
FROM Orders
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
JOIN Customer ON Orders.Customer_id = Customer.customer_id
WHERE Customer.grade IS NOT NULL;

-- Customers with salesman where comission is between 0.12 and 0.14
SELECT Customer.cust_name AS "Customer",
Customer.city AS "City",
Salesman.name AS "Salesman",
Salesman.comission
FROM Customer
JOIN Salesman ON Customer.salesman_id = Salesman.Salesman_id
WHERE Salesman.comission BETWEEN 0.12 AND 0.14;

-- Calculating comission for orders  where customer grade is 200 or more
SELECT Orders.ord_no, Customer.cust_name, Salesman.comission AS "Comission%",
Orders.purch_amt * Salesman.comission AS "Comission"
FROM Orders
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
JOIN Customer ON Orders.customer_id = Customer.customer_id
WHERE Customer.grade >= 200;