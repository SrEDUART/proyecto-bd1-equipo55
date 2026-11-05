USE ProyectoFerreteria;
GO

IF OBJECT_ID('dbo.VENTA_HISTORICA', 'U') IS NULL
    THROW 55001, 'No existe dbo.VENTA_HISTORICA. Ejecute primero 01_implementacion_indices.sql.', 1;
GO

-- Quitar los indices de las ejecuciones anteriores para iniciar sin indice.
IF EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_VentaHistorica_Fecha'
      AND object_id = OBJECT_ID('dbo.VENTA_HISTORICA')
)
    DROP INDEX IX_VentaHistorica_Fecha ON dbo.VENTA_HISTORICA;

IF EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_VentaHistorica_Fecha_Cobertura'
      AND object_id = OBJECT_ID('dbo.VENTA_HISTORICA')
)
    DROP INDEX IX_VentaHistorica_Fecha_Cobertura ON dbo.VENTA_HISTORICA;

IF EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'CX_VentaHistorica_Fecha'
      AND object_id = OBJECT_ID('dbo.VENTA_HISTORICA')
)
    DROP INDEX CX_VentaHistorica_Fecha ON dbo.VENTA_HISTORICA;
GO

-- En SSMS, activar el plan de ejecucion real con Ctrl+M antes de ejecutar.
-- Se usa exactamente la misma consulta en los tres escenarios.
-- Escenario 1: tabla sin indice.
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT id_venta, fecha_venta, estado, total
FROM dbo.VENTA_HISTORICA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

-- Escenario 2: indice clustered sobre fecha_venta.
IF EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'CX_VentaHistorica_Fecha'
      AND object_id = OBJECT_ID('dbo.VENTA_HISTORICA')
)
    DROP INDEX CX_VentaHistorica_Fecha ON dbo.VENTA_HISTORICA;
GO

CREATE CLUSTERED INDEX CX_VentaHistorica_Fecha
ON dbo.VENTA_HISTORICA (fecha_venta);
GO

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT id_venta, fecha_venta, estado, total
FROM dbo.VENTA_HISTORICA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

-- Escenario 3: quitar el clustered y crear un indice de cobertura.
DROP INDEX CX_VentaHistorica_Fecha ON dbo.VENTA_HISTORICA;
GO

IF EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_VentaHistorica_Fecha_Cobertura'
      AND object_id = OBJECT_ID('dbo.VENTA_HISTORICA')
)
    DROP INDEX IX_VentaHistorica_Fecha_Cobertura ON dbo.VENTA_HISTORICA;
GO

CREATE NONCLUSTERED INDEX IX_VentaHistorica_Fecha_Cobertura
ON dbo.VENTA_HISTORICA (fecha_venta)
INCLUDE (id_venta, estado, total);
GO

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SELECT id_venta, fecha_venta, estado, total
FROM dbo.VENTA_HISTORICA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO
