-- Q1: Get all employees whose salary is between 200000 and 300000
select * from employee
where salary between 200000 AND 300000;

-- OR
select * from employee
where salary > 200000 And salary < 300000;


-- Q2: Find all employees who are from the same city as another employee
select e1.EmpName ,e1.City  
from employee e1 
join employee e2 
on e1.City = e2.City AND e1.EmpID != e2.EmpID;


-- Q3: Count the number of employees having NULL EmpID
select count(*) from employee
where EmpID is null;


-- Q4: Find cumulative sum of salary ordered by EmpID
select EmpName, salary,
       sum(Salary) over (order by EmpID) as "Cumulative Sum" 
from employee;


-- Q5: Find percentage of male and female employees
SELECT
    AVG(Gender = 'M') * 100 AS male_percentage,
    AVG(Gender = 'F') * 100 AS female_percentage
FROM employee;


-- Q6: Get first half of employees based on EmpID
select * from employee 
where EmpID <= (select count(*)/2 from employee);

-- OR using CTE with row_number
with cte as (
    select *, row_number() over(order by EmpID) As RowNO
    from employee
)
select * from cte 
where RowNO <= (select count(*)/2 from employee);


-- Q7: Mask salary by replacing last two digits with **
select salary, concat(left(salary, length(salary)-2),'**') as MaskedSalary
from employee;


-- Q8: Select employees having odd EmpID order using row_number
WITH RowCTE as (
    select *, row_number() over(order by EmpID) as RowNum 
    from employee
) 
select * from RowCTE 
where RowNum % 2 != 0;


-- Q9: Select employees having even EmpID order using row_number
WITH ROWCTE AS(
    SELECT *, row_number() OVER (ORDER BY EmpID) as RowNo 
    from employee
)
select * from ROWCTE 
where RowNo % 2 = 0;


-- Q10: Get employees whose names start with 'A'
select EmpID, EmpName 
from employee
where EmpName like 'A%'; 


-- Q11: Get employees whose names have 'A' as the second letter
select EmpID , EmpName 
from employee 
where EmpName like '_A%';


-- Q12: Get employees whose names contain 'Y' at second last position
select EmpID , EmpName 
from employee 
where EmpName like '%Y_';


-- Q13: Get employees whose names end with 'L' and have exactly 4 letters
select EmpID , EmpName 
from employee 
where EmpName like '____L';


-- Q14: Get employees whose names begin with 'V' and end with 'A'
select EmpID , EmpName 
from employee 
where EmpName like 'V%A'; 


-- Q15: Get distinct employee names starting with a vowel
select distinct EmpName 
from employee
where lower(EmpName) Rlike '^[aeiou]';


-- Q16: Get distinct employee names ending with a vowel
select distinct EmpName 
from employee 
where lower(EmpName) REGEXP '[aeiou]$';


-- Q17: Get distinct employee names starting and ending with a vowel
select distinct EmpName 
from employee 
where lower(EmpName) REGEXP '^[aeiou].*[aeiou]$';


-- Q18: Find duplicate employee records
select count(*) as Counts , EmpId, EmpName, salary, city, gender
from employee 
group by EmpId, EmpName, salary, city, gender
having Counts > 1;

-- OR (based only on EmpID)
select count(*) as counts , EmpID 
from employee 
group by EmpId
having counts > 1;


-- Q19: Delete duplicate employees based on EmpID
delete from employee 
where EmpID IN (
    select EmpID 
    from employee 
    group by EmpID  
    having COUNT(*) > 1
);


-- Q20: Find employees working on the same project
with cte as (
    select e1.EmpId ,e1.EmpName,e2.project 
    from employee e1 
    inner join employeedetail e2
    on e1.EmpID = e2.EmpID
)
select c1.EmpName , c2.EmpName , c1.project 
from cte c1 , cte c2 
where c1.project = c2.project 
  and c1.EmpID != c2.EmpID 
  and c1.EmpID < c2.EmpId;


-- Q21: Find maximum salary per project
select e2.project , max(e1.salary) as projectSalary 
from employee e1 
inner join employeedetail e2 
on e1.EmpID = e2.EmpID 
group by project
order by projectSalary desc;


-- Q22: Find total salary and employee count per project
select e2.project , sum(e1.salary) as TotalSal, count(*) as NoOfEmp  
from employee e1 
inner join employeedetail e2 
on e1.EmpID = e2.EmpID
group by Project
order by TotalSal desc;


-- Q23: Get number of employees joined each year
select year(doj) As Years, count(*) as COUNTS 
from employeedetail
group by Years
order by Years asc;


-- Q24: Categorize employees based on salary
select salary, EmpName,
    CASE 
        when salary > 200000 then 'High'
        when salary >= 100000 and salary <= 200000 then 'Medium'
        else 'Low'
    end as salaryStatus
from employee;


-- Q25: Show salary sum per city in separate columns
select EmpId, EmpName,
    sum(case when city like 'Pune' then salary end) as 'PUNE',
    sum(case when city like 'Mathura' then salary end) as 'Mathura',
    sum(case when city like 'Delhi' then salary end) as 'Delhi'
from employee
group by EmpID, EmpName;
