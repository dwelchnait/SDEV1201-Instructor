--use MickeyMouse
--Go

Delete From MickeyMouseGrade;
Delete From MickeyMouseCourse;
Delete From MickeyMouseStudent;
--Go


Insert Into MickeyMouseStudent
	(StudentID, FirstName, LastName, Address, Phone, EnrollmentDate, Gender)
Values
	(1234567, 'Mickey', 'Mouse', '1 Disneyland Street', '5551212', '18-Dec-1992', 'M'),
	(1234568, 'Minnie', 'Mouse', '1 Disneyland Street', '5551212', '01-Mar-1986', 'F'),
	(3114115, 'Daffy', 'Duck', '25 Disneyland Avenue', '5551234', '22-Oct-1967', 'M'),
	(5242424, 'Uncle', 'Scrooge', '500 Lootville Crescent', '6034444', '12-Jul-1947', 'M'),
	(8888888, 'Bugs', 'Bunny', '14 Hole Street', '1111111', '28-Feb-1972', 'M'),
	(7777777, 'Wylie', 'Coyote', 'RR2 Desert Drive', '9382763', '09-Jul-1994', 'M'),
	(5500055, 'Tinker', 'Bell', 'Neverland', '0000001', '31-May-1978', 'F'),
	(8800088, 'Peter', 'Pan', 'Neverland', '0000002', '17-Nov-1986', 'M');

Insert Into MickeyMouseCourse
	(CourseID, CourseName, CourseHours, CourseCost)
Values
	('DMIT1508', 'Database Fundamentals', 80, 375),
	('COMP1017', 'Web Design Fundamentals I', 96, 430),
	('CPSC1012', 'Programming Fundamentals', 160, 500),
	('DMIT2504', 'Android Development', 96, 430),
	('ORGB1500', 'Organizational Behaviour for Media and IT', 96, 430),
	('DMIT229' , 'Oracle', 96, 430),
	('DMIT2028', 'Systems Analysis and Design II', 80, 375),
	('DMIT2019', 'Intermediate Database Programming', 64, 315),
	('NULL0001', 'Test 1', null, 123),
	('NULL0002', 'Test 2', 55, null),
	('NULL0003', 'Test 3', 88, null);


Insert Into MickeyMouseGrade
	(StudentID, CourseID, Mark)
Values
	(1234567, 'DMIT1508', 74),
	(1234568, 'DMIT1508', 74),
	(3114115, 'ORGB1500', 33),
	(8888888, 'DMIT229',  96),
	(7777777, 'CPSC1012', 12),
	(5500055, 'DMIT2019', 84),
	(8800088, 'ORGB1500', 66),
	(1234567, 'CPSC1012', 54),
	(1234568, 'DMIT229',  88),
	(1234568, 'DMIT2028', 88),
	(5500055, 'COMP1017', 84),
	(8800088, 'DMIT2019', 49),
	(3114115, 'DMIT1508', 37),
	(8888888, 'DMIT1508', 73),
	(1234568, 'DMIT2019', 78),
	(7777777, 'DMIT1508', 29),
	(5500055, 'DMIT1508', 65),
	(8800088, 'DMIT1508',  9);
