USE proyectoFerreteria;
GO

-- ===================================================================================================
-- ETAPA 5 - TRANSACCIONES (DEMOSTRACIÓN)
-- Integrante 3
-- Objetivo: Probar la transaccion exitosa y la fallida.
-- ===================================================================================================

PRINT '--- ESTADO INICIAL ---';
SELECT id_producto, nombre_producto, stock FROM INVENTARIO WHERE id_producto = 1 AND id_sucursal = 1;
SELECT TOP 1 id_venta FROM VENTA ORDER BY id_venta DESC;
GO


-- ---------------------------------------------------------
-- CASO 1: TRANSACCIÓN EXITOSA (Usando el Procedimiento)
-- ---------------------------------------------------------
PRINT '--- CASO 1: TRANSACCION EXITOSA ---';

-- Ejecutamos el SP (Simulamos la venta de 2 martillos)
EXEC dbo.sp_RegistrarVentaTransaccion 
    @id_cliente = 1, 
    @id_usuario = 1, 
    @id_sucursal = 1, 
    @id_producto = 1, 
    @cantidad = 2;
GO

-- Verificamos que los datos se guardaron y el stock bajó
SELECT TOP 1 id_venta, tipo_factura FROM VENTA ORDER BY id_venta DESC;
SELECT TOP 1 id_detalle, cantidad, id_venta FROM DETALLE_VENTA ORDER BY id_detalle DESC;
SELECT id_producto, nombre_producto, stock FROM INVENTARIO WHERE id_producto = 1 AND id_sucursal = 1;
GO


-- ---------------------------------------------------------
-- CASO 2: TRANSACCIÓN FALLIDA A PROPÓSITO
-- ---------------------------------------------------------
PRINT '--- CASO 2: TRANSACCION FALLIDA (ERROR FORZADO) ---';

BEGIN TRY
    BEGIN TRANSACTION;

    -- 1. Insertar en VENTA (Esto se va a ejecutar)
    INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) 
    VALUES ('A', 0.00, 1, 1, 1);
    
    DECLARE @id_venta_fallida INT = SCOPE_IDENTITY();

    -- 2. FORZAMOS EL ERROR (Producto 9999 no existe)
    PRINT 'Forzando error con producto inexistente...';
    INSERT INTO DETALLE_VENTA (cantidad, precio_unitario_catalogo, id_producto, id_venta)
    VALUES (1, 15000.00, 9999, @id_venta_fallida);

    -- 3. Actualizar Stock
    UPDATE INVENTARIO 
    SET stock = stock - 1 
    WHERE id_producto = 1 AND id_sucursal = 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END
    PRINT 'ERROR CAPTURADO: ' + ERROR_MESSAGE();
    PRINT 'La venta fallida NO se guardó y el stock no cambió.';
END CATCH;
GO

-- ---------------------------------------------------------
-- VERIFICACIÓN FINAL
-- ---------------------------------------------------------
PRINT '--- VERIFICACION FINAL (No debe haber ventas nuevas del caso 2) ---';
SELECT TOP 2 id_venta, tipo_factura FROM VENTA ORDER BY id_venta DESC;
SELECT id_producto, nombre_producto, stock FROM INVENTARIO WHERE id_producto = 1 AND id_sucursal = 1;
GO
