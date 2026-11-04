USE proyectoFerreteria;
GO


-- ETAPA V: Implementacion de procedimientos almacenados


-- 1. insertar cliente
IF OBJECT_ID('sp_InsertarCliente', 'P') IS NOT NULL
    DROP PROCEDURE sp_InsertarCliente;
GO

CREATE PROCEDURE sp_InsertarCliente
    @nombre VARCHAR(50),
    @apellido VARCHAR(50),
    @dni INT,
    @correo VARCHAR(100),
    @id_direccion INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion)
    VALUES (@nombre, @apellido, @dni, @correo, @id_direccion);
END;
GO


-- 2. modificar cliente
IF OBJECT_ID('sp_ModificarCliente', 'P') IS NOT NULL
    DROP PROCEDURE sp_ModificarCliente;
GO

CREATE PROCEDURE sp_ModificarCliente
    @id_cliente INT,
    @nombre VARCHAR(50),
    @apellido VARCHAR(50),
    @dni INT,
    @correo VARCHAR(100),
    @id_direccion INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar que el cliente a modificar exista
    IF EXISTS (SELECT 1 FROM CLIENTE WHERE id_cliente = @id_cliente)
    BEGIN
        UPDATE CLIENTE
        SET nombre = @nombre,
            apellido = @apellido,
            dni = @dni,
            correo = @correo,
            id_direccion = @id_direccion
        WHERE id_cliente = @id_cliente;
    END
    ELSE
    BEGIN
        PRINT 'El cliente especificado no existe.';
    END
END;
GO


-- 3. eliminar cliente
IF OBJECT_ID('sp_EliminarCliente', 'P') IS NOT NULL
    DROP PROCEDURE sp_EliminarCliente;
GO

CREATE PROCEDURE sp_EliminarCliente
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar que el cliente exista antes de dar de baja
    IF EXISTS (SELECT 1 FROM CLIENTE WHERE id_cliente = @id_cliente)
    BEGIN
        UPDATE CLIENTE
        SET eliminado_en = GETDATE()
        WHERE id_cliente = @id_cliente;
    END
    ELSE
    BEGIN
        PRINT 'El cliente especificado no existe.';
    END
END;
GO
