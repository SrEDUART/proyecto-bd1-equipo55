/*
    Las fechas pueden modificarse segun el periodo que se quiera analizar.
    Se utiliza un limite superior exclusivo para incluir todo el dia
    indicado en @fecha_hasta, incluso si VENTA.fecha_hora contiene hora.
*/

USE ferreteria;
GO

DECLARE @fecha_desde DATE = '2026-02-01';
DECLARE @fecha_hasta DATE =  GETDATE();;


-- CONSULTA A: VENTAS POR VENDEDOR
-- Muestra cantidad de ventas, unidades vendidas y total vendido.
-- El total se calcula con el precio unitario registrado en el
-- detalle de la venta, no con el precio actual del producto.
-- Se consideran vendedores con id_perfil = 2.


SELECT
    U.nombre AS [Nombre],
    U.apellido AS [Apellido],
    COUNT(DISTINCT V.id_venta) AS [Cantidad de ventas],
    SUM(DV.cantidad) AS [Unidades vendidas],
    CAST(SUM(DV.cantidad * DV.precio_unitario_catalogo) AS DECIMAL(12, 2))
        AS [Total vendido]
FROM USUARIO AS U
INNER JOIN VENTA AS V
    ON V.id_usuario = U.id_usuario
INNER JOIN DETALLE_VENTA AS DV
    ON DV.id_venta = V.id_venta
WHERE
    U.id_perfil = 2
    AND V.fecha_hora >= @fecha_desde
    AND V.fecha_hora < DATEADD(DAY, 1, @fecha_hasta)
GROUP BY
    U.id_usuario,
    U.nombre,
    U.apellido
ORDER BY
    [Total vendido] DESC,
    U.apellido ASC,
    U.nombre ASC;
GO


-- CONSULTA B: VENTAS POR CATEGORIA
-- Muestra unidades vendidas, cantidad de ventas, cantidad de
-- renglones de detalle y total vendido por categoría.
-- COUNT(DISTINCT V.id_venta) evita contar varias veces una misma
-- venta cuando contiene varios productos de la misma categoría.


DECLARE @fecha_desde_categoria DATE = '2026-02-01';
DECLARE @fecha_hasta_categoria DATE =  GETDATE();;

SELECT
    C.nombre_cat AS [Categoria],
    SUM(DV.cantidad) AS [Unidades vendidas],
    COUNT(DISTINCT V.id_venta) AS [Cantidad de ventas],
    COUNT(DV.id_detalle) AS [Cantidad de renglones],
    CAST(SUM(DV.cantidad * DV.precio_unitario_catalogo) AS DECIMAL(12, 2))
        AS [Total vendido]
FROM CATEGORIA AS C
INNER JOIN PRODUCTO AS P
    ON P.id_categoria = C.id_categoria
INNER JOIN DETALLE_VENTA AS DV
    ON DV.id_producto = P.id_producto
INNER JOIN VENTA AS V
    ON V.id_venta = DV.id_venta
WHERE
    V.fecha_hora >= @fecha_desde_categoria
    AND V.fecha_hora < DATEADD(DAY, 1, @fecha_hasta_categoria)
GROUP BY
    C.id_categoria,
    C.nombre_cat
ORDER BY
    [Total vendido] DESC,
    C.nombre_cat ASC;
GO
