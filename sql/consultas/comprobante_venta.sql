USE proyectoFerreteria;

--  COMPROBANTE / FACTURA DE VENTA


DECLARE @id_venta_busqueda INT = 1;

SELECT 
    VENTA.id_venta AS [Nro Venta],
    VENTA.fecha_hora AS [Fecha y Hora],
    VENTA.tipo_factura AS [Tipo Factura],
    SUCURSAL.nombre AS [Sucursal],
    ISNULL(CONCAT(CLIENTE.nombre, ' ', CLIENTE.apellido), 'Consumidor Final') AS [Cliente],
    
    PRODUCTO.nombre_producto AS [Producto],
    DETALLE_VENTA.cantidad AS [Cantidad],
    DETALLE_VENTA.precio_unitario_catalogo AS [Precio Unitario],
    
    (DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo) AS [Subtotal Renglón],
    VENTA.descuento AS [Descuento (%)],
    
    (
        SELECT SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo)
        FROM DETALLE_VENTA
        WHERE DETALLE_VENTA.id_venta = VENTA.id_venta
    ) AS [Subtotal General],
    
    CAST(
        (
            SELECT SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo)
            FROM DETALLE_VENTA
            WHERE DETALLE_VENTA.id_venta = VENTA.id_venta
        ) * (1 - (VENTA.descuento / 100.0))
        AS DECIMAL(12,2)
    ) AS [Total Final]

FROM VENTA
INNER JOIN SUCURSAL 
    ON VENTA.id_sucursal = SUCURSAL.id_sucursal
LEFT JOIN CLIENTE 
    ON VENTA.id_cliente = CLIENTE.id_cliente
INNER JOIN DETALLE_VENTA 
    ON VENTA.id_venta = DETALLE_VENTA.id_venta
INNER JOIN PRODUCTO 
    ON DETALLE_VENTA.id_producto = PRODUCTO.id_producto

WHERE VENTA.id_venta = @id_venta_busqueda;
