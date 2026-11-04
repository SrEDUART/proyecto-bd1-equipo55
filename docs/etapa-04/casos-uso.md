# Casos de Uso — Etapa IV

## Objetivo

Este documento introduce las tres consultas SQL que forman parte de la Etapa IV del proyecto, cada una resolviendo una necesidad de información distinta sobre el sistema de la ferretería: emisión de comprobantes, reportes gerenciales agregados y una consulta de negocio avanzada que combina múltiples tablas con un filtro condicional.

---

## CU.01 — Comprobante de Venta

Esta consulta permite reconstruir la factura o comprobante de una venta puntual, consolidando el encabezado de la operación con el detalle de los productos vendidos. A partir de las tablas `VENTA`, `DETALLE_VENTA`, `PRODUCTO`, `CLIENTE`, `USUARIO` y `SUCURSAL`, la consulta obtiene:

- encabezado de venta (número, fecha/hora, tipo de factura, descuento);
- cliente (si la venta está asociada a uno registrado);
- vendedor (usuario que atendió la venta);
- sucursal donde se realizó la operación;
- productos incluidos en la venta;
- cantidades de cada producto;
- precios unitarios utilizados al momento de la venta;
- subtotales por renglón (cantidad × precio unitario);
- total acumulado de la venta.

**Archivo SQL relacionado:** `sql/consultas/comprobante_venta.sql`
**Documento relacionado:** `docs/etapa-04/comprobante-venta.md`

---

## CU.02 — Informe Agregado de Ventas

Esta consulta genera reportes gerenciales que resumen la actividad comercial de la ferretería, agrupando las ventas por distintos criterios para facilitar el análisis de desempeño. Se desarrollan dos variantes de reporte agregado:

- **por vendedor:** total vendido, cantidad de ventas y/o unidades por cada usuario con perfil de ventas;
- **por categoría:** total vendido y cantidad de unidades por cada categoría de producto.

Ambas variantes permiten filtrar por un rango de fechas, y se construyen utilizando las cláusulas `GROUP BY`, `SUM` y `COUNT` sobre las tablas `VENTA`, `DETALLE_VENTA`, `PRODUCTO`, `CATEGORIA` y `USUARIO`.

**Archivo SQL:** `sql/consultas/informe_ventas.sql`
**Documento:** `docs/etapa-04/informe-ventas.md`

---

## CU.03 — Consulta de Negocio Avanzada

Esta consulta resuelve una necesidad de información más compleja, que requiere combinar al menos tres tablas mediante `JOIN` y aplicar un filtro condicional sobre un resultado agregado, utilizando `HAVING` (o, alternativamente, una subconsulta). El propósito es identificar, por ejemplo, clientes, productos o sucursales que cumplen una condición de negocio que solo puede evaluarse después de agrupar los datos (como un monto mínimo de compras acumuladas o una cantidad mínima de unidades vendidas).

**Archivo SQL:** `sql/consultas/consulta_avanzada.sql`
**Documento:** `docs/etapa-04/consulta-avanzada.md`

---

## Resumen

| Caso de uso | Consulta | Técnicas principales |
|---|---|---|
| CU.01 | Comprobante de Venta | JOIN de encabezado y detalle, subtotal por renglón, total acumulado |
| CU.02 | Informe Agregado de Ventas | GROUP BY, SUM, COUNT, filtro por rango de fechas |
| CU.03 | Consulta de Negocio Avanzada | JOIN de 3+ tablas, HAVING o subconsulta |
