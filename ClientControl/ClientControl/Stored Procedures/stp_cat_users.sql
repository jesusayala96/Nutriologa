if not exists (select [id] from sysobjects where id = object_id('stp_cat_users'))
	EXECUTE ('CREATE PROCEDURE stp_cat_users AS')  
GO
/*****************************************************************************/
ALTER PROCEDURE stp_cat_users
(
	@method			varchar(50)
	,@username		varchar(50)		= NULL
	,@password		varchar(50)		= NULL
	,@personId		INT				= NULL
	,@userId		INT				= NULL
	,@nombre		varchar(200)	= NULL
	,@idPersona		int				= NULL
	,@idEstatus		int				= NULL
)
WITH ENCRYPTION
AS
SET NOCOUNT ON
--------------------------------------------------------------------------------------------------------
IF @method = 'getUser' BEGIN
	select [user_id] as personId, username as username
	from usuarios
	where username = @username and [password] = @password
	and id_estatus = 1
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'saveItem' Begin
	IF @userId is not null begin
		update usuarios
		set [username] = @username
			,[password] = @password
			,nombre = @nombre
			,id_estatus = @idEstatus
			where [user_id] = @userId
	end
	else
		insert into [user]([username],[password], nombre, fecha_creacion, id_persona,id_estatus) values(@userName, @password, @nombre, getDate(),@idPersona, @idEstatus)
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showItem' BEGIN
	select [user_id] idUsuario, [username] userName, [password] as "password", nombre, id_estatus idEstatus
	from usuarios
	where [user_id] = @userId
	and [user_id]<>1
END
--------------------------------------------------------------------------------------------------------
ELSE IF @method = 'showAll' Begin
	select [user_id] userId, [username] userName, [password] as "password", nombre
	from usuarios
	where [user_id]<>1
END
--
RETURN
--
GO