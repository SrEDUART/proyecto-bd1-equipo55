USE proyectoFerreteria;
GO


-- demostracion de procedimientos almacenados (pruebas)

-- 1. prueba de insercion (solo inserta si no existe previamente el DNI)
IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE dni = 48999888)
BEGIN
    EXEC sp_InsertarCliente 'Carlos', 'Benitez', 48999888, 'carlos.benitez@test.com', 31;
END

-- verificar insercion
SELECT TOP 1 * FROM CLIENTE ORDER BY id_cliente DESC;

-- 2. prueba de modificacion (modifica solo nombre/apellido del ultimo cliente sin tocar DNI/correo para evitar duplicados)
DECLARE @id_prueba INT = (SELECT MAX(id_cliente) FROM CLIENTE);
DECLARE @dni_actual INT = (SELECT dni FROM CLIENTE WHERE id_cliente = @id_prueba);
DECLARE @correo_actual VARCHAR(100) = (SELECT correo FROM CLIENTE WHERE id_cliente = @id_prueba);
DECLARE @direccion_actual INT = (SELECT id_direccion FROM CLIENTE WHERE id_cliente = @id_prueba);

EXEC sp_ModificarCliente @id_prueba, 'Carlos Alberto', 'Benitez', @dni_actual, @correo_actual, @direccion_actual;

-- verificar modificacion
SELECT * FROM CLIENTE WHERE id_cliente = (SELECT MAX(id_cliente) FROM CLIENTE);

-- 3. prueba de eliminacion (baja logica sobre el ultimo cliente)
DECLARE @id_prueba_baja INT = (SELECT MAX(id_cliente) FROM CLIENTE);
EXEC sp_EliminarCliente @id_prueba_baja;

-- verificar fecha de eliminacion
SELECT * FROM CLIENTE WHERE id_cliente = (SELECT MAX(id_cliente) FROM CLIENTE);
GO
