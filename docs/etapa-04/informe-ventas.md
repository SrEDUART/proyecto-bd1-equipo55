# Informe agregado de ventas

## Objetivo
Resumir las ventas de la ferretería dentro de un rango de fechas, por vendedor y por categoría de producto.
Las consultas trabajan con los datos existentes en las tablas del proyecto; no incorporan ventas ni resultados ficticios.


## Tablas utilizadas
- **Por vendedor:** `USUARIO`, `VENTA` y `DETALLE_VENTA`.
- **Por categoría:** `CATEGORIA`, `PRODUCTO`, `DETALLE_VENTA` y `VENTA`.

## Consultas

Consulta A: ventas por vendedor
Muestra el nombre y apellido de cada vendedor, la cantidad de ventas, las unidades vendidas y el total vendido. Se consideran usuarios con id_perfil = 2.

Consulta B: ventas por categoría
Muestra cada categoría, las unidades vendidas, la cantidad de ventas distintas, la cantidad de renglones de detalle y el total vendido. Una misma venta puede contabilizarse en más de una categoría si contiene productos de distintas categorías.


## Funciones SQL utilizadas
- `JOIN`: relaciona las tablas mediante sus claves.
- `WHERE`: filtra las ventas según el rango de fechas y, en la consulta A, según el perfil del usuario.
- `GROUP BY`: agrupa los registros por vendedor o categoría.
- `SUM`: suma las unidades y los importes vendidos.
- `COUNT`: cuenta renglones o ventas distintas. COUNT(DISTINCT V.id_venta) evita contar más de una vez una misma venta dentro de cada grupo.
- `ORDER BY`: ordena los resultados por total vendido de mayor a menor.


## Rango de fechas

Las variables @fecha_desde y @fecha_hasta se establecen para ambas consultas. La fecha inicial es 2026-02-01 y la fecha final se obtiene con GETDATE(), por lo que se actualiza automáticamente al ejecutar el archivo.

El filtro usa V.fecha_hora >= @fecha_desde y V.fecha_hora < DATEADD(DAY, 1, @fecha_hasta) para incluir todas las ventas del día final, aunque fecha_hora contenga hora.


## Resultado y utilidad
El archivo devuelve dos resultados: uno con los totales por vendedor y otro con los totales por categoría. Los valores dependen de las ventas realmente cargadas en la base de datos ferreteria. El informe permite comparar el desempeño de los vendedores e identificar las categorías con mayor volumen e importe de ventas.
