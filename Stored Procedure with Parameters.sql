-- delete a procedure

-- this is a batch
DROP PROCEDURE IF EXISTS Student_Names_Gender
go

-- this is a batch
-- this batch will NOT execute until the previous batch completes
-- this code is NOT dependent on the previous batch

--parameters are deemed to be a local variable
--parameters do NOT needed to be separately declared within your procedure
CREATE PROCEDURE Student_Names_Gender
(@gender char(1) = null)
AS
	--there are a few select conditions that do not use relative operators
	-- for their operation such as null, in (list/subquery), is not
	if (@gender is null)
	BEGIN
		PRINT 'Gender value was not supplied. Use B, M or F'
	END
	ELSE
	BEGIN
		--local variable
		--DECLARE @gender char(1)
		--SET @gender = 'F'

		--identation is a useful tool for readability
		-- the if is used to control the logic of the stored procedure
		--	dictating what course of action is to be executed
		-- the if structure can be nested (an if within an if)
		if (@gender = 'B')
		Begin
			SELECT LastName + ', ' + FirstName AS Name, Gender
			FROM Student
			ORDER BY LastName, FirstName
		END
		ELSE
		BEGIN
			-- when using the EXISTS/ NOT EXISTS one will NOT
			--		actually receive the record list
			--	instead, the condition checks to see if a dataset with records
			--		would have been created
			--  the system interprets the existence of the dataset as a boolean
			--		true or false
			--  many times you will see an * used in this type of test and
			--		is considered safe as the procedure never actually exposes the
			--		returned data
			--  if you are not allowed to use the *, any field on the data collection
			--		would be sufficent, note the field should have a data value
			if EXISTS (Select StudentID
						FROM Student
						WHERE Gender = @gender)
			BEGIN
				SELECT LastName + ', ' + FirstName AS Name, Gender
				FROM Student
				WHERE Gender = @gender
				ORDER BY LastName, FirstName
			END
			ELSE
			BEGIN
				Print 'There are no students on file of that gender'
			END
		END
	END
RETURN
go

-- this is a batch
-- this batch will NOT execute until the previous batch completes
-- you last batch does not need a go commmand, however, it is good
--	coding clarity to include the closing batch go
exec Student_Names_Gender 
go