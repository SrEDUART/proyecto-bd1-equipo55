USE proyectoFerreteria;
GO

-- 1. Activar estadisticas de tiempo y lecturas de E/S en SSMS
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- 2. Consulta por rango de fechas sobre 1.000.000 de filas aprovechando el indice IX_VentaHistorica_Fecha_Cobertura
SELECT id_venta, fecha_venta, estado, total
FROM VENTA_HISTORICA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- 3. Desactivar estadisticas
SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO
