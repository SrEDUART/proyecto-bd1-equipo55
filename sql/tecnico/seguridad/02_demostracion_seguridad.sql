USE ProyectoFerreteria;
GO

IF OBJECT_ID('dbo.sp_InsertarCliente', 'P') IS NULL
    THROW 56002, 'No existe dbo.sp_InsertarCliente. Ejecute primero 01_implementacion_procedimientos.sql y 01_implementacion_seguridad.sql.', 1;
GO

IF USER_ID('usuario_administrador') IS NULL
   OR USER_ID('usuario_lectura_1') IS NULL
   OR USER_ID('usuario_lectura_2') IS NULL
    THROW 56003, 'Faltan usuarios de prueba. Ejecute primero 01_implementacion_seguridad.sql.', 1;
GO

SET NOCOUNT ON;

SELECT CASE CONVERT(INT, SERVERPROPERTY('IsIntegratedSecurityOnly'))
           WHEN 0 THEN 'Autenticacion mixta habilitada'
           WHEN 1 THEN 'Solo autenticacion de Windows'
       END AS modo_autenticacion_instancia;

DECLARE @id_direccion INT;
DECLARE @dni_admin INT;
DECLARE @dni_lectura_1 INT;
DECLARE @dni_lectura_2 INT;
DECLARE @correo_admin VARCHAR(100);
DECLARE @correo_lectura_1 VARCHAR(100);
DECLARE @correo_lectura_2 VARCHAR(100);
DECLARE @denegado_lectura_1 BIT = 0;
DECLARE @denegado_lectura_2 BIT = 0;
DECLARE @impersonando BIT = 0;

SELECT TOP (1) @id_direccion = id_direccion
FROM dbo.DIRECCION
ORDER BY id_direccion;

IF @id_direccion IS NULL
    THROW 56004, 'No hay direcciones disponibles para las pruebas de CLIENTE.', 1;

SET @dni_admin = CONVERT(INT, CHECKSUM(NEWID()) & 2147483647);
WHILE @dni_admin = 0 OR EXISTS (SELECT 1 FROM dbo.CLIENTE WHERE dni = @dni_admin)
    SET @dni_admin = CONVERT(INT, CHECKSUM(NEWID()) & 2147483647);

SET @dni_lectura_1 = CONVERT(INT, CHECKSUM(NEWID()) & 2147483647);
WHILE @dni_lectura_1 = 0
   OR @dni_lectura_1 = @dni_admin
   OR EXISTS (SELECT 1 FROM dbo.CLIENTE WHERE dni = @dni_lectura_1)
    SET @dni_lectura_1 = CONVERT(INT, CHECKSUM(NEWID()) & 2147483647);

SET @dni_lectura_2 = CONVERT(INT, CHECKSUM(NEWID()) & 2147483647);
WHILE @dni_lectura_2 = 0
   OR @dni_lectura_2 IN (@dni_admin, @dni_lectura_1)
   OR EXISTS (SELECT 1 FROM dbo.CLIENTE WHERE dni = @dni_lectura_2)
    SET @dni_lectura_2 = CONVERT(INT, CHECKSUM(NEWID()) & 2147483647);

SET @correo_admin = CONCAT('seguridad.admin.', CONVERT(VARCHAR(36), NEWID()), '@example.test');
SET @correo_lectura_1 = CONCAT('seguridad.lectura1.', CONVERT(VARCHAR(36), NEWID()), '@example.test');
SET @correo_lectura_2 = CONCAT('seguridad.lectura2.', CONVERT(VARCHAR(36), NEWID()), '@example.test');

BEGIN TRY
    BEGIN TRANSACTION;

    PRINT '--- ADMINISTRADOR: insercion directa y lectura permitidas ---';
    EXECUTE AS USER = 'usuario_administrador';
    SET @impersonando = 1;

    INSERT INTO dbo.CLIENTE (nombre, apellido, dni, correo, id_direccion)
    VALUES ('Prueba', 'Administrador', @dni_admin, @correo_admin, @id_direccion);

    SELECT id_cliente, nombre, apellido, dni, correo
    FROM dbo.CLIENTE
    WHERE correo = @correo_admin;

    REVERT;
    SET @impersonando = 0;

    PRINT '--- LECTOR 1: SELECT permitido, INSERT directo denegado, procedimiento permitido ---';
    EXECUTE AS USER = 'usuario_lectura_1';
    SET @impersonando = 1;

    SELECT TOP (1) id_cliente, nombre, apellido
    FROM dbo.CLIENTE
    ORDER BY id_cliente;

    BEGIN TRY
        INSERT INTO dbo.CLIENTE (nombre, apellido, dni, correo, id_direccion)
        VALUES ('Prueba', 'Directa1', @dni_lectura_1, @correo_lectura_1, @id_direccion);
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 229
            THROW;

        SET @denegado_lectura_1 = 1;
        SELECT ERROR_NUMBER() AS numero_error_esperado, ERROR_MESSAGE() AS mensaje_esperado;
    END CATCH;

    IF @denegado_lectura_1 = 0
        THROW 56005, 'El INSERT directo del primer usuario de lectura no fue rechazado.', 1;

    EXEC dbo.sp_InsertarCliente
        @nombre = 'Prueba',
        @apellido = 'Procedimiento1',
        @dni = @dni_lectura_1,
        @correo = @correo_lectura_1,
        @id_direccion = @id_direccion;

    SELECT id_cliente, nombre, apellido, dni, correo
    FROM dbo.CLIENTE
    WHERE correo = @correo_lectura_1;

    REVERT;
    SET @impersonando = 0;

    PRINT '--- LECTOR 2: mismos permisos heredados del rol ---';
    EXECUTE AS USER = 'usuario_lectura_2';
    SET @impersonando = 1;

    SELECT TOP (1) id_cliente, nombre, apellido
    FROM dbo.CLIENTE
    ORDER BY id_cliente;

    BEGIN TRY
        INSERT INTO dbo.CLIENTE (nombre, apellido, dni, correo, id_direccion)
        VALUES ('Prueba', 'Directa2', @dni_lectura_2, @correo_lectura_2, @id_direccion);
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 229
            THROW;

        SET @denegado_lectura_2 = 1;
        SELECT ERROR_NUMBER() AS numero_error_esperado, ERROR_MESSAGE() AS mensaje_esperado;
    END CATCH;

    IF @denegado_lectura_2 = 0
        THROW 56006, 'El INSERT directo del segundo usuario de lectura no fue rechazado.', 1;

    EXEC dbo.sp_InsertarCliente
        @nombre = 'Prueba',
        @apellido = 'Procedimiento2',
        @dni = @dni_lectura_2,
        @correo = @correo_lectura_2,
        @id_direccion = @id_direccion;

    SELECT id_cliente, nombre, apellido, dni, correo
    FROM dbo.CLIENTE
    WHERE correo = @correo_lectura_2;

    REVERT;
    SET @impersonando = 0;

    ROLLBACK TRANSACTION;
END TRY
BEGIN CATCH
    IF @impersonando = 1
        REVERT;

    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;

PRINT '--- Limpieza: ninguna fila temporal debe permanecer ---';
SELECT id_cliente, correo
FROM dbo.CLIENTE
WHERE correo IN (@correo_admin, @correo_lectura_1, @correo_lectura_2);
GO
