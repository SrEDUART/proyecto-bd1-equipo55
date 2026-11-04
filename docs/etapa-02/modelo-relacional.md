# Modelo Relacional

El modelo relacional vigente del sistema de gestión comercial para la ferretería multisucursal se encuentra compuesto por **20 tablas**.

De ellas, **19 corresponden al modelo principal del sistema** y **1 corresponde a una tabla técnica de auditoría** incorporada en la etapa final del proyecto.

La siguiente especificación se corresponde con la implementación física actual definida en los scripts SQL del proyecto.

---

## 1. Ubicación geográfica

### PROVINCIA
- `id_provincia` **PK**
- `nombre_provincia` **UNIQUE**

### LOCALIDAD
- `id_localidad` **PK**
- `nombre_localidad`
- `codigo_postal`
- `id_provincia` **FK → PROVINCIA.id_provincia**

### DIRECCION
- `id_direccion` **PK**
- `calle`
- `altura`
- `id_localidad` **FK → LOCALIDAD.id_localidad**

Relaciones:

```text
PROVINCIA 1 ─── N LOCALIDAD
LOCALIDAD 1 ─── N DIRECCION
```

---

## 2. Productos

### CATEGORIA
- `id_categoria` **PK**
- `nombre_cat` **UNIQUE**
- `descripcion_cat`
- `eliminado_en`

### PRODUCTO
- `id_producto` **PK**
- `codigo_barra` **UNIQUE**
- `nombre_producto`
- `descripcion`
- `precio_costo`
- `porcentaje_ganancia`
- `precio_venta` **columna calculada persistida**
- `id_categoria` **FK → CATEGORIA.id_categoria**
- `eliminado_en`

Relación:

```text
CATEGORIA 1 ─── N PRODUCTO
```

El valor de `precio_venta` se calcula automáticamente a partir de `precio_costo` y `porcentaje_ganancia`.

---

## 3. Auditoría de productos

### AUDITORIA_PRODUCTO
- `id_auditoria` **PK**
- `id_producto`
- `tipo_operacion`
- `codigo_barra_anterior`
- `nombre_producto_anterior`
- `descripcion_anterior`
- `precio_costo_anterior`
- `porcentaje_ganancia_anterior`
- `precio_venta_anterior`
- `id_categoria_anterior`
- `eliminado_en_anterior`
- `fecha_hora`
- `usuario_bd`

`AUDITORIA_PRODUCTO` es una **tabla técnica de auditoría** incorporada en la etapa final del proyecto.

Su función es conservar los valores anteriores de los registros de `PRODUCTO` cuando se ejecutan operaciones `UPDATE` o `DELETE`.

La columna `id_producto` **no se define como clave foránea** hacia `PRODUCTO`.

Esto es intencional, ya que la auditoría debe conservarse aunque el producto original sea eliminado físicamente. Si existiera una FK, el registro de auditoría podría impedir o invalidar el `DELETE`.

La relación entre ambas tablas es, por lo tanto, **lógica y técnica**, no una relación referencial mediante FK.

```text
PRODUCTO
   │
   │ auditado mediante triggers
   ▼
AUDITORIA_PRODUCTO
```

Los triggers utilizados son:

```text
TR_PRODUCTO_AUD_UPDATE
TR_PRODUCTO_AUD_DELETE
```

---

## 4. Sucursales

### SUCURSAL
- `id_sucursal` **PK**
- `nombre` **UNIQUE**
- `id_direccion` **FK → DIRECCION.id_direccion**
- `eliminado_en`

### SUCURSAL_TELEFONO
- `telefono` **PK**
- `id_sucursal` **PK, FK → SUCURSAL.id_sucursal**

La clave primaria de `SUCURSAL_TELEFONO` es compuesta:

```text
(telefono, id_sucursal)
```

Relaciones:

```text
DIRECCION 1 ─── N SUCURSAL
SUCURSAL 1 ─── N SUCURSAL_TELEFONO
```

---

## 5. Clientes

### CLIENTE
- `id_cliente` **PK**
- `nombre`
- `apellido`
- `dni` **UNIQUE**
- `correo` **UNIQUE**
- `id_direccion` **FK → DIRECCION.id_direccion**
- `eliminado_en`

### CLIENTE_TELEFONO
- `telefono` **PK**
- `id_cliente` **PK, FK → CLIENTE.id_cliente**

La clave primaria de `CLIENTE_TELEFONO` es compuesta:

```text
(telefono, id_cliente)
```

Relaciones:

```text
DIRECCION 1 ─── N CLIENTE
CLIENTE 1 ─── N CLIENTE_TELEFONO
```

---

## 6. Usuarios, perfiles y funcionalidades

### PERFIL
- `id_perfil` **PK**
- `nombre_perfil` **UNIQUE**
- `descripcion_perfil`
- `eliminado_en`

### FUNCIONALIDAD
- `id_funcionalidad` **PK**
- `codigo_funcionalidad` **UNIQUE**
- `nombre_funcionalidad`
- `descripcion_funcionalidad`
- `eliminado_en`

### PERFIL_FUNCIONALIDAD
- `id_perfil` **PK, FK → PERFIL.id_perfil**
- `id_funcionalidad` **PK, FK → FUNCIONALIDAD.id_funcionalidad**

La clave primaria es compuesta:

```text
(id_perfil, id_funcionalidad)
```

Esta tabla resuelve la relación muchos a muchos entre `PERFIL` y `FUNCIONALIDAD`.

### USUARIO
- `id_usuario` **PK**
- `nombre`
- `apellido`
- `dni` **UNIQUE**
- `nombre_usuario` **UNIQUE**
- `contraseña_hash`
- `correo` **UNIQUE**
- `fecha_nacimiento`
- `id_direccion` **FK → DIRECCION.id_direccion**
- `id_perfil` **FK → PERFIL.id_perfil**
- `id_sucursal` **FK → SUCURSAL.id_sucursal**
- `eliminado_en`

### USUARIO_TELEFONO
- `telefono` **PK**
- `id_usuario` **PK, FK → USUARIO.id_usuario**

La clave primaria es compuesta:

```text
(telefono, id_usuario)
```

Relaciones:

```text
PERFIL N ─── M FUNCIONALIDAD
       mediante PERFIL_FUNCIONALIDAD

PERFIL 1 ─── N USUARIO
DIRECCION 1 ─── N USUARIO
SUCURSAL 1 ─── N USUARIO
USUARIO 1 ─── N USUARIO_TELEFONO
```

---

## 7. Inventario

### INVENTARIO
- `id_inventario` **PK**
- `stock`
- `stock_minimo`
- `id_producto` **FK → PRODUCTO.id_producto**
- `id_sucursal` **FK → SUCURSAL.id_sucursal**

La combinación:

```text
(id_producto, id_sucursal)
```

posee una restricción `UNIQUE`, por lo que un producto solo puede tener un registro de inventario por sucursal.

Relaciones:

```text
PRODUCTO 1 ─── N INVENTARIO
SUCURSAL 1 ─── N INVENTARIO
```

Conceptualmente, `INVENTARIO` resuelve la disponibilidad de un producto en cada sucursal.

---

## 8. Ventas

### VENTA
- `id_venta` **PK**
- `fecha_hora`
- `tipo_factura`
- `descuento`
- `id_sucursal` **FK → SUCURSAL.id_sucursal**
- `id_cliente` **FK → CLIENTE.id_cliente, NULL permitido**
- `id_usuario` **FK → USUARIO.id_usuario**

Una venta puede no tener cliente asociado, por lo que `id_cliente` admite `NULL`.

### DETALLE_VENTA
- `id_detalle` **PK**
- `cantidad`
- `precio_unitario_catalogo`
- `id_producto` **FK → PRODUCTO.id_producto**
- `id_venta` **FK → VENTA.id_venta**

Relaciones:

```text
SUCURSAL 1 ─── N VENTA
CLIENTE 1 ─── N VENTA
USUARIO 1 ─── N VENTA

VENTA 1 ─── N DETALLE_VENTA
PRODUCTO 1 ─── N DETALLE_VENTA
```

`DETALLE_VENTA` conserva el precio utilizado al momento de la venta mediante `precio_unitario_catalogo`.

---

## 9. Métodos de pago y pagos

### METODO_PAGO
- `id_metodo_pago` **PK**
- `nombre` **UNIQUE**
- `descripcion`
- `eliminado_en`

### PAGO
- `id_pago` **PK**
- `monto`
- `id_venta` **FK → VENTA.id_venta**
- `id_metodo_pago` **FK → METODO_PAGO.id_metodo_pago**

Relaciones:

```text
VENTA 1 ─── N PAGO
METODO_PAGO 1 ─── N PAGO
```

Una venta puede registrar uno o varios pagos, permitiendo representar pagos combinados.

---

# Resumen de relaciones principales

```text
PROVINCIA 1 ─── N LOCALIDAD
LOCALIDAD 1 ─── N DIRECCION

DIRECCION 1 ─── N CLIENTE
DIRECCION 1 ─── N USUARIO
DIRECCION 1 ─── N SUCURSAL

CATEGORIA 1 ─── N PRODUCTO

PERFIL N ─── M FUNCIONALIDAD
       mediante PERFIL_FUNCIONALIDAD

PERFIL 1 ─── N USUARIO
SUCURSAL 1 ─── N USUARIO

PRODUCTO 1 ─── N INVENTARIO
SUCURSAL 1 ─── N INVENTARIO

CLIENTE 1 ─── N VENTA
USUARIO 1 ─── N VENTA
SUCURSAL 1 ─── N VENTA

VENTA 1 ─── N DETALLE_VENTA
PRODUCTO 1 ─── N DETALLE_VENTA

VENTA 1 ─── N PAGO
METODO_PAGO 1 ─── N PAGO

CLIENTE 1 ─── N CLIENTE_TELEFONO
USUARIO 1 ─── N USUARIO_TELEFONO
SUCURSAL 1 ─── N SUCURSAL_TELEFONO
```

Relación técnica de auditoría:

```text
PRODUCTO
   │
   │ triggers UPDATE / DELETE
   ▼
AUDITORIA_PRODUCTO
```

No existe FK entre `PRODUCTO` y `AUDITORIA_PRODUCTO`.

---

# Total de tablas

El modelo final contiene **20 tablas**.

## Tablas del modelo principal

1. `PROVINCIA`
2. `PERFIL`
3. `CATEGORIA`
4. `METODO_PAGO`
5. `PRODUCTO`
6. `LOCALIDAD`
7. `FUNCIONALIDAD`
8. `PERFIL_FUNCIONALIDAD`
9. `DIRECCION`
10. `CLIENTE`
11. `SUCURSAL`
12. `USUARIO`
13. `INVENTARIO`
14. `VENTA`
15. `DETALLE_VENTA`
16. `PAGO`
17. `SUCURSAL_TELEFONO`
18. `CLIENTE_TELEFONO`
19. `USUARIO_TELEFONO`

## Tabla técnica de auditoría

20. `AUDITORIA_PRODUCTO`

La tabla `AUDITORIA_PRODUCTO` fue incorporada posteriormente como parte de la implementación de triggers de auditoría y no representa una entidad propia del dominio comercial de la ferretería.

Este documento debe mantenerse sincronizado con los scripts SQL vigentes del proyecto.
