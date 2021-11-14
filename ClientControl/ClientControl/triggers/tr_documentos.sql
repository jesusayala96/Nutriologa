USE [Client_Control]
GO

/****** Object:  Trigger [dbo].[tr_documentos]    Script Date: 22/06/2019 12:01:07 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_documentos] ON [dbo].[documentos] 
 
AFTER INSERT, UPDATE, DELETE
AS
--------------------------------------------------------------------------------------------------------
	declare	@@insCount			int
			, @@delCount			int 
	
	select	@@insCount = count(id_documento) from inserted
	select	@@delCount = count(id_documento) from deleted
	
	declare @@documento table(id_documento int, id_estatus int)
--------------------------------------------------------------------------------------------------------	
	if @@insCount > 0 and @@delCount = 0 begin			--INSERT
		print 'INSERT'
	end
--------------------------------------------------------------------------------------------------------
	else if @@insCount > 0 and @@delCount > 0 begin		--UPDATE
		if update(balance) begin
			insert into @@documento(id_documento, id_estatus)
				select	id_documento
						, (case id_estatus when 1 then 2 else 1 end)
				from	inserted
				where	(id_estatus = 1 and balance = 0)
						or 
						(id_estatus = 2 and balance > 0)
			
			update	documentos
			set		id_estatus = du.id_estatus
			from	documentos d inner join
					@@documento du on d.id_documento = du.id_documento
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

ALTER TABLE [dbo].[documentos] ENABLE TRIGGER [tr_documentos]
GO


