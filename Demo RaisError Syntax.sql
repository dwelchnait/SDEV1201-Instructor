DROP PROCEDURE IF EXISTS ConcatenationRaisError
DROP PROCEDURE IF EXISTS InLineRaisError
go

CREATE PROC ConcatenationRaisError
(
@stringVariable1 varchar(10) = null,
@stringVariable2 varchar(10) = null
)
AS
DECLARE @ErrorMessage varchar(2048)
if @stringVariable1 is null or @stringVariable2 is null
BEGIN
	RaisError('Missing variable input value. Variable values are required', 16,1)
END
ELSE
BEGIN
	Set @ErrorMessage = 'You can use concatenated variables ' + @StringVariable1 + ', ' + @StringVariable2
	RaisError (@ErrorMessage, 16, 1) 
END
RETURN
go 
CREATE PROC InLineRaisError
(
@stringVariable1 int = null,
@stringVariable2 varchar(10) = null
)
AS
DECLARE @ErrorMessage varchar(2048)
if @stringVariable1 is null or @stringVariable2 is null
BEGIN
	RaisError('Missing variable input value. Variable values are required', 16,1)
END
ELSE
BEGIN
	-- %d indicates that an integer will be supplied
	-- %s indicates that a string will be supplied
	-- the order of the placeholders (%d and %s) alines with the order of the
	--		variables in the command
	RaisError ('Create message using inline variables integer %d and string %s', 16, 1,@StringVariable1, @StringVariable2)
	 
END
RETURN
go

Print 'Concatenation executions'
exec ConcatenationRaisError
go
exec ConcatenationRaisError 'string1', 'string2'
go
Print 'InLine executions'
exec InLineRaisError
go
exec InLineRaisError 100, 'string2'
go