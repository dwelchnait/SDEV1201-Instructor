-- double dash is a comment

--if you wish to physically remove a table from your database
--		you can use the DROP TABLE command
--the order in which you drop table is important
--you MUST drop tables starting with the "child" table then
--		work up your ERD structure to the "parent" table
--IF you DROP a table ALL associated meta data AND records
--		are removed from the database
DROP TABLE IF EXISTS MickeyMouseGrade;
DROP TABLE IF EXISTS MickeyMouseCourse;
DROP TABLE IF EXISTS MickeyMouseStudent;


--if you wish to physically add a table to your database
--		you can use the CREATE TABLE command
--the order in which you create tables is important
--you MUST create tables starting with the "parent" table then
--		work down your ERD structure to the "child" tables

--the constraint PRIMARY KEY is placed on the attribute that is
--		to uniquely identify a row on your table
--IF there is only one attribute for the PKEY then the constraint
--		may be placed directly on the attribute declaration
CREATE TABLE IF NOT EXISTS MickeyMouseStudent (
StudentID		integer		NOT NULL PRIMARY KEY,
FirstName		varchar(30)	NULL,
LastName		varchar(40) NULL,
Address			varchar(50) NULL,
Phone			varchar(10) NULL,
EnrollmentDate	date		NULL,
Gender			char(1)		NOT NULL
);

CREATE TABLE IF NOT EXISTS MickeyMouseCourse(
CourseID		char(8)			NOT NULL PRIMARY KEY,
CourseName		varchar(50)		NULL,
CourseHours		decimal(3,0)	NULL,
CourseCost		money			NULL
);

--IF you have a compound (composite) PKEY then the
--		primary key constraint is done as a table-level constraint

-- pkey  PK_tablename_attributenames
--    example PK_MickeyMouseGrade_StudentIDCourseID

--fkey will tie the parent and child table together
--IF you have a fkey on your table, then for a row
--		to exist on the child table, the assoicated parent record
--		MUST FIRST exist

-- fkey  FK_tablenames_attributename
--    example FK_MickeyMouseGradeMickeyMouseStudent_StudentID
CREATE TABLE IF NOT EXISTS MickeyMouseGrade(
StudentID		integer			NOT NULL,
CourseID		char(8)			NOT NULL,
Mark			decimal(5,2)	NULL,

CONSTRAINT PK_MickeyMouseGrade_StudentIDCourseID
		PRIMARY KEY (StudentID,CourseID),

CONSTRAINT FK_MickeyMouseGradeMickeyMouseStudent_StudentID
		FOREIGN KEY (StudentID)
		REFERENCES MickeyMouseStudent(StudentID),

CONSTRAINT FK_MickeyMouseGradeMickeyMouseCourse_CourseID
		FOREIGN KEY (CourseID)
		REFERENCES MickeyMouseCourse(CourseID)
);




