# Implementación física de la base de datos

## 1. Introducción

La implementación física de la base de datos del sistema de gestión de la ferretería se realizó utilizando Microsoft SQL Server y el lenguaje Transact-SQL (T-SQL). El diseño se compone de 19 tablas que permiten administrar productos, categorías, sucursales, usuarios, clientes, inventario, ventas, pagos y permisos del sistema.

El objetivo de esta etapa es trasladar el diseño lógico a estructuras concretas de base de datos, definiendo tipos de datos, claves, relaciones y restricciones que contribuyan a preservar la integridad y consistencia de la información.

## 2. Tecnologías y recursos utilizados

La implementación utiliza recursos propios de SQL Server:

- **IDENTITY(1,1)**: genera identificadores numéricos consecutivos automáticamente.
- **PRIMARY KEY**: identifica de forma única cada registro.
- **FOREIGN KEY**: establece relaciones entre tablas y evita referencias a registros inexistentes.
- **UNIQUE**: impide valores duplicados en las columnas o combinaciones de columnas especificadas.
- **CHECK**: limita los valores admitidos según una condición.
- **DEFAULT**: asigna un valor predeterminado cuando no se proporciona uno al insertar un registro.
- **GETDATE()**: obtiene la fecha y hora actuales del servidor SQL.
- **Columnas calculadas (`AS ... PERSISTED`)**: derivan un valor a partir de otras columnas de la misma tabla y lo almacenan físicamente, actualizándolo cuando cambian sus valores de origen.

Estas características permiten trasladar parte de las reglas del negocio al nivel de la base de datos.

## 3. Organización de las tablas

Las 19 tablas se organizan en los siguientes dominios funcionales:

### 3.1. Catálogos y clasificación

- **PROVINCIA**: almacena las provincias.
- **LOCALIDAD**: registra las localidades y las vincula con una provincia.
- **CATEGORIA**: organiza los productos por categorías.
- **PRODUCTO**: contiene los datos del catálogo de productos.
- **METODO_PAGO**: registra los métodos de pago disponibles.

### 3.2. Usuarios y permisos

- **PERFIL**: almacena los perfiles de usuario.
- **FUNCIONALIDAD**: define las funcionalidades disponibles en el sistema.
- **PERFIL_FUNCIONALIDAD**: vincula perfiles con funcionalidades.
- **USUARIO**: almacena los usuarios internos y sus relaciones con direcciones, perfiles y sucursales.

### 3.3. Direcciones y personas

- **DIRECCION**: centraliza las direcciones utilizadas por clientes, usuarios y sucursales.
- **CLIENTE**: almacena los datos de los clientes.
- **CLIENTE_TELEFONO**: registra los teléfonos de los clientes.
- **USUARIO_TELEFONO**: registra los teléfonos de los usuarios.

### 3.4. Sucursales e inventario

- **SUCURSAL**: contiene los datos de las sucursales.
- **SUCURSAL_TELEFONO**: registra los teléfonos de las sucursales.
- **INVENTARIO**: administra las existencias y los niveles mínimos de stock por producto y sucursal.

### 3.5. Operaciones comerciales

- **VENTA**: almacena el encabezado de cada operación de venta.
- **DETALLE_VENTA**: registra los productos, cantidades y precios unitarios asociados a las ventas.
- **PAGO**: registra los pagos vinculados a las ventas y sus métodos de pago.

Esta organización facilita la separación de responsabilidades entre las entidades y permite establecer relaciones mediante claves foráneas.

## 4. Identificadores y claves primarias

La mayoría de las tablas utiliza columnas `INT IDENTITY(1,1)` como identificadores generados automáticamente. Cada una de estas tablas declara una clave primaria que identifica de forma única sus registros.

Existen tablas cuya identificación se realiza mediante claves primarias compuestas:

- **PERFIL_FUNCIONALIDAD**: utiliza `(id_perfil, id_funcionalidad)`.
- **SUCURSAL_TELEFONO**: utiliza `(telefono, id_sucursal)`.
- **CLIENTE_TELEFONO**: utiliza `(telefono, id_cliente)`.
- **USUARIO_TELEFONO**: utiliza `(telefono, id_usuario)`.

Estas claves compuestas impiden repetir la misma asociación entre una entidad y una funcionalidad, o un mismo número telefónico dentro de su entidad correspondiente.

## 5. Relaciones y claves foráneas

Las claves foráneas aseguran que las referencias entre tablas correspondan a registros existentes. Las relaciones implementadas son las siguientes:

| Tabla dependiente | Tabla(s) referenciada(s) |
|---|---|
| LOCALIDAD | PROVINCIA |
| DIRECCION | LOCALIDAD |
| PRODUCTO | CATEGORIA |
| CLIENTE | DIRECCION |
| SUCURSAL | DIRECCION |
| USUARIO | DIRECCION, PERFIL, SUCURSAL |
| PERFIL_FUNCIONALIDAD | PERFIL, FUNCIONALIDAD |
| INVENTARIO | PRODUCTO, SUCURSAL |
| VENTA | SUCURSAL, USUARIO, CLIENTE (opcional) |
| DETALLE_VENTA | VENTA, PRODUCTO |
| PAGO | VENTA, METODO_PAGO |
| SUCURSAL_TELEFONO | SUCURSAL |
| CLIENTE_TELEFONO | CLIENTE |
| USUARIO_TELEFONO | USUARIO |

La columna `VENTA.id_cliente` admite valores NULL, por lo que una venta puede registrarse sin asociarla a un cliente registrado. En cambio, las referencias a sucursal y usuario son obligatorias.

## 6. Columna calculada del precio de venta

En la tabla PRODUCTO, el precio de venta se calcula a partir del precio de costo y el porcentaje de ganancia mediante la siguiente expresión:

```sql
precio_costo * (1 + porcentaje_ganancia / 100.0)
```

El resultado se convierte a `DECIMAL(10,2)` y se define como una columna calculada mediante `AS ... PERSISTED`.

Esto permite obtener el precio de venta a partir de los valores de origen, evitando tener que mantener manualmente un precio derivado independiente. Al ser persistida, SQL Server almacena físicamente el resultado calculado y lo actualiza cuando cambian sus valores de origen.

## 7. Control de inventario por sucursal

La tabla INVENTARIO contiene las columnas `id_producto` e `id_sucursal`, además de `stock` y `stock_minimo`.

La restricción `UQ_INVENTARIO_PRODUCTO_SUCURSAL` establece que la combinación `(id_producto, id_sucursal)` debe ser única. De esta manera, un mismo producto no puede tener dos registros de inventario para una misma sucursal.

Esta restricción permite controlar las existencias de forma independiente en cada sucursal y evita duplicaciones de la misma asociación producto-sucursal.

## 8. Relación entre perfiles y funcionalidades

La relación entre PERFIL y FUNCIONALIDAD es de muchos a muchos: un perfil puede disponer de varias funcionalidades y una funcionalidad puede asignarse a distintos perfiles.

Esta relación se implementa mediante la tabla intermedia PERFIL_FUNCIONALIDAD, que contiene las claves foráneas `id_perfil` e `id_funcionalidad`. Su clave primaria compuesta impide registrar dos veces la misma asignación.

## 9. Conservación del precio histórico de las ventas

La tabla DETALLE_VENTA contiene `precio_unitario_catalogo`, que almacena el precio unitario aplicado al producto en el momento de la operación.

Aunque el precio de venta del catálogo pueda cambiar posteriormente, el detalle conserva el valor registrado en la venta original. Esto permite mantener el historial de los importes cobrados y evita que una modificación posterior del catálogo altere retroactivamente los precios históricos.

## 10. Tratamiento de atributos multivaluados

Los teléfonos se almacenan en tablas independientes: CLIENTE_TELEFONO, USUARIO_TELEFONO y SUCURSAL_TELEFONO.

Esta decisión permite que cada cliente, usuario o sucursal tenga varios números telefónicos sin incorporar múltiples columnas de teléfono en la tabla principal. Además, las claves foráneas vinculan cada número con su entidad y las claves primarias compuestas evitan repetir el mismo número para una misma entidad.

## 11. Bajas lógicas

Varias tablas incluyen la columna `eliminado_en`, de tipo `DATETIME`, que admite valores NULL.

Esta columna permite representar una baja lógica mediante el registro de una fecha y hora de eliminación, en lugar de borrar físicamente el registro. Un valor NULL indica que no se registró una baja lógica en esa columna; un valor informado permite identificar cuándo se registró.

Este mecanismo facilita conservar información histórica. No obstante, para que las consultas excluyan los registros dados de baja, deben incorporar los filtros correspondientes.

## 12. Restricciones de integridad y valores predeterminados

La implementación incorpora restricciones para evitar datos inválidos:

- En **PRODUCTO**, `precio_costo` debe ser mayor que cero y `porcentaje_ganancia` debe ser mayor o igual que cero.
- En **DIRECCION**, `altura` debe ser mayor que cero.
- En **INVENTARIO**, `stock` y `stock_minimo` deben ser mayores o iguales que cero.
- En **VENTA**, `tipo_factura` solo admite los valores A, B o C, y `descuento` debe estar entre cero y cien.
- En **DETALLE_VENTA**, `cantidad` y `precio_unitario_catalogo` deben ser mayores que cero.
- En **PAGO**, `monto` debe ser mayor que cero.

También se utilizan restricciones UNIQUE para evitar duplicaciones en atributos como nombres de provincias, categorías, perfiles, métodos de pago y sucursales, códigos de barras, código de funcionalidad, DNI, nombre de usuario y correo electrónico, según la tabla correspondiente.

En cuanto a los valores predeterminados, `VENTA.fecha_hora` utiliza `DEFAULT GETDATE()` para asignar la fecha y hora actuales cuando no se proporciona un valor. Por su parte, `VENTA.descuento` utiliza `DEFAULT 0.00` cuando no se especifica un descuento.

## 13. Conclusión

La implementación física traduce el diseño de la base de datos de la ferretería a estructuras concretas de SQL Server. El uso de claves primarias y foráneas, restricciones de unicidad, validaciones, valores predeterminados y columnas calculadas contribuye a preservar la integridad de los datos.

Asimismo, la separación de teléfonos, la gestión del inventario por sucursal, la asignación de funcionalidades a perfiles y la conservación de precios históricos permiten representar adecuadamente las necesidades operativas del sistema y facilitan el mantenimiento de la información.
