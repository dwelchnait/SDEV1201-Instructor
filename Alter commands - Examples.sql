--Sample Alter commands

--Add Column to Course called Active char(1)
Alter TABLE MickeyMouseCourse
	ADD COLUMN Active char(1) NULL;


--Alter datatype of Column in Course called Active to a boolean value (true or false)
--Since the column MAY already have data of a character type (Y or N) that
--		needs to be converted to a boolean (0 or 1) value.
--the physical storage size will also change
--PostgreSQL can implicitly alter the data therefore one needs to add a qualifier
--	to the command USING column-name::boolean
Alter TABLE MickeyMouseCourse
	Alter Column Active Set Data Type Boolean USING Active::boolean; 

--drop column
Alter TABLE MickeyMouseCourse
	DROP COLUMN Active;

-- Constraint
--yes:
--warning: suggests that there will be times that the constraint cannot
--			be alter directly and that the procedure should be to 
--			drop the current constraint THEN add the new constraint to 
--			the column
--			ALSO when placing a constraint on the table which MAY or MAYNOT
--			contain data, managing your changes to check contraints will
--			cause the checking of your data to the alternation and IF
--			there is a problem with your data matching the alternation
--			the Alter command will fail

-- remove the unique constraint UQ_MickeyMouseCourse_CourseName from coursename

ALTER TABLE MickeyMouseCourse
	DROP CONSTRAINT UQ_MickeyMouseCourse_CourseName;

ALTER TABLE MickeyMouseCourse
	Add CONSTRAINT UQ_MickeyMouseCourse_CourseName UNIQUE (CourseName);