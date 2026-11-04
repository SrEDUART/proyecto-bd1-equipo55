# Evidencias de ejecución: triggers de auditoría

## 1. `01_implementacion_triggers.png`

Muestra la tabla `AUDITORIA_PRODUCTO` y los triggers `TR_PRODUCTO_AUD_UPDATE` y `TR_PRODUCTO_AUD_DELETE` asociados a `PRODUCTO`. Ambos son de tipo `AFTER` y están activos.

## 2. `02_demostracion_update.png`

Muestra el producto antes y después del `UPDATE`, y los valores anteriores guardados en `AUDITORIA_PRODUCTO`. El registro también incluye el tipo de operación, la fecha y hora (`fecha_hora`) y el usuario de base de datos (`usuario_bd`).

## 3. `03_demostracion_delete.png`

Muestra el producto antes del `DELETE`, que ya no existe en `PRODUCTO` después de la operación, y sus valores anteriores guardados en `AUDITORIA_PRODUCTO`, junto con el tipo de operación, `fecha_hora` y `usuario_bd`.

## 4. `04_implementacion_trigger_bloqueo.png`

Verifica que `TR_CLIENTE_BLOQUEAR_DELETE` existe, está asociado a `CLIENTE`, es de tipo `INSTEAD OF` y está habilitado.

## 5. `05_demostracion_trigger_bloqueo.png`

Muestra el cliente antes del intento de `DELETE`, el mensaje de rechazo y el mismo cliente después del intento, confirmando que el registro permanece intacto.
