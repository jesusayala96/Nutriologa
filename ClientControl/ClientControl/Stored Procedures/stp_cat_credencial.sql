if not exists (select [id] from sysobjects where id = object_id('stp_cat_credencial'))
	EXECUTE ('CREATE PROCEDURE stp_cat_credencial AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_credencial
(
	@method			varchar(50),
	@idCliente		varchar(100)	= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showItem' BEGIN
	declare @@socioDesde datetime, @@fechaExpira datetime, @@lote int, @@manzana varchar(10)
	set @@socioDesde = getDate()
	set @@fechaExpira =  dateadd(year, 5, getDate())
	--select @@fechaExpira = valor from configuracion where item='expira credencial'

	select top(1) @@socioDesde = fecha_vencimiento
	from documentos where id_cliente=@idCliente
	and fecha_vencimiento>'1950-01-01'
	order by fecha_vencimiento
	
	select top(1) @@lote= numlote, @@manzana = m.manzana
	from lotes l 
	inner join manzanas m on l.id_manzana=m.id_manzana
	where l.id_cliente= @idCliente

	select year(@@socioDesde) fecha_ingreso, year(@@fechaExpira) fecha_expira
	, id_cliente idCliente, concat(nombre,' ', ap_paterno, ' ', ap_materno) as "nombre"
	,concat(nombre,' ', ap_paterno) as "nombreReferencia"
	, @@lote lote, @@manzana manzana, referencia
	from clientes 	
	where id_cliente = @idCliente
END
--------------------------------------------------------------------------------------------------------
--
RETURN
--
GO