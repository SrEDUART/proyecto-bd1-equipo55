USE proyectoFerreteria;


DECLARE @fecha_desde DATE = '2026-01-01';
DECLARE @fecha_hasta DATE = '2026-12-31';

SELECT
    CATEGORIA.nombre_cat                                                          AS [Categoria],
    COUNT(DISTINCT VENTA.id_venta)                                                AS [Cantidad Ventas],
    SUM(DETALLE_VENTA.cantidad)                                                   AS [Unidades Vendidas],
    SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo)          AS [Monto Total Vendido],
    CAST(
        SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo) * 100.0 /
        NULLIF((
            SELECT SUM(DV2.cantidad * DV2.precio_unitario_catalogo)
            FROM DETALLE_VENTA DV2
            INNER JOIN VENTA V2
                ON DV2.id_venta = V2.id_venta
            WHERE V2.fecha_hora >= @fecha_desde
              AND V2.fecha_hora <  DATEADD(DAY, 1, @fecha_hasta)
        ), 0)
        AS DECIMAL(5,2)
    )                                                                             AS [% del Total]

FROM DETALLE_VENTA

INNER JOIN PRODUCTO
    ON DETALLE_VENTA.id_producto = PRODUCTO.id_producto

INNER JOIN CATEGORIA
    ON PRODUCTO.id_categoria = CATEGORIA.id_categoria

INNER JOIN VENTA
    ON DETALLE_VENTA.id_venta = VENTA.id_venta

WHERE
    VENTA.fecha_hora >= @fecha_desde
    AND VENTA.fecha_hora <  DATEADD(DAY, 1, @fecha_hasta)

GROUP BY
    CATEGORIA.nombre_cat

ORDER BY
    [Monto Total Vendido] DESC;
