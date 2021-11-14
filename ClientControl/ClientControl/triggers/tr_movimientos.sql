USE [Client_Control]
GO

/****** Object:  Trigger [dbo].[tr_movimientos]    Script Date: 22/06/2019 01:48:35 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*****************************************************************************/
CREATE TRIGGER [dbo].[tr_movimientos] ON [dbo].[movimientos] 
--WITH ENCRYPTION
AFTER INSERT, UPDATE, DELETE
AS
--------------------------------------------------------------------------------------------------------
	declare	@@idDoc			bigint
			, @@idC			bigint
			, @@monto		decimal(18,2)
			, @@fecha		datetime
			, @@insCount	int
			, @@delCount	int 
			, @@idPago		int
			, @@idEstatus	tinyint
	select	@@insCount = count(id_movimiento) from inserted
	select	@@delCount = count(id_movimiento) from deleted
--------------------------------------------------------------------------------------------------------	
	if @@insCount > 0 and @@delCount = 0 begin			--INSERT
		select	@@idDoc = a.id_documento
				, @@monto = a.monto
				, @@fecha = a.fecha_creacion
		from	inserted a				
				LEFT JOIN documentos c on a.id_documento = c.id_documento
		------------------------------------------------------------------------------------
		update	documentos
		set		balance = balance - @@monto, fecha_pago = @@fecha
		where	id_documento = @@idDoc
	end
--------------------------------------------------------------------------------------------------------
	else if @@insCount > 0 and @@delCount > 0 begin		--UPDATE
		if update(id_estatus) begin
			declare @@movementUpdated table(idCliente int, idDocumento bigint, monto decimal(18,2), idPago bigint, idMovimiento bigint, idEstatus tinyint)
		

			insert into @@movementUpdated
				select	d.id_cliente
						, d.id_documento
						, mi.monto
						, mi.id_pago
						, mi.id_movimiento
						, mi.id_estatus
				from	inserted mi inner join
						deleted md on mi.id_movimiento = md.id_movimiento
						LEFT JOIN documentos d on md.id_documento = d.id_documento
				where	mi.id_estatus = 4
						and md.id_estatus <> 4
			
			if @@rowcount > 0 begin	
			   	------------------------------------------------------------------------------------
				select @@idC=idCliente, @@monto=monto, @@idPago=idPago, @@idEstatus = idEstatus
				from @@movementUpdated
				------------------------------------------------------------------------------------
				if(@@idEstatus=4)begin
					update	documentos
					set		balance = balance + m.monto
					from	documentos d inner join
							@@movementUpdated m on d.id_documento = m.idDocumento
				end else begin
					update	documentos
					set		balance = balance - m.monto
					from	documentos d inner join
							@@movementUpdated m on d.id_documento = m.idDocumento
				end
			end
		end
	end
--------------------------------------------------------------------------------------------------------
	else if @@insCount = 0 and @@delCount > 0 begin		--DELETE
		print 'Delete'	
	    --RAISERROR('ESTOS REGISTROS NO PUEDEN SER ELIMINADOS, DEBEN SER CANCELADOS POR SISTEMA', 16, 1)
	end
--------------------------------------------------------------------------------------------------------
--

GO

ALTER TABLE [dbo].[movimientos] ENABLE TRIGGER [tr_movimientos]
GO


