CREATE TABLE Employee (
EmpID int NOT NULL,
EmpName Varchar(20),
Gender Char,
Salary int,
City Char (20));

-- first run the above code then below code
INSERT INTO Employee
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
 (2, 'Ekadanta', 'M', 125000, 'Bangalore'), 
 (3, 'Lalita', 'F', 150000, 'Mathura'), 
 (4, 'Madhav', 'M', 250000, 'Delhi'), 
 (5, 'Visakha', 'F', 120000, 'Mathura');