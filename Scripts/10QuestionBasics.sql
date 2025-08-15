-- 🔹 Q1. Write a query to retrieve all active users from the table

select * from user where isactive=1;

-- 🔹 Q2. Find the total number of users grouped by gender.

select count(user_name) "Total Users", gender from user group by gender;

-- 🔹 Q3. Write a query to find users who registered in the last 7 days.

select user_name ,createdate from user where CreateDate <= NOW() - INTERVAL 7 DAY;

-- 🔹 Q4. List all users that have NULL in any of the optional columns (EmailID, Gender, or IsActive).

select User_name from user where (emailid || gender || isactive) is null;

-- 🔹 Q5. Update all inactive users (IsActive = 0) and set them to active (IsActive = 1).

update user set isactive=1 where isactive=0;

-- 🔹 Q6. Delete all users where EmailID is NULL.

delete from user where emailid is null;

-- 🔹 Q7. Add a new column LastLogin of type DATETIME to the user table.

alter table user add column LastLogin datetime ;

-- 🔹 Q8. Set a default password 'default123' for users whose password is NULL.

update user  set User_password="default123" where User_password is null;

-- 🔹 Q9. Retrieve the latest 5 users created in the system (by CreateDate).

select * from user order by CreateDate desc limit 5;

-- 🔹 Q10. Create a view named active_females that includes all active female users showing only id, User_Name, and EmailID.

create  view active_females as select id,user_name,emailid from user where isactive=1 and gender="female"; 

-- viewing result of view 
select * from active_females;




