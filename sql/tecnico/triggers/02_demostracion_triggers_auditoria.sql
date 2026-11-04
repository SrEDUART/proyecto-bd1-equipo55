USE proyectoFerreteria;
GO

SET XACT_ABORT ON;

BEGIN TRY
    DECLARE @id_categoria INT;
    DECLARE @id_producto_update INT;
    DECLARE @id_producto_delete INT;

    SELECT TOP (1) @id_categoria = id_categoria
    FROM dbo.CATEGORIA
    ORDER BY id_categoria;

    IF @id_categoria IS NULL
        THROW 50001, 'No existen categorías para ejecutar la demostración.', 1;

    BEGIN TRANSACTION;

    PRINT 'PRUEBA A - UPDATE';

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
        'AUD-UPD-' + REPLACE(CONVERT(VARCHAR(36), NEWID()), '-', ''),
        'Producto prueba auditoría UPDATE',
        'Registro temporal para demostrar la auditoría de UPDATE',
        10000.00,
        40.00,
        @id_categoria,
        NULL
    );

    SET @id_producto_update = CONVERT(INT, SCOPE_IDENTITY());

    PRINT 'Valores iniciales del producto:';
    SELECT
        id_producto,
        codigo_barra,
        nombre_producto,
        precio_costo,
        porcentaje_ganancia,
        precio_venta,
        id_categoria
    FROM dbo.PRODUCTO
    WHERE id_producto = @id_producto_update;

    UPDATE dbo.PRODUCTO
    SET precio_costo = 12000.00,
        porcentaje_ganancia = 45.00
    WHERE id_producto = @id_producto_update;

    PRINT 'Valores nuevos del producto:';
    SELECT
        id_producto,
        nombre_producto,
        precio_costo,
        porcentaje_ganancia,
        precio_venta
    FROM dbo.PRODUCTO
    WHERE id_producto = @id_producto_update;

    PRINT 'Auditoría UPDATE: los valores registrados deben coincidir con los iniciales.';
    SELECT
        id_auditoria,
        id_producto,
        tipo_operacion,
        codigo_barra_anterior,
        nombre_producto_anterior,
        precio_costo_anterior,
        porcentaje_ganancia_anterior,
        precio_venta_anterior,
        id_categoria_anterior,
        eliminado_en_anterior,
        fecha_hora,
        usuario_bd
    FROM dbo.AUDITORIA_PRODUCTO
    WHERE id_producto = @id_producto_update
      AND tipo_operacion = 'UPDATE';

    PRINT 'PRUEBA B - DELETE';

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
        'AUD-DEL-' + REPLACE(CONVERT(VARCHAR(36), NEWID()), '-', ''),
        'Producto prueba auditoría DELETE',
        'Registro temporal para demostrar la auditoría de DELETE',
        8000.00,
        30.00,
        @id_categoria,
        NULL
    );

    SET @id_producto_delete = CONVERT(INT, SCOPE_IDENTITY());

    PRINT 'Producto antes del DELETE:';
    SELECT
        id_producto,
        codigo_barra,
        nombre_producto,
        precio_costo,
        porcentaje_ganancia,
        precio_venta,
        id_categoria
    FROM dbo.PRODUCTO
    WHERE id_producto = @id_producto_delete;

    DELETE FROM dbo.PRODUCTO
    WHERE id_producto = @id_producto_delete;

    PRINT 'La consulta siguiente debe devolver cero filas:';
    SELECT id_producto, codigo_barra, nombre_producto
    FROM dbo.PRODUCTO
    WHERE id_producto = @id_producto_delete;

    PRINT 'Auditoría DELETE: los valores registrados deben coincidir con los previos al borrado.';
    SELECT
        id_auditoria,
        id_producto,
        tipo_operacion,
        codigo_barra_anterior,
        nombre_producto_anterior,
        precio_costo_anterior,
        porcentaje_ganancia_anterior,
        precio_venta_anterior,
        id_categoria_anterior,
        eliminado_en_anterior,
        fecha_hora,
        usuario_bd
    FROM dbo.AUDITORIA_PRODUCTO
    WHERE id_producto = @id_producto_delete
      AND tipo_operacion = 'DELETE';

    -- Las consultas de evidencia se ejecutan antes de revertir los datos de prueba.
    ROLLBACK TRANSACTION;
    PRINT 'Demostración finalizada; los cambios temporales fueron revertidos.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
GO
