USE ProyectoFerreteria;
GO

-- ===================================================================================================
-- ETAPA 5 - TRANSACCIONES (IMPLEMENTACIÓN)
-- Integrante 3
-- Objetivo: Crear la logica transaccional para registrar una venta completa.
-- ===================================================================================================

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarVentaTransaccion
    @id_cliente INT,
    @id_usuario INT,
    @id_sucursal INT,
    @id_producto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @id_venta INT;
        DECLARE @precio DECIMAL(10,2);
        DECLARE @stock INT;

        IF @cantidad IS NULL OR @cantidad <= 0
            THROW 51001, 'La cantidad debe ser mayor que cero.', 1;

        IF NOT EXISTS (
            SELECT 1
            FROM dbo.SUCURSAL
            WHERE id_sucursal = @id_sucursal
        )
            THROW 51006, 'La sucursal indicada no existe.', 1;

        IF NOT EXISTS (
            SELECT 1
            FROM dbo.USUARIO
            WHERE id_usuario = @id_usuario
              AND id_sucursal = @id_sucursal
        )
            THROW 51007, 'El usuario indicado no existe o no pertenece a la sucursal.', 1;

        IF @id_cliente IS NOT NULL
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CLIENTE
                WHERE id_cliente = @id_cliente
           )
            THROW 51008, 'El cliente indicado no existe.', 1;

        SELECT @precio = P.precio_venta
        FROM dbo.PRODUCTO AS P WITH (UPDLOCK, HOLDLOCK)
        WHERE P.id_producto = @id_producto;

        IF @precio IS NULL
            THROW 51002, 'El producto indicado no existe.', 1;

        SELECT @stock = I.stock
        FROM dbo.INVENTARIO AS I WITH (UPDLOCK, HOLDLOCK)
        WHERE I.id_producto = @id_producto
          AND I.id_sucursal = @id_sucursal;

        IF @stock IS NULL
            THROW 51003, 'No existe inventario para el producto y la sucursal indicados.', 1;

        IF @stock < @cantidad
            THROW 51004, 'El stock disponible es insuficiente para la cantidad solicitada.', 1;

        INSERT INTO dbo.VENTA (
            tipo_factura,
            descuento,
            id_sucursal,
            id_cliente,
            id_usuario
        )
        VALUES ('B', 0.00, @id_sucursal, @id_cliente, @id_usuario);

        SET @id_venta = CONVERT(INT, SCOPE_IDENTITY());

        INSERT INTO dbo.DETALLE_VENTA (
            cantidad,
            precio_unitario_catalogo,
            id_producto,
            id_venta
        )
        VALUES (@cantidad, @precio, @id_producto, @id_venta);

        UPDATE dbo.INVENTARIO
        SET stock = stock - @cantidad
        WHERE id_producto = @id_producto
          AND id_sucursal = @id_sucursal
          AND stock >= @cantidad;

        IF @@ROWCOUNT <> 1
            THROW 51005, 'No se pudo actualizar el inventario; la venta fue cancelada.', 1;

        COMMIT TRANSACTION;
        PRINT 'Venta registrada correctamente.';
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        PRINT 'ERROR: Se canceló la transacción.';
        THROW;
    END CATCH;
END;
GO
