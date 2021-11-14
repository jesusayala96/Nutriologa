--UPDATE t1
--  SET t1.id_manzana = t2.id_manzana
--  FROM dbo.colonosOLD AS t1
--  INNER JOIN dbo.manzanas AS t2
--  ON cast(t1.manzana as varchar(10)) = t2.manzana
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--update colonosold set id_manzana =8 where id_manzana is null--35
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--declare @@iStart int, @@jRows int
--create table #loteManzana (id int not null identity(1,1), lote int, id_manzana bigint)

--insert into #loteManzana(lote, id_manzana)
--select lote, id_manzana
--from colonosOLD where id_lote is null
--select	@@iStart = 1, @@jRows = @@rowcount

--declare @@lote int, @@id_manzana bigint, @@id_lote bigint
--select * from #loteManzana
--while	@@iStart <= @@jRows begin
--	select	@@lote=lote, @@id_manzana=id_manzana
--	from	#loteManzana
--	where	id = @@iStart
	
	
--	if not exists(select id_lote from lotes where numlote=@@lote and id_manzana=@@id_manzana)begin
--		insert into lotes (numlote, manzana, [status], id_estatus, id_manzana, id_persona, fecha_creacion) 
--		values(@@lote, @@id_manzana, 'vendido', 2, @@id_manzana, 1,getDate())

--		set @@id_lote=scope_identity()
--	end else begin
--		select @@id_lote=id_lote from lotes where numlote=@@lote and id_manzana=@@id_manzana
--	end
--	update colonosOLD set id_lote=@@id_lote where lote = @@lote and id_manzana=@@id_manzana--actualiza el id del documento para relacionarlo

--	set	@@iStart = @@iStart + 1		
--end
--drop table #loteManzana
-----------------------------------------------------------------------------------------------------------------------------------------------------------
------ASIGNAR LOTES DE COLONOS A CATALOGO LOTES
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--UPDATE t1
--  SET t1.id_cliente = t2.id_cliente
--  FROM dbo.lotes AS t1
--  INNER JOIN dbo.colonosOLD AS t2
--  ON t1.numlote = t2.lote and t1.id_manzana=t2.id_manzana
--  WHERE t1.id_cliente is null; --281
-----------------------------------------------------------------------------------------------------------------------------------------------------------
------actualizar id_lote en colonos
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--UPDATE t1
--  SET t1.id_lote = t2.id_lote
--  FROM dbo.colonosOLD AS t1
--  INNER JOIN dbo.lotes AS t2
--  ON t1.id_cliente = t2.id_cliente
--  WHERE t1.id_lote is null; --264
--select * from colonosOLD where id_cliente is not null
-----------------------------------------------------------------------------------------------------------------------------------------------------------
------VENDER LOTES QUE TIENEN UN CLIENTE ASIGNADO
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--update lotes set id_estatus=2 where id_cliente is not null and id_estatus<>2--65


--UPDATE t1
--  SET t1.id_lote = t2.id_lote, t1.manzana = t2.manzana
--  FROM dbo.documentos AS t1
--  INNER JOIN dbo.colonosOLD AS t2
--  ON t1.id_cliente = t2.id_cliente
--  WHERE t2.id_cliente2 = 0 and t2.id_cliente>0; --6901




