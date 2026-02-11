--	*****SUBQUERIES*****
 
--	Basically, it is a query within a query
--	We often refer to the subquery
--	When should we use a subquery?
--	There will be times when you need some data prior to answering your question
--		I need to know A before I can answer your qestion B

--	List all of the staff who have a position of "Dean"
--	problem here is the staff has an attribute positionId
--	Dean is a position
--	What I dont know is what the positionId of Dean is
--	therefore, I need to know the positionId before I can tell you which staff are deans
 
SELECT FirstName, LastName
FROM Staff
WHERE PositionId = (SELECT PositionId
					FROM Position
					WHERE positionDescription = 'Dean');
 
--There will be times that you can use a join as well as a subquery

SELECT FirstName, LastName
FROM Staff s
	INNER JOIN Position p
		ON s.positionId = p.positionId
WHERE p.positionDescription = 'Dean';
 
-- if the query can be written as either a subquery or join, which is better?
-- usually it does not matter
 
-- subqueries can be used on Where and on Having
--	usally place on having if an aggregate is used
 
--	List all students with an average greater than the overall average
--	Display firstName, LastName, and Average
--	Do not include any courses that your withdrawn from.
 
--	data source: student, registration
--	fields: firstName, Lastname, average(mark)
--	filtering: withdrawyn = 'N'
--	Grouping : firstName, LastName
--  filter group: average > overall average
--  sorting: no
--  do i need information to solve the query (subquery) : Yes - overall average

-- IF the Having is not used, there appears to be a difference between using
--		using firstname, lastname (7 lines) and studentid (8 lines) on the GROUP BY

-- WHY!!!!!!!!

-- we have 2 students with the same firstname and lastname
-- solution: use a attribute which would uniquely separate the two students: studentid
-- could one include firstname and lastname also on the GROUP BY : Yes

SELECT s.FirstName, s.LastName, ROUND(AVG(r.Mark), 2)
FROM Student s INNER JOIN Registration r
		ON s.StudentId = r.StudentId
WHERE WithdrawYN = 'N'
GROUP BY s.studentid --s.FirstName, s.LastName
HAVING AVG(r.Mark) > (SELECT AVG(mark) 
						FROM Registration 
						WHERE withdrawyn = 'N');
 
--	List all students who have made 5 or more payments
--	Display Student id, FirstName, LastName, and number of payments
--	Order by most to least payment count
 
SELECT s.StudentId ,s.FirstName, s.LastName, COUNT(p.PaymentId) as "Number of Payments"
FROM Student S INNER JOIN Payment p
		ON s.StudentId = p.StudentId
GROUP BY s.studentid, s.FirstName, s.LastName
HAVING COUNT(p.PaymentId) >= 5
ORDER BY COUNT(p.PaymentId) desc

-- in this scenario, the subquery will be returning a list of studentids
-- your relative operators =,>,<,>=,<+ and != will not do the job
-- WHAT operator should be used??
-- there is an operator that will allow one to check to see if something is in a list
-- that operator is the: in
-- the list is not restricted to either numerics or alphanumeric

SELECT s.StudentId ,s.FirstName, s.LastName, COUNT(p.PaymentId) as "Number of Payments"
FROM Student S INNER JOIN Payment p
		ON s.StudentId = p.StudentId
GROUP BY s.studentid, s.FirstName, s.LastName
HAVING s.Studentid in (SELECT Studentid
						FROM payment
						GROUP BY studentid
						HAVING Count(Paymentid) >= 5)
ORDER BY COUNT(p.PaymentId) desc
 