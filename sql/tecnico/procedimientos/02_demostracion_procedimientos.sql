USE ProyectoFerreteria;
GO


-- demostracion de procedimientos almacenados (pruebas)

-- 1. pruebas CRUD sobre un cliente temporal con identificadores unicos.
DECLARE @id_direccion_prueba INT;
DECLARE @dni_prueba INT;
DECLARE @correo_prueba VARCHAR(100);
DECLARE @id_cliente_prueba INT;

SELECT TOP (1) @id_direccion_prueba = id_direccion
FROM dbo.DIRECCION
ORDER BY id_direccion;

IF @id_direccion_prueba IS NULL
    THROW 57000, 'No hay direcciones disponibles para las pruebas CRUD.', 1;

SET @dni_prueba =
    CONVERT(INT, ABS(CONVERT(BIGINT, CHECKSUM(NEWID()))) % 2147483646) + 1;

WHILE EXISTS (
    SELECT 1
    FROM dbo.CLIENTE
    WHERE dni = @dni_prueba
)
BEGIN
    SET @dni_prueba =
        CONVERT(INT, ABS(CONVERT(BIGINT, CHECKSUM(NEWID()))) % 2147483646) + 1;
END;

SET @correo_prueba =
    CONCAT('crud-prueba-', CONVERT(VARCHAR(36), NEWID()), '@example.test');

WHILE EXISTS (
    SELECT 1
    FROM dbo.CLIENTE
    WHERE correo = @correo_prueba
)
BEGIN
    SET @correo_prueba =
        CONCAT('crud-prueba-', CONVERT(VARCHAR(36), NEWID()), '@example.test');
END;

BEGIN TRY
    BEGIN TRANSACTION;

    PRINT '--- PRUEBA 1: INSERCION DE CLIENTE TEMPORAL ---';
    EXEC dbo.sp_InsertarCliente
        @nombre = 'Cliente',
        @apellido = 'Prueba CRUD',
        @dni = @dni_prueba,
        @correo = @correo_prueba,
        @id_direccion = @id_direccion_prueba;

    SELECT @id_cliente_prueba = id_cliente
    FROM dbo.CLIENTE
    WHERE dni = @dni_prueba
      AND correo = @correo_prueba;

    IF @id_cliente_prueba IS NULL
        THROW 57002, 'No se pudo identificar el cliente temporal insertado.', 1;

    SELECT id_cliente, nombre, apellido, dni, correo, id_direccion, eliminado_en
    FROM dbo.CLIENTE
    WHERE id_cliente = @id_cliente_prueba;

    PRINT '--- PRUEBA 2: MODIFICACION DEL MISMO CLIENTE ---';
    EXEC dbo.sp_ModificarCliente
        @id_cliente = @id_cliente_prueba,
        @nombre = 'Cliente Modificado',
        @apellido = 'Prueba CRUD',
        @dni = @dni_prueba,
        @correo = @correo_prueba,
        @id_direccion = @id_direccion_prueba;

    SELECT id_cliente, nombre, apellido, dni, correo, id_direccion, eliminado_en
    FROM dbo.CLIENTE
    WHERE id_cliente = @id_cliente_prueba;

    PRINT '--- PRUEBA 3: BAJA LOGICA DEL MISMO CLIENTE ---';
    EXEC dbo.sp_EliminarCliente
        @id_cliente = @id_cliente_prueba;

    SELECT id_cliente, nombre, apellido, dni, correo, eliminado_en
    FROM dbo.CLIENTE
    WHERE id_cliente = @id_cliente_prueba;

    ROLLBACK TRANSACTION;

    PRINT 'Verificacion posterior al ROLLBACK (0 filas esperadas):';
    SELECT COUNT(*) AS clientes_temporales_restantes
    FROM dbo.CLIENTE
    WHERE id_cliente = @id_cliente_prueba;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;

-- 4. comparacion de insercion directa y mediante procedimiento
DECLARE @id_direccion_lote INT;
DECLARE @dni_base_lote INT;
DECLARE @prefijo_correo_lote VARCHAR(50);
DECLARE @numero_lote INT = 1;
DECLARE @nombre_lote VARCHAR(50);
DECLARE @apellido_lote VARCHAR(50);
DECLARE @dni_lote INT;
DECLARE @correo_lote VARCHAR(100);
DECLARE @direccion_lote INT;

SELECT TOP (1) @id_direccion_lote = id_direccion
FROM dbo.DIRECCION
ORDER BY id_direccion;

IF @id_direccion_lote IS NULL
    THROW 57001, 'No hay direcciones disponibles para la comparacion de inserciones.', 1;

SET @dni_base_lote = 1000000000
    + CONVERT(INT, ABS(CONVERT(BIGINT, CHECKSUM(NEWID()))) % 1000000000);

WHILE EXISTS (
    SELECT 1
    FROM dbo.CLIENTE
    WHERE dni BETWEEN @dni_base_lote AND @dni_base_lote + 9
)
BEGIN
    SET @dni_base_lote = 1000000000
        + CONVERT(INT, ABS(CONVERT(BIGINT, CHECKSUM(NEWID()))) % 1000000000);
END;

SET @prefijo_correo_lote = CONCAT('proc-lote-', CONVERT(VARCHAR(36), NEWID()));

DECLARE @lote_clientes TABLE (
    numero INT PRIMARY KEY,
    grupo VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni INT NOT NULL UNIQUE,
    correo VARCHAR(100) NOT NULL UNIQUE,
    id_direccion INT NOT NULL
);

WHILE @numero_lote <= 10
BEGIN
    INSERT INTO @lote_clientes (
        numero,
        grupo,
        nombre,
        apellido,
        dni,
        correo,
        id_direccion
    )
    VALUES (
        @numero_lote,
        CASE WHEN @numero_lote <= 5 THEN 'Directo' ELSE 'Procedimiento' END,
        'Prueba',
        CONCAT('Lote', @numero_lote),
        @dni_base_lote + @numero_lote - 1,
        CONCAT(@prefijo_correo_lote, '.', @numero_lote, '@example.test'),
        @id_direccion_lote
    );

    SET @numero_lote += 1;
END;

PRINT '--- COMPARACION: INSERCION DIRECTA DE 5 CLIENTES ---';
BEGIN TRY
    BEGIN TRANSACTION;

    SET STATISTICS TIME ON;
    INSERT INTO dbo.CLIENTE (nombre, apellido, dni, correo, id_direccion)
    SELECT nombre, apellido, dni, correo, id_direccion
    FROM @lote_clientes
    WHERE grupo = 'Directo';
    SET STATISTICS TIME OFF;

    PRINT '--- COMPARACION: INSERCION DE 5 CLIENTES MEDIANTE sp_InsertarCliente ---';
    SET STATISTICS TIME ON;
    SET @numero_lote = 6;

    WHILE @numero_lote <= 10
    BEGIN
        SELECT
            @nombre_lote = nombre,
            @apellido_lote = apellido,
            @dni_lote = dni,
            @correo_lote = correo,
            @direccion_lote = id_direccion
        FROM @lote_clientes
        WHERE numero = @numero_lote;

        EXEC dbo.sp_InsertarCliente
            @nombre = @nombre_lote,
            @apellido = @apellido_lote,
            @dni = @dni_lote,
            @correo = @correo_lote,
            @id_direccion = @direccion_lote;

        SET @numero_lote += 1;
    END;

    SET STATISTICS TIME OFF;

    PRINT 'Cantidad insertada por alternativa (5 filas esperadas en cada lote):';
    SELECT
        L.grupo AS alternativa,
        COUNT(C.id_cliente) AS cantidad_insertada
    FROM @lote_clientes AS L
    LEFT JOIN dbo.CLIENTE AS C
        ON C.dni = L.dni
    GROUP BY L.grupo;

    ROLLBACK TRANSACTION;
END TRY
BEGIN CATCH
    SET STATISTICS TIME OFF;

    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;

PRINT 'Verificacion posterior al ROLLBACK (0 filas esperadas):';
SELECT COUNT(*) AS filas_de_prueba_restantes
FROM dbo.CLIENTE AS C
INNER JOIN @lote_clientes AS L
    ON L.dni = C.dni;

PRINT 'Conclusion: el tiempo depende del contexto y la carga; el procedimiento tambien aporta centralizacion y reutilizacion de la logica.';
GO
