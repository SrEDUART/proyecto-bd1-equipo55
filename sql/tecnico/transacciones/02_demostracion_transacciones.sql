USE ProyectoFerreteria;
GO

IF OBJECT_ID('dbo.sp_RegistrarVentaTransaccion', 'P') IS NULL
    THROW 54000, 'No existe dbo.sp_RegistrarVentaTransaccion. Ejecute primero 01_implementacion_transacciones.sql.', 1;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @id_cliente INT;
DECLARE @id_usuario INT;
DECLARE @id_sucursal INT;
DECLARE @id_producto INT;
DECLARE @cantidad INT = 1;
DECLARE @stock_exitoso INT;
DECLARE @stock_fallida INT;
DECLARE @id_venta_base INT;
DECLARE @id_venta_exitosa INT;
DECLARE @id_detalle_exitosa INT;
DECLARE @id_venta_fallida INT;

SELECT TOP (1)
    @id_cliente = C.id_cliente,
    @id_usuario = U.id_usuario,
    @id_sucursal = S.id_sucursal,
    @id_producto = P.id_producto
FROM dbo.INVENTARIO AS I
INNER JOIN dbo.PRODUCTO AS P
    ON P.id_producto = I.id_producto
INNER JOIN dbo.SUCURSAL AS S
    ON S.id_sucursal = I.id_sucursal
INNER JOIN dbo.USUARIO AS U
    ON U.id_sucursal = S.id_sucursal
CROSS JOIN dbo.CLIENTE AS C
WHERE I.stock > 0
  AND P.eliminado_en IS NULL
  AND S.eliminado_en IS NULL
  AND U.eliminado_en IS NULL
  AND C.eliminado_en IS NULL
ORDER BY I.stock DESC, I.id_sucursal, I.id_producto, U.id_usuario, C.id_cliente;

IF @id_cliente IS NULL
    THROW 54001, 'No se encontró una combinación activa de cliente, usuario, sucursal y producto con stock.', 1;

PRINT '--- CASO 1: VENTA EXITOSA, REVERTIDA AL FINAL ---';
BEGIN TRY
    BEGIN TRANSACTION;

    -- El bloqueo de rango permite identificar la venta creada dentro de esta prueba.
    SELECT @id_venta_base = COALESCE(MAX(id_venta), 0)
    FROM dbo.VENTA WITH (UPDLOCK, HOLDLOCK);

    PRINT 'Estado inicial de producto e inventario:';
    SELECT @stock_exitoso = I.stock
    FROM dbo.INVENTARIO AS I
    WHERE I.id_producto = @id_producto
      AND I.id_sucursal = @id_sucursal;

    SELECT
        I.id_producto,
        P.nombre_producto,
        I.id_sucursal,
        I.stock AS stock_inicial
    FROM dbo.INVENTARIO AS I
    INNER JOIN dbo.PRODUCTO AS P
        ON P.id_producto = I.id_producto
    WHERE I.id_producto = @id_producto
      AND I.id_sucursal = @id_sucursal;

    EXEC dbo.sp_RegistrarVentaTransaccion
        @id_cliente = @id_cliente,
        @id_usuario = @id_usuario,
        @id_sucursal = @id_sucursal,
        @id_producto = @id_producto,
        @cantidad = @cantidad;

    SELECT @id_venta_exitosa = MAX(id_venta)
    FROM dbo.VENTA
    WHERE id_venta > @id_venta_base;

    IF @id_venta_exitosa IS NULL
        THROW 54002, 'El procedimiento no creó la venta esperada.', 1;

    PRINT 'Venta creada:';
    SELECT id_venta, fecha_hora, tipo_factura, descuento, id_sucursal, id_cliente, id_usuario
    FROM dbo.VENTA
    WHERE id_venta = @id_venta_exitosa;

    PRINT 'Detalle creado:';
    SELECT @id_detalle_exitosa = id_detalle
    FROM dbo.DETALLE_VENTA
    WHERE id_venta = @id_venta_exitosa;

    SELECT id_detalle, cantidad, precio_unitario_catalogo, id_producto, id_venta
    FROM dbo.DETALLE_VENTA
    WHERE id_venta = @id_venta_exitosa;

    PRINT 'Stock luego de la venta:';
    SELECT I.id_producto, P.nombre_producto, I.id_sucursal, I.stock AS stock_luego_de_venta
    FROM dbo.INVENTARIO AS I
    INNER JOIN dbo.PRODUCTO AS P
        ON P.id_producto = I.id_producto
    WHERE I.id_producto = @id_producto
      AND I.id_sucursal = @id_sucursal;

    ROLLBACK TRANSACTION;

    PRINT 'Comprobación de rollback de la prueba exitosa (venta y detalle ausentes; stock restaurado):';
    SELECT id_venta
    FROM dbo.VENTA
    WHERE id_venta = @id_venta_exitosa;

    SELECT id_detalle
    FROM dbo.DETALLE_VENTA
    WHERE id_detalle = @id_detalle_exitosa;

    SELECT
        I.id_producto,
        I.id_sucursal,
        I.stock AS stock_despues_del_rollback,
        @stock_exitoso AS stock_inicial
    FROM dbo.INVENTARIO AS I
    WHERE I.id_producto = @id_producto
      AND I.id_sucursal = @id_sucursal;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;

PRINT '--- CASO 2: ERROR REAL DESPUÉS DE INSERTAR VENTA ---';
BEGIN TRY
    BEGIN TRANSACTION;

    SELECT @stock_fallida = I.stock
    FROM dbo.INVENTARIO AS I
    WHERE I.id_producto = @id_producto
      AND I.id_sucursal = @id_sucursal;

    INSERT INTO dbo.VENTA (
        tipo_factura,
        descuento,
        id_sucursal,
        id_cliente,
        id_usuario
    )
    VALUES ('A', 0.00, @id_sucursal, @id_cliente, @id_usuario);

    SET @id_venta_fallida = CONVERT(INT, SCOPE_IDENTITY());
    PRINT 'Encabezado insertado; se provoca un error de CHECK al insertar un detalle con precio cero.';

    INSERT INTO dbo.DETALLE_VENTA (
        cantidad,
        precio_unitario_catalogo,
        id_producto,
        id_venta
    )
    VALUES (@cantidad, 0.00, @id_producto, @id_venta_fallida);

    COMMIT TRANSACTION;
    THROW 54003, 'La prueba fallida no provocó el error esperado.', 1;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    IF ERROR_NUMBER() = 54003
        THROW;

    IF ERROR_NUMBER() <> 547
        THROW;

    PRINT 'Error real capturado; la transacción fue revertida: ' + ERROR_MESSAGE();
END CATCH;

PRINT 'Comprobación del rollback de la prueba fallida (venta y detalle ausentes; stock sin cambios):';
SELECT id_venta
FROM dbo.VENTA
WHERE id_venta = @id_venta_fallida;

SELECT id_detalle
FROM dbo.DETALLE_VENTA
WHERE id_venta = @id_venta_fallida;

SELECT
    I.id_producto,
    I.id_sucursal,
    I.stock AS stock_despues_del_rollback,
    @stock_fallida AS stock_antes_de_la_prueba_fallida
FROM dbo.INVENTARIO AS I
WHERE I.id_producto = @id_producto
  AND I.id_sucursal = @id_sucursal;
GO
