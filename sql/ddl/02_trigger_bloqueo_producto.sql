-- =========================================================
-- INTEGRANTE 5 - TRIGGER DE BLOQUEO
-- Tabla: PRODUCTO
-- Objetivo: impedir la eliminación física de productos.
-- El sistema ya contempla baja lógica (columna 'activo' y
-- 'eliminado_en'), por lo tanto un DELETE físico rompería
-- la trazabilidad de ventas históricas en DETALLE_VENTA.
-- =========================================================

USE SistemaGestion;
GO

CREATE TRIGGER trg_BloqueoDelete_Producto
ON PRODUCTO
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSTEAD OF DELETE intercepta el DELETE antes de que se
    -- ejecute: la fila nunca se borra, por eso no hace falta
    -- ROLLBACK explícito.
    RAISERROR('No está permitido eliminar productos físicamente. Utilice baja lógica (UPDATE activo = 0) para conservar el historial de ventas.', 16, 1);
END;
GO


-- =========================================================
-- PRUEBAS DE VERIFICACIÓN
-- =========================================================

-- Prueba 1: intento de DELETE sobre un producto existente
-- Resultado esperado: rechazado por el trigger (RAISERROR)
DELETE FROM PRODUCTO WHERE id_producto = 30;

-- Prueba 2: verificación de integridad - el producto debe
-- seguir existiendo intacto tras el intento de DELETE
SELECT id_producto, nombre, activo 
FROM PRODUCTO 
WHERE id_producto = 30;
