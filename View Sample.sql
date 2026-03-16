Create View StudentCourseView
As
Select Student.FirstName, Student.LastName, Course.CourseID,
Course.CourseName
From Student Inner Join Registration
				On Student.StudentID = Registration.StudentID
			 Inner Join Offering
				On Offering.Offeringcode = Registration.OfferingCode
			 Inner Join Course
				On Offering.CourseId = Course.Courseid;

SELECT * From StudentCourseView
ORDER By 3;

DROP View StudentCourseView;