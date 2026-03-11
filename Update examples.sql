-- UPDATE command ----

select * 
from Course
where courseid = 'DMIT1001';

--if the where clause cannot find any record on your table
--	that matches the WHERE condition, the update will NOT
--	make any changes to the table AND does not abort

--the values on the SET can be any valid sql expression
--such a literal

update Course
SET maxstudents = 3
WHERE courseid = 'DMIT1001';

--such a calculation
--all calucations on the right side of all SET attributes
--		are done PRIOR to assigning the new value to the
--		left side attribute
select * 
from Course
where courseid = 'COMP1017';

update Course
SET CourseCost = CourseCost * 1.1
WHERE courseid = 'COMP1017';

--such as a subquery
select * 
from Course
where courseid in ('DMIT2590', 'DMIT2515');

Update Course
Set CourseCost = (Select CourseCost
					From Course
					Where CourseID = 'DMIT2590')
Where CourseID = 'DMIT2515';

-- multiple attributes on a table change be change together
select * 
from Course
where courseid = 'DMIT1001';

Update Course
Set CourseHours = 4,
	MaxStudents = 5,
	CourseCost= 300
Where CourseID = 'DMIT1001';

--using another table then the update table
--	within your DML command

--reminder
-- if your subquery returns a single value, use =
-- if your subquery returns a list (collection) of values, use in


select * from registration where studentid = 200495500; --1000, 80.0 N
Select * from student where studentid = 200495500; --Robert Smith
select * from 
update Registration
Set Mark = 0.0,
	withdrawyn = 'Y'
WHERE offeringcode = 1000
	and studentid = (Select StudentId
					 from Student
					 WHERE FirstName = 'Robert'
					 	and LastName = 'Smith');

--the FROM clause allows you to introduce an other table(s)
--		into your command to isolate the record(s) to update
--		on the table indicated in the Update clause
update Registration
Set Mark = 80.0,
	withdrawyn = 'N'
FROM Student
WHERE offeringcode = 1000
	and Registration.studentid = Student.StudentId
	and FirstName = 'Robert'
	and LastName = 'Smith';						 


