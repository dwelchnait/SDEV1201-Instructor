CREATE TABLE IF NOT EXISTS MouseStudent (
StudentID		integer		NOT NULL,
FirstName		varchar(30)	NULL,
LastName		varchar(40) NULL,
Address			varchar(50) NULL,
Phone			varchar(10) NULL,
EnrollmentDate	date		NULL,
Gender			char(1)		NOT NULL
);

CREATE TABLE IF NOT EXISTS MouseCourse(
CourseID		char(8)			NOT NULL,
CourseName		varchar(50)		NULL,
CourseHours		decimal(3,0)	NULL,
CourseCost		money			NULL
);

CREATE TABLE IF NOT EXISTS MouseGrade(
StudentID		integer			NOT NULL,
CourseID		char(8)			NOT NULL,
Mark			decimal(5,2)	NULL
);




--DROP TABLE MouseStudent;
--DROP TABLE MouseCourse;
--DROP TABLE MouseGrade;