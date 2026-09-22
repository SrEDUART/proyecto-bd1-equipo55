# Justificación de Normalización a 3FN -- Ferretería Multisucursal

### Justificación de RN.04 (Precio Histórico en Detalle de Venta)
* **Atributo:** `detalle_venta.precio_unitario_historico`
* **Análisis:** En la tabla `producto` se guarda el precio actual del catálogo. Guardar el precio en `detalle_venta` no es una redundancia que viole la 3FN, sino la registración del valor real de la transacción en el momento exacto de la compra.
* **Conclusión:** Preserva la integridad histórica comercial frente a futuros cambios de precios en el catálogo sin generar dependencias transitivas.
