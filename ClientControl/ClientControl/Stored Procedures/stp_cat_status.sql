if not exists (select [id] from sysobjects where id = object_id('stp_cat_status'))
	EXECUTE ('CREATE PROCEDURE stp_cat_status AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_status
(
	@method			varchar(50)
	,@status		varchar(50)		= NULL
	,@statusId		INT				= NULL
	,@tipo			tinyint			= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showItem' BEGIN
	select estatus, id_estatus as 'idEstatus'
	from [estatus]
	where id_estatus = @statusId
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' Begin
	select estatus,id_estatus as 'idEstatus'
	from [estatus]
	where tipo = isnull(@tipo, tipo)
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveItem' Begin
	IF @statusId is not null begin
		update [estatus]
		set estatus = @status,
			id_estatus = @statusId
			where id_estatus= @statusId
		end
	else
		insert into [estatus](estatus) values(@status)
END
--
RETURN
--
GO