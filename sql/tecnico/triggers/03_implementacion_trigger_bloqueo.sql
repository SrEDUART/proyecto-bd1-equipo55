USE ProyectoFerreteria;
GO

-- ============================================================
-- TRIGGER DE BLOQUEO DE DELETE SOBRE CLIENTE
-- ============================================================
-- Impide eliminar físicamente clientes.
-- El sistema dispone del campo eliminado_en para realizar
-- bajas lógicas sin perder información histórica.
-- ============================================================

CREATE OR ALTER TRIGGER dbo.TR_CLIENTE_BLOQUEAR_DELETE
ON dbo.CLIENTE
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    RAISERROR(
        'No se permite eliminar clientes fisicamente. Debe utilizarse la baja logica.',
        16,
        1
    );
END;
GO