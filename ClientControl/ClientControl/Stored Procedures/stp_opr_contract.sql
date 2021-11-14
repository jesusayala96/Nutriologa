if not exists (select [id] from sysobjects where id = object_id('stp_opr_contract'))
	EXECUTE ('CREATE PROCEDURE stp_opr_contract AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_opr_contract
(
	@method				varchar(50)
	,@idLote			INT				= NULL
	,@idCliente			INT				= NULL

)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showByClient' BEGIN
declare @@firstDate date;
select SUM(total) as amount,id_cliente, id_lote, COUNT(id_documento) pagaresQuantity, Avg(total) as amountPagares
into #data
from documentos 
where id_cliente = @idCliente and id_lote = @idLote
group by id_cliente,id_lote


select top 1 @@firstDate = fecha_pago
from documentos where id_cliente = @idCliente and id_lote = @idLote
order by fecha_pago asc

select CONCAT(c.nombre,' ',c.ap_paterno,' ',c.ap_materno) as clientName,
		CONCAT(c.dom_calle,' #',c.dom_num,', ',c.dom_colonia,', ',c.dom_ciudad,', ',c.dom_estado) as clientAddress,
		00 as clientCP,
		c.tel_casa as clientPhone,
		ISNULL(l.fechaVenta,@@firstDate) as [date],
		l.numlote as lote,
		l.manzana as manzana,
		l.superficie as superficie,
		d.amount as amount,
		dbo.[CantidadConLetra](d.amount) as textAmount,
		0 as enganche,
		dbo.[CantidadConLetra](0) AS textEnganche,
		d.amount as saldo,
		dbo.[CantidadConLetra](d.amount)as textSaldo,
		--@@firstDate as [date],
		@@firstDate as fechaPagares,
		d.amountPagares as amountPagares,
		dbo.[CantidadConLetra](d.amountPagares)as textAmountPagares,
		d.pagaresQuantity as pagaresQuantity,
		0 as xAmount,
		dbo.[CantidadConLetra](0)as textXAmount


from 
clientes c
INNER JOIN lotes l ON c.id_cliente = l.id_cliente
INNER JOIN #data d ON c.id_cliente = d.id_cliente


drop table #data

END
--
RETURN
--
GO