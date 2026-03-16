Select * from mickeymousegrade order by 2;

-- delete from child tables before the parent table
delete from MickeyMouseGrade
Where courseid = 'COMP1017';

delete from MickeyMouseCourse
Where courseid = 'COMP1017';


-- insert into parent table before inserting into the child table

INSERT INTO MickeyMouseCourse (Courseid, CourseName, CourseHours, CourseCost)
VALUES ('COMP1017', 'Digital Design Tools I', 60, 450.00);

Insert Into MickeyMouseGrade (Studentid, Courseid, mark)
VALUES(5500055, 'COMP1017', 84);

--if you are reloading the data to the tables 
-- AND
-- do NOT wish to recreate the tables
-- THEN
-- use a series of DELETE commands (child then parent order)
--		without a Where clause

-- if you DROP a table, ALL data material associated with the table
--		is also removed from the database, THEREFORE no DELETE commands
--		would be necessary