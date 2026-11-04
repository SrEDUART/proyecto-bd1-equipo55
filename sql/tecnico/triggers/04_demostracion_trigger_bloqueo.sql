USE ProyectoFerreteria;
GO

SET NOCOUNT ON;

DECLARE @id_cliente INT;
DECLARE @delete_rechazado BIT = 0;

SELECT TOP (1) @id_cliente = id_cliente
FROM dbo.CLIENTE
WHERE eliminado_en IS NULL
ORDER BY id_cliente;

IF @id_cliente IS NULL
    THROW 55001, 'No existen clientes activos para ejecutar la demostración.', 1;

BEGIN TRY
    BEGIN TRANSACTION;

    PRINT 'Cliente antes del intento de DELETE:';
    SELECT id_cliente, nombre, apellido, dni, correo, eliminado_en
    FROM dbo.CLIENTE
    WHERE id_cliente = @id_cliente;

    PRINT 'Intentando eliminar el cliente seleccionado:';
    BEGIN TRY
        DELETE FROM dbo.CLIENTE
        WHERE id_cliente = @id_cliente;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 50000
            THROW;

        SET @delete_rechazado = 1;
        PRINT 'Mensaje de rechazo: ' + ERROR_MESSAGE();
    END CATCH;

    PRINT 'El mismo cliente después del intento:';
    SELECT id_cliente, nombre, apellido, dni, correo, eliminado_en
    FROM dbo.CLIENTE
    WHERE id_cliente = @id_cliente;

    IF @delete_rechazado = 0
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 55002, 'El DELETE no fue rechazado por el trigger.', 1;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.CLIENTE
        WHERE id_cliente = @id_cliente
          AND eliminado_en IS NULL
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 55003, 'El cliente no permanece intacto después del intento.', 1;
    END;

    ROLLBACK TRANSACTION;
    PRINT 'El DELETE fue rechazado y el cliente permanece intacto.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
GO
