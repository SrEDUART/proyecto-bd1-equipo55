# Etapa V - Procedimientos y Funciones Almacenadas: Operaciones CRUD (Cliente)

## 1. Descripción
Implementación de los tres procedimientos almacenados para la gestión básica de la tabla `CLIENTE` (Alta, Modificación y Baja Lógica) correspondientes a la Etapa V.

---

## 2. Detalle de los Procedimientos

### 2.1. Inserción (`sp_InsertarCliente`)
Recibe los datos del nuevo cliente (`nombre`, `apellido`, `dni`, `correo`, `id_direccion`) y ejecuta la sentencia `INSERT INTO CLIENTE`.

### 2.2. Modificación (`sp_ModificarCliente`)
Recibe el `id_cliente` junto a los datos actualizados. Comprueba que el cliente exista en la base de datos antes de realizar el `UPDATE`.

### 2.3. Eliminación (`sp_EliminarCliente`)
Recibe el `id_cliente` y realiza una **baja lógica** actualizando el campo `eliminado_en = GETDATE()`. Esto permite desactivar el registro sin romper la integridad referencial con las ventas asociadas.

---

## 3. Ejemplo de Ejecución y Demostración (T-SQL)

```sql
USE proyectoFerreteria;
GO

-- prueba de insercion
IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE dni = 48999888)
BEGIN
    EXEC sp_InsertarCliente 'Carlos', 'Benitez', 48999888, 'carlos.benitez@test.com', 31;
END

-- prueba de modificacion
EXEC sp_ModificarCliente 301, 'Carlos Alberto', 'Benitez', 48999888, 'carlos.modificado@test.com', 31;

-- prueba de eliminacion (baja logica)
EXEC sp_EliminarCliente 301;
