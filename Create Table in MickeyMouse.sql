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

-- Primary Key index will have a developer specified constraint name (preferred)

-- setting up constraints can be done 
--    	a) on the attribute declaration
--      b) at the end of the table

--syntax CONSTRAINT name type need contraint declaration
--  name: DF_tablename_attributename DEFAULT value
--        UQ_tablename_attributename UNIQUE
--        CK_tablename_attributename CHECK (conditon)

CREATE TABLE IF NOT EXISTS MickeyMouseStudent (
StudentID		integer		NOT NULL 
	CONSTRAINT PK_MickeyMouseStudent_StudentID PRIMARY KEY,
FirstName		varchar(30)	NULL,
LastName		varchar(40) NULL,
Address			varchar(50) NULL,
-- in the following check we are testing a pattern (usually referred to as a Regex- regular expression)
--		and basicly means: "I want a literal [ in the string"; without the backslash SQL treats the
--		[ as something special
-- NOTE the operator is the ~ symbol in PostgreSql
--      the operator is the word like in MSSQL
-- the content within the [...] is a character in the string
-- other items 
--  ^ means "start of the string", with out pattern could be anywhere in string
--  + means additional characters eg [A-Za-z]+ means at least one character, matches "A" and "John"
--  $ means "end of the string"
-- in the following the ^ and $ are unnecessary because the pattern has 10 characters which is the exact
--		max length of the attribute
Phone			varchar(10) NULL
	CONSTRAINT CK_MickeyMouseStudent_Phone CHECK (Phone ~ '[1-9][0-9][0-9][1-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
EnrollmentDate	date		NULL
	CONSTRAINT DF_MickeyMouseStudent_EnrollmentDate Default Current_Date,
Gender			char(1)		NOT NULL
);

-- Primary Key index will have a system generated constraint name
CREATE TABLE IF NOT EXISTS MickeyMouseCourse(
CourseID		char(8)			NOT NULL PRIMARY KEY,
CourseName		varchar(50)		NULL
	CONSTRAINT UQ_MickeyMouseCourse_CourseName UNIQUE,
CourseHours		decimal(3,0)	NULL
	CONSTRAINT CK_MickeyMouseCourse_CourseHours CHECK (CourseHours between 0 AND 160),
--	CONSTRAINT CK_MickeyMouseCourse_CourseHours CHECK (CourseHours >= 0 AND CourseHours <= 160),

--NOTE: on some constraint Postgre will not implicitly do conversions of datatype
--      example: on the cost field, one needs to typecast the argument value as MONEY '...'
--   	one could avoid this problem by making the datatype of CourseCost a DECIMAL(12,2)
--          then the condition argument would not have to be typecast
CourseCost		money			NULL
	CONSTRAINT CK_MickeyMouseCourse_CourseCost CHECK (CourseCost >= MONEY '0.00')
-- CourseCost		decimal(12,2)			NULL
-- 	CONSTRAINT CK_MickeyMouseCourse_CourseCost CHECK (CourseCost >= 0.00)
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
Mark			decimal(5,2)	NULL
	CONSTRAINT CK_MickeyMouseGrade_Mark CHECK (Mark between 0 AND 100),

CONSTRAINT PK_MickeyMouseGrade_StudentIDCourseID
		PRIMARY KEY (StudentID,CourseID),

CONSTRAINT FK_MickeyMouseGradeMickeyMouseStudent_StudentID
		FOREIGN KEY (StudentID)
		REFERENCES MickeyMouseStudent(StudentID),

CONSTRAINT FK_MickeyMouseGradeMickeyMouseCourse_CourseID
		FOREIGN KEY (CourseID)
		REFERENCES MickeyMouseCourse(CourseID)
);

-- indexes are great for foreign keys and attributes that must be unique
-- naming pattern: IX_tablename_attributename

--can indexes be individually drop: Yes
-- NOTE: every time you drop a table, ALL material (table, data, indexes etc) for that table
--		 	is removed from the database

DROP INDEX IF EXISTS IX_MickeyMouseGrade_StudentID;
DROP INDEX IF EXISTS IX_MickeyMouseGrade_CourseID;
DROP INDEX IF EXISTS IX_MickeyMouseCourse_CourseName;

-- will be altered every time a record is added, updated or deleted on the grade table
CREATE Index IX_MickeyMouseGrade_StudentID
	ON MickeyMouseGrade(StudentID);

-- will be altered every time a record is added, updated or deleted on the grade table
CREATE Index IX_MickeyMouseGrade_CourseID
	ON MickeyMouseGrade(CourseID);

-- will be altered every time a record is added, updated or deleted on the course table
CREATE UNIQUE Index IX_MickeyMouseCourse_CourseName
	ON MickeyMouseCourse(CourseName);
