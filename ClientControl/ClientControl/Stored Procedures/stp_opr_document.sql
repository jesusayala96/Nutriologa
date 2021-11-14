if not exists (select [id] from sysobjects where id = object_id('stp_opr_document'))
	EXECUTE ('CREATE PROCEDURE stp_opr_document AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_opr_document
(
	 @method				varchar(50)
	,@idCliente			INT				= NULL
	,@idDocumento		INT				= NULL
	,@monto				decimal(18,2)	= NULL
	,@folioLote			int				= NULL
	,@fechaPago			DATE			= NULL
	,@numeroPagare		INT				= NULL
	,@fechaVencimiento	DATE			= NULL
	,@idPersona			INT				= NULL
	
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showLotes' BEGIN
select l.id_lote as folioLote, CONCAT('Manzana:',l.manzana,' Lote:',l.numlote) as 'lote' from lotes l
INNER JOIN clientes c ON l.id_cliente = c.id_cliente
where @idCliente = c.id_cliente
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveDocument' BEGIN
declare @@numLote INT
declare @@manzana VARCHAR(10)
select @@numLote=numlote,@@manzana = manzana from lotes where id_lote = @folioLote
	insert into documentos(id_cliente,numero,id_lote,fecha_vencimiento,fecha_creacion,total,balance,id_estatus,numero_lote,manzana, id_persona)
	values(@idCliente,@numeroPagare,@folioLote,@fechaVencimiento,GETDATE(),@monto,@monto,1,@@numLote,@@manzana, @idPersona)
END
--------------------------------------------------------------------------------------------------------
--
RETURN
--
GO