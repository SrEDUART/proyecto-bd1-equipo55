# Triggers de auditoría sobre PRODUCTO

## Integrante 4 — Auditoría

### Objetivo

Se implementó un mecanismo de auditoría sobre la tabla `PRODUCTO` para conservar los valores anteriores de los registros cuando se ejecutan operaciones `UPDATE` o `DELETE`.

La auditoría registra:

- identificador del producto afectado;
- tipo de operación (`UPDATE` o `DELETE`);
- valores anteriores del producto;
- fecha y hora de la operación;
- usuario de base de datos que ejecutó la sentencia.

## Tabla auxiliar

Se creó la tabla `AUDITORIA_PRODUCTO`.

La tabla conserva el estado anterior de las siguientes columnas de `PRODUCTO`:

- `codigo_barra`;
- `nombre_producto`;
- `descripcion`;
- `precio_costo`;
- `porcentaje_ganancia`;
- `precio_venta`;
- `id_categoria`;
- `eliminado_en`.

También registra `fecha_hora`, `usuario_bd` y `tipo_operacion`.

`id_producto` no se definió como clave foránea hacia `PRODUCTO`, debido a que la auditoría debe permanecer válida incluso después de eliminar físicamente el registro original.

## Triggers implementados

### `TR_PRODUCTO_AUD_UPDATE`

Se ejecuta después de una operación `UPDATE` sobre `PRODUCTO`.

En SQL Server, la tabla lógica `deleted` contiene los valores que poseía cada fila antes de la modificación. El trigger inserta esos valores en `AUDITORIA_PRODUCTO` y registra la operación como `UPDATE`.

La implementación utiliza `INSERT ... SELECT FROM deleted`, por lo que también funciona correctamente cuando una misma sentencia modifica más de una fila.

### `TR_PRODUCTO_AUD_DELETE`

Se ejecuta después de una operación `DELETE` sobre `PRODUCTO`.

La tabla lógica `deleted` conserva temporalmente los valores de las filas eliminadas. El trigger copia dichos valores a `AUDITORIA_PRODUCTO` y registra la operación como `DELETE`.

## Aclaración sobre valores anteriores

SQL Server no dispone de triggers `BEFORE` como otros motores de bases de datos. Para obtener el estado previo se utilizaron triggers `AFTER UPDATE` y `AFTER DELETE` junto con la tabla lógica `deleted`.

De esta manera, aunque el trigger se ejecute después de la sentencia DML, los valores almacenados en la tabla de auditoría corresponden al estado anterior del registro.

## Prueba de UPDATE

Para evitar alterar definitivamente los datos del proyecto, la prueba se realiza dentro de una transacción.

1. Se inserta un producto temporal.
2. Se consultan sus valores iniciales.
3. Se modifica `precio_costo` y `porcentaje_ganancia`.
4. Se consulta nuevamente el producto para verificar los valores nuevos.
5. Se consulta `AUDITORIA_PRODUCTO`.
6. La auditoría debe mostrar los valores que tenía el producto antes del `UPDATE`.
7. Se ejecuta `ROLLBACK`.

### Resultado esperado

La fila de auditoría debe contener:

- `tipo_operacion = 'UPDATE'`;
- el precio de costo anterior;
- el porcentaje de ganancia anterior;
- el precio de venta anterior;
- la fecha y hora de la modificación;
- el usuario SQL que ejecutó la operación.

### Evidencia

> Insertar aquí captura de la consulta del producto actualizado y de la fila registrada en `AUDITORIA_PRODUCTO`.

## Prueba de DELETE

También se utiliza una transacción de prueba.

1. Se inserta un producto temporal.
2. Se verifica que el producto exista.
3. Se ejecuta `DELETE`.
4. Se comprueba que la consulta a `PRODUCTO` ya no devuelva la fila.
5. Se consulta `AUDITORIA_PRODUCTO`.
6. La auditoría debe contener todos los valores anteriores del producto eliminado.
7. Se ejecuta `ROLLBACK`.

### Resultado esperado

La fila de auditoría debe contener:

- `tipo_operacion = 'DELETE'`;
- los datos que tenía el producto antes de eliminarse;
- la fecha y hora de la operación;
- el usuario SQL responsable.

### Evidencia

> Insertar aquí captura de la ausencia del producto luego del `DELETE` y de la fila registrada en `AUDITORIA_PRODUCTO`.

## Conclusión

Los triggers implementados permiten conservar la trazabilidad de modificaciones y eliminaciones realizadas sobre `PRODUCTO`.

El uso de la tabla lógica `deleted` permite almacenar el estado anterior de cada fila sin depender de que la aplicación cliente realice el registro de auditoría. Además, las pruebas controladas mediante transacciones permiten verificar el comportamiento de los triggers sin alterar permanentemente los datos utilizados por el proyecto.

La solución registra correctamente el tipo de operación, los valores anteriores, la fecha y hora y el usuario de base de datos que ejecutó la modificación.
