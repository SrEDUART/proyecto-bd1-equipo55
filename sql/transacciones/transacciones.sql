USE proyectoFerreteria;
GO

-- ===================================================================================================
-- ETAPA 5 - TRANSACCIONES
-- Integrante 3
-- Objetivo: Demostrar atomicidad en operaciones de Insert y Update en multiples tablas.
-- ===================================================================================================

PRINT '=============================================================';
PRINT '--- INICIANDO PRUEBA 1: TRANSACCION EXITOSA ---';
PRINT '=============================================================';

BEGIN TRY
    -- Iniciamos la transaccion
    BEGIN TRANSACTION;

    -- 1. Insertar en VENTA (Tabla A)
    -- Usamos id_sucursal=1, id_cliente=1, id_usuario=1 (sabemos que existen por el DML)
    INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) 
    VALUES ('B', 0.00, 1, 1, 1);
    
    -- Guardamos el ID autogenerado para usarlo en las siguientes tablas
    DECLARE @id_venta_exitosa INT = SCOPE_IDENTITY();

    -- 2. Insertar en DETALLE_VENTA (Tabla B)
    -- Compramos 2 unidades del producto 1 (Martillo)
    INSERT INTO DETALLE_VENTA (cantidad, precio_unitario_catalogo, id_producto, id_venta)
    VALUES (2, 15000.00, 1, @id_venta_exitosa);

    -- 3. Actualizar INVENTARIO (Tabla C)
    -- Restamos 2 unidades del stock del producto 1 en la sucursal 1
    UPDATE INVENTARIO 
    SET stock = stock - 2 
    WHERE id_producto = 1 AND id_sucursal = 1;

    -- Si no hubo errores, confirmamos todos los cambios juntos
    COMMIT TRANSACTION;
    PRINT '>> RESULTADO: Transaccion completada con exito. La venta, el detalle y el stock se guardaron.';
END TRY
BEGIN CATCH
    -- Si algo falla, se deshace TODO.
    ROLLBACK TRANSACTION;
    PRINT '>> RESULTADO: Error. Se cancelo toda la operacion.';
    PRINT '>> Mensaje del error: ' + ERROR_MESSAGE();
END CATCH;
GO


PRINT '=============================================================';
PRINT '--- INICIANDO PRUEBA 2: TRANSACCION FALLIDA A PROPOSITO ---';
PRINT '=============================================================';

BEGIN TRY
    BEGIN TRANSACTION;

    -- 1. Insertar en VENTA (Esto va a entrar, pero luego se va a deshacer)
    INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) 
    VALUES ('A', 0.00, 1, 1, 1);
    
    DECLARE @id_venta_fallida INT = SCOPE_IDENTITY();

    -- 2. FORZAMOS UN ERROR
    -- Intentamos vender el producto 9999, el cual NO EXISTE en la tabla PRODUCTO.
    -- Esto violara la Clave Foranea (FK) y saltara al bloque CATCH.
    PRINT 'Forzando error con producto inexistente (ID 9999)...';
    INSERT INTO DETALLE_VENTA (cantidad, precio_unitario_catalogo, id_producto, id_venta)
    VALUES (1, 15000.00, 9999, @id_venta_fallida);

    -- 3. Esta actualizacion jamas se ejecutara por el error anterior.
    UPDATE INVENTARIO 
    SET stock = stock - 1 
    WHERE id_producto = 1 AND id_sucursal = 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Al fallar, Rollback deshace el INSERT de la VENTA que si habia entrado.
    ROLLBACK TRANSACTION;
    PRINT '>> RESULTADO: Error capturado intencionalmente.';
    PRINT '>> Mensaje: ' + ERROR_MESSAGE();
    PRINT '>> La venta fallida NO quedo registrada. La base de datos mantiene su integridad.';
END CATCH;
GO


PRINT '=============================================================';
PRINT '--- VERIFICACION FINAL ---';
PRINT '=============================================================';
-- Consultamos las ultimas ventas para demostrar que la fallida no esta.
SELECT TOP 5 id_venta, tipo_factura, id_cliente FROM VENTA ORDER BY id_venta DESC;
