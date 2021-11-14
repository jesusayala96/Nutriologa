if not exists (select [id] from sysobjects where id = object_id('stp_cat_tipo'))
	EXECUTE ('CREATE PROCEDURE stp_cat_tipo AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_tipo
(
	@method			varchar(50),
	@tipo			INT		= NULL,
	@enganche		INT				= NULL,
	@precio		INT				= NULL,
	@fechaUA		INT				= NULL,
	@value			varchar(100)	= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showItem' BEGIN
	select [tipo], enganche,precio, fechaUA
	from lotes_tipo
	where tipo = @tipo
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' Begin
	select [tipo], enganche,precio, fechaUA, concat('$',precio,'(enganche:$',enganche,')') precioEnganche
	from lotes_tipo
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveItem' Begin
	IF @tipo is not null begin
		update lotes_tipo
		set enganche = @enganche,
			precio = @precio,
			fechaUA = getDate()
			where tipo = @tipo
		end
	else
		insert into lotes_tipo(precio,enganche,fechaUA) values(@precio,@enganche,@fechaUA)
END
--else if @method = 'searchItem' begin
--		select [tipo], [status],status_id as 'statusId', tipo_id as 'tipoId'
--		from lotes_tipo
--		where tipo like '%' + @value + '%'
--		or [status] like '%' + @value + '%'
--end
--
RETURN
--
GO