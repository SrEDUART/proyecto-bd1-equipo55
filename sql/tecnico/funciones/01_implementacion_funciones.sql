USE ProyectoFerreteria;
GO

/*
  SCRIPT SQL DE IMPLEMENTACION: FUNCIONES ALMACENADAS
  Proyecto: Ferreteria

  Objetivo:
    Crear o actualizar las tres funciones almacenadas del proyecto:
      1. dbo.fn_ImporteDetalleVenta
      2. dbo.fn_TotalGastadoCliente
      3. dbo.fn_StockDisponible

  Requisito previo:
    La base de datos ProyectoFerreteria debe existir y contener las tablas
    utilizadas por las funciones.

  Ejecutar este archivo antes de demostracion_funciones.sql.
  Este script contiene solamente la definicion de las funciones; las pruebas
  de funcionamiento y comparaciones se encuentran en el archivo de demostracion.
*/

SET NOCOUNT ON;
GO

/*=============================================================================
  PARTE 1. CREACION DE FUNCIONES
=============================================================================*/

-- ----------------------------------------------------------------------------
-- FUNCION 1: dbo.fn_ImporteDetalleVenta
--
-- Recibe el identificador de un detalle de venta y devuelve su importe final.
-- El importe se calcula con:
-- cantidad * precio_unitario_catalogo * (1 - descuento / 100)
--
-- Se utiliza precio_unitario_catalogo porque conserva el precio historico
-- aplicado al momento de realizar la venta.
--
-- Si el id_detalle no existe, devuelve NULL.
-- ----------------------------------------------------------------------------

CREATE OR ALTER FUNCTION dbo.fn_ImporteDetalleVenta
(
    @id_detalle INT
)
RETURNS DECIMAL(14,2)
AS
BEGIN
    DECLARE @importe DECIMAL(14,2);

    SELECT
        @importe = CAST(
            DV.cantidad
            * DV.precio_unitario_catalogo
            * (1 - V.descuento / 100.0)
            AS DECIMAL(14,2)
        )
    FROM dbo.DETALLE_VENTA AS DV
    INNER JOIN dbo.VENTA AS V
        ON V.id_venta = DV.id_venta
    WHERE DV.id_detalle = @id_detalle;

    RETURN @importe;
END;
GO


-- ----------------------------------------------------------------------------
-- FUNCION 2: dbo.fn_TotalGastadoCliente
--
-- Recibe el identificador de un cliente y devuelve el importe total de sus
-- ventas, sumando todos los detalles y aplicando el descuento de cada venta.
--
-- Se consideran todas las ventas registradas para el cliente, sin aplicar
-- un filtro por eliminacion logica del cliente.
-- Si el cliente no tiene ventas con detalles asociados, devuelve cero.
-- ----------------------------------------------------------------------------

CREATE OR ALTER FUNCTION dbo.fn_TotalGastadoCliente
(
    @id_cliente INT
)
RETURNS DECIMAL(14,2)
AS
BEGIN
    DECLARE @total DECIMAL(14,2);

    SELECT
        @total = COALESCE(
            CAST(
                SUM(
                    DV.cantidad
                    * DV.precio_unitario_catalogo
                    * (1 - V.descuento / 100.0)
                )
                AS DECIMAL(14,2)
            ),
            0
        )
    FROM dbo.VENTA AS V
    INNER JOIN dbo.DETALLE_VENTA AS DV
        ON DV.id_venta = V.id_venta
    WHERE V.id_cliente = @id_cliente;

    RETURN @total;
END;
GO


-- ----------------------------------------------------------------------------
-- FUNCION 3: dbo.fn_StockDisponible
--
-- Recibe el identificador de un producto y una sucursal.
-- Devuelve el stock registrado en INVENTARIO para esa combinacion.
--
-- La tabla INVENTARIO posee una restriccion UNIQUE sobre
-- (id_producto, id_sucursal), por lo que existe como maximo un registro.
--
-- Si no existe inventario para esa combinacion, devuelve NULL.
-- ----------------------------------------------------------------------------

CREATE OR ALTER FUNCTION dbo.fn_StockDisponible
(
    @id_producto INT,
    @id_sucursal INT
)
RETURNS INT
AS
BEGIN
    DECLARE @stock INT;

    SELECT
        @stock = I.stock
    FROM dbo.INVENTARIO AS I
    WHERE I.id_producto = @id_producto
      AND I.id_sucursal = @id_sucursal;

    RETURN @stock;
END;
GO
