# Consulta de Negocio Avanzada

## 1. Objetivo

La presente consulta corresponde al punto **Consulta de Negocio Avanzada** de la Etapa IV.

El objetivo es identificar productos que hayan alcanzado una cantidad significativa de unidades vendidas, mostrando además la categoría a la que pertenecen, la sucursal donde se realizaron las ventas, la cantidad de operaciones involucradas y el importe total vendido.

La consulta fue diseñada para cumplir con la consigna de combinar al menos tres tablas mediante `JOIN` y aplicar un filtro condicional utilizando `HAVING`.

El script correspondiente se encuentra en:

```text
sql/consultas/consulta_avanzada.sql
```

---

## 2. Necesidad de negocio

Para la ferretería resulta útil conocer qué productos presentan mayor movimiento comercial en cada sucursal.

Esta información puede utilizarse para:

- identificar productos con mayor rotación;
- comparar el comportamiento de los productos entre sucursales;
- detectar categorías con mayor movimiento;
- analizar la cantidad de unidades vendidas;
- estimar el importe generado por cada producto;
- colaborar con futuras decisiones de reposición de inventario.

La consulta no modifica información de la base de datos. Su finalidad es únicamente analítica.

---

## 3. Tablas utilizadas

La consulta utiliza cinco tablas del modelo:

| Tabla | Función dentro de la consulta |
|---|---|
| `CATEGORIA` | Permite conocer la categoría a la que pertenece el producto. |
| `PRODUCTO` | Aporta el nombre del producto y su relación con la categoría. |
| `DETALLE_VENTA` | Contiene la cantidad vendida y el precio unitario utilizado en cada operación. |
| `VENTA` | Permite identificar cada venta y relacionarla con la sucursal. |
| `SUCURSAL` | Permite conocer en qué sucursal se realizó la operación. |

De esta forma, la consulta utiliza cinco tablas, superando el mínimo de tres solicitado por la consigna.

---

## 4. Relaciones utilizadas

Las tablas se vinculan de la siguiente manera:

```text
CATEGORIA
    |
    | 1:N
    v
PRODUCTO
    |
    | 1:N
    v
DETALLE_VENTA
    |
    | N:1
    v
VENTA
    |
    | N:1
    v
SUCURSAL
```

Las condiciones utilizadas en los `JOIN` son:

```sql
dv.id_producto = p.id_producto
p.id_categoria = c.id_categoria
dv.id_venta = v.id_venta
v.id_sucursal = s.id_sucursal
```

---

## 5. Datos obtenidos

La consulta devuelve:

```text
categoria
nombre_producto
sucursal
cantidad_ventas
unidades_vendidas
total_vendido
```

### `categoria`

Nombre de la categoría del producto.

### `nombre_producto`

Nombre del producto vendido.

### `sucursal`

Sucursal en la cual se registraron las ventas.

### `cantidad_ventas`

Cantidad de ventas distintas en las que apareció el producto.

Se calcula mediante:

```sql
COUNT(DISTINCT v.id_venta)
```

### `unidades_vendidas`

Cantidad total de unidades vendidas del producto.

Se calcula mediante:

```sql
SUM(dv.cantidad)
```

### `total_vendido`

Importe bruto correspondiente a las líneas de detalle del producto.

Se calcula mediante:

```sql
SUM(dv.cantidad * dv.precio_unitario_catalogo)
```

Se utiliza `precio_unitario_catalogo` porque `DETALLE_VENTA` conserva el precio utilizado al momento de realizar la operación.

---

## 6. Agrupación de resultados

La consulta agrupa los datos por:

```sql
GROUP BY
    c.nombre_cat,
    p.nombre_producto,
    s.nombre
```

Esto permite obtener un resultado independiente para cada combinación de:

```text
categoría + producto + sucursal
```

Por ejemplo, un mismo producto vendido en dos sucursales puede aparecer en dos filas diferentes.

---

## 7. Filtro con HAVING

La consigna requiere aplicar filtros condicionales mediante `HAVING` o subconsultas.

En este caso se utiliza:

```sql
HAVING
    SUM(dv.cantidad) >= 2
```

Esto significa que solamente se muestran los grupos en los cuales se hayan vendido al menos dos unidades.

Se utiliza `HAVING` y no `WHERE` porque el filtro se aplica sobre el resultado de una función de agregación: `SUM(dv.cantidad)`.

---

## 8. Orden de los resultados

Los resultados se ordenan utilizando:

```sql
ORDER BY
    total_vendido DESC
```

De esta manera, primero aparecen los productos que generaron un mayor importe dentro del conjunto analizado.

---

## 9. Variante con rango de fechas

El archivo SQL también incluye una segunda versión de la misma consulta que permite analizar un período determinado.

Se utilizan las variables:

```sql
DECLARE @fecha_desde DATE = '2026-01-01';
DECLARE @fecha_hasta DATE = '2026-12-31';
```

y el filtro:

```sql
WHERE
    v.fecha_hora >= @fecha_desde
    AND v.fecha_hora < DATEADD(DAY, 1, @fecha_hasta)
```

Esta variante permite reutilizar la consulta para diferentes períodos sin cambiar su estructura principal.

---

## 10. Ejemplo conceptual de resultado

```text
Categoria       Producto                    Sucursal                  Ventas   Unidades   Total
Herramientas    Martillo carpintero         Sucursal Centro          1        2          30000
Pintureria      Pintura latex interior 4L   Sucursal Goya            1        2          44000
Electricidad    Llave termica 16A           Sucursal Mercedes        1        3          25500
```

Los valores reales obtenidos dependen de los datos existentes en la base al momento de ejecutar la consulta.

---

## 11. Elementos SQL aplicados

La consulta permite aplicar contenidos trabajados durante la asignatura:

- `SELECT`;
- `INNER JOIN`;
- relaciones entre múltiples tablas;
- `COUNT`;
- `SUM`;
- `GROUP BY`;
- `HAVING`;
- `WHERE`;
- variables T-SQL;
- `ORDER BY`;
- alias de columnas;
- operaciones aritméticas.

---

## 12. Cumplimiento de la consigna

La consulta cumple con los requisitos de la Etapa IV:

```text
✓ combina al menos 3 tablas;
✓ utiliza 5 tablas;
✓ utiliza JOIN;
✓ utiliza funciones de agregación;
✓ utiliza GROUP BY;
✓ utiliza HAVING;
✓ aplica un filtro condicional;
✓ presenta una necesidad de negocio concreta;
✓ incluye una variante con rango de fechas.
```

---

## 13. Conclusión

La consulta desarrollada permite obtener una visión resumida del comportamiento comercial de los productos por categoría y sucursal.

Además de cumplir con los requerimientos técnicos de la consigna, representa un caso de uso aplicable al sistema de la ferretería, ya que permite identificar productos con movimiento significativo y analizar su volumen de venta.
