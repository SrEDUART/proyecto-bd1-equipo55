# Evidencias de transacciones

Guardar aquí las dos capturas tomadas durante la ejecución de `02_demostracion_transacciones.sql` en SQL Server Management Studio. Las imágenes aún deben capturarse; este README describe qué mostrar en cada una.

## `01_transaccion_exitosa.png`

Debe mostrar la ejecución exitosa del registro de una venta:

- el mensaje de ejecución correcta del procedimiento, que confirma que el flujo llegó a `COMMIT TRANSACTION`;
- los resultados de `VENTA` y `DETALLE_VENTA` que muestran los registros creados;
- el resultado de `INVENTARIO` con el stock descontado.

La demostración usa una transacción externa para consultar esos resultados y luego restaurar los datos con `ROLLBACK`. Ese rollback externo es solo limpieza de la prueba; no indica que haya fallado la transacción del procedimiento.

## `02_transaccion_rollback.png`

Debe mostrar el caso con error y su verificación:

- la inserción de la venta antes del error;
- el error `CHECK` producido al intentar insertar un detalle con `precio_unitario_catalogo = 0`;
- el mensaje de error capturado y la ejecución del `ROLLBACK`;
- la comprobación posterior de que no quedó la venta ni el detalle y de que el stock no cambió.

Usar los resultados reales de la ejecución. No agregar valores ni mensajes que no aparezcan en SSMS.
