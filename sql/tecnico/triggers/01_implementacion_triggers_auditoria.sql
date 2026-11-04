USE ProyectoFerreteria;
GO

-- Conserva los valores anteriores de PRODUCTO en operaciones UPDATE y DELETE.
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

-- No hay FK hacia PRODUCTO para conservar el historial tras eliminarlo.
CREATE OR ALTER TRIGGER dbo.TR_PRODUCTO_AUD_UPDATE
ON dbo.PRODUCTO
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- deleted contiene los valores anteriores y permite auditar múltiples filas.
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

CREATE OR ALTER TRIGGER dbo.TR_PRODUCTO_AUD_DELETE
ON dbo.PRODUCTO
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cada fila eliminada se conserva con sus valores previos.
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
