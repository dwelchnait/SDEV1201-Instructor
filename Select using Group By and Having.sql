--Grouping
--The GROUP BY clause is used in conjunction with aggregate functions to
--provide subtotal calculations of the aggregate function. We could easily
--return the average Mark from the grade table. What if we wanted the
--average Mark for each Course? For each student? For each course for each
--student? To do this we would use GROUP BY

--How many staff in each position?
--the report return simply has a list of the count AND no information
--	on which position the count is for. NOTE: the positionid is NOT
--	in the selected list of attributes

SELECT count(*) AS "Staff Count By Postion"
FROM Staff
GROUP BY positionid;

--what if you wish to not the relationship between the count and the position

SELECT positionid, count(*) AS "Staff Count By Postion"
FROM Staff
GROUP BY positionid
-- ORDER BY positionid;
-- ORDER BY count(*); 
ORDER BY 2 desc; --descending sort

--what is the average mark for each student
SELECT AVG(mark) AS "Avg Mark By Student"
FROM Registration
GROUP BY studentid;

--what is the average mark for each student
--NOTE: if you have a non-aggregate attribute on your select when
--		you are using an aggregate function, you MUST use a GROUP BY
--		AND list ALL non-aggregate attributes on the GROUP BY

--following produces an error
SELECT studentid, AVG(mark) AS "Avg Mark By Student"
FROM Registration;

--following solves the error
SELECT studentid, AVG(mark) AS "Avg Mark By Student"
FROM Registration
GROUP BY studentid;

-- Having 
-- Having is the filter for your groups
-- IF you wish to filter on an aggregate of a group
-- you MUST use the Having clause
-- Placing an aggregate on the WHERE clause will cause your query to abort
--		Aggregrates are NOT allowed on the Where clause

--List all student who are A grade students. "A" grade students have an average of
--	at least 80%. Order by highest average.
-- inputs:
--		table(s): Registration
--      inputs: studentid, mark
--      output: studentid, average mark
--     contraints: grade A students (avg >= 80)
--     display concerns: descending average

SELECT studentid, Avg(mark) AS "Student Average"
FROM Registration
GROUP BY studentid
Having Avg(mark) >= 80
ORDER BY Avg(mark) desc;
-- ORDER BY "Student Average" desc;
-- ORDER BY 2 desc;