# Transacciones y Transacciones Anidadas

**Integrante 3** — Manejo de Transacciones

## 1. Objetivo
Se implementó un mecanismo de transacciones para garantizar la **atomicidad** y **consistencia** de los datos en operaciones que afectan a múltiples tablas del sistema. 

El objetivo principal de la prueba es demostrar que, ante un fallo en medio de un proceso (como registrar una venta), la base de datos es capaz de revertir todos los cambios parciales (ROLLBACK), evitando la creación de registros huérfanos o inconsistentes.

## 2. Operación Seleccionada
Para la prueba se seleccionó el flujo transaccional más crítico del negocio: **el registro de una venta**.
Esta operación requiere interactuar con tres tablas de forma simultánea:
1. `VENTA` (cabecera de la transacción).
2. `DETALLE_VENTA` (productos adquiridos).
3. `INVENTARIO` (actualización del stock en la sucursal).

## 3. Pruebas Realizadas

### 3.1. Prueba 1: Transacción Exitosa
En esta prueba se ejecuta el flujo completo dentro de un bloque `BEGIN TRANSACTION`.
1. Se inserta un registro en `VENTA` (utilizando un cliente y usuario válidos).
2. Se recupera el ID autogenerado con `SCOPE_IDENTITY()`.
3. Se inserta el producto en `DETALLE_VENTA` asociado a ese ID.
4. Se ejecuta un `UPDATE` sobre `INVENTARIO` para restar las unidades vendidas.
5. Se confirma la operación completa con `COMMIT TRANSACTION`.

**Resultado esperado:** Los tres registros se guardan de forma simultánea y el stock se descuenta correctamente. Si alguna de las tres operaciones fallara, el `CATCH` capturaría el error y se ejecutaría un `ROLLBACK`.

### 3.2. Prueba 2: Transacción Fallida (Error Intencional)
Para demostrar la efectividad del `ROLLBACK`, se diseñó una prueba que fuerza un error de integridad referencial.
1. Se inicia la transacción (`BEGIN TRANSACTION`).
2. Se inserta la cabecera en `VENTA`.
3. **Error provocado:** se intenta insertar un producto en `DETALLE_VENTA` con un `id_producto = 9999` que no existe en la base de datos.
4. El motor de SQL Server lanza un error de clave foránea (FK) y el flujo salta al bloque `BEGIN CATCH`.
5. Se ejecuta `ROLLBACK TRANSACTION`.

**Resultado esperado:** La tabla `VENTA` no debe tener ningún registro nuevo. El `INSERT` inicial se deshace automáticamente, demostrando que la base de datos mantuvo su integridad y no quedaron "ventas fantasma" sin productos asociados.

## 4. Implementación T-SQL
A continuación, un fragmento representativo de la transacción fallida implementada:

```sql
BEGIN TRY
    BEGIN TRANSACTION;

    -- 1. Insertar en VENTA
    INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) 
    VALUES ('A', 0.00, 1, 1, 1);
    
    DECLARE @id_venta_fallida INT = SCOPE_IDENTITY();

    -- 2. Forzar Error (Producto inexistente)
    INSERT INTO DETALLE_VENTA (cantidad, precio_unitario_catalogo, id_producto, id_venta)
    VALUES (1, 15000.00, 9999, @id_venta_fallida);

    -- 3. Actualizar Stock
    UPDATE INVENTARIO 
    SET stock = stock - 1 
    WHERE id_producto = 1 AND id_sucursal = 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Si hay error, se deshace todo
    ROLLBACK TRANSACTION;
    PRINT 'Error detectado intencionalmente. La venta NO se guardó.';
END CATCH;
