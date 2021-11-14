if not exists (select  [id]  from sysobjects where [id] = object_id('stp_cat_client'))
	EXECUTE ('create PROCEDURE stp_cat_client AS')
GO
/*****************************************************************************/
ALTER PROCEDURE [stp_cat_client]
(
	 @method			varchar(50)			= NULL
	 ,@idCliente		bigint				= NULL
	 ,@apPaterno		varchar(100)		= NULL
	 ,@apMaterno		varchar(100)		= NULL
	 ,@nombre			varchar(100)		= NULL
	 ,@rfc				varchar(100)		= NULL
	 ,@ocupacion		varchar(100)		= NULL
	 ,@domCalle			varchar(100)		= NULL
	 ,@domNum			varchar(100)		= NULL
	 ,@domColonia		varchar(100)		= NULL
	 ,@domCiudad		varchar(100)		= NULL
	 ,@domEstado		varchar(100)		= NULL 
	 ,@cp				int					= NULL
	 ,@telCasa			varchar(100)		= NULL
	 ,@telOficina		varchar(100)		= NULL
	 ,@celular			varchar(100)		= NULL 
	 ,@nextel			varchar(100)		= NULL
	 ,@email			varchar(100)		= NULL
     ,@nomContacto		varchar(100)		= NULL
	 ,@telContacto		varchar(100)		= NULL
	 ,@edoCivil			varchar(100)		= NULL
	 ,@numHijos			int					= null
	 ,@diaPago			int					= NULL
	 ,@numPagos			int					= NULL
	 ,@mensualidad		decimal(18,4)		= NULL
     ,@observaciones	varchar(200)		= NULL
	 ,@value			varchar(100)		= NULL
	 ,@idEstatus		tinyint				= NULL
	 ,@idPersona		int					= NULL
	 ,@referencia		varchar(20)			= NULL
)
WITH ENCRYPTION 
AS 
SET NOCOUNT ON
--------------------------------------------------------------------------------------------
if @method = 'showAll' begin
	select  id_cliente idCliente, ap_paterno apPaterno, ap_materno apMaterno, nombre, RFC 
      , tel_casa telCasa, email 
      , observaciones, b.estatus 
		from clientes a
		inner join estatus b on a.id_estatus=b.id_estatus and b.tipo=3
		where a.id_estatus = isnull(@idEstatus, a.id_estatus)
end
--------------------------------------------------------------------------------------------
else if @method = 'showItem' begin
	select  id_cliente idCliente, ap_paterno apPaterno, ap_materno apMaterno, nombre, RFC
      , ocupacion, dom_calle domCalle, dom_num domNum, dom_colonia domColonia, dom_ciudad domCiudad, dom_estado domEstado 
      , tel_casa telCasa, email, referencia
      , observaciones, id_estatus idEstatus
	  , id_cliente as client_id, ap_paterno, ap_materno
		from Client_Control.dbo.clientes
		where id_cliente = isnull(@idCliente, id_cliente)
		and id_estatus = isnull(@idEstatus, id_estatus)		
end
--------------------------------------------------------------------------------------------
else if @method = 'saveItem' begin
	if(@idCliente is not null) begin
		update Client_Control.dbo.clientes
			set ap_paterno=@apPaterno, ap_materno=@apMaterno, nombre=@nombre, RFC=@rfc 
		  , ocupacion=@ocupacion, dom_calle=@domCalle, dom_num=@domNum, dom_colonia=@domColonia, dom_ciudad=@domCiudad, dom_estado=@domEstado 
		  , tel_casa=@telCasa, email= @email
		  , observaciones=@observaciones, id_estatus = @idEstatus
		  , referencia =@referencia
		  where id_cliente = @idCliente
	  end else begin
	  		insert into Client_Control.dbo.clientes(id_cliente, ap_paterno, ap_materno, nombre, RFC 
		  , ocupacion, dom_calle, dom_num, dom_colonia, dom_ciudad, dom_estado 
		  , tel_casa, email 
		  , observaciones, id_estatus, id_persona, referencia)
		  values('',@apPaterno, @apMaterno, @nombre, @rfc
		  ,@ocupacion, @domCalle, @domNum, @domColonia, @domCiudad, @domEstado
		  ,@telCasa, @email
		  ,@observaciones, @idEstatus, @idPersona, @referencia)
	  end
end
--------------------------------------------------------------------------------------------
else if @method = 'searchItem' begin
	select  id_cliente idCliente, ap_paterno apPaterno, ap_materno apMaterno, nombre, RFC 
      , tel_casa telCasa, email 
      , observaciones, b.estatus, referencia
	  , concat(a.nombre,' ', a.ap_paterno, ' ', a.ap_materno) as "nombreCliente"
		from Client_Control.dbo.clientes a
		inner join estatus b on a.id_estatus=b.id_estatus and b.tipo=3
		where (ap_paterno like '%' + @value + '%'
		or ap_materno like '%' + @value + '%'
		or nombre like '%' + @value + '%'
		or concat(nombre,' ',ap_paterno,' ', ap_materno) like '%' + @value + '%'
		)
		and a.id_estatus = isnull(@idEstatus, a.id_estatus)
end
--------------------------------------------------------------------------------------------

return
--
GO
--
--GRANT  EXECUTE  ON  [stp_cat_client]   TO  [community_user] 
--
GO