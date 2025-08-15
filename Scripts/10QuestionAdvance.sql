-- 🔹 Q11. Write a query to count how many users were created each day.

select CreateDate ,count(*) "User Count" from user group by CreateDate;

-- 🔹 Q12. Fetch the first user (by CreateDate) in the system.

select User_Name from user order by CreateDate asc limit 1;

-- 🔹 Q13. Write a query to get the number of active vs inactive users.

select isactive ,count(*) from user group by IsActive;

-- 🔹 Q14. Update all users with Gender as NULL and set it to 'OTHER'.

update user set gender="Other" where gender is null;

-- 🔹 Q15. Write a query to mask the User_password field with ***** when displaying users.

select id , user_name , emailid, "******" as user_password ,createdate from user ;

-- 🔹 Q16. Find users whose User_Name starts with a vowel (A, E, I, O, U — case-insensitive).

select user_name from user where user_name like  ("A%" or "E%" or "I%" or "O%" or "U%");

-- or 

select * from user where LOWER(left(user_name,1))in ('a','e','i','o','u');


-- 🔹 Q17. Add a UNIQUE constraint to the User_Name column (if not already there).

alter table user modify column user_name varchar(30) unique ;

-- 🔹 Q18. Write a query to find the top 3 most common Gender values (with count).

select gender ,count(gender) "Gender Count" from user group by gender limit 3;

-- 🔹 Q19. Add a column User_Age (INT) and then set random ages between 18–50 for all users.

alter table user add column User_Age int not null;

update user set User_Age= FLOOR(RAND() * (50 - 18 + 1) + 18);

-- OR 

UPDATE user SET User_Age = FLOOR(18 + (RAND() * 33));


-- 🔹 Q20. Create a trigger that automatically sets IsActive = 1 whenever a new user is inserted.


DELIMITER //
create trigger set_isactive_before_insert
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
   SET NEW.IsActive = 1;
END;
//

DELIMITER ;

