if not exists (select [id] from sysobjects where id = object_id('stp_cat_lote'))
	EXECUTE ('CREATE PROCEDURE stp_cat_lote AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_lote
(
	@method				varchar(50)
	,@idLote			INT				= NULL
	,@numLote			INT				= NULL
	,@idManzana			INT				= NULL
	,@tipo				INT				= NULL
	,@superficie		decimal(18,4)	= NULL
	,@idVendedor		varchar(50)		= NULL
	,@porComision		decimal(18,4)	= NULL
	,@value				varchar(100)	= NULL 
	,@idEstatus			int				= NULL
	,@idCliente			int				= NULL
	,@idPersona			int				= NULL
	,@enganche			decimal(18,4)	= NULL

)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'showItem' BEGIN
	select id_lote idLote,numlote numLote, [manzana], [tipo], [superficie], id_vendedor idVendedor,PorcComis as 'porComision'
	, [fechaVenta], id_estatus idEstatus, id_manzana idManzana, id_cliente idCliente, enganche
	from lotes 
	where id_lote = @idLote
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' Begin
	select id_lote as idLote,numlote numLote, m.manzana,[superficie]
		, concat(c.nombre,' ', c.ap_paterno, ' ',c.ap_materno) propietario
		, b.estatus
		, concat(v.nombre,' ', v.ap_paterno, ' ', v.ap_materno) as "vendedor"
		from lotes a
		inner join manzanas m on a.id_manzana =m.id_manzana
		inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=2
		left join clientes c on a.id_cliente = c.id_cliente
		left join vendedores v on a.id_vendedor=v.id_vendedor
	order by manzana, numlote
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveItem' Begin
	IF @idLote is not null begin
		update lotes
		set numlote = @numLote
			,id_cliente = @idCliente
			,tipo = @tipo
			,superficie = @superficie
			,id_vendedor = @idVendedor
			,PorcComis = @porComision
			,id_estatus= @idEstatus
			,id_manzana = @idManzana				
			,enganche = @enganche
			where id_lote = @idLote
		end
	else
		insert into lotes(numlote,id_cliente,tipo,superficie,id_vendedor,PorcComis,id_estatus,id_manzana,id_persona, enganche) 
		values(@numLote,@idCliente,@tipo,@superficie,@idVendedor,@porComision,@idEstatus,@idManzana, @idPersona, @enganche)
END
--------------------------------------------------------------------------------------------------------
else if @method = 'searchItem' begin
		select id_lote as idLote,numlote numLote, m.manzana,[superficie]
		, concat(c.nombre,' ', c.ap_paterno, ' ',c.ap_materno) propietario
		, b.estatus
		, concat(v.nombre,' ', v.ap_paterno, ' ', v.ap_materno) as "vendedor"
		from lotes a
		inner join manzanas m on a.id_manzana=m.id_manzana
		inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=2
		left join clientes c on a.id_cliente = c.id_cliente
		left join vendedores v on a.id_vendedor=v.id_vendedor
		where numlote = @value
end
--------------------------------------------------------------------------------------------------------
else if @method = 'searchItemByManzana' begin
		select id_lote as idLote,numlote numLote, m.[manzana],[superficie]
		, concat(c.nombre,' ', c.ap_paterno, ' ',c.ap_materno) propietario
		, b.estatus
		, concat(v.nombre,' ', v.ap_paterno, ' ', v.ap_materno) as "vendedor"
		from lotes a
		inner join manzanas m on a.id_manzana=m.id_manzana
		inner join estatus b on a.id_estatus = b.id_estatus and b.tipo=2
		left join clientes c on a.id_cliente = c.id_cliente
		left join vendedores v on a.id_vendedor=v.id_vendedor
		where a.id_manzana=@idManzana
		order by a.numlote
end
--
RETURN
--
GO