DROP PROCEDURE IF EXISTS FullDMLInsertProc
DROP PROCEDURE IF EXISTS FullDMLUpdateProc
DROP PROCEDURE IF EXISTS FullDMLDeleteProc
DROP PROCEDURE IF EXISTS FullDMLVaidationProc
go

Create PROCEDURE FullDMLInsertProc
(
@CourseId char(8) = null,
@CourseName varchar(40) = null,
@CourseHours smallint = null,
@MaxStudents int = null,
@CourseCost decimal(6,2) = null
)
AS
-- this proc will insert into Course on IQSchool
Begin
	DECLARE @ErrorMsg varchar (2048)
	-- note MaxStudents can be null on the table
	--	therefore does NOT need to be in this first if
	if @CourseId is null or
		@CourseName is null or
		@CourseHours is null or
		@CourseCost is null
		BEGIN
			RaisError ('Missing one of the following: course id, course name, course hours or the course cost',16,1)
		END
		ELSE
		BEGIN
			BEGIN TRY
			    -- this is the code that will be attempted to be executed
				INSERT INTO Course (CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
				VALUES (@CourseId, @CourseName, @CourseHours, @MaxStudents, @CourseCost)
			END TRY
			BEGIN CATCH
			    -- this is a "post" handling of errors
				-- this code is executed IF the DML command causes an sql execute error to be generated
				-- if no sql execution error is generated, this code is NOT executed
				-- INTERESTING NOTE: a ; is needed here at the end of the SET and before the Throw
				SET @ErrorMsg = 'Insert into Course for ' + @CourseId + ' failed due to ' + ERROR_MESSAGE();
				Throw 50000, @ErrorMsg, 1
			END CATCH
		END
END
RETURN
go

Create PROCEDURE FullDMLVaidationProc
(
@CourseId char(8) = null,
@CourseName varchar(40) = null,
@CourseHours smallint = null,
@MaxStudents int = null,
@CourseCost decimal(6,2) = null
)
AS
-- this proc will insert into Course on IQSchool
Begin
	DECLARE @ErrorMsg varchar (2048)
	-- note MaxStudents can be null on the table
	--	therefore does NOT need to be in this first if
	if @CourseId is null or
		@CourseName is null or
		@CourseHours is null or
		@CourseCost is null
		BEGIN
			RaisError ('Missing one of the following: course id, course name, course hours or the course cost',16,1)
		END
		ELSE
		BEGIN
			-- a pre-test technique for DML commands
			if EXISTS (SELECT CourseId
						 FROM Course
						 WHERE CourseId like @CourseId)
			BEGIN
				SET @ErrorMsg = 'A course with the id of: ' + @CourseId + ' already exists on file. Insert fails.';
				Throw 50000, @ErrorMsg, 1
				--or
				--RaisError (@ErrorMsg,16,1)

			END
			ELSE
			BEGIN
				if @CourseCost < 0
				BEGIN
					-- note typecast on numeric data to a string to create the message
					SET @ErrorMsg = 'A course with the id of: ' + @CourseId + ' has an invalid cost of ' + CAST(@CourseCost as varchar(20)) + '. Insert fails.';
					Throw 50000, @ErrorMsg, 1
				END
				ELSE
				BEGIN
					if @CourseHours < 0
					BEGIN
						SET @ErrorMsg = 'A course with the id of: ' + @CourseId + ' has an invalid hours of ' + CAST(@CourseHours as varchar(20)) + '. Insert fails.';
						Throw 50000, @ErrorMsg, 1
					END
					ELSE
					BEGIN
						if @MaxStudents is not null
						BEGIN
							if @MaxStudents < 0
							BEGIN
								SET @ErrorMsg = 'A course with the id of: ' + @CourseId + ' has an invalid maximun students of ' + CAST(@MaxStudents as varchar(20)) + '. Insert fails.';
								Throw 50000, @ErrorMsg, 1
							END
							ELSE
							BEGIN
								INSERT INTO Course (CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
								VALUES (@CourseId, @CourseName, @CourseHours, @MaxStudents, @CourseCost)
							END
						END
						ELSE
						BEGIN
							INSERT INTO Course (CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
							VALUES (@CourseId, @CourseName, @CourseHours, @MaxStudents, @CourseCost)
						END
					END
				END
			END
		END
END
RETURN
go
PRINT 'Testing Course insert'
PRINT 'Testing missing parameter values'
DELETE Course WHERE CourseId like 'SDEV1201'
exec FullDMLInsertProc
go

DELETE Course WHERE CourseId like 'SDEV1201'
PRINT 'Testing good insert'
exec FullDMLInsertProc 'SDEV1201', 'Fundamental Database Structures', 90, 32, 765.00
PRINT 'Display good insert'
Select * FROM Course WHERE CourseId LIKE 'SDEV1201'

go

DELETE Course WHERE CourseId like 'SDEV1201'
PRINT 'Testing good insert'
exec FullDMLInsertProc 'SDEV1201', 'Fundamental Database Structures', 90, 32, 765.00
PRINT 'Display good insert'
Select * FROM Course WHERE CourseId LIKE 'SDEV1201'
PRINT 'Testing duplicate pkey insert'
exec FullDMLInsertProc 'SDEV1201', 'Fundamental Database Structures', 90, 32, 765.00

go

DELETE Course WHERE CourseId like 'SDEV1201'
PRINT 'Testing constraint error on insert: coursecost >= 0'
exec FullDMLInsertProc 'SDEV1201', 'Fundamental Database Structures', 90, 32, -765.00

go

DELETE Course WHERE CourseId like 'SDEV1201'
PRINT 'Testing constraint error on insert: coursecost >= 0'
exec FullDMLVaidationProc 'SDEV1201', 'Fundamental Database Structures', 90, 32, -765.00

go