  --insert into clientes([cliente_bk],[ap_paterno],[ap_materno],[nombre],[RFC]
  --    ,[ocupacion],[dom_calle],[dom_num],[dom_colonia],[dom_ciudad],[dom_estado]
  --    ,[tel_casa],[email],[observaciones],[fecha_creacion],[id_estatus],[id_persona])

	 -- select id_cliente,ap_pat_cliente, ap_mat_cliente, nom_cliente, RFC_cliente
	 -- ,profesion, calle_cliente, numdom_cliente, colonia_cliente, cuidad_cliente, edo_dom_cliente
	 -- , tel_casacliente, email_cliente, observaciones, getDate(),1,1
	 -- from clientesOLD



--select * from PAGO_CLIENTESOLD where monto>isnull(total,0)

--UPDATE t1
--  SET t1.id_cliente = t2.id_cliente
--  FROM dbo.PAGO_CLIENTESOLD AS t1
--  INNER JOIN dbo.clientes AS t2
--  ON t1.cliente_bk = t2.cliente_bk
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
------GENERAR PAGARES--------------------
--declare @@iStart int, @@jRows int
--create table #PAGO_CLIENTESOLD (id int not null identity(1,1), folio int, id_cliente bigint, fecha_vence date, fecha_pagado datetime, monto decimal(18,2), observaciones varchar(200), numero int)

--insert into #PAGO_CLIENTESOLD(folio, id_cliente, fecha_vence, fecha_pagado, monto, observaciones, numero)
--select folio, id_cliente, fechavence, fechapagado, monto, observaciones, numpagare
--from PAGO_CLIENTESOLD where id_documento is null
--select	@@iStart = 1, @@jRows = @@rowcount

--declare @@folio int, @@id_cliente bigint, @@fechaVence date, @@monto decimal(18,2), @@observaciones varchar(200), @@numero int, @@id_documento bigint
--while	@@iStart <= @@jRows begin
--	select	@@folio=folio, @@fechaVence=fecha_vence, @@monto=monto, @@observaciones=observaciones, @@numero=numero, @@id_cliente = id_cliente
--	from	#PAGO_CLIENTESOLD
--	where	id = @@iStart
--		insert into documentos (id_cliente, numero, fecha_vencimiento, fecha_creacion, total, balance, id_estatus, id_persona) 
--		values(@@id_cliente, @@numero, @@fechaVence, getDate(), @@monto, @@monto, 1, 1)

--		set @@id_documento=scope_identity()

--		update PAGO_CLIENTESOLD set id_documento=@@id_documento where folio = @@folio--actualiza el id del documento para relacionarlo
--	set	@@iStart = @@iStart + 1		
--end
--drop table #PAGO_CLIENTESOLD
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------CANCELAR PAGARES CON MONTO NULL-----------------------------------------------------------------------------------------------------------------------
 --update documentos set id_estatus=4  where total is null--22
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------GENERAR PAGOS-----------------------------------------------------------------------------------------------------------------------------------------
--declare @@iStart int, @@jRows int
--create table #PAGO_CLIENTESOLD (id int not null identity(1,1), folio int, id_cliente bigint, fecha_vence date, fecha_pagado datetime, monto decimal(18,2), observaciones varchar(200), numero int
--, total decimal(18,2), id_documento bigint)

--insert into #PAGO_CLIENTESOLD(folio, id_cliente, fecha_vence, fecha_pagado, monto, observaciones, numero, total, id_documento)
--select folio, id_cliente, fechavence, fechapagado, monto, observaciones, numpagare, total, id_documento
--from PAGO_CLIENTESOLD where id_documento is not null and total is not null
--select	@@iStart = 1, @@jRows = @@rowcount

--declare @@folio int, @@id_cliente bigint, @@fechaVence date, @@monto decimal(18,2), @@observaciones varchar(200), @@numero int, @@id_documento bigint, @@id_pago bigint,@@totalCubierto decimal(18,2)
--while	@@iStart <= @@jRows begin
--	select	@@folio=folio, @@fechaVence=fecha_vence, @@monto=monto, @@observaciones=observaciones, @@numero=numero, @@id_cliente = id_cliente, @@totalCubierto = total, @@id_documento=id_documento
--	from	#PAGO_CLIENTESOLD
--	where	id = @@iStart
--		insert into pagos (id_cliente, id_tipoPago, referencia, monto, id_persona, id_estatus, fecha_creacion, comentarios) 
--		values(@@id_cliente, 1, 'INICIO SISTEMA',@@totalCubierto, 1, 1, getDate(), 'RESPALDO')

--		set @@id_pago=scope_identity()
		
--		insert into movimientos(id_documento, id_pago, referencia, fecha_creacion, monto, id_persona, id_estatus)
--		values(@@id_documento, @@id_pago, 'inicio sistema', getDate(), @@totalCubierto, 1, 1)
--	set	@@iStart = @@iStart + 1		
--end
--drop table #PAGO_CLIENTESOLD
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--update documentos set id_estatus=2 where balance<0--264
	
	