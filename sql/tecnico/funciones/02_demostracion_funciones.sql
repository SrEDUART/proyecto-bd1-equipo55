/*
  SCRIPT SQL DE DEMOSTRACION DE FUNCIONES ALMACENADAS

  Requisito previo:
    Ejecutar implementacion_funciones.sql para crear las tres funciones.

  Este archivo demuestra su utilización mediante:
    - Pruebas individuales de funcionamiento.
    - Comparación con consultas directas.
    - Medición de tiempo y lecturas con STATISTICS TIME e IO.
    - Verificación de coincidencia de resultados.
*/

USE ferreteria;
GO

SET NOCOUNT ON;
GO

/*=============================================================================
  PARTE 1. PRUEBAS DE FUNCIONAMIENTO
=============================================================================*/

-- ----------------------------------------------------------------------------
-- PRUEBA 1: importe calculado para los primeros diez detalles.
-- ----------------------------------------------------------------------------

PRINT 'PRUEBA 1: IMPORTE DE DETALLES DE VENTA';

SELECT TOP (10)
    DV.id_detalle,
    DV.cantidad,
    DV.precio_unitario_catalogo,
    V.descuento,
    dbo.fn_ImporteDetalleVenta(DV.id_detalle) AS importe_calculado
FROM dbo.DETALLE_VENTA AS DV
INNER JOIN dbo.VENTA AS V
    ON V.id_venta = DV.id_venta
ORDER BY DV.id_detalle;
GO


-- ----------------------------------------------------------------------------
-- PRUEBA 2: total gastado por cada cliente no eliminado logicamente.
-- Los clientes sin ventas deben mostrar cero.
-- ----------------------------------------------------------------------------

PRINT 'PRUEBA 2: TOTAL GASTADO POR CLIENTE';

SELECT
    C.id_cliente,
    C.nombre,
    C.apellido,
    dbo.fn_TotalGastadoCliente(C.id_cliente) AS total_gastado
FROM dbo.CLIENTE AS C
WHERE C.eliminado_en IS NULL
ORDER BY total_gastado DESC;
GO


-- ----------------------------------------------------------------------------
-- PRUEBA 3: stock de cada producto en cada sucursal.
-- ----------------------------------------------------------------------------

PRINT 'PRUEBA 3: STOCK POR PRODUCTO Y SUCURSAL';

SELECT
    I.id_producto,
    P.nombre_producto,
    I.id_sucursal,
    I.stock AS stock_guardado,
    dbo.fn_StockDisponible(I.id_producto, I.id_sucursal) AS stock_funcion
FROM dbo.INVENTARIO AS I
INNER JOIN dbo.PRODUCTO AS P
    ON P.id_producto = I.id_producto
ORDER BY I.id_sucursal, I.id_producto;
GO


/*=============================================================================
  PARTE 2. COMPARACION DE RESULTADOS Y EFICIENCIA

  Se comparan:
    A. Consultas directas, que realizan el calculo en el SELECT.
    B. Consultas que invocan las funciones almacenadas.

  Para medir:
    - STATISTICS TIME informa tiempo de CPU y tiempo transcurrido.
    - STATISTICS IO informa lecturas logicas y fisicas.

  La medicion depende de los datos, indices, memoria, version y carga del
  servidor. No se debe afirmar que una alternativa es mas rapida sin medirla.
=============================================================================*/

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO


-- ----------------------------------------------------------------------------
-- COMPARACION 1A: importe de detalle mediante consulta directa.
-- ----------------------------------------------------------------------------

PRINT 'COMPARACION 1A: IMPORTE MEDIANTE CONSULTA DIRECTA';

SELECT
    DV.id_detalle,
    CAST(
        DV.cantidad
        * DV.precio_unitario_catalogo
        * (1 - V.descuento / 100.0)
        AS DECIMAL(14,2)
    ) AS importe
FROM dbo.DETALLE_VENTA AS DV
INNER JOIN dbo.VENTA AS V
    ON V.id_venta = DV.id_venta
ORDER BY DV.id_detalle;
GO


-- ----------------------------------------------------------------------------
-- COMPARACION 1B: importe de detalle mediante funcion escalar.
-- ----------------------------------------------------------------------------

PRINT 'COMPARACION 1B: IMPORTE MEDIANTE FUNCION';

SELECT
    DV.id_detalle,
    dbo.fn_ImporteDetalleVenta(DV.id_detalle) AS importe
FROM dbo.DETALLE_VENTA AS DV
ORDER BY DV.id_detalle;
GO


-- ----------------------------------------------------------------------------
-- COMPARACION 2A: total gastado por cliente mediante consulta directa.
-- Se usa LEFT JOIN para incluir clientes sin ventas, cuyo total es cero.
-- ----------------------------------------------------------------------------

PRINT 'COMPARACION 2A: TOTAL POR CLIENTE MEDIANTE CONSULTA DIRECTA';

SELECT
    C.id_cliente,
    C.nombre,
    C.apellido,
    COALESCE(
        CAST(
            SUM(
                DV.cantidad
                * DV.precio_unitario_catalogo
                * (1 - V.descuento / 100.0)
            )
            AS DECIMAL(14,2)
        ),
        0
    ) AS total_gastado
FROM dbo.CLIENTE AS C
LEFT JOIN dbo.VENTA AS V
    ON V.id_cliente = C.id_cliente
LEFT JOIN dbo.DETALLE_VENTA AS DV
    ON DV.id_venta = V.id_venta
WHERE C.eliminado_en IS NULL
GROUP BY
    C.id_cliente,
    C.nombre,
    C.apellido
ORDER BY total_gastado DESC;
GO


-- ----------------------------------------------------------------------------
-- COMPARACION 2B: total gastado por cliente mediante funcion.
-- ----------------------------------------------------------------------------

PRINT 'COMPARACION 2B: TOTAL POR CLIENTE MEDIANTE FUNCION';

SELECT
    C.id_cliente,
    C.nombre,
    C.apellido,
    dbo.fn_TotalGastadoCliente(C.id_cliente) AS total_gastado
FROM dbo.CLIENTE AS C
WHERE C.eliminado_en IS NULL
ORDER BY total_gastado DESC;
GO


-- ----------------------------------------------------------------------------
-- COMPARACION 3A: stock mediante consulta directa.
-- ----------------------------------------------------------------------------

PRINT 'COMPARACION 3A: STOCK MEDIANTE CONSULTA DIRECTA';

SELECT
    I.id_producto,
    I.id_sucursal,
    I.stock AS stock_disponible
FROM dbo.INVENTARIO AS I
ORDER BY I.id_sucursal, I.id_producto;
GO


-- ----------------------------------------------------------------------------
-- COMPARACION 3B: stock mediante funcion.
-- ----------------------------------------------------------------------------

PRINT 'COMPARACION 3B: STOCK MEDIANTE FUNCION';

SELECT
    I.id_producto,
    I.id_sucursal,
    dbo.fn_StockDisponible(I.id_producto, I.id_sucursal) AS stock_disponible
FROM dbo.INVENTARIO AS I
ORDER BY I.id_sucursal, I.id_producto;
GO


SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO


/*=============================================================================
  PARTE 3. VERIFICACION DE COINCIDENCIA DE RESULTADOS

  Estas consultas permiten comprobar que el calculo directo y el realizado
  mediante las funciones producen los mismos valores.
=============================================================================*/

-- ----------------------------------------------------------------------------
-- VERIFICACION 1: importe de cada detalle.
-- Si no devuelve filas, los resultados coinciden.
-- ----------------------------------------------------------------------------

PRINT 'VERIFICACION 1: DIFERENCIAS EN IMPORTE DE DETALLES';

SELECT
    DV.id_detalle,
    CAST(
        DV.cantidad
        * DV.precio_unitario_catalogo
        * (1 - V.descuento / 100.0)
        AS DECIMAL(14,2)
    ) AS importe_directo,
    dbo.fn_ImporteDetalleVenta(DV.id_detalle) AS importe_funcion
FROM dbo.DETALLE_VENTA AS DV
INNER JOIN dbo.VENTA AS V
    ON V.id_venta = DV.id_venta
WHERE CAST(
        DV.cantidad
        * DV.precio_unitario_catalogo
        * (1 - V.descuento / 100.0)
        AS DECIMAL(14,2)
      ) <> dbo.fn_ImporteDetalleVenta(DV.id_detalle);
GO


-- ----------------------------------------------------------------------------
-- VERIFICACION 2: total gastado por cliente.
-- Si no devuelve filas, los resultados coinciden.
-- ----------------------------------------------------------------------------

PRINT 'VERIFICACION 2: DIFERENCIAS EN TOTAL POR CLIENTE';

SELECT
    C.id_cliente,
    COALESCE(
        CAST(
            SUM(
                DV.cantidad
                * DV.precio_unitario_catalogo
                * (1 - V.descuento / 100.0)
            )
            AS DECIMAL(14,2)
        ),
        0
    ) AS total_directo,
    dbo.fn_TotalGastadoCliente(C.id_cliente) AS total_funcion
FROM dbo.CLIENTE AS C
LEFT JOIN dbo.VENTA AS V
    ON V.id_cliente = C.id_cliente
LEFT JOIN dbo.DETALLE_VENTA AS DV
    ON DV.id_venta = V.id_venta
WHERE C.eliminado_en IS NULL
GROUP BY C.id_cliente
HAVING COALESCE(
            CAST(
                SUM(
                    DV.cantidad
                    * DV.precio_unitario_catalogo
                    * (1 - V.descuento / 100.0)
                )
                AS DECIMAL(14,2)
            ),
            0
       ) <> dbo.fn_TotalGastadoCliente(C.id_cliente);
GO


-- ----------------------------------------------------------------------------
-- VERIFICACION 3: stock por producto y sucursal.
-- Si no devuelve filas, los resultados coinciden.
-- ----------------------------------------------------------------------------

PRINT 'VERIFICACION 3: DIFERENCIAS EN STOCK';

SELECT
    I.id_producto,
    I.id_sucursal,
    I.stock AS stock_directo,
    dbo.fn_StockDisponible(I.id_producto, I.id_sucursal) AS stock_funcion
FROM dbo.INVENTARIO AS I
WHERE I.stock <> dbo.fn_StockDisponible(I.id_producto, I.id_sucursal);
GO


/*=============================================================================
  FIN DEL ARCHIVO

  Interpretacion:
    - Las funciones encapsulan calculos y consultas reutilizables.
    - Las consultas directas suelen permitir al optimizador trabajar con toda
      la consulta de manera mas integrada.
    - Las funciones escalares pueden agregar costo cuando se invocan muchas
      veces, aunque el resultado depende de la version de SQL Server y de si
      el motor puede aplicar optimizaciones como scalar UDF inlining.
    - STATISTICS TIME e IO permiten observar el costo real de cada alternativa.
    - Las verificaciones finales deben devolver cero filas si los calculos
      coinciden.
=============================================================================*/
