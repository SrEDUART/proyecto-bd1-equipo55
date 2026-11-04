# Índices sobre `VENTA_HISTORICA`

## 1. Definición y objetivo

Un índice es una estructura que SQL Server utiliza para localizar
registros de una tabla de manera más eficiente. En esta implementación
se crea un índice no agrupado (`NONCLUSTERED`) sobre la columna
`fecha_venta` de la tabla `VENTA_HISTORICA`.

El objetivo es optimizar las consultas que buscan ventas históricas
dentro de un rango de fechas. Para realizar la prueba, se utiliza una
tabla con 1.000.000 de registros generados automáticamente, lo que
permite trabajar con un volumen significativo de datos.

La implementación se centra en demostrar el funcionamiento de un índice
sobre una columna utilizada como criterio de búsqueda. La tabla
`VENTA_HISTORICA` es una tabla de prueba creada para esta demostración y
no reemplaza ni modifica la tabla operativa `VENTA` del proyecto.

## 2. Ventajas y aplicaciones

-   **Búsqueda por fechas:** permite localizar de manera más eficiente
    las ventas correspondientes a un período determinado.
-   **Índice no agrupado:** crea una estructura de búsqueda secundaria
    sin establecer el orden físico de los registros de la tabla.
-   **Columnas incluidas:** almacena `total` y `estado` como información
    adicional del índice para facilitar consultas que utilizan esos
    datos.
-   **Evaluación del rendimiento:** permite observar las lecturas de E/S
    y los tiempos de ejecución de una consulta.
-   **Prueba con volumen de datos:** utiliza un millón de registros para
    analizar el comportamiento de la consulta sobre una tabla de tamaño
    considerable.

## 3. Implementación en SQL Server Express

La implementación está en
[`01_implementacion_indices.sql`](../../sql/tecnico/indices/01_implementacion_indices.sql).
Debe ejecutarse sobre la base de datos `proyectoFerreteria`.

El script primero verifica si existe una tabla llamada
`VENTA_HISTORICA`. Si existe, la elimina y luego la crea nuevamente con
las siguientes columnas:

-   `id_venta`: identificador autoincremental.
-   `estado`: estado de la venta.
-   `domicilio_entrega`: domicilio de entrega de prueba.
-   `total`: importe de la venta.
-   `fecha_venta`: fecha y hora de la venta.
-   `id_usuario`: identificador del usuario asociado.

A continuación, genera e inserta 1.000.000 de registros mediante una
expresión de tabla común (`CTE`) y la función `ROW_NUMBER()`. Los
estados se distribuyen entre `Pendiente`, `Entregado` y `Cancelado`. Los
domicilios, importes, fechas y usuarios se generan automáticamente.

**Importante:** el script elimina y vuelve a crear `VENTA_HISTORICA`
cada vez que se ejecuta. Por ese motivo, debe utilizarse como una tabla
de prueba y no sobre una tabla que contenga información que se necesite
conservar.

### Creación del índice

El índice implementado es:

``` sql
CREATE NONCLUSTERED INDEX IX_VentaHistorica_Fecha_Cobertura
ON VENTA_HISTORICA (fecha_venta)
INCLUDE (total, estado);
```

La columna `fecha_venta` es la clave del índice porque se utiliza para
filtrar las ventas por un rango de fechas. Las columnas `total` y
`estado` se incorporan mediante `INCLUDE`, por lo que quedan almacenadas
como información adicional del índice.

El script también verifica si ya existe un índice con ese nombre en la
tabla y, en ese caso, lo elimina antes de crearlo nuevamente. Como la
tabla se elimina y se crea otra vez al comienzo del script, normalmente
el índice anterior también desaparece al recrearse la tabla.

## 4. Caso concreto aplicado a la demostración

El índice está pensado para optimizar consultas que necesitan recuperar
ventas históricas según su fecha. Por ejemplo:

``` sql
SELECT id_venta, fecha_venta, estado, total
FROM VENTA_HISTORICA
WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-03-31';
```

SQL Server puede utilizar `IX_VentaHistorica_Fecha_Cobertura` para
localizar los registros que cumplen el filtro sobre `fecha_venta`.

La columna `fecha_venta` funciona como clave de búsqueda, mientras que
`estado` y `total` están incluidas en el índice. Sin embargo, `id_venta`
no forma parte de la clave ni de las columnas incluidas. Por eso, el
índice no cubre por sí solo todas las columnas solicitadas por el
`SELECT` y SQL Server podría necesitar acceder también a la tabla para
obtener `id_venta`.

Además, como `fecha_venta` es de tipo `DATETIME`, el límite
`'2023-03-31'` representa el comienzo de ese día. Por lo tanto, el
filtro `BETWEEN` no incluye las horas posteriores del 31 de marzo. Para
abarcar todo el período hasta el final de ese día, se podría utilizar un
límite exclusivo:

``` sql
WHERE fecha_venta >= '2023-01-01'
  AND fecha_venta <  '2023-04-01';
```

## 5. Script de demostración y resultados obtenidos

La demostración está en
[`02_demostracion_indices.sql`](../../sql/tecnico/indices/02_demostracion_indices.sql).
Debe ejecutarse después del script de implementación, ya que necesita
que exista la tabla `VENTA_HISTORICA` y que el índice haya sido creado.

El script realiza las siguientes acciones:

1.  Selecciona la base de datos `proyectoFerreteria`.
2.  Activa `SET STATISTICS TIME ON` para obtener información sobre los
    tiempos de ejecución.
3.  Activa `SET STATISTICS IO ON` para observar las lecturas de entrada
    y salida realizadas por SQL Server.
4.  Ejecuta una consulta que busca las ventas históricas comprendidas
    entre las fechas indicadas.
5.  Desactiva las estadísticas al finalizar.

Para complementar la demostración, se puede activar el plan de ejecución
real en SQL Server Management Studio mediante `Ctrl + M` antes de
ejecutar la consulta. Esto permite observar qué operaciones utiliza SQL
Server y si decide aprovechar el índice creado.

Las estadísticas permiten analizar las lecturas lógicas y los tiempos
informados por el motor. Sin embargo, la existencia del índice no
garantiza que SQL Server lo utilice: el optimizador elige el plan de
ejecución según las estadísticas, la distribución de los datos y el
costo estimado de cada alternativa.

La demostración actual ejecuta la consulta con el índice disponible,
pero no realiza automáticamente una comparación entre la ejecución con y
sin índice. Por lo tanto, para afirmar que hubo una mejora de
rendimiento sería necesario realizar ambas pruebas bajo las mismas
condiciones y comparar sus resultados.

## Conclusión

Se implementó un índice no agrupado sobre
`VENTA_HISTORICA(fecha_venta)`, incluyendo las columnas `total` y
`estado`, con el propósito de optimizar las búsquedas por rango de
fechas. La prueba utiliza un millón de registros generados
automáticamente y un script de demostración que permite observar las
lecturas de E/S y los tiempos de ejecución. De esta manera, se muestra
cómo SQL Server puede aprovechar los índices para mejorar determinadas
consultas y cómo evaluar su comportamiento mediante las herramientas de
estadísticas y los planes de ejecución.
