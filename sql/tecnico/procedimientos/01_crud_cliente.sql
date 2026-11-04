USE proyectoFerreteria;
GO

-- insertar cliente
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


-- modificar cliente
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


-- eliminar cliente
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


-- pruebas y lote de ejecucion

-- prueba de insercion
EXEC sp_InsertarCliente 'Carlos', 'Benitez', 48999888, 'carlos.benitez@test.com', 31;

-- verificar insercion
SELECT TOP 1 * FROM CLIENTE ORDER BY id_cliente DESC;

-- prueba de modificacion (usando el ultimo cliente cargado)
DECLARE @id_prueba INT = (SELECT MAX(id_cliente) FROM CLIENTE);
EXEC sp_ModificarCliente @id_prueba, 'Carlos Alberto', 'Benitez', 48999888, 'carlos.modificado@test.com', 31;

-- verificar modificacion
SELECT * FROM CLIENTE WHERE id_cliente = (SELECT MAX(id_cliente) FROM CLIENTE);

-- prueba de eliminacion (baja logica)
EXEC sp_EliminarCliente @id_prueba;

-- verificar fecha de eliminacion
SELECT * FROM CLIENTE WHERE id_cliente = (SELECT MAX(id_cliente) FROM CLIENTE);
