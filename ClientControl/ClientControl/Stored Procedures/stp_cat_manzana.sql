if not exists (select [id] from sysobjects where id = object_id('stp_cat_manzana'))
	EXECUTE ('CREATE PROCEDURE stp_cat_manzana AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_manzana
(
	@method			varchar(50),
	@manzana		varchar(50)		= NULL,
	@idEstatus		INT				= NULL,
	@idManzana		INT				= NULL,
	@value			varchar(100)	= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showItem' BEGIN
	select [manzana], id_estatus idEstatus, id_manzana idManzana
	from manzanas a 
	where id_manzana = @idManzana
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' Begin
	select [manzana], b.estatus, id_manzana idManzana
	from manzanas a 
	inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=4
	order by manzana
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveItem' Begin
	IF @idManzana is not null begin
		update manzanas
		set manzana = @manzana,
			id_estatus = @idEstatus
			where id_manzana = @idManzana
		end
	else
		insert into manzanas(manzana,id_estatus, fecha_creacion) values(@manzana,@idEstatus,getDate())
END
else if @method = 'searchItem' begin
		select [manzana], b.estatus, id_manzana as 'idManzana'
		from manzanas a 
		inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=4
		where manzana like '%' + @value + '%'
		--or [status] like '%' + @value + '%'
end
--
RETURN
--
GO