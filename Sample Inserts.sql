-- Insert

--basic structure
-- contains all table attributes (aka column or field) *
-- order is typically the same as the order of attributes on the table

-- * NOTE: the primary key (StudentID) is NOT an IDENTITY(seed,increment) primary key
--         This means you MUST supply the primary key value on the insert
--         IF!!!!! the primary key was an IDENTITY pkey, then you would NOT have supplied the studentid.

INSERT INTO Student (StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
VALUES(202611111,'Shirely','Ujest','F','123 Maple Ave','Edmonton','AB','T6Y7U8','2007-10-14',0.00);

-- can the attribute list be mixed up?
-- YES
-- the system will match the data to the appropriate attribute on the table

INSERT INTO Student (StudentID, LastName, FirstName, Gender, BalanceOwing, StreetAddress, City, Province, PostalCode, Birthdate)
VALUES(202622222,'Kan','Jerry','M',123.45,'123 Maple Ave','Edmonton','AB','T6Y7U8','2007-10-14');

-- can a record be added without using the column list
-- yes: As long as the data value are in the same order as the table attributes AND 
--         same number of data values to attributes (assuming no defaults)

INSERT INTO Student 
VALUES(202633333,'Iam','Stew-Dent','F','324 Oak St.','Spruce Grove','AB','T8Y7U8','1997-1-14',0.00);

-- what would happen if the order of data does not match the order of the table attributes
--  one problem is datatypes - mismatch
--  another problem is missing data
INSERT INTO Student 
VALUES(202633334,'Iam','Stew-Dent','F','324 Oak St.','Spruce Grove','AB','T8Y7U8',0.00,'1997-1-14');

select * from student where studentid >= 202600000;

-- add staff memebers
-- pkey is not IDENTITY therefore once again we must supply the pkey value
-- DateHired is default to today
-- DateReleased and Login are nullable fields (does not need a value)
-- DateReleased if present must be greater than DateHired

-- enter all new staff in one insert
-- DateReleased has no value: used the keyword NULL

-- all record will be added at the same time
-- if one record is incorrect NO records will be added
INSERT INTO Staff (Staffid, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
VALUES (11, 'Lowand', 'Behold','2026-1-3',null, 4, 'LBehold'),
		(12, 'Cheerie', 'Cheek','2026-1-3',null, 4, 'CCheek'),
		(14, 'Oliver', 'Twisted','2026-1-3',null, 4, 'OTwisted'),
		(13, 'Kandy','Kane','2026-1-3',null,5,null);
	
select * from Staff;

-- problem: do NOT know the pkey values for all positions available on the table
--          do known the position decription: Dean
-- can we dynamically obtain the foreign key for the position for the new staff member
-- Yes: use a subquery as the column data
-- can we use the default constraint on a given attribute
-- Yes: DateHired has a constraint that deault to the current date
INSERT INTO Staff (Staffid, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
VALUES (21, 'Don', 'Welch',default,null, 
			(SELECT PositionID 
			 FROM Position
			 WHERE positiondescription LIKE 'Dean'), 'DWelch');
