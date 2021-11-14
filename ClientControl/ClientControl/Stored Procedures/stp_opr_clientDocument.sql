if not exists (select [id] from sysobjects where id = object_id('stp_opr_clientDocument'))
	EXECUTE ('CREATE PROCEDURE stp_opr_clientDocument AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_opr_clientDocument
(
	@method					varchar(50)
	,@idCliente				INT					= NULL
	,@idDocumento			INT					= NULL
	,@monto					decimal(18,2)		= NULL
	,@idPersona				INT					= NULL
	,@fechaInicial			datetime			= NULL
	,@fechaFinal			datetime			= NULL
	,@estatus				tinyint				= NULL
	,@incluirCancelados		tinyint				= NULL
	,@incluirPagados		tinyint				= NULL
	,@value					varchar(50)			= NULL
	,@comentarios			varchar(200)		= NULL
	,@idEstatus				tinyint				= NULL
	,@report				varchar(100)		= NULL
	,@idLote				bigint				= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'getDocuments' BEGIN
	select id_documento as "idDocumento", numero
	, convert(date,isnull(fecha_vencimiento, getDate()),101) as "fechaVencimiento"
	, convert(date,isnull(fecha_pago, getDate()),101) as "fechaPago"
	, total, balance, isnull(balance,0) as monto
	, isnull(l.numlote,0) as "numeroLote", isnull(l.numlote,0) as "lote" 
	, isnull(m.manzana,'')as "manzana"
	, e.estatus, e.id_estatus
	, c.id_cliente as "idCliente" , lower(concat(c.nombre,' ',c.ap_paterno, ' ', c.ap_materno)) as "nombre"
	from documentos d
	inner join clientes c on d.id_cliente= c.id_cliente
	left join estatus e on d.id_estatus = e.id_estatus and e.tipo=1
	left join lotes l on d.id_lote = l.id_lote
	inner join manzanas m on l.id_manzana = m.id_manzana
	where d.fecha_vencimiento<=isnull(@fechaInicial,d.fecha_vencimiento)
	--and d.fecha_vencimiento<=@fechaFinal+1
	and d.id_cliente = isnull(@idCliente, d.id_cliente)
	and d.id_estatus = isnull(@idEstatus, d.id_estatus)
	and d.id_lote= isnull(@idLote, d.id_lote)
	order by fechaVencimiento
END
--------------------------------------------------------------------------------------------------------
else IF @method = 'searchItem' BEGIN
	select id_documento as "idDocumento", numero
	, convert(date,isnull(fecha_vencimiento, getDate()),101) as "fechaVencimiento"
	, convert(date,isnull(fecha_pago, getDate()),101) as "fechaPago"
	, total, balance, isnull(numero_lote,0) as "numeroLote"
	, isnull(balance,0) as monto
	, isnull(manzana,'')as "manzana"
	, e.estatus, e.id_estatus
	, c.id_cliente as "idCliente" , lower(concat(c.nombre,' ',c.ap_paterno, ' ', c.ap_materno)) as "nombre"
	from documentos d
	inner join clientes c on d.id_cliente= d.id_cliente
	left join estatus e on d.id_estatus = e.id_estatus and e.tipo=1
	where d.fecha_vencimiento<=@fechaInicial
	--and d.id_cliente = isnull(@idCliente, d.id_cliente)
	and isnull(c.id_estatus,0) <> 4
	and (ap_paterno like '%' + @value + '%'
		or ap_materno like '%' + @value + '%'
		or nombre like '%' + @value + '%'
		or concat(nombre, ' ', ap_paterno, ' ', ap_materno) like '%' + @value + '%'
		)
	and d.id_estatus = isnull(@idEstatus, d.id_estatus)

	order by fechaVencimiento
END
ELSE IF @method = 'getRptDocuments' BEGIN
	declare @@cantidad int

	select id_documento as "idDocumento", numero
	, convert(date,isnull(fecha_vencimiento, getDate()),101) as "fechaVencimiento"
	, convert(date,isnull(fecha_pago, getDate()),101) as "fechaPago"
	, total, balance, isnull(balance,0) as monto
	, isnull(l.numlote,0) as "numeroLote", isnull(l.numlote,0) as "lote" 
	, isnull(m.manzana,'')as "manzana"
	, e.estatus, e.id_estatus
	, c.id_cliente as "idCliente" , upper(concat(c.nombre,' ',c.ap_paterno, ' ', c.ap_materno)) as "nombre"
	into #clientData
	from documentos d
	inner join clientes c on d.id_cliente= c.id_cliente
	left join estatus e on d.id_estatus = e.id_estatus and e.tipo=1
	left join lotes l on d.id_lote = l.id_lote
	inner join manzanas m on l.id_manzana = m.id_manzana
	where d.fecha_vencimiento<=isnull(@fechaInicial,d.fecha_vencimiento)
	--and d.fecha_vencimiento<=@fechaFinal+1
	and d.id_cliente = isnull(@idCliente, d.id_cliente)
	and d.id_estatus = isnull(@idEstatus, d.id_estatus)
	and d.id_lote= isnull(@idLote, d.id_lote)
	--order by d.numero
	set @@cantidad=@@ROWCOUNT

	select @@cantidad as "cantidad",dbo.[CantidadConLetra](total) as totalCantidad,* from #clientData
	order by numero
	drop table #clientData
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' BEGIN
	select id_documento as "idDocumento", numero, numero numeroPagare
	, convert(date,isnull(fecha_vencimiento, getDate()),101) as "fechaVencimiento"
	, convert(date,isnull(fecha_pago, getDate()),101) as "fechaPago"
	, total, balance, isnull(numero_lote,0) as "numeroLote"
	, isnull(manzana,'')as "manzana", d.id_lote idLote
	, e.estatus, e.id_estatus, isnull(d.balance,0) as monto
	, c.id_cliente as "idCliente" , lower(concat(c.nombre,' ',c.ap_paterno, ' ', c.ap_materno)) as "nombre"
	from documentos d
	inner join clientes c on d.id_cliente= c.id_cliente
	left join estatus e on d.id_estatus = e.id_estatus and e.tipo=1
	where d.fecha_vencimiento<=isnull(@fechaInicial, d.fecha_vencimiento)
	and c.id_estatus<>4
	and d.id_cliente = isnull(@idCliente, d.id_cliente)
	and d.id_estatus = isnull(@idEstatus, d.id_estatus)
	and isnull(d.id_lote,0) = isnull(@idLote, isnull(d.id_lote,0))
	order by fechaVencimiento
END

--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'cancelDocument' BEGIN
	update documentos set id_estatus=4
	, fecha_cancela = getDate()
	, id_persona_cancela =1
	, comentarios_cancela = @comentarios
	where id_documento=@idDocumento
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'getDocumentToPay' BEGIN
	select id_documento as "idDocumento", numero
	, convert(date,isnull(fecha_vencimiento, getDate()),101) as "fechaVencimiento"
	, total, balance, isnull(numero_lote,0) as "numeroLote"
	, isnull(manzana,'')as "manzana", balance as "monto", balance as "monto_"
	
	from documentos
	where id_cliente = @idCliente
	and balance>0
	and id_estatus<>4
	order by fechaVencimiento
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'getDocumentToCancel' BEGIN
	select id_documento as "idDocumento", numero
	, convert(date,isnull(fecha_vencimiento, getDate()),101) as "fechaVencimiento"
	, total, isnull(numero_lote,0) as lote
	, isnull(manzana,'')as "manzana"
	from documentos
	where id_cliente = @idCliente
	and balance=total
	and id_estatus<>4
	order by fechaVencimiento
END
--------------------------------------------------------------------------------------------------------
--
RETURN
--
GO