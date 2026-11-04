# Restricciones de Integridad — DDL

## Objetivo

Este documento describe las restricciones de integridad implementadas en el DDL del sistema de la ferretería, explicando su propósito y mostrando ejemplos reales tomados del esquema del proyecto.

---

## PRIMARY KEY

Cada tabla del modelo posee una clave primaria que identifica de manera única a cada registro. En la mayoría de las tablas se implementa como una columna `IDENTITY(1,1)` autoincremental; en las tablas intermedias e intersección (relaciones N:M o atributos multivaluados) se implementa como clave compuesta.

Ejemplo (clave simple):

```sql
CONSTRAINT PK_PRODUCTO
PRIMARY KEY (id_producto)
```

Ejemplo (clave compuesta, tabla intermedia N:M):

```sql
CONSTRAINT PK_PERFIL_FUNCIONALIDAD
PRIMARY KEY (id_perfil, id_funcionalidad)
```

Ejemplo (clave compuesta, atributo multivaluado):

```sql
CONSTRAINT PK_CLIENTE_TELEFONO
PRIMARY KEY (telefono, id_cliente)
```

---

## FOREIGN KEY

Las claves foráneas garantizan la integridad referencial: un registro no puede referenciar a otro que no existe en la tabla padre. Se usan para vincular tablas dependientes con sus tablas de referencia (por ejemplo, un producto con su categoría, o una venta con su sucursal, cliente y usuario).

Ejemplo:

```sql
CONSTRAINT FK_PRODUCTO_CATEGORIA
FOREIGN KEY (id_categoria)
REFERENCES CATEGORIA(id_categoria)
```

Otro ejemplo, con varias FK en una misma tabla (`VENTA`, que referencia a `SUCURSAL`, `CLIENTE` y `USUARIO`):

```sql
CONSTRAINT FK_VENTA_SUCURSAL
FOREIGN KEY (id_sucursal)
REFERENCES SUCURSAL(id_sucursal),

CONSTRAINT FK_VENTA_CLIENTE
FOREIGN KEY (id_cliente)
REFERENCES CLIENTE(id_cliente),

CONSTRAINT FK_VENTA_USUARIO
FOREIGN KEY (id_usuario)
REFERENCES USUARIO(id_usuario)
```

En `VENTA`, la FK hacia `CLIENTE` permite valores `NULL` (`id_cliente INT NULL`), ya que una venta puede realizarse sin un cliente registrado (consumidor final).

---

## UNIQUE

Las restricciones UNIQUE evitan valores duplicados en columnas que deben identificar de forma inequívoca a una entidad, aunque no sean la clave primaria. En el proyecto se aplican en:

```text
PROVINCIA.nombre_provincia
PERFIL.nombre_perfil
CATEGORIA.nombre_cat
METODO_PAGO.nombre
PRODUCTO.codigo_barra
FUNCIONALIDAD.codigo_funcionalidad
CLIENTE.dni
CLIENTE.correo
SUCURSAL.nombre
USUARIO.dni
USUARIO.nombre_usuario
USUARIO.correo
```

También se utiliza una restricción UNIQUE compuesta en `INVENTARIO`, para garantizar que un mismo producto no tenga más de un registro de stock por sucursal:

```sql
CONSTRAINT UQ_INVENTARIO_PRODUCTO_SUCURSAL
UNIQUE (id_producto, id_sucursal)
```

---

## CHECK

Las restricciones CHECK validan reglas de negocio a nivel de columna, impidiendo que se inserten o actualicen valores fuera de los rangos o formatos permitidos. En el proyecto se utilizan para:

```text
precio_costo > 0                        -- PRODUCTO
porcentaje_ganancia >= 0                 -- PRODUCTO
altura > 0                               -- DIRECCION
stock >= 0                               -- INVENTARIO
stock_minimo >= 0                        -- INVENTARIO
descuento BETWEEN 0 AND 100              -- VENTA
tipo_factura IN ('A', 'B', 'C')          -- VENTA
cantidad > 0                             -- DETALLE_VENTA
precio_unitario_catalogo > 0             -- DETALLE_VENTA
monto > 0                                -- PAGO
```

Ejemplo:

```sql
precio_costo DECIMAL(10,2) NOT NULL CHECK (precio_costo > 0)
```

---

## DEFAULT

Las restricciones DEFAULT asignan un valor automático a una columna cuando no se especifica uno explícito en el INSERT. Se utilizan en `VENTA` para:

```sql
fecha_hora DATETIME NOT NULL DEFAULT GETDATE()
```

De esta manera, si no se indica la fecha y hora de la venta, el sistema toma la fecha y hora actual del servidor.

```sql
descuento DECIMAL(5,2) NOT NULL DEFAULT 0.00
```

De esta manera, si no se indica un descuento, la venta se registra sin descuento (0%) por defecto.

---

## Bajas lógicas (`eliminado_en`)

Varias tablas del modelo (`PERFIL`, `CATEGORIA`, `METODO_PAGO`, `PRODUCTO`, `FUNCIONALIDAD`, `CLIENTE`, `SUCURSAL`, `USUARIO`) incluyen una columna `eliminado_en DATETIME NULL`.

Esta columna implementa el patrón de **baja lógica** (*soft delete*): en lugar de eliminar físicamente un registro con `DELETE`, se actualiza `eliminado_en` con la fecha y hora en la que se dio de baja. Mientras el valor sea `NULL`, el registro se considera activo; cuando tiene una fecha, se considera dado de baja.

Este enfoque evita romper la integridad referencial con tablas que dependen de esos registros (por ejemplo, no se puede borrar físicamente un producto que ya tiene ventas asociadas) y permite conservar el historial completo del sistema para auditoría y reportes.
