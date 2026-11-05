USE ProyectoFerreteria;
GO

IF OBJECT_ID('dbo.sp_InsertarCliente', 'P') IS NULL
    THROW 56001, 'No existe dbo.sp_InsertarCliente. Ejecute primero 01_implementacion_procedimientos.sql.', 1;
GO

-- Se conserva el rol existente para los operadores.
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_operador_ventas' AND type = 'R')
BEGIN
    CREATE ROLE rol_operador_ventas;
END;
GO

DENY INSERT, UPDATE, DELETE ON dbo.CLIENTE TO rol_operador_ventas;
GRANT SELECT ON dbo.CLIENTE TO rol_operador_ventas;
GRANT EXECUTE ON dbo.sp_InsertarCliente TO rol_operador_ventas;
GRANT EXECUTE ON dbo.sp_ModificarCliente TO rol_operador_ventas;
GRANT EXECUTE ON dbo.sp_EliminarCliente TO rol_operador_ventas;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_vendedor')
BEGIN
    CREATE USER usuario_vendedor WITHOUT LOGIN;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_role_members AS drm
    INNER JOIN sys.database_principals AS r
        ON r.principal_id = drm.role_principal_id
    INNER JOIN sys.database_principals AS u
        ON u.principal_id = drm.member_principal_id
    WHERE r.name = 'rol_operador_ventas'
      AND u.name = 'usuario_vendedor'
)
    ALTER ROLE rol_operador_ventas ADD MEMBER usuario_vendedor;
GO

-- Usuario administrador de prueba: db_owner permite administrar la base.
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_administrador')
    CREATE USER usuario_administrador WITHOUT LOGIN;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_role_members AS drm
    INNER JOIN sys.database_principals AS r
        ON r.principal_id = drm.role_principal_id
    INNER JOIN sys.database_principals AS u
        ON u.principal_id = drm.member_principal_id
    WHERE r.name = 'db_owner'
      AND u.name = 'usuario_administrador'
)
    ALTER ROLE db_owner ADD MEMBER usuario_administrador;
GO

-- Rol de lectura con escritura directa denegada y alta controlada por procedimiento.
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_lectura' AND type = 'R')
    CREATE ROLE rol_lectura;
GO

GRANT SELECT ON dbo.CLIENTE TO rol_lectura;
DENY INSERT, UPDATE, DELETE ON dbo.CLIENTE TO rol_lectura;
GRANT EXECUTE ON OBJECT::dbo.sp_InsertarCliente TO rol_lectura;
GO

-- Dos usuarios de prueba comparten exactamente los permisos del rol.
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_lectura_1')
    CREATE USER usuario_lectura_1 WITHOUT LOGIN;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usuario_lectura_2')
    CREATE USER usuario_lectura_2 WITHOUT LOGIN;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_role_members AS drm
    INNER JOIN sys.database_principals AS r
        ON r.principal_id = drm.role_principal_id
    INNER JOIN sys.database_principals AS u
        ON u.principal_id = drm.member_principal_id
    WHERE r.name = 'rol_lectura'
      AND u.name = 'usuario_lectura_1'
)
    ALTER ROLE rol_lectura ADD MEMBER usuario_lectura_1;

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_role_members AS drm
    INNER JOIN sys.database_principals AS r
        ON r.principal_id = drm.role_principal_id
    INNER JOIN sys.database_principals AS u
        ON u.principal_id = drm.member_principal_id
    WHERE r.name = 'rol_lectura'
      AND u.name = 'usuario_lectura_2'
)
    ALTER ROLE rol_lectura ADD MEMBER usuario_lectura_2;
GO
