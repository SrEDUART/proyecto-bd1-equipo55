# Evidencias de Ejecución - Módulo de Índices y Optimización

## 1. Captura: `implementacion_indices.png`
Demostración de ejecución del script `01_implementacion_indices.sql` en SQL Server Management Studio (SSMS):
- Muestra la creación de la tabla masiva `VENTA_HISTORICA`, la inserción exitosa de 1.000.000 de registros de prueba y la compilación del índice no agrupado con cobertura `IX_VentaHistorica_Fecha_Cobertura`.

## 2. Captura: `demostracion_indices.png`
Demostración de ejecución del script `02_demostracion_indices.sql` en SSMS:
- **Resultados de la Consulta:** Grilla con las 48.570 filas filtradas por rango de fecha ejecutadas en tan solo 1 segundo.
- **Rendimiento y Métricas:** Evidencia de la ejecución optimizada aprovechando el índice no agrupado de cobertura.
