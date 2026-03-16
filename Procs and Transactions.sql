Begin Transaction -- Start a transaction
Select OfferingCode, StudentID, Mark, WithdrawYN From Registration -- See data
Delete from Registration -- Delete the records
Rollback Transaction -- Rollback the Transaction
Select OfferingCode, StudentID, Mark, WithdrawYN From Registration -- See data

Begin Transaction -- Start a transaction
Select OfferingCode, StudentID, Mark, WithdrawYN From Registration -- See data
Delete from Registration -- Delete the records
Commit Transaction -- Commit the Transaction
Select OfferingCode, StudentID, Mark, WithdrawYN From Registration -- See data

--after the above demo, you will need to reload the IQSchool records using your script

DROP PROCEDURE IF EXISTS PR_RegisterStudent
go
Create Procedure PR_RegisterStudent 
(@OfferingCode int = null, 
@StudentID int = null, 
@CourseID char(8))
As
Begin
	Declare @Error_Message varchar(2048)
	if (@OfferingCode = null or @StudentID = null or @CourseID = null)
	BEGIN
		RaisError ('Missing one of: offerring code, student id and/or courseid',16,1)
	END
	ELSE
	BEGIN
		-- remember in this course you will validate that pkey exists first for
		--		any filter condition on your DML Update and delete commands
		--      and if possible the filter conditon for these commands if it
		--		does not involve a pkey
		if not EXISTS (Select OfferingCode
						FROM Offering
						WHERE OfferingCode = @OfferingCode)
		BEGIN
			RaisError ('offerring code does not exist. Registration not done',16,1)
		END
		ELSE
		BEGIN
			if not EXISTS (Select Studentid
						FROM Student
						WHERE StudentID = @StudentID)
			BEGIN
				RaisError ('Student ID code does not exist. Registration not done',16,1)
			END
			ELSE
			BEGIN
				if not EXISTS (Select CourseId
						FROM Course
						WHERE CourseId = @CourseID)
				BEGIN
					RaisError ('Course ID code does not exist. Registration not done',16,1)
				END
				ELSE
				BEGIN
					-- starts the explicit transaction in memory
					-- sql tracks any changes
					-- there is only one Begin Transaction

					-- A TRANSACTION MUST BE ABLE TO EXECUTE A COMMIT OR ROLLBACK TO BE SUCCESSFUL
					-- DO NOT LEAVE "HANGING" TRANSACTIONS

					--NOTE: DO NOT confuse the Begin Transaction command with the IF's Begin
					Begin Transaction
					Begin Try
						Insert Into Registration
						(OfferingCode, StudentID, Mark, WithdrawYN)
						Values
						(@OfferingCode, @StudentID, 0, 'M')

						Update Student
						Set BalanceOwing = BalanceOwing + (Select CourseCost 
															From Course 
															Where CourseID = @CourseID)
						Where StudentID = @StudentID

						-- all DML commands have been execute and the result
						--		are to be permanently keep on the database
						--there is only ONE Commit per transaction
						Commit Transaction
					End Try
					Begin Catch
						-- the rollback transaction erases any and all changes
						--	to the database made during the explicit transaction
						-- there is only ONe Rollback executed per transaction
						Rollback Transaction
						--seems that the statement prior to a Throw needs a semi-colon ;
						Select @Error_Message = Error_Message();
						Throw 50000, @ErrorMessage, 1
					End Catch
				END
			END
		END
	END
End
Return
Go
