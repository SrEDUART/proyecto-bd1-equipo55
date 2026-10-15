# Pruebas y Validaciones — DML

## Objetivo

Documentar las pruebas intencionales incluidas en el DML del proyecto. Cada prueba intenta insertar un dato que viola una restricción de integridad definida en el DDL, con el fin de demostrar que esa restricción funciona correctamente. Todas las pruebas listadas **deben fallar** al ejecutarse (deben arrojar error).

## Tabla de pruebas

| Prueba | Restricción | Resultado esperado |
|---|---|---|
| Código de barra repetido | UNIQUE | Error |
| Porcentaje negativo | CHECK | Error |
| Provincia inexistente | FOREIGN KEY | Error |
| Altura igual a 0 | CHECK | Error |
| DNI de cliente repetido | UNIQUE | Error |
| Sucursal repetida | UNIQUE | Error |
| Usuario repetido | UNIQUE | Error |
| Sucursal inexistente en usuario | FOREIGN KEY | Error |
| Stock negativo | CHECK | Error |
| Producto inexistente en inventario | FOREIGN KEY | Error |
| Tipo de factura inválido | CHECK | Error |
| Cliente inexistente | FOREIGN KEY | Error |
| Cantidad igual a 0 | CHECK | Error |
| Producto inexistente en detalle | FOREIGN KEY | Error |
| Pago con monto 0 | CHECK | Error |
| Método de pago inexistente | FOREIGN KEY | Error |

## Explicación de cada prueba

**Código de barra repetido (UNIQUE):** se inserta un producto reutilizando el `codigo_barra` de un producto ya existente. Como `PRODUCTO.codigo_barra` tiene restricción `UNIQUE`, el motor rechaza el INSERT.

**Porcentaje negativo (CHECK):** se inserta un producto con `porcentaje_ganancia = -10.00`. La restricción `CHECK (porcentaje_ganancia >= 0)` impide valores negativos de margen de ganancia.

**Provincia inexistente (FOREIGN KEY):** se inserta una localidad con `id_provincia = 999`, un valor que no existe en `PROVINCIA`. La FK `FK_LOCALIDAD_PROVINCIA` impide crear una localidad huérfana.

**Altura igual a 0 (CHECK):** se inserta una dirección con `altura = 0`. La restricción `CHECK (altura > 0)` exige que la altura sea un valor positivo.

**DNI de cliente repetido (UNIQUE):** se inserta un cliente reutilizando el `dni` de un cliente ya cargado. La restricción `UNIQUE` sobre `CLIENTE.dni` evita que dos clientes compartan el mismo documento.

**Sucursal repetida (UNIQUE):** se inserta una sucursal con un `nombre` ya existente ("Sucursal Centro"). La restricción `UNIQUE` sobre `SUCURSAL.nombre` impide nombres duplicados.

**Usuario repetido (UNIQUE):** se inserta un usuario reutilizando un `nombre_usuario` ya existente ("jperez11"). La restricción `UNIQUE` sobre `USUARIO.nombre_usuario` garantiza que cada nombre de usuario sea único en el sistema.

**Sucursal inexistente en usuario (FOREIGN KEY):** se inserta un usuario con `id_sucursal = 999`. La FK `FK_USUARIO_SUCURSAL` impide asignar un usuario a una sucursal que no existe.

**Stock negativo (CHECK):** se inserta un registro de inventario con `stock = -5`. La restricción `CHECK (stock >= 0)` no permite valores negativos de stock.

**Producto inexistente en inventario (FOREIGN KEY):** se inserta un registro de inventario con `id_producto = 999`. La FK `FK_INVENTARIO_PRODUCTO` impide llevar stock de un producto que no existe en el catálogo.

**Tipo de factura inválido (CHECK):** se inserta una venta con `tipo_factura = 'X'`. La restricción `CHECK (tipo_factura IN ('A','B','C'))` solo permite los tipos de comprobante válidos.

**Cliente inexistente (FOREIGN KEY):** se inserta una venta con `id_cliente = 999`. La FK `FK_VENTA_CLIENTE` impide asociar la venta a un cliente que no está registrado.

**Cantidad igual a 0 (CHECK):** se inserta un detalle de venta con `cantidad = 0`. La restricción `CHECK (cantidad > 0)` exige que se venda al menos una unidad del producto.

**Producto inexistente en detalle (FOREIGN KEY):** se inserta un detalle de venta con `id_producto = 999`. La FK `FK_DETALLE_PRODUCTO` impide vender un producto que no existe.

**Pago con monto 0 (CHECK):** se inserta un pago con `monto = 0.00`. La restricción `CHECK (monto > 0)` no permite registrar un pago sin importe.

**Método de pago inexistente (FOREIGN KEY):** se inserta un pago con `id_metodo_pago = 999`. La FK `FK_PAGO_METODO` impide usar un método de pago que no está dado de alta en `METODO_PAGO`.

## Nota

Además de estas pruebas negativas, el DML incluye ejemplos de `UPDATE` sobre cada una de las tablas principales (`PRODUCTO`, `LOCALIDAD`, `DIRECCION`, `FUNCIONALIDAD`, `SUCURSAL`, `USUARIO`, `INVENTARIO`, `VENTA`, `DETALLE_VENTA`, `PAGO`, `CLIENTE`), que demuestran que las modificaciones válidas sí se aplican correctamente cuando respetan las restricciones de integridad.
