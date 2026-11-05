USE ProyectoFerreteria;
GO


-- demostracion de procedimientos almacenados (pruebas)

-- 1. prueba de insercion (solo inserta si no existe previamente el DNI)
IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE dni = 48999888)
BEGIN
    EXEC sp_InsertarCliente 'Carlos', 'Benitez', 48999888, 'carlos.benitez@test.com', 31;
END

-- verificar insercion
SELECT TOP 1 * FROM CLIENTE ORDER BY id_cliente DESC;

-- 2. prueba de modificacion (modifica solo nombre/apellido del ultimo cliente sin tocar DNI/correo para evitar duplicados)
DECLARE @id_prueba INT = (SELECT MAX(id_cliente) FROM CLIENTE);
DECLARE @dni_actual INT = (SELECT dni FROM CLIENTE WHERE id_cliente = @id_prueba);
DECLARE @correo_actual VARCHAR(100) = (SELECT correo FROM CLIENTE WHERE id_cliente = @id_prueba);
DECLARE @direccion_actual INT = (SELECT id_direccion FROM CLIENTE WHERE id_cliente = @id_prueba);

EXEC sp_ModificarCliente @id_prueba, 'Carlos Alberto', 'Benitez', @dni_actual, @correo_actual, @direccion_actual;

-- verificar modificacion
SELECT * FROM CLIENTE WHERE id_cliente = (SELECT MAX(id_cliente) FROM CLIENTE);

-- 3. prueba de eliminacion (baja logica sobre el ultimo cliente)
DECLARE @id_prueba_baja INT = (SELECT MAX(id_cliente) FROM CLIENTE);
EXEC sp_EliminarCliente @id_prueba_baja;

-- verificar fecha de eliminacion
SELECT * FROM CLIENTE WHERE id_cliente = (SELECT MAX(id_cliente) FROM CLIENTE);

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
