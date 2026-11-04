USE proyectoFerreteria;
GO

-- ===================================================================================================
-- ETAPA 5 - TRANSACCIONES (IMPLEMENTACIÓN)
-- Integrante 3
-- Objetivo: Crear la logica transaccional para registrar una venta completa.
-- ===================================================================================================

CREATE PROCEDURE dbo.sp_RegistrarVentaTransaccion
    @id_cliente INT,
    @id_usuario INT,
    @id_sucursal INT,
    @id_producto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON; -- Si hay un error, aborta todo automaticamente

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @id_venta INT;
        DECLARE @precio DECIMAL(10,2);

        -- 1. Obtener el precio del producto
        SELECT @precio = precio_costo * (1 + porcentaje_ganancia / 100.0) 
        FROM PRODUCTO WHERE id_producto = @id_producto;

        -- 2. Insertar en VENTA (Tabla A)
        INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) 
        VALUES ('B', 0.00, @id_sucursal, @id_cliente, @id_usuario);

        -- Guardamos el ID de la venta generada
        SET @id_venta = SCOPE_IDENTITY();

        -- 3. Insertar en DETALLE_VENTA (Tabla B)
        INSERT INTO DETALLE_VENTA (cantidad, precio_unitario_catalogo, id_producto, id_venta)
        VALUES (@cantidad, @precio, @id_producto, @id_venta);

        -- 4. Actualizar INVENTARIO (Tabla C)
        UPDATE INVENTARIO 
        SET stock = stock - @cantidad 
        WHERE id_producto = @id_producto AND id_sucursal = @id_sucursal;

        -- Si todo salió bien, confirmamos
        COMMIT TRANSACTION;
        PRINT 'Venta registrada correctamente.';
    END TRY
    BEGIN CATCH
        -- Si algo falló, deshacemos todo
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        PRINT 'ERROR: Se canceló la transacción.';
        THROW;
    END CATCH;
END;
GO
