if not exists (select [id] from sysobjects where id = object_id('stp_opr_clientPayment'))
	EXECUTE ('CREATE PROCEDURE stp_opr_clientPayment AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_opr_clientPayment
(
	@method				varchar(50)
	,@idCliente			INT					= NULL
	,@idDocumento		INT					= NULL
	,@idPago			INT					= NULL
	,@referencia		varchar(50)			= NULL
	,@monto				decimal(18,2)		= NULL
	,@idPersona			INT					= NULL
	,@fechaInicial		datetime			= NULL
	,@fechaFinal		datetime			= NULL
	,@value				varchar(50)			= NULL
	,@comentarios		varchar(200)		= NULL
	,@idEstatus			tinyint				= NULL
	,@penalizacion		decimal(18,2)		= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON

--------------------------------------------------------------------------------------------------------
IF @method = 'getPayments' BEGIN
	select id_pago idPago, referencia, monto, fecha_creacion as fecha, comentarios, penalizacion
	from pagos
	where id_cliente = @idCliente
	and id_estatus<>4
	order by fecha_creacion desc
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'savePayment' BEGIN
	insert into pagos(id_cliente, id_tipoPago, monto, id_persona, id_estatus, fecha_creacion, comentarios, penalizacion)
	values(@idCliente, 1,@monto,@idPersona, 1, getDate(), @referencia,@penalizacion)
	select SCOPE_IDENTITY()
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'cancelPayment' BEGIN
	update pagos set id_estatus=4
	, fecha_cancela = getDate()
	, id_persona_cancela =@idPersona
	, comentarios_cancela = @comentarios
	where id_pago=@idPago

	update movimientos set id_estatus=4 where id_pago=@idPago
	
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveMovement' BEGIN
	insert into movimientos(id_documento, id_pago, fecha_creacion, monto, id_persona, id_estatus)
	values(@idDocumento, @idPago, getDate(),@monto,@idPersona,1)
	select SCOPE_IDENTITY()
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' BEGIN
	select c.id_cliente as "idCliente", lower(concat(c.nombre,' ',c.ap_paterno, ' ', c.ap_materno)) as "nombre"
	, p.id_pago as "idPago", p.monto, p.comentarios, p.fecha_creacion as "fechaPago", isnull(p.penalizacion,0) as penalizacion
	from pagos p
	inner join clientes c on p.id_cliente= c.id_cliente
	where p.fecha_creacion>=@fechaInicial
	and p.fecha_creacion<=@fechaFinal+1
	and p.id_estatus=@idEstatus
	--and p.id_cliente = isnull(@idCliente, p.id_cliente)
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'searchItem' BEGIN
	select c.id_cliente as "idCliente", lower(concat(c.nombre,' ',c.ap_paterno, ' ', c.ap_materno)) as "nombre"
	, p.id_pago as "idPago", p.monto, p.comentarios, p.fecha_creacion as "fechaPago", isnull(p.penalizacion,0) as penalizacion
	from pagos p
	inner join clientes c on p.id_cliente= c.id_cliente
	where p.fecha_creacion>=@fechaInicial
	and p.fecha_creacion<=@fechaFinal+1
	--and p.id_cliente = isnull(@idCliente, p.id_cliente)
	and (ap_paterno like '%' + @value + '%'
		or ap_materno like '%' + @value + '%'
		or nombre like '%' + @value + '%'
		or concat(nombre, ' ', ap_paterno, ' ', ap_materno) like '%' + @value + '%'
	)
	and p.id_estatus=@idEstatus
END
--------------------------------------------------------------------------------------------------------
--
RETURN
--
GO