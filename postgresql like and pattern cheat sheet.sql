--starts are the beginning of the string

-- PostgreSql implicityly anchors at the start and end
Select FirstName || ' ' || LastName "Student Name"
From Student
Where FirstName Like 'D_n%s';

-- Sql
Select FirstName || ' ' || LastName "Student Name"
From Student
Where FirstName Like '^D_n%s$';



--starts are the anywhere in the string (regex expression)
-- PostgreSql
Select FirstName || ' ' || LastName "Student Name"
From Student
Where FirstName ~ '[Dd].[Nn].*[Ss]';

-- Sql
Select FirstName || ' ' || LastName "Student Name"
From Student
Where FirstName Like '%D_n%s';



-- | SQL Server LIKE | PostgreSQL regex |
-- | --------------- | ---------------- |
-- | `%`             | `.*`             |
-- | `_`             | `.`              |
-- | `LIKE`          | `~`              |
-- | `LIKE (CI)`     | `~*`             |
-- | `^`             | `^`             |
-- | `$`             | `$`             |
