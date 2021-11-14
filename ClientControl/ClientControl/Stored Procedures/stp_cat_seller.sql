if not exists (select [id] from sysobjects where id = object_id('stp_cat_seller'))
	EXECUTE ('CREATE PROCEDURE stp_cat_seller AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_seller
(
	@method				varchar(50)
	,@idVendedor			INT				= NULL
	,@value				varchar(100)		= NULL 
	,@idEstatus			int					= NULL
	,@idPersona			int					= NULL
	,@apPaterno			varchar(100)		= NULL
	,@apMaterno			varchar(100)		= NULL
	,@nombre			varchar(100)		= NULL
	,@email				varchar(50)			= NULL
	,@telefono			varchar(50)			= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showItem' BEGIN
	select id_vendedor idVendedor, ap_paterno apPaterno, ap_materno apMaterno, nombre, id_estatus idEstatus, telefono, email
	from vendedores 
	where id_vendedor = @idVendedor
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' Begin
	select id_vendedor idVendedor, a.id_estatus idEstatus
		, concat(a.nombre,' ', a.ap_paterno, ' ', a.ap_materno) as "nombreCompleto"
		, concat(a.nombre,' ', a.ap_paterno, ' ', a.ap_materno, '(',b.estatus,')') as "nombreCompletoDropDown"
		, b.estatus
		from vendedores a
		inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=3
		where a.id_estatus = isnull(@idEstatus, a.id_estatus)
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveItem' Begin
	IF @idVendedor is not null begin
		update vendedores
		set ap_paterno = @apPaterno
		, ap_materno=@apMaterno
		, nombre =@nombre
		, id_estatus = @idEstatus
		,telefono=@telefono
		,email=@email
			where id_vendedor = @idVendedor
		end
	else
		insert into vendedores(ap_paterno, ap_materno, nombre, fecha_creacion, id_estatus, telefono, email) 
		values(@apPaterno, @apMaterno, @nombre, getDate(), @idEstatus,@telefono,@email)
END
--------------------------------------------------------------------------------------------------------
else if @method = 'searchItem' begin
		select id_vendedor as idVendedor
		, b.estatus
		, concat(a.nombre,' ', a.ap_paterno, ' ', a.ap_materno) as "nombreCompleto"
		from vendedores a
		inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=3
		where  concat(nombre,' ',ap_paterno,' ', ap_materno) like '%' + @value + '%'
end
--------------------------------------------------------------------------------------------------------
--
RETURN
--
GO