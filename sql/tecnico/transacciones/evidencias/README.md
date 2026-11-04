# Evidencias de transacciones

Guardar aquí las capturas tomadas durante la ejecución de `02_demostracion_transacciones.sql` en SQL Server Management Studio. Las imágenes aún deben capturarse; este README describe qué mostrar en cada una.

## `01_transaccion_exitosa.png`

Debe mostrar el caso exitoso de registro de una venta:

- la venta y su detalle insertados;
- el stock de `INVENTARIO` descontado;
- el mensaje de ejecución correcta del procedimiento, cuyo flujo confirma las operaciones con `COMMIT TRANSACTION`.

La demostración envuelve esta prueba en una transacción externa y luego ejecuta `ROLLBACK` para dejar los datos como estaban. Conviene mostrar también la comprobación final de que la venta y su detalle se revirtieron y el stock volvió al valor inicial.

## `02_transaccion_rollback.png`

Debe mostrar el caso con error:

- la inserción de la venta antes del error;
- el error producido al intentar insertar un detalle con precio unitario cero;
- el mensaje de error capturado y la ejecución del `ROLLBACK`;
- la comprobación posterior de que no quedaron la venta ni el detalle y que el stock no cambió.

Usar los resultados reales de la ejecución. No agregar valores ni mensajes que no aparezcan en SSMS.
