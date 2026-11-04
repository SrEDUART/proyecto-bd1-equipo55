USE ProyectoFerreteria;
GO


-- demostracion de seguridad (pruebas)



-- prueba 1: intento de insercion directa (debe fallar por acceso denegado)
EXECUTE AS USER = 'usuario_vendedor';

BEGIN TRY
    INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion)
    VALUES ('Prueba', 'Denegada', 99999999, 'denegado@test.com', 31);
END TRY
BEGIN CATCH
    PRINT 'Resultado esperado: ' + ERROR_MESSAGE();
END CATCH;

REVERT;
GO

-- prueba 2: ejecucion a traves del procedimiento almacenado (debe funcionar)
EXECUTE AS USER = 'usuario_vendedor';

EXEC sp_InsertarCliente 'Mariana', 'Gomez', 47111222, 'mariana.gomez@test.com', 31;

REVERT;
GO

-- verificar insercion realizada via procedimiento
SELECT * FROM CLIENTE WHERE dni = 47111222;
GO
