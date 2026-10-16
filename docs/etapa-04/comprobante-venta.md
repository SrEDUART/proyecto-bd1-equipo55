# Etapa IV - Consulta de Negocio: Comprobante de Venta



Esta consulta genera la información necesaria para armar un comprobante o factura de venta. Trae los datos generales de la operación (sucursal, vendedor, cliente, fecha y tipo de factura) junto con el detalle de los productos comprados.

Además del subtotal de cada ítem, calcula el subtotal general de la venta y el total final aplicando el descuento correspondiente.

---

## 2. Puntos a tener en cuenta

* **Combinación de tablas (`JOIN`):** Junta la información de 6 tablas (`VENTA`, `SUCURSAL`, `USUARIO`, `CLIENTE`, `DETALLE_VENTA` y `PRODUCTO`).
* **Ventas a Consumidor Final:** Con un `LEFT JOIN` hacia la tabla `CLIENTE` y la función `ISNULL`, si la venta no tiene un cliente registrado, muestra directamente el texto `'Consumidor Final'`.
* **Cálculo de totales sin agrupar el detalle:** Usa subconsultas en el `SELECT` sobre `DETALLE_VENTA` para obtener la suma total de la venta sin perder las filas de cada producto.
* **Redondeo del total:** Utiliza `CAST(... AS DECIMAL(12,2))` para que el total final siempre se muestre formateado a dos decimales.

---

## 3. Código SQL

```sql
USE proyectoFerreteria;


DECLARE @id_venta_busqueda INT = 1;

SELECT 
    VENTA.id_venta AS [Nro Venta],
    VENTA.fecha_hora AS [Fecha y Hora],
    VENTA.tipo_factura AS [Tipo Factura],
    SUCURSAL.nombre AS [Sucursal],
    CONCAT(USUARIO.nombre, ' ', USUARIO.apellido) AS [Vendedor],
    ISNULL(CONCAT(CLIENTE.nombre, ' ', CLIENTE.apellido), 'Consumidor Final') AS [Cliente],
    
    PRODUCTO.nombre_producto AS [Producto],
    DETALLE_VENTA.cantidad AS [Cantidad],
    DETALLE_VENTA.precio_unitario_catalogo AS [Precio Unitario],
    
    (DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo) AS [Subtotal Renglón],
    VENTA.descuento AS [Descuento (%)],
    
    (
        SELECT SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo)
        FROM DETALLE_VENTA
        WHERE DETALLE_VENTA.id_venta = VENTA.id_venta
    ) AS [Subtotal General],
    
    CAST(
        (
            SELECT SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario_catalogo)
            FROM DETALLE_VENTA
            WHERE DETALLE_VENTA.id_venta = VENTA.id_venta
        ) * (1 - (VENTA.descuento / 100.0))
        AS DECIMAL(12,2)
    ) AS [Total Final]

FROM VENTA
INNER JOIN SUCURSAL 
    ON VENTA.id_sucursal = SUCURSAL.id_sucursal
INNER JOIN USUARIO 
    ON VENTA.id_usuario = USUARIO.id_usuario
LEFT JOIN CLIENTE 
    ON VENTA.id_cliente = CLIENTE.id_cliente
INNER JOIN DETALLE_VENTA 
    ON VENTA.id_venta = DETALLE_VENTA.id_venta
INNER JOIN PRODUCTO 
    ON DETALLE_VENTA.id_producto = PRODUCTO.id_producto

WHERE VENTA.id_venta = @id_venta_busqueda;
```

---

## 4. Ejemplo de resultado (Venta 1)

| Nro Venta | Fecha y Hora | Tipo Factura | Sucursal | Vendedor | Cliente | Producto | Cantidad | Precio Unitario | Subtotal Renglón | Descuento (%) | Subtotal General | Total Final |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2026-10-15 | B | Sucursal Centro Corrientes | Maria Lopez | Lucas Gomez | Martillo carpintero | 3 | 15000.00 | 45000.00 | 0.00 | 110000.00 | 110000.00 |
| 1 | 2026-10-15 | B | Sucursal Centro Corrientes | Maria Lopez | Lucas Gomez | Amoladora angular 4-1/2 | 1 | 65000.00 | 65000.00 | 0.00 | 110000.00 | 110000.00 |
