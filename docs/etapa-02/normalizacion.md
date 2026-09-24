# Normalización del Modelo Relacional

Se analiza el modelo relacional de la ferretería para reducir redundancia y evitar anomalías de actualización, inserción y eliminación. El análisis se realiza a partir de las relaciones y dependencias funcionales que se pueden identificar en el modelo actual y en las reglas de negocio.

## Primera Forma Normal (1FN)

La 1FN requiere que cada atributo sea atómico, que cada celda almacene un solo valor y que no existan grupos repetitivos.

En el modelo, una venta puede contener varios productos. En lugar de guardar una lista de productos, cantidades y precios dentro de `VENTA`, se utiliza `DETALLE_VENTA`: cada fila representa un producto de una venta y contiene `id_venta`, `id_producto`, `cantidad` y `precio_unitario`. De esta forma, los productos no constituyen un grupo repetitivo dentro de la venta.

También se separan los pagos mediante `PAGO` y `METODO_PAGO`. Una venta puede tener varios registros de `PAGO`, cada uno con un método y un monto, por lo que no se repiten columnas tales como “método de pago 1”, “método de pago 2” o sus respectivos importes en `VENTA`.

La relación `PERFIL_FUNCIONALIDAD` representa las funcionalidades habilitadas para cada perfil. Así se evita guardar una lista de funcionalidades en un único atributo de `PERFIL`: cada combinación perfil-funcionalidad se registra en una fila.

Los atributos declarados en las relaciones del modelo son valores simples por registro: identificadores, nombres, descripciones, importes, fechas, cantidades y referencias mediante claves foráneas. Por ello, no se observan atributos multivaluados ni celdas con conjuntos de valores en las relaciones documentadas.

## Segunda Forma Normal (2FN)

La 2FN requiere cumplir previamente 1FN y que todo atributo no clave dependa de la totalidad de una clave primaria compuesta. El análisis de dependencias parciales solo corresponde a relaciones con clave primaria compuesta.

En el modelo relacional documentado, la relación con clave primaria compuesta es:

- `PERFIL_FUNCIONALIDAD`, cuya clave primaria es (`id_perfil`, `id_funcionalidad`). No posee atributos no clave: ambos atributos forman parte de la clave y, además, son claves foráneas. Por lo tanto, no puede presentar dependencias parciales.

Las demás relaciones declaradas tienen claves primarias simples, por ejemplo `id_venta`, `id_producto`, `id_pago` e `id_detalle_venta`. En consecuencia, no corresponde aplicarles el análisis de dependencia parcial propio de la 2FN.

## Tercera Forma Normal (3FN)

La 3FN requiere cumplir 2FN y evitar dependencias transitivas entre atributos no clave; es decir, un atributo no clave no debe depender de otro atributo no clave.

El modelo separa `CATEGORIA` de `PRODUCTO`. La información propia de la categoría depende de `id_categoria`, mientras que `PRODUCTO` conserva solo la referencia `id_categoria`. Esto evita repetir el nombre y la descripción de una categoría en cada producto.

De modo similar, la información de los perfiles se mantiene en `PERFIL` y `USUARIO` conserva `id_perfil`; las funcionalidades se mantienen en `FUNCIONALIDAD` y se vinculan con los perfiles mediante `PERFIL_FUNCIONALIDAD`. Así, los datos descriptivos de perfiles y funcionalidades no dependen transitivamente de la clave de `USUARIO`.

`METODO_PAGO` también se encuentra separado de `PAGO`. El nombre y la descripción del método dependen de `id_metodo_pago`, mientras que cada pago solo lo referencia. Esto evita repetir esos datos para cada importe pagado.

Las dependencias anteriores pueden expresarse de forma simple como:

```text
id_producto -> id_categoria, codigo_barra, nombre, descripcion,
               precio_costo, porcentaje_ganancia, precio_venta
id_categoria -> nombre, descripcion

id_usuario -> id_perfil, id_sucursal, id_direccion, nombre, apellido, ...
id_perfil -> nombre, descripcion

id_pago -> id_venta, id_metodo_pago, monto
id_metodo_pago -> nombre, descripcion
```

En las relaciones mostradas, las separaciones anteriores evitan que los atributos descriptivos de categoría, perfil y método de pago queden como dependencias transitivas en `PRODUCTO`, `USUARIO` o `PAGO`, respectivamente.

No obstante, existe una inconsistencia entre el modelo relacional actual y el objetivo obligatorio de alcanzar estrictamente 3FN: se almacenan atributos derivados. En `PRODUCTO`, RN.06 permite identificar las siguientes dependencias:

```text
id_producto -> precio_costo, porcentaje_ganancia
(precio_costo, porcentaje_ganancia) -> precio_venta
```

Como `precio_costo`, `porcentaje_ganancia` y `precio_venta` son atributos no clave, `precio_venta` queda transitivamente determinado por `id_producto`. Mientras `precio_venta` permanezca almacenado, existe redundancia derivada y el modelo lógico debe revisarse para alcanzar estrictamente 3FN.

En `DETALLE_VENTA` se almacena `subtotal` junto con `cantidad` y `precio_unitario`. El modelo indica que ese subtotal es calculado, pero no documenta expresamente la fórmula `cantidad * precio_unitario`. Si esa es la fórmula definida, se cumple:

```text
id_detalle_venta -> cantidad, precio_unitario
(cantidad, precio_unitario) -> subtotal
```

En ese caso, `subtotal` también sería un atributo derivado que debe revisarse para cumplir estrictamente 3FN. Hasta que la fórmula quede documentada, solo puede afirmarse que su almacenamiento requiere revisión de consistencia.

Para `VENTA`, el modelo indica que `subtotal`, `descuento` y `total` se guardan calculados. Además, establece que la suma de los montos de `PAGO` de una venta debe ser igual a `VENTA.total`. Por lo tanto, puede afirmarse que `total` se relaciona con los pagos registrados; sin embargo, el repositorio no define una fórmula que relacione `subtotal`, `descuento` y `total`. En consecuencia, no se debe asumir una dependencia funcional adicional entre esos tres atributos, pero su condición de valores calculados requiere revisión en el modelo final para verificar el cumplimiento estricto de 3FN.

## Dependencias Funcionales Relevantes

Las principales dependencias que se justifican por las claves primarias y foráneas del modelo son:

```text
id_sucursal -> nombre, telefono, id_direccion, eliminado_en
id_usuario -> id_perfil, id_sucursal, id_direccion, nombre, apellido, dni, ...
id_producto -> id_categoria, codigo_barra, nombre, descripcion,
               precio_costo, porcentaje_ganancia, precio_venta, eliminado_en
id_venta -> id_cliente, id_usuario, id_sucursal, fecha_hora, tipo_factura,
            subtotal, descuento, total, eliminado_en
id_detalle_venta -> id_venta, id_producto, cantidad, precio_unitario,
                     subtotal, eliminado_en
id_pago -> id_venta, id_metodo_pago, monto, eliminado_en
```

`PERFIL_FUNCIONALIDAD` tiene clave primaria compuesta (`id_perfil`, `id_funcionalidad`) y no posee atributos no clave. Por ello, no presenta dependencias parciales ni dependencias transitivas sobre atributos no clave.

## Decisiones particulares de normalización

### Justificación de RN.04 (Precio histórico en detalle de venta)

- **Atributo:** `DETALLE_VENTA.precio_unitario`.
- **Análisis:** `PRODUCTO` guarda el precio vigente del catálogo, mientras que `precio_unitario` conserva la copia del valor aplicado al registrar cada detalle de venta. Si posteriormente cambia el precio del producto, ese cambio no modifica las ventas ya realizadas.
- **Conclusión:** No se trata de repetir el precio actual del catálogo para su consulta, sino de preservar el valor histórico de la transacción. La justificación está dada por RN.04 y no incorpora una dependencia transitiva entre atributos no clave.

### Justificación de RN.06 (Cálculo del precio de venta)

- **Atributo:** `PRODUCTO.precio_venta`.
- **Análisis:** RN.06 establece que el precio de venta se calcula automáticamente a partir de `precio_costo` y `porcentaje_ganancia`. Por lo tanto, `precio_venta` es un atributo derivado de información del mismo producto y no debería cargarse manualmente.
- **Consideración técnica:** Al estar almacenado en `PRODUCTO`, `precio_venta` queda determinado por `precio_costo` y `porcentaje_ganancia`, que son atributos no clave. Por ello existe una dependencia transitiva desde `id_producto` y una redundancia derivada; el atributo debe revisarse en el modelo final para alcanzar estrictamente 3FN.

Los subtotales y totales de las ventas son valores distintos de la decisión de RN.06. El modelo actual los almacena para conservar el importe de la operación; su control de consistencia corresponde a una definición posterior del equipo.

## Conclusión

El modelo elimina grupos repetitivos al separar los detalles de venta, los pagos y las funcionalidades por perfil, cumpliendo el enfoque de 1FN. La única clave primaria compuesta documentada no posee atributos no clave, por lo que no presenta dependencias parciales de 2FN. Para 3FN, se separaron categorías, perfiles, funcionalidades y métodos de pago para evitar dependencias transitivas descriptivas. No obstante, el almacenamiento de `precio_venta` constituye una dependencia transitiva derivada según RN.06, y los valores calculados de `DETALLE_VENTA` y `VENTA` requieren revisión. Por ello, el modelo relacional actual debe revisarse antes de afirmar que alcanza estrictamente 3FN.
