# Etapa V - Seguridad: Permisos y Roles (Operador de Ventas)

## 1. Descripción
Implementación de la política de seguridad y control de acceso para el perfil de ventas dentro de la base de datos `proyectoFerreteria`, correspondiente a la Etapa V. Se configura el rol de base de datos `rol_operador_ventas`, se aplican restricciones de acceso directo sobre la tabla `CLIENTE` mediante `DENY`, se conceden permisos de ejecución (`GRANT EXECUTE`) sobre los procedimientos almacenados correspondientes y se valida todo con el usuario de prueba `usuario_vendedor`.

---

## 2. Detalle de los Permisos y Controles

### 2.1. Creación de Rol y Usuario
Se verifica y crea el rol de base de datos `rol_operador_ventas` y el usuario `usuario_vendedor` (creado `WITHOUT LOGIN` para pruebas internas de permisos), asignando posteriormente el usuario como miembro del rol.

### 2.2. Restricción Directa de Escritura (`DENY`)
Se aplica una restricción explícita de `DENY INSERT, UPDATE, DELETE ON dbo.CLIENTE TO rol_operador_ventas`. Esto impide que los usuarios con este rol modifiquen la tabla `CLIENTE` de forma directa a través de sentencias SQL estándar.

### 2.3. Lectura y Ejecución Controlada (`GRANT SELECT` / `GRANT EXECUTE`)
Se otorga permiso de consulta (`GRANT SELECT`) sobre la tabla `CLIENTE` y permiso de ejecución (`GRANT EXECUTE`) exclusivo sobre los procedimientos almacenados de gestión de clientes:
- `dbo.sp_InsertarCliente`
- `dbo.sp_ModificarCliente`
- `dbo.sp_EliminarCliente`

Esto asegura el principio de menor privilegio: el usuario solo puede operar a través de la interfaz lógica controlada por los procedimientos almacenados.

---

## 3. Ejemplo de Ejecución y Demostración (T-SQL)

```sql
USE proyectoFerreteria;
GO

-- Prueba 1: Intento de inserción directa (Debe fallar intencionalmente por el DENY)
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

-- Prueba 2: Ejecución a través del procedimiento almacenado (Debe funcionar por el GRANT EXECUTE)
EXECUTE AS USER = 'usuario_vendedor';

EXEC sp_InsertarCliente 'Mariana', 'Gomez', 47111222, 'mariana.gomez@test.com', 31;

REVERT;
GO

-- Verificar inserción realizada vía procedimiento
SELECT * FROM CLIENTE WHERE dni = 47111222;
GO
