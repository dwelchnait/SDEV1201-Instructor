/*
   Joins
   ....coming together...............
*/

-- report indicates the position but only by the positionid value
Select firstname, lastname, positionid
from staff;

--Problem, What is the position associate with the positionid
--that information can be found in the position table
--Solution: report from both tables
Select *
from staff, position
order by staffid;

--why do I get a separate report line for each position against a staff member
--		when the staff member only has one position

--sql will match each record in each table to each each in the other table

--Solution:
-- use the schema relationship
-- a relation between tables are set by the primary/foreign key pairing
--
-- match the position on the staff member to the associated position in the position table
-- this matching is called a JOIN

--the mission of a JOIN is to take data from two or more tables and create a single report
--  from table1 [inner  | left outer | right outer] join table2
--			ON table1.attribute = table2.attribute
--the listing of the tables do not matter of parent/child order
-- INNER is the default

--INNER join
--match the child record to ONLY the associated parent record
--use ONLY records that have an association
--	if a parent record has NO child record, the parent record
--		will not appear in the record
Select *
from staff join position
		on staff.positionid = position.positionid
order by staffid;

Select *
from position join staff
		on staff.positionid = position.positionid
order by staffid;

--common fields on the Select statement need to be qualified as to which
--		table to extract the data from IF the attribute is common to both tables
Select firstname, lastname, position.positionid, positiondescription
from position join staff
		on staff.positionid = position.positionid
order by staffid;

--instead of using the full table name, you can assign an alias to the table
--RULE: once you assign an alias to a table, you MUST use that alias anywhere
--			in your select, where the full table name would have been needed
Select firstname, lastname, staff.positionid, positiondescription
from position p join staff 
		on staff.positionid = p.positionid
order by staffid;

--List all students that have withdrawn from a course. Display
--	student full name and the course name they dropped.

-- data source(s):student, course, registration, offering
-- report fields: firstname, lastname, coursename
-- filtering? : withdrawyn = Y
-- grouping: no
-- filtering of group: no
-- ordering: no

select firstname || ' ' || lastname as "Name", coursename
from student s inner join registration r
					on s.studentid = r.studentid
				INNER join offering o
					on r.offeringcode = o.offeringcode
				INNER join course c
					on o.courseid = c.courseid
				
where withdrawyn = 'Y';

--List all positions and the number of staff in each position.
--Display position description and count of staff in the position

-- data source(s):position, staff
-- report fields: positiondescription, aggregate Count(*)
-- filtering? : no
-- grouping: positionid
-- filtering of group: no
-- ordering: no

select positiondescription, p.positionid, Count(*)
from position p join staff s
		on p.positionid = s.positionid
group by positiondescription, p.positionid;

select * from position;

--problem there is no staff that is in positionid 7
--there is no match between staff and position for positionid 7
--therefore an INNER would NOT use positionid 7

-- HOW to get the count for position 7 to show up
-- Use an OUTER join to obtain the require information
-- WHICH OUTER JOIN, RIGHT OR LEFT?
--Choosing RIGHT or LEFT is dependent on where the table
--	is specified in the join on the FROM clause
-- in our example: FROM position p JOIN staff s
-- the table where ALL records are required is on the LEFT
--		side of the JOIN
-- typically you will discover that the important and deciding
--		table is the parent table

select positiondescription, p.positionid, Count(*)
from position p LEFT OUTER JOIN staff s
		on p.positionid = s.positionid
group by positiondescription, p.positionid;

-- why does the position of the unused position have a count of 1
-- the outer join will produce a row
-- Count(*) counts rows
-- Solution: specific an attribute off the child table
--           Count(child attribute)
-- Count(attribute) does not count missing data

select positiondescription, p.positionid, Count(staffid)
from position p LEFT OUTER JOIN staff s
		on p.positionid = s.positionid
group by positiondescription, p.positionid;

select positiondescription, p.positionid, Count(staffid)
from staff s RIGHT OUTER JOIN position p
		on p.positionid = s.positionid
group by positiondescription, p.positionid;