# Justificación de Normalización a 3FN -- Ferretería Multisucursal

### Justificación de RN.04 (Precio Histórico en Detalle de Venta)
* **Atributo:** `detalle_venta.precio_unitario_historico`
* **Análisis:** En la tabla `producto` se guarda el precio actual del catálogo. Guardar el precio en `detalle_venta` no es una redundancia que viole la 3FN, sino la registración del valor real de la transacción en el momento exacto de la compra.
* **Conclusión:** Preserva la integridad histórica comercial frente a futuros cambios de precios en el catálogo sin generar dependencias transitivas.

### Justificación de RN.06 (Valores Calculados y 3FN)
* **Atributo:** Subtotales y Totales de venta.
* **Análisis de Normalización:** La 3FN exige eliminar dependencias transitivas y atributos calculados que puedan obtenerse a partir de otros datos (por ejemplo, `subtotal = cantidad * precio_unitario_historico`).
* **Justificación:** Para garantizar el cumplimiento estricto de la **Tercera Forma Normal (3FN)**, los valores de subtotales por ítem y el total general de la venta **no se almacenan de forma redundante en las tablas principales**, sino que se calculan dinámicamente mediante consultas SQL o vistas relacionales en el motor de base de datos.
