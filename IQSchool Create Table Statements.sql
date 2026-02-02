/* IQSchool Table Creation  */

-- if you do NOT have a IQSchool database, then first create it
--		then execute




DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS PaymentType;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Offering;
DROP TABLE IF EXISTS Semester;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Club;
DROP TABLE IF EXISTS Position;


Create Table Position
(
	PositionID			SMALLINT	Not Null
										Constraint PK_Position_PositionID
											Primary Key,
	PositionDescription	varchar(50)		Not Null
);


Create Table Club
(
	ClubId				varchar(10)		Not Null
										Constraint PK_Club_ClubId
											Primary Key,
	ClubName			varchar(50)		Not Null
);


Create Table Student
(
	StudentID			integer				Not Null
										Constraint PK_Student_StudentID
											Primary Key,
	FirstName			varchar(25)		Not Null,
	LastName			varchar(35)		Not Null,
	Gender				char(1)			Not Null,
	StreetAddress		varchar(35)		Null,
	City				varchar(30)		Null,
	Province			char(2)			Null 
										Constraint DF_Student_Province_AB
											Default 'AB'
										Constraint CK_Student_Province_ZZ
											Check (Province ~ '[A-Za-z][A-Za-z]'),
	PostalCode			char(6)			Null
										Constraint CK_Student_PostalCode_Canadian_Style_Z9Z9Z9
											check(PostalCode ~ '[A-Za-z][0-9][A-Za-z][0-9][A-Za-z][0-9]'),
	Birthdate			date	Not Null,
	BalanceOwing		decimal(7,2)	Null
										Constraint DF_Student_BalanceOwing_Zero
											Default 0
										Constraint CK_Student_BalanceOwing_GreaterEqualZero
											Check (BalanceOwing >= 0)
);


Create Table Course
(
	CourseId			char(8)			Not Null
										Constraint PK_Course_CourseId
											Primary Key ,
	CourseName			varchar(40)		Not Null,	
	CourseHours 		smallint		Not Null
										Constraint CK_Course_CourseHours_GreaterThanZero
											Check (CourseHours > 0),
	MaxStudents			integer				Null
										Constraint DF_Course_MaxStudents_Zero
											Default 0
										Constraint CK_Course_MaxStudents_GreaterEqualZero
											Check (MaxStudents >= 0),
	CourseCost			decimal(6,2)	Not Null
										Constraint DF_Course_CourseCost_Zero
											Default 0
										Constraint CK_Course_CourseCost_GreaterEqualZero
											Check (CourseCost >= 0)
);


Create Table Staff
(
	StaffID				smallint		Not Null
										Constraint PK_Staff_StaffID
											Primary Key ,
	FirstName			varchar(25)		Not Null,
	LastName			varchar(35)		Not Null,
	DateHired			date	Not Null
										Constraint DF_Staff_DateHired_GetDate
											Default Current_Date,
	DateReleased		date	Null,
	PositionID			smallint			Not Null
										Constraint FK_Staff_PositionID_To_Position_PositionID
											References Position(PositionID),
	LoginID				varchar(30)		Null,
	Constraint CK_Staff_DateReleased_GreaterThan_DateHired
		Check (DateReleased > DateHired)
);


Create Table Activity
(
	StudentID			integer				Not Null
										Constraint FK_Activity_StudentID_To_Student_StudentID
											References Student (StudentID), 
	ClubId				varchar(10) 	Not Null
										Constraint FK_Activity_ClubId_To_Club_ClubId
											References Club (ClubId),
	Constraint PK_Activity_StudentID_ClubId
		Primary Key  (StudentID, ClubId)
);


Create Table Semester
(
	SemesterCode		char(5)			Not Null
										Constraint PK_Semester_SemesterCode
											Primary Key ,
	StartDate			date		Not Null,
	EndDate				date		Not Null
);


Create Table Offering
(
	OfferingCode		integer				Not Null
										Constraint PK_Offering_OfferingCode
											Primary Key ,
	StaffID				smallint		Not Null
										Constraint fk_Offering_StaffID_To_Staff_StaffID
											References Staff(StaffID),
	CourseId			char(8)			Not Null
										Constraint fk_Offering_CourseId_To_Course_CourseId
											References Course(CourseId),
	SemesterCode		char(5)			Not Null
										Constraint fk_Offering_SemesterCode_To_Semester_SemesterCode
											References Semester(SemesterCode)
);


Create Table Registration
(
	OfferingCode		integer				Not Null
										Constraint fk_Registration_OfferingCode_To_Offering_OfferingCode
											References Offering(OfferingCode),
	StudentID			integer				Constraint fk_Registration_StudentID_To_Student_StudentID
											References Student(StudentID),
	Mark				decimal(5,2)	Null
										Constraint CK_Registration_Mark_0_To_100
											Check (Mark between 0 and 100),
	WithdrawYN			char(1)			Null
										Constraint DF_Registration_WithdrawYN_N
											Default 'N'
										Constraint CK_Registration_WithdrawYN_YN
											Check (WithdrawYN in ('Y','N')),
	Constraint PK_Registration_OfferingCode_StudentID
		Primary Key (OfferingCode, StudentID)
);


Create Table PaymentType
(
	PaymentTypeID			smallint		Not Null
										Constraint PK_PaymentType_PaymentTypeID
											Primary Key ,
	PaymentTypeDescription	varchar(40) Null
);


Create Table Payment
(
	PaymentID			integer				Not Null
										Constraint PK_Payment_PaymentID
											Primary Key ,
	PaymentDate			date		Not Null
										Constraint DF_Payment_PaymentDate_GetDate
											Default Current_Date
										Constraint CK_Payment_PaymentDate_GreaterEqual_GetDate
											Check (PaymentDate >= Current_Date),
	Amount				decimal(6,2)	Not Null
										Constraint DF_Payment_Amount_Zero
											Default 0
										Constraint CK_Payment_Amount_GreaterEqualZero
											Check (Amount >= 0),
	PaymentTypeID		smallint			Not Null
										Constraint FK_Payment_PaymentTypeID_To_PaymentType_PaymentTypeID
											References PaymentType (PaymentTypeID),
	StudentID			integer				Not Null
										Constraint FK_Payment_StudentID_To_Student_StudentID
											References Student (StudentID)
);
