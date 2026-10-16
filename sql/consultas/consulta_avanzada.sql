-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- CONSULTA AVANZADA:
-- Productos con una cantidad significativa de unidades vendidas,
-- agrupados por categoria, producto y sucursal.
--
-- La consulta combina 5 tablas mediante INNER JOIN y utiliza
-- GROUP BY, SUM, COUNT, HAVING y ORDER BY.
-- ============================================================

SELECT
    c.nombre_cat AS categoria,
    p.nombre_producto,
    s.nombre AS sucursal,
    COUNT(DISTINCT v.id_venta) AS cantidad_ventas,
    SUM(dv.cantidad) AS unidades_vendidas,
    SUM(dv.cantidad * dv.precio_unitario_catalogo) AS total_vendido
FROM DETALLE_VENTA dv

INNER JOIN PRODUCTO p
    ON dv.id_producto = p.id_producto

INNER JOIN CATEGORIA c
    ON p.id_categoria = c.id_categoria

INNER JOIN VENTA v
    ON dv.id_venta = v.id_venta

INNER JOIN SUCURSAL s
    ON v.id_sucursal = s.id_sucursal

GROUP BY
    c.nombre_cat,
    p.nombre_producto,
    s.nombre

HAVING
    SUM(dv.cantidad) >= 2

ORDER BY
    total_vendido DESC;


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- VARIANTE CON RANGO DE FECHAS:
-- Permite aplicar el mismo analisis dentro de un periodo determinado.
-- Las fechas pueden modificarse segun la necesidad del reporte.
-- ============================================================

DECLARE @fecha_desde DATE = '2026-01-01';
DECLARE @fecha_hasta DATE = '2026-12-31';

SELECT
    c.nombre_cat AS categoria,
    p.nombre_producto,
    s.nombre AS sucursal,
    COUNT(DISTINCT v.id_venta) AS cantidad_ventas,
    SUM(dv.cantidad) AS unidades_vendidas,
    SUM(dv.cantidad * dv.precio_unitario_catalogo) AS total_vendido
FROM DETALLE_VENTA dv

INNER JOIN PRODUCTO p
    ON dv.id_producto = p.id_producto

INNER JOIN CATEGORIA c
    ON p.id_categoria = c.id_categoria

INNER JOIN VENTA v
    ON dv.id_venta = v.id_venta

INNER JOIN SUCURSAL s
    ON v.id_sucursal = s.id_sucursal

WHERE
    v.fecha_hora >= @fecha_desde
    AND v.fecha_hora < DATEADD(DAY, 1, @fecha_hasta)

GROUP BY
    c.nombre_cat,
    p.nombre_producto,
    s.nombre

HAVING
    SUM(dv.cantidad) >= 2

ORDER BY
    total_vendido DESC;
