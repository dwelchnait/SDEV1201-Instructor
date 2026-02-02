SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
--WHERE Gender = 'M'
ORDER BY FirstName DESC , LastName DESC
;

SELECT CourseName, CourseHours, CourseCost
FROM MickeyMouseCourse
WHERE CourseHours > 60 and CourseCost > MONEY (400.00);

SELECT StudentID, Mark
FROM MickeyMouseGrade
WHERE CourseID in ('DMIT1508','CPSC1012');

SELECT StudentID, Mark
FROM MickeyMouseGrade
WHERE CourseID = 'DMIT1508' or CourseID = 'CPSC1012';

-- PostgreSql has two string filtering operators
-- LIKE 
--		starts to implicitly match from the first character to the end of the string
-- Pattern (Regex) matching using ~
--      matches patterns according to the supplied regex expression

-- using 'Daffy', 'Duck'

--the string consists of ONLY the D
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName LIKE 'D';


--finds a D at the start of the stirng
-- ^ indicates the start of string
-- $ indicates the end of string
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName ~ '^D$';

--finds a D anywhere in the stirng
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName ~ 'D';

--how can I use LIKE to check any specific pattern in a string
-- % in LIKE means any adding characters
-- _ in LIKE means a single character
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName LIKE 'D%';

SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName LIKE 'D_f%';

--LIKE is case sensitive
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName LIKE 'M_c%';

--ILIKE is NOT case sensitive
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName ILIKE 'M_C%';

--Pattern wild card characters

-- ^ indicates the start of string
-- $ indicates the end of string
-- .* (similar to % in LIKE)
-- . (similar to _ in LIKE)
-- ~* (similar to ILIKE)
-- [..] within the brackets is your character pattern eg [A-Za-z}] is upper or lower case letter; [0-9] is a digit

--these patterns are anywhere in the string
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
--WHERE FirstName ~* 'M.C.*';
--WHERE FirstName ~* 'm.C.*';
WHERE FirstName ~* '[m].[C].*';

SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName ~ '[Mm].[Cc].*';

--these patterns are at the start and end in the string
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone --, Gender
FROM MickeyMouseStudent
WHERE FirstName ~ '^[Mm].[Cc].*$';


-- ALL (default) vs DISTINCT
-- ALL as implied display all rows
-- DISTINCT display unique rows
SELECT Gender
FROM MickeyMouseStudent;

SELECT DISTINCT Gender
FROM MickeyMouseStudent;

SELECT DISTINCT Gender, FirstName
FROM MickeyMouseStudent;

SELECT Gender, Address
FROM MickeyMouseStudent;

SELECT DISTINCT Gender, Address
FROM MickeyMouseStudent;

SELECT DISTINCT Address
FROM MickeyMouseStudent;


--Aggregate Functions
--Aggregate functions are a summing of data to create additional information
--Count(*), Count(col), SUM(col), AVG(col), MIN(col), MAX(col)
--Count(*) counts rows regardless of data
--Count(col) counts rows depending on the data content of the column, 
--            if the row data for the column is null, it is NOT counted
--SUM and AVG are restricted to numerics
--for aggregate column you MUST include a title select 

--phrases to look for; how many, number of, ...
SELECT Count(*) "Student Count"
FROM MickeyMouseStudent;

SELECT Count(Address) "Student Count"
FROM MickeyMouseStudent;

SELECT Count(DISTINCT Address) "Student Count"
FROM MickeyMouseStudent;

-- null in column
SELECT Count(*) "Course Count"
FROM MickeyMouseCourse;

SELECT Count(CourseCost) "PayFor Count"
FROM MickeyMouseCourse;

--phrases to look for; the total of, sum of, ...
--Sum(col)
SELECT SUM(CourseCost) "Program Count"
FROM MickeyMouseCourse;

-- not possible, CourseName is NOT numeric
SELECT SUM(CourseName) "Program Count"
FROM MickeyMouseCourse;

--Avg(col)
--because CourseCost is money it needs to be typecast to a numeric
SELECT AVG(CourseCost::numeric) "Avg Course Cost"
FROM MickeyMouseCourse;

SELECT AVG(CourseHours) "Avg Course Hours"
FROM MickeyMouseCourse;

-- not possible, CourseName is NOT numeric
SELECT AVG(CourseName) "Program Count"
FROM MickeyMouseCourse;

--Min(col)

SELECT MIN(CourseCost) "Minimum Course Cost"
FROM MickeyMouseCourse;

SELECT MIN(CourseHours) "Minimum Course Hours"
FROM MickeyMouseCourse;

-- MIN will find what it consider the Minimum Name
-- it does a dictionary order comparison
-- it does a character by character matching
-- for character matching internally, captial letters are before lower case letters
SELECT MIN(CourseName) "Minimum Course Name"
FROM MickeyMouseCourse;

--Max(col)

SELECT MAX(CourseCost) "Maximum Course Cost"
FROM MickeyMouseCourse;

SELECT MAX(CourseHours) "Maximum Course Hours"
FROM MickeyMouseCourse;

-- MAX will find what it consider the Minimum Name
-- it does a dictionary order comparison
-- it does a character by character matching
-- for character matching internally, captial letters are before lower case letters
SELECT MAX(CourseName) "Maximum Course Name"
FROM MickeyMouseCourse;

--STring Functions

--LENGTH (column | expression) returns the length of the string
--LEFT (column |expression, length) returns a string starting from the left for a length of characters
--RIGHT (column |expression, length) returns a string starting from the right for a length of characters
--SUBSTRING (column | expression, start, length) --extract a substring from string start at for length of characters
--REVERSE (column | expression) -- reverses and returns string
--UPPER (column | expression) -- changes all characters to upper case
--LOWER (column | expression) -- changes all characters to lower case
--LTRIM (column | expression) --will remove blanks
--RTRIM (column | expression) --will remove blanks
SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone, 
	Length(FirstName) "Len FirstName", Length(LastName) "Len LastName",
	Length(FirstName || ' ' || LastName) "Len FullName" --, Gender
FROM MickeyMouseStudent;

SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone, 
	LEFT(FirstName,3) "Short FirstName", LEFT(LastName,3) "Short LastName" --, Gender
FROM MickeyMouseStudent;

SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone, 
	RIGHT(FirstName,3) "Short FirstName", RIGHT(LastName,3) "Short LastName" --, Gender
FROM MickeyMouseStudent;

SELECT  StudentID, FirstName || ' ' || LastName  Name, Phone, 
	LEFT(FirstName,3) || LastName || '@nait.ca' "Email" --, Gender
FROM MickeyMouseStudent;
