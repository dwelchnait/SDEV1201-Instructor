DROP TRIGGER IF EXISTS TR_MovieCharacter_Insert_Update
go

CREATE TRIGGER TR_MovieCharacter_Insert_Update
ON MovieCharacter
FOR Insert, Update
AS

 --trigger code
 --the trigger needs to be able to handle
 --		0 rows affected
 --     1 row affected
 --     many rows affected


 -- @@ROWCOUNT is set by the system when the system executes a DML command
 -- The value stored in this system variable is the number of rows affected
 --		by the executed DML command

 -- UPDATE(attribute) on the trigger
 -- the trigger is checking to see if the indicate attribute has be changed
 -- if the attribute is involved in the DML Update command, the trigger will execute
 -- if the attribute is NOT involved in the DAL Update command, the trigger will NOT execute
 --NOTE: on an INSERT the Update(attribute) is considered TRUE
 if @@ROWCOUNT > 0 and update(CharacterWage)
 BEGIN
	-- what is the "business rule" you are testing
	-- in this example the rule is : CharacterWage >= 0
	-- first we need to identify the tables required for the test: Inserted? Deleted? Base?
	--		or a combination of the tables
	-- NORMALLY you DO NOT need the physical records to make the decision
	-- NORMALLY just knowing the the condition exists is sufficient (Yes or NO)

	--on your Select statement you may use the * because NO ACTUAL record is returned
	--if you prefer using an attribute the use the pkey as the pkey MUST have a value

	PRINT 'Starting Test' -- NOTE PRINT alters @@ROWCOUNT
	if EXISTS (Select *
				FROM inserted
				WHERE CharacterWage < 0)
	BEGIN
		-- the data is deemed invalid
		-- the transaction needs to be rejected
		-- a message needs to be sent to the user
		-- ROLLBACK is done BEFORE your RaisError
		PRINT 'data invalid rolling back'
		ROLLBACK TRANSACTION
		RaisError('Character wage cannot be negative',16,1)
	END
 END
RETURN
go

delete from MovieCharacter
WHERE CharacterID > 5
go
Insert into MovieCharacter(CharacterID, CharacterName, CharacterMovie, CharacterRating, Characterwage)
VALUES (12,'BubBub','The Hills are alive with people',1,25.00)
go
Insert into MovieCharacter(CharacterID, CharacterName, CharacterMovie, CharacterRating, Characterwage)
VALUES (13,'BubBub','The Hills are alive with people',1,-25.00)
go
Update MovieCharacter
SET Characterwage = 35.00
WHERE CharacterID = 12
go
Update MovieCharacter
SET Characterwage = -35.00
WHERE CharacterID = 12
go
Update MovieCharacter
SET Characterwage = 35.00
WHERE CharacterID = 111
go
Update MovieCharacter
SET CharacterName = 'Don'
WHERE CharacterID = 12
go