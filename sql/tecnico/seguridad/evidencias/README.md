# Evidencias de seguridad

Las capturas actuales fueron tomadas con la demostración anterior, que usaba datos fijos y solo probaba un usuario operador. Se conservan, pero no cubren todos los casos del SQL actual. Tomar capturas nuevas al ejecutar `01_implementacion_seguridad.sql` y `02_demostracion_seguridad.sql` en SQL Server Management Studio. No agregar resultados que no aparezcan en la ejecución.

## Capturas necesarias

### `01_implementacion_seguridad.png`

Debe mostrar la ejecución correcta de la implementación y la creación/asignación de:

- `usuario_administrador` como miembro de `db_owner`;
- el rol `rol_lectura` con `SELECT`, `DENY` de escritura directa y `EXECUTE` sobre `dbo.sp_InsertarCliente`;
- `usuario_lectura_1` y `usuario_lectura_2` como miembros de `rol_lectura`.

### `02_autenticacion_mixta.png`

Debe mostrar el resultado de `modo_autenticacion_instancia` de la demostración, indicando si la instancia usa autenticación mixta o solo Windows. Si indica solo Windows, activar el modo mixto desde las propiedades de seguridad del servidor en SSMS y reiniciar el servicio; luego volver a ejecutar la consulta de verificación.

### `03_prueba_administrador.png`

Debe mostrar que `usuario_administrador` insertó directamente un cliente de prueba y pudo consultar la fila mientras se ejecutaba como ese usuario.

### `04_prueba_usuario_lectura_1.png`

Debe mostrar para `usuario_lectura_1`:

- una consulta permitida sobre `CLIENTE`;
- el error esperado al intentar un `INSERT` directo;
- la fila creada y consultada mediante `dbo.sp_InsertarCliente`.

### `05_prueba_usuario_lectura_2.png`

Debe mostrar para `usuario_lectura_2` los mismos resultados: `SELECT` permitido, `INSERT` directo rechazado e inserción mediante `dbo.sp_InsertarCliente` permitida.

### `06_limpieza_pruebas.png`

Debe mostrar la consulta final posterior al `ROLLBACK` sin filas correspondientes a los clientes temporales.

Las capturas existentes `implementacion_seguridad.png`, `demostracion_seguridad1.png` y `demostracion_seguridad2.png` no se modifican. Se recomienda reemplazar o complementar las evidencias del README con las capturas nuevas cuando estén disponibles.
