# Índices y optimización

## 1. Definición y objetivo

Un índice es una estructura que SQL Server puede utilizar para localizar filas. Esta demostración compara una consulta por rango de fechas sobre `VENTA_HISTORICA`, una tabla de prueba con 1.000.000 de registros, en tres escenarios: sin índice, con índice `CLUSTERED` sobre `fecha_venta` y con un índice `NONCLUSTERED` de cobertura sobre esa fecha.

La tabla es solo para la prueba y no reemplaza ni modifica la tabla operativa `VENTA`.

## 2. Ventajas y aplicaciones

- Los índices pueden ayudar a localizar filas según las columnas usadas en los filtros.
- Un índice `CLUSTERED` organiza las filas de la tabla según su clave.
- Un índice `NONCLUSTERED` crea una estructura de búsqueda separada. Las columnas incluidas pueden cubrir los datos que devuelve una consulta.
- `SET STATISTICS TIME` y `SET STATISTICS IO` permiten observar tiempos y lecturas para comparar ejecuciones.
- El plan de ejecución permite revisar qué operaciones eligió SQL Server; el optimizador puede seleccionar planes distintos según los datos y las estadísticas.

## 3. Implementación en SQL Server Express

Ejecutar [`01_implementacion_indices.sql`](../../sql/tecnico/indices/01_implementacion_indices.sql) en `ProyectoFerreteria`. El script elimina y vuelve a crear `VENTA_HISTORICA`, luego carga 1.000.000 de filas de prueba. No crea índices, de modo que la tabla queda sin índice antes de comenzar la comparación.

La tabla contiene `id_venta`, `estado`, `domicilio_entrega`, `total`, `fecha_venta` e `id_usuario`. Los datos se generan en el mismo script. Como el script recrea la tabla, no debe usarse para guardar información que se necesite conservar.

## 4. Caso concreto y escenarios comparados

La demostración está en [`02_demostracion_indices.sql`](../../sql/tecnico/indices/02_demostracion_indices.sql), que debe ejecutarse después de la implementación. Primero retira los índices de prueba con nombre conocido, para iniciar con la tabla sin índice.

La misma consulta se ejecuta en los tres escenarios:

```sql
SELECT id_venta, fecha_venta, estado, total
FROM dbo.VENTA_HISTORICA
WHERE fecha_venta >= '2023-01-01'
  AND fecha_venta < '2023-04-01';
```

1. **Sin índice:** ejecuta la consulta sobre la tabla sin índice.
2. **Índice agrupado:** crea `CX_VentaHistorica_Fecha` con `CREATE CLUSTERED INDEX` sobre `fecha_venta` y repite la consulta.
3. **Índice de cobertura:** elimina el índice agrupado con `DROP INDEX`, crea `IX_VentaHistorica_Fecha_Cobertura` con `CREATE NONCLUSTERED INDEX` sobre `fecha_venta` e incluye `id_venta`, `estado` y `total`; luego repite la consulta.

Las tres ejecuciones están medidas con `SET STATISTICS TIME ON` y `SET STATISTICS IO ON`. Antes de ejecutar en SSMS, activar el plan de ejecución real con `Ctrl+M`. Para comparar, registrar por escenario el plan mostrado, las lecturas lógicas y el tiempo informado por SQL Server. No se afirma un ganador ni se presentan métricas nuevas: dependen de la ejecución y deben obtenerse de las evidencias.

| Escenario | Índice disponible | Datos para comparar |
|---|---|---|
| 1 | Ninguno | Plan real, lecturas y tiempo |
| 2 | `CLUSTERED` sobre `fecha_venta` | Plan real, lecturas y tiempo |
| 3 | `NONCLUSTERED` sobre `fecha_venta`, con `id_venta`, `estado` y `total` incluidos | Plan real, lecturas y tiempo |

El límite superior exclusivo `'2023-04-01'` incluye todo el 31 de marzo, incluso las horas posteriores al comienzo del día en una columna `DATETIME`. La misma condición se usa en los tres escenarios.

## 5. Evidencias y resultados

Las evidencias finales de la demostración actual y la descripción de cada captura están en [`evidencias/README.md`](../../sql/tecnico/indices/evidencias/README.md).

## Conclusión

La demostración compara la misma consulta con la tabla sin índice, con un índice agrupado y con uno no agrupado de cobertura. Las estadísticas y los planes de ejecución permiten observar las diferencias de cada ejecución, sin asumir de antemano que una alternativa siempre será más rápida.
