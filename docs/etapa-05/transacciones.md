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
El procedimiento `sp_RegistrarVentaTransaccion` realiza el flujo dentro de una transacción:
1. Inserta la cabecera de la venta en `VENTA`.
2. Inserta el producto, la cantidad y el precio en `DETALLE_VENTA`.
3. Actualiza `INVENTARIO` para descontar las unidades vendidas.
4. Si las operaciones terminan correctamente, ejecuta `COMMIT TRANSACTION`.

La demostración consulta la venta y su detalle, y muestra el stock luego de la operación. También verifica que la venta y el detalle se hayan creado y que el stock se haya descontado.

La demostración ejecuta este procedimiento dentro de una transacción externa de prueba. Luego de mostrar y verificar los resultados, revierte esa transacción externa para dejar la base de datos como estaba. Esta limpieza no significa que la operación del procedimiento haya fallado: el procedimiento completó su flujo y ejecutó `COMMIT`.

### 3.2. Prueba 2: Transacción Fallida (Error Intencional)
Para demostrar la efectividad del `ROLLBACK`, la demostración realiza las siguientes operaciones:
1. Se inicia la transacción (`BEGIN TRANSACTION`).
2. Se inserta una cabecera en `VENTA`.
3. Se intenta insertar un detalle en `DETALLE_VENTA` con `precio_unitario_catalogo = 0`.
4. La restricción `CHECK`, que exige un precio unitario mayor que cero, provoca el error y el flujo pasa al bloque `CATCH`.
5. El bloque `CATCH` ejecuta `ROLLBACK TRANSACTION`.

Después, la demostración consulta la venta y el detalle para comprobar que no quedaron registros de esa operación y consulta `INVENTARIO` para verificar que el stock no cambió.

## 4. Implementación T-SQL
A continuación se muestra el fragmento de la demostración que provoca el error:

```sql
BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) 
    VALUES ('A', 0.00, @id_sucursal, @id_cliente, @id_usuario);
    
    DECLARE @id_venta_fallida INT = SCOPE_IDENTITY();

    -- El precio cero incumple la restricción CHECK.
    INSERT INTO DETALLE_VENTA (cantidad, precio_unitario_catalogo, id_producto, id_venta)
    VALUES (@cantidad, 0.00, @id_producto, @id_venta_fallida);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Si hay error, se deshace todo
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    IF ERROR_NUMBER() <> 547
        THROW;

    PRINT 'Error real capturado; la transacción fue revertida: ' + ERROR_MESSAGE();
END CATCH;
```

## 5. Conclusión

`COMMIT` confirma las operaciones cuando la transacción termina correctamente. Si ocurre un error, `ROLLBACK` revierte el conjunto completo de modificaciones. Así se evitan estados parciales y se mantiene la consistencia de los datos.
