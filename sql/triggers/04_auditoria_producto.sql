/*
===============================================================================
 PROYECTO BD1 - EQUIPO 55
 INTEGRANTE 4 - TRIGGERS DE AUDITORÍA
 Tabla auditada: PRODUCTO
 Motor: Microsoft SQL Server / T-SQL
===============================================================================

Objetivo:
- Registrar los valores ANTERIORES de PRODUCTO cuando se realiza un UPDATE.
- Registrar los valores ANTERIORES de PRODUCTO cuando se realiza un DELETE.
- Guardar fecha/hora, tipo de operación y usuario de base de datos.

Nota:
SQL Server no posee triggers BEFORE. Los triggers AFTER pueden acceder a la tabla
lógica deleted, que contiene los valores anteriores de las filas modificadas o
eliminadas.
===============================================================================
*/

-- ============================================================================
-- 1. TABLA AUXILIAR DE AUDITORÍA
-- ============================================================================

IF OBJECT_ID('dbo.AUDITORIA_PRODUCTO', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.AUDITORIA_PRODUCTO (
        id_auditoria INT IDENTITY(1,1) NOT NULL,
        id_producto INT NOT NULL,
        tipo_operacion VARCHAR(10) NOT NULL,

        codigo_barra_anterior VARCHAR(50) NOT NULL,
        nombre_producto_anterior VARCHAR(50) NOT NULL,
        descripcion_anterior VARCHAR(150) NOT NULL,
        precio_costo_anterior DECIMAL(10,2) NOT NULL,
        porcentaje_ganancia_anterior DECIMAL(5,2) NOT NULL,
        precio_venta_anterior DECIMAL(10,2) NOT NULL,
        id_categoria_anterior INT NOT NULL,
        eliminado_en_anterior DATETIME NULL,

        fecha_hora DATETIME2(0) NOT NULL
            CONSTRAINT DF_AUDITORIA_PRODUCTO_FECHA DEFAULT SYSDATETIME(),

        usuario_bd SYSNAME NOT NULL
            CONSTRAINT DF_AUDITORIA_PRODUCTO_USUARIO DEFAULT SUSER_SNAME(),

        CONSTRAINT PK_AUDITORIA_PRODUCTO PRIMARY KEY (id_auditoria),
        CONSTRAINT CK_AUDITORIA_PRODUCTO_OPERACION
            CHECK (tipo_operacion IN ('UPDATE', 'DELETE'))
    );
END;
GO

-- AUDITORIA_PRODUCTO.id_producto no se declara como FK hacia PRODUCTO.
-- Si se eliminara físicamente un producto, la auditoría debe poder conservar
-- igualmente el identificador y los valores históricos de ese registro.

-- ============================================================================
-- 2. TRIGGER DE AUDITORÍA PARA UPDATE
-- ============================================================================

CREATE OR ALTER TRIGGER dbo.TR_PRODUCTO_AUD_UPDATE
ON dbo.PRODUCTO
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- En UPDATE, deleted contiene los valores ANTERIORES.
    INSERT INTO dbo.AUDITORIA_PRODUCTO (
        id_producto,
        tipo_operacion,
        codigo_barra_anterior,
        nombre_producto_anterior,
        descripcion_anterior,
        precio_costo_anterior,
        porcentaje_ganancia_anterior,
        precio_venta_anterior,
        id_categoria_anterior,
        eliminado_en_anterior,
        fecha_hora,
        usuario_bd
    )
    SELECT
        d.id_producto,
        'UPDATE',
        d.codigo_barra,
        d.nombre_producto,
        d.descripcion,
        d.precio_costo,
        d.porcentaje_ganancia,
        d.precio_venta,
        d.id_categoria,
        d.eliminado_en,
        SYSDATETIME(),
        SUSER_SNAME()
    FROM deleted AS d;
END;
GO

-- ============================================================================
-- 3. TRIGGER DE AUDITORÍA PARA DELETE
-- ============================================================================

CREATE OR ALTER TRIGGER dbo.TR_PRODUCTO_AUD_DELETE
ON dbo.PRODUCTO
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- En DELETE, deleted contiene las filas tal como estaban antes de borrarse.
    INSERT INTO dbo.AUDITORIA_PRODUCTO (
        id_producto,
        tipo_operacion,
        codigo_barra_anterior,
        nombre_producto_anterior,
        descripcion_anterior,
        precio_costo_anterior,
        porcentaje_ganancia_anterior,
        precio_venta_anterior,
        id_categoria_anterior,
        eliminado_en_anterior,
        fecha_hora,
        usuario_bd
    )
    SELECT
        d.id_producto,
        'DELETE',
        d.codigo_barra,
        d.nombre_producto,
        d.descripcion,
        d.precio_costo,
        d.porcentaje_ganancia,
        d.precio_venta,
        d.id_categoria,
        d.eliminado_en,
        SYSDATETIME(),
        SUSER_SNAME()
    FROM deleted AS d;
END;
GO

-- ============================================================================
-- 4. CONSULTA GENERAL DE AUDITORÍA
-- ============================================================================

SELECT
    id_auditoria,
    id_producto,
    tipo_operacion,
    nombre_producto_anterior,
    precio_costo_anterior,
    porcentaje_ganancia_anterior,
    precio_venta_anterior,
    id_categoria_anterior,
    fecha_hora,
    usuario_bd
FROM dbo.AUDITORIA_PRODUCTO
ORDER BY id_auditoria DESC;
GO

-- ============================================================================
-- 5. PRUEBA CONTROLADA DEL TRIGGER UPDATE
-- ============================================================================

DECLARE @id_categoria_update INT;
DECLARE @id_producto_update INT;
DECLARE @codigo_update VARCHAR(50);

SELECT TOP (1)
    @id_categoria_update = id_categoria
FROM dbo.CATEGORIA
ORDER BY id_categoria;

IF @id_categoria_update IS NULL
    THROW 50001, 'No existen categorías para ejecutar la prueba de auditoría.', 1;

SET @codigo_update =
    'AUD-UPD-' + RIGHT(REPLACE(CONVERT(VARCHAR(36), NEWID()), '-', ''), 12);

BEGIN TRANSACTION;

INSERT INTO dbo.PRODUCTO (
    codigo_barra,
    nombre_producto,
    descripcion,
    precio_costo,
    porcentaje_ganancia,
    id_categoria,
    eliminado_en
)
VALUES (
    @codigo_update,
    'Producto prueba auditoría UPDATE',
    'Registro temporal para probar TR_PRODUCTO_AUD_UPDATE',
    10000.00,
    40.00,
    @id_categoria_update,
    NULL
);

SET @id_producto_update = SCOPE_IDENTITY();

-- Estado inicial.
SELECT
    id_producto,
    codigo_barra,
    nombre_producto,
    precio_costo,
    porcentaje_ganancia,
    precio_venta
FROM dbo.PRODUCTO
WHERE id_producto = @id_producto_update;

-- Operación que activa el trigger.
UPDATE dbo.PRODUCTO
SET precio_costo = 12000.00,
    porcentaje_ganancia = 45.00
WHERE id_producto = @id_producto_update;

-- Estado nuevo del producto.
SELECT
    id_producto,
    nombre_producto,
    precio_costo,
    porcentaje_ganancia,
    precio_venta
FROM dbo.PRODUCTO
WHERE id_producto = @id_producto_update;

-- Evidencia: debe mostrar los valores ANTERIORES.
SELECT
    id_auditoria,
    id_producto,
    tipo_operacion,
    nombre_producto_anterior,
    precio_costo_anterior,
    porcentaje_ganancia_anterior,
    precio_venta_anterior,
    fecha_hora,
    usuario_bd
FROM dbo.AUDITORIA_PRODUCTO
WHERE id_producto = @id_producto_update
ORDER BY id_auditoria DESC;

ROLLBACK TRANSACTION;
GO

-- ============================================================================
-- 6. PRUEBA CONTROLADA DEL TRIGGER DELETE
-- ============================================================================

DECLARE @id_categoria_delete INT;
DECLARE @id_producto_delete INT;
DECLARE @codigo_delete VARCHAR(50);

SELECT TOP (1)
    @id_categoria_delete = id_categoria
FROM dbo.CATEGORIA
ORDER BY id_categoria;

IF @id_categoria_delete IS NULL
    THROW 50002, 'No existen categorías para ejecutar la prueba de auditoría.', 1;

SET @codigo_delete =
    'AUD-DEL-' + RIGHT(REPLACE(CONVERT(VARCHAR(36), NEWID()), '-', ''), 12);

BEGIN TRANSACTION;

INSERT INTO dbo.PRODUCTO (
    codigo_barra,
    nombre_producto,
    descripcion,
    precio_costo,
    porcentaje_ganancia,
    id_categoria,
    eliminado_en
)
VALUES (
    @codigo_delete,
    'Producto prueba auditoría DELETE',
    'Registro temporal para probar TR_PRODUCTO_AUD_DELETE',
    8000.00,
    30.00,
    @id_categoria_delete,
    NULL
);

SET @id_producto_delete = SCOPE_IDENTITY();

-- Confirmamos que el producto existe antes del DELETE.
SELECT
    id_producto,
    codigo_barra,
    nombre_producto,
    precio_costo,
    porcentaje_ganancia,
    precio_venta
FROM dbo.PRODUCTO
WHERE id_producto = @id_producto_delete;

-- Operación que activa el trigger.
DELETE FROM dbo.PRODUCTO
WHERE id_producto = @id_producto_delete;

-- Debe devolver 0 filas dentro de la transacción.
SELECT *
FROM dbo.PRODUCTO
WHERE id_producto = @id_producto_delete;

-- Evidencia: debe conservar el estado anterior al DELETE.
SELECT
    id_auditoria,
    id_producto,
    tipo_operacion,
    codigo_barra_anterior,
    nombre_producto_anterior,
    precio_costo_anterior,
    porcentaje_ganancia_anterior,
    precio_venta_anterior,
    fecha_hora,
    usuario_bd
FROM dbo.AUDITORIA_PRODUCTO
WHERE id_producto = @id_producto_delete
ORDER BY id_auditoria DESC;

ROLLBACK TRANSACTION;
GO

-- ============================================================================
-- 7. VERIFICACIÓN DEL USUARIO DE BASE DE DATOS
-- ============================================================================

SELECT
    SUSER_SNAME() AS usuario_bd_actual,
    SYSDATETIME() AS fecha_hora_actual;
GO
