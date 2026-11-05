# Triggers de auditoría sobre `PRODUCTO`

## 1. Definición y objetivo

Un trigger es una acción que SQL Server ejecuta automáticamente ante un evento en una tabla. En este caso, `TR_PRODUCTO_AUD_UPDATE` y `TR_PRODUCTO_AUD_DELETE` guardan los valores anteriores de `PRODUCTO` cuando se modifica o elimina una fila.

El objetivo de la auditoría es conservar una trazabilidad de los cambios y eliminaciones, incluyendo los datos previos, el tipo de operación, la fecha y hora y el usuario de base de datos que la realizó. Se audita `PRODUCTO` porque sus precios y demás datos de catálogo pueden cambiar, y es importante poder reconstruir su estado previo.

## 2. Ventajas y aplicaciones

- **Trazabilidad:** deja constancia de las modificaciones y eliminaciones.
- **Control de modificaciones:** permite revisar qué datos del producto cambiaron.
- **Identificación del usuario responsable:** registra el usuario SQL que ejecutó la operación.
- **Conservación del estado previo:** mantiene una copia de los valores anteriores del producto.
- **Apoyo a auditorías y revisión de incidentes:** facilita investigar cambios inesperados y reconstruir el historial disponible.

## 3. Implementación en SQL Server Express

La implementación está en [`01_implementacion_triggers_auditoria.sql`](../../sql/tecnico/triggers/01_implementacion_triggers_auditoria.sql). Debe ejecutarse en SQL Server Express después de crear la base `ProyectoFerreteria` y las tablas del proyecto.

El script crea `AUDITORIA_PRODUCTO` solo si aún no existe. Su estructura conserva el identificador del producto, el tipo de operación, los valores anteriores de las columnas de `PRODUCTO`, `fecha_hora` y `usuario_bd`. Una restricción `CHECK` limita `tipo_operacion` a `UPDATE` o `DELETE`. La fecha se registra con `SYSDATETIME()` y el usuario SQL con `SUSER_SNAME()`.

`AUDITORIA_PRODUCTO.id_producto` no tiene una clave foránea hacia `PRODUCTO`: así, la fila de auditoría permanece después de que se elimina el producto.

### Funcionamiento de los triggers

- `TR_PRODUCTO_AUD_UPDATE` se ejecuta después de un `UPDATE`.
- `TR_PRODUCTO_AUD_DELETE` se ejecuta después de un `DELETE`.

SQL Server proporciona la tabla lógica `deleted` con los datos anteriores: en un `UPDATE`, contiene los valores previos al cambio y, en un `DELETE`, los de la fila eliminada. Los triggers los copian a la auditoría con `INSERT ... SELECT`. Así, también se registra cada fila cuando una sentencia afecta varios productos.

El DDL define `precio_venta` como una columna calculada y persistida. La auditoría lee su valor anterior desde `deleted`, junto con `precio_costo` y `porcentaje_ganancia`.

## 4. Caso concreto aplicado al sistema

Cuando se modifica el costo o el porcentaje de ganancia de un producto, `TR_PRODUCTO_AUD_UPDATE` conserva en `AUDITORIA_PRODUCTO` el costo, porcentaje y precio de venta que tenía antes del cambio. Si el producto se elimina, `TR_PRODUCTO_AUD_DELETE` conserva su identificador y el resto de sus valores previos aunque ya no exista en `PRODUCTO`.

Ambos registros incluyen el tipo de operación, la fecha y hora de ejecución y el usuario de base de datos. El mecanismo es automático y también cubre las sentencias que afectan varios productos.

## 5. Script de demostración y resultados obtenidos

La demostración está en [`02_demostracion_triggers_auditoria.sql`](../../sql/tecnico/triggers/02_demostracion_triggers_auditoria.sql). Ejecutar primero el script de implementación y luego el de demostración.

El script selecciona una categoría existente, crea productos temporales con códigos de barras generados dinámicamente y ejecuta dos casos:

1. **UPDATE:** muestra el producto inicial, modifica `precio_costo` y `porcentaje_ganancia`, muestra los valores nuevos y consulta la fila de auditoría. Esta debe indicar `UPDATE` y contener los valores iniciales, además de `fecha_hora` y `usuario_bd`.
2. **DELETE:** muestra otro producto antes de eliminarlo, confirma con una consulta sin resultados que ya no existe en `PRODUCTO` y consulta la fila de auditoría. Esta debe indicar `DELETE` y conservar sus valores anteriores, `fecha_hora` y `usuario_bd`.

Las consultas de evidencia se ejecutan dentro de la transacción y antes del `ROLLBACK`, que revierte los productos temporales y sus filas de auditoría. Las capturas de implementación, `UPDATE` y `DELETE` se describen en [`evidencias/README.md`](../../sql/tecnico/triggers/evidencias/README.md).

## 6. Bloqueo de eliminación física de clientes

La implementación está en [`03_implementacion_trigger_bloqueo.sql`](../../sql/tecnico/triggers/03_implementacion_trigger_bloqueo.sql). Se eligió `CLIENTE` porque la tabla tiene el campo `eliminado_en` y el sistema contempla la baja lógica para conservar sus datos.

El trigger `TR_CLIENTE_BLOQUEAR_DELETE` es `INSTEAD OF DELETE`: se ejecuta en lugar del borrado solicitado. Emite un mensaje con `RAISERROR` y no elimina la fila.

La demostración está en [`04_demostracion_trigger_bloqueo.sql`](../../sql/tecnico/triggers/04_demostracion_trigger_bloqueo.sql). Selecciona un cliente activo, muestra sus datos, intenta eliminarlo, captura el mensaje y vuelve a consultar el mismo cliente. La transacción se revierte al final para no dejar cambios permanentes.

Las capturas correspondientes están descriptas en [`evidencias/README.md`](../../sql/tecnico/triggers/evidencias/README.md). La prueba debe mostrar el mensaje de rechazo y confirmar que el cliente sigue activo e intacto.

## Conclusión

Los triggers de auditoría conservan los valores previos de los productos y el trigger de bloqueo impide el borrado físico de clientes, preservando los registros y orientando a utilizar la baja lógica.
