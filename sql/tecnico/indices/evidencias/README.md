# Evidencias de índices

Las siguientes siete capturas son las evidencias finales de la demostración actual. Las imágenes históricas `implementacion_indice.png` y `demostracion_indice.png` se conservan, pero corresponden a la prueba anterior.

## Carga de datos

### `01_carga_millon_registros.png`

Muestra el conteo de 1.000.000 de filas en `VENTA_HISTORICA` y que la tabla comienza sin índices definidos.

## Escenario 1: sin índice

### `02_sin_indice_mensajes.png`

Muestra la consulta por rango de fechas y las métricas de tiempo y lecturas del escenario sin índice.

### `02_sin_indice_plan.png`

Muestra el plan de ejecución real de la consulta en el escenario sin índice.

## Escenario 2: índice CLUSTERED

### `03_indice_clustered_mensajes.png`

Muestra las métricas de tiempo y lecturas al ejecutar la consulta con el índice agrupado sobre `fecha_venta`.

### `03_indice_clustered_plan.png`

Muestra el plan de ejecución real correspondiente al escenario con índice `CLUSTERED`.

## Escenario 3: índice de cobertura

### `04_indice_cobertura_mensajes.png`

Muestra las métricas de tiempo y lecturas al ejecutar la consulta con el índice `NONCLUSTERED` de cobertura.

### `04_indice_cobertura_plan.png`

Muestra el plan de ejecución real correspondiente al escenario con índice de cobertura.
