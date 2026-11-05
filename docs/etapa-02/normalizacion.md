# Normalización del modelo relacional

Este análisis describe el modelo relacional implementado en
[`01_creacion_tablas.sql`](../../sql/ddl/01_creacion_tablas.sql), contrastado
con la estructura documentada en
[`modelo-relacional.md`](modelo-relacional.md).

## Primera Forma Normal (1FN)

La 1FN requiere que los valores de cada atributo sean atómicos y que no se
guarden grupos repetitivos en una misma fila.

El modelo representa los productos de una venta en filas separadas de
`DETALLE_VENTA`, relacionadas con `VENTA` y `PRODUCTO`. El detalle conserva
`cantidad` y `precio_unitario_catalogo`, en vez de guardar una lista de
productos dentro de `VENTA`.

Los pagos se representan en `PAGO`, relacionado con `VENTA` y
`METODO_PAGO`. Las funcionalidades asignadas a perfiles se registran en
`PERFIL_FUNCIONALIDAD`. Los teléfonos de clientes, usuarios y sucursales
se guardan en `CLIENTE_TELEFONO`, `USUARIO_TELEFONO` y
`SUCURSAL_TELEFONO`, respectivamente, con una fila por teléfono.

Así, esos conjuntos de valores se representan en filas relacionadas y
los atributos de las tablas contienen valores individuales.

## Segunda Forma Normal (2FN)

La 2FN requiere que cada atributo no clave dependa de la clave completa,
no solo de una parte de una clave compuesta.

El DDL define claves primarias compuestas en:

- `PERFIL_FUNCIONALIDAD` (`id_perfil`, `id_funcionalidad`);
- `SUCURSAL_TELEFONO` (`telefono`, `id_sucursal`);
- `CLIENTE_TELEFONO` (`telefono`, `id_cliente`);
- `USUARIO_TELEFONO` (`telefono`, `id_usuario`).

En esas tablas, ambos atributos de cada fila forman parte de la clave
primaria y no hay atributos no clave que dependan parcialmente de ella.
Las demás tablas usan claves primarias simples. Además, `INVENTARIO`
tiene una restricción `UNIQUE` sobre (`id_producto`, `id_sucursal`) para
permitir un solo registro de stock por producto y sucursal.

## Tercera Forma Normal (3FN)

La 3FN busca que los atributos no clave dependan de la clave y no de
otros atributos no clave.

El DDL mantiene en tablas separadas los datos descriptivos que se
referencian desde otras entidades: `CATEGORIA` y `PRODUCTO`;
`PROVINCIA`, `LOCALIDAD` y `DIRECCION`; `PERFIL`, `FUNCIONALIDAD` y
`USUARIO`; y `METODO_PAGO` y `PAGO`. Las claves foráneas conectan esas
tablas sin repetir sus descripciones en cada registro relacionado.

En `PRODUCTO`, `precio_venta` es una columna calculada `PERSISTED` cuya
expresión se define en el DDL a partir de `precio_costo` y
`porcentaje_ganancia`. No se ingresa ni modifica como un dato
independiente: SQL Server calcula y mantiene su valor cuando cambian los
datos de origen. Por ello, el análisis la identifica como derivada y no
la confunde con un valor de venta introducido manualmente.

En `DETALLE_VENTA`, los nombres definidos son `id_detalle` y
`precio_unitario_catalogo`. Este último conserva el precio aplicado al
producto en ese detalle. `VENTA` contiene sus datos de cabecera y `PAGO`
contiene `monto` y sus referencias a venta y método de pago.

## Conclusión

La estructura usa tablas relacionadas para representar detalles,
pagos, teléfonos y asignaciones de funcionalidades sin grupos
repetitivos. Las tablas con clave primaria compuesta no tienen atributos
no clave, y las entidades descriptivas se mantienen separadas mediante
claves foráneas. El precio de venta del producto es derivado y calculado
por SQL Server conforme al DDL. Este análisis se limita a las tablas,
columnas y restricciones presentes en el modelo y en el script de
creación actuales.
