--UNions

--Create a single list of staff and students. Display firstname and 
--	lastname, and indicate with the individaul is a student or staff.

Select FirstName, LastName, 'Student' Type
From Student

Union
Select FirstName, LastName, 'staffid' 
From Staff
ORDER BY LastName, FirstName;

--RULES
-- 1) each query MUST have the same number of columns
-- 2) the datatype of a column MUST be consistent through all unioned queries
--     the first query in the union dictates the datatype for the column
-- 3) column title comes from the first query
-- 4) ordering is done on the last query

