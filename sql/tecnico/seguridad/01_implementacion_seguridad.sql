USE ProyectoFerreteria;
GO


--  implementacion de seguridad



-- 1. crear rol de aplicacion para operadores
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_operador_ventas' AND type = 'R')
BEGIN
    CREATE ROLE rol_operador_ventas;
END;
GO

-- 2. denegar acceso directo de escritura a la tabla cliente
DENY INSERT, UPDATE, DELETE ON dbo.CLIENTE TO rol_operador_ventas;
GO

-- 3. conceder lectura sobre la tabla cliente
GRANT SELECT ON dbo.CLIENTE TO rol_operador_ventas;
GO

-- 4. conceder permiso de ejecucion sobre los procedimientos almacenados crud
GRANT EXECUTE ON dbo.sp_InsertarCliente TO rol_operador_ventas;
GRANT EXECUTE ON dbo.sp_ModificarCliente TO rol_operador_ventas;
GRANT EXECUTE ON dbo.sp_EliminarCliente TO rol_operador_ventas;
GO

-- 5. crear usuario de prueba sin privilegios administrativos
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_vendedor')
BEGIN
    CREATE USER usuario_vendedor WITHOUT LOGIN;
END;
GO

-- 6. asignar el usuario al rol de operador
ALTER ROLE rol_operador_ventas ADD MEMBER usuario_vendedor;
GO
