# Evidencias de índices

Las capturas actuales, `implementacion_indice.png` y `demostracion_indice.png`, corresponden a una versión anterior del módulo que solo creaba el índice no agrupado y ejecutaba una vez la consulta. Se conservan sin cambios, pero no demuestran los tres escenarios de la demostración actual.

Tomar las siguientes capturas nuevas al ejecutar los scripts en SQL Server Management Studio. Para las tres consultas, activar el plan de ejecución real con `Ctrl+M` y mostrar también las estadísticas de `TIME` e `IO` en la pestaña **Mensajes**.

## Capturas necesarias

### `01_implementacion_datos.png`

Debe mostrar que `01_implementacion_indices.sql` terminó correctamente y el resultado de esta consulta, que confirma la cantidad de filas cargadas:

```sql
SELECT COUNT(*) AS cantidad_registros
FROM dbo.VENTA_HISTORICA;
```

El resultado debe corresponder a 1.000.000 de filas. La tabla queda sin índices para iniciar la prueba.

### `02_consulta_sin_indice.png`

Debe mostrar la consulta por rango de fechas, el plan real elegido por SQL Server y las estadísticas de tiempo y lecturas para el escenario sin índice.

### `03_consulta_indice_clustered.png`

Debe mostrar la creación de `CX_VentaHistorica_Fecha` y la ejecución de la misma consulta, con su plan real y las estadísticas de tiempo y lecturas.

### `04_consulta_indice_cobertura.png`

Debe mostrar el `DROP INDEX` del clustered, la creación de `IX_VentaHistorica_Fecha_Cobertura` con las columnas incluidas, y la ejecución de la misma consulta con su plan real y las estadísticas de tiempo y lecturas.

Las capturas deben reflejar los resultados observados; no agregar métricas ni conclusiones que no aparezcan en SSMS.
