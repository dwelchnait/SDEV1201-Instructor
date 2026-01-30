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

