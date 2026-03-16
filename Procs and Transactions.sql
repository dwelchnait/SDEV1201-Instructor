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

						Commit Transaction
					End Try
					Begin Catch
						Rollback Transaction

						Select @Error_Message = Error_Message()
						Throw 50000, @ErrorMessage, 1
					End Catch
				END
			END
		END
	END
End
Return
Go
