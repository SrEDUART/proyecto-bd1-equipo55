1. Introduccion

La implementacion fisica de la base de datos del sistema de gestion de la ferreteria se realizo utilizando Microsoft SQL Server y el lenguaje Transact-SQL (T-SQL). El diseño se compone de 19 tablas que permiten administrar productos, categorias, sucursales, usuarios, clientes, inventario, ventas, pagos y permisos del sistema.

El objetivo de esta etapa es trasladar el diseño logico a estructuras concretas de base de datos, definiendo tipos de datos, claves, relaciones y restricciones que contribuyan a preservar la integridad y consistencia de la informacion.

2. Tecnologias y recursos utilizados

La implementacion utiliza recursos propios de SQL Server:

IDENTITY(1,1): genera identificadores numericos consecutivos automaticamente.

PRIMARY KEY: identifica de forma unica cada registro.

FOREIGN KEY: establece relaciones entre tablas y evita referencias a registros inexistentes.

UNIQUE: impide valores duplicados en las columnas o combinaciones de columnas especificadas.

CHECK: limita los valores admitidos segun una condicion.

DEFAULT: asigna un valor predeterminado cuando no se proporciona uno al insertar un registro.

GETDATE(): obtiene la fecha y hora actuales del servidor SQL.

Estas caracteristicas permiten trasladar parte de las reglas del negocio al nivel de la base de datos.

3. Organizacion de las tablas

Las 19 tablas se organizan en los siguientes dominios funcionales:

3.1. Catalogos y clasificacion

PROVINCIA: almacena las provincias.

LOCALIDAD: registra las localidades y las vincula con una provincia.

CATEGORIA: organiza los productos por categorias.

PRODUCTO: contiene los datos del catalogo de productos.

METODO_PAGO: registra los metodos de pago disponibles.

3.2. Usuarios y permisos

PERFIL: almacena los perfiles de usuario.

FUNCIONALIDAD: define las funcionalidades disponibles en el sistema.

PERFIL_FUNCIONALIDAD: vincula perfiles con funcionalidades.

USUARIO: almacena los usuarios internos y sus relaciones con direcciones, perfiles y sucursales.

3.3. Direcciones y personas

DIRECCION: centraliza las direcciones utilizadas por clientes, usuarios y sucursales.

CLIENTE: almacena los datos de los clientes.

CLIENTE_TELEFONO: registra los telefonos de los clientes.

USUARIO_TELEFONO: registra los telefonos de los usuarios.

3.4. Sucursales e inventario

SUCURSAL: contiene los datos de las sucursales.

SUCURSAL_TELEFONO: registra los telefonos de las sucursales.

INVENTARIO: administra las existencias y los niveles minimos de stock por producto y sucursal.

3.5. Operaciones comerciales

VENTA: almacena el encabezado de cada operacion de venta.

DETALLE_VENTA: registra los productos, cantidades y precios unitarios asociados a las ventas.

PAGO: registra los pagos vinculados a las ventas y sus metodos de pago.

Esta organizacion facilita la separacion de responsabilidades entre las entidades y permite establecer relaciones mediante claves foraneas.

4. Identificadores y claves primarias

La mayoria de las tablas utiliza columnas INT IDENTITY(1,1) como identificadores generados automaticamente. Cada una de estas tablas declara una clave primaria que identifica de forma unica sus registros.

Existen tablas cuya identificacion se realiza mediante claves primarias compuestas:

PERFIL_FUNCIONALIDAD: utiliza (id_perfil, id_funcionalidad).

SUCURSAL_TELEFONO: utiliza (telefono, id_sucursal).

CLIENTE_TELEFONO: utiliza (telefono, id_cliente).

USUARIO_TELEFONO: utiliza (telefono, id_usuario).

Estas claves compuestas impiden repetir la misma asociacion entre una entidad y una funcionalidad o un numero telefonico dentro de su entidad correspondiente.

5. Relaciones y claves foraneas

Las claves foraneas aseguran que las referencias entre tablas correspondan a registros existentes.

Entre las relaciones implementadas se encuentran:

LOCALIDAD con PROVINCIA.

DIRECCION con LOCALIDAD.

PRODUCTO con CATEGORIA.

CLIENTE y SUCURSAL con DIRECCION.

USUARIO con DIRECCION, PERFIL y SUCURSAL.

INVENTARIO con PRODUCTO y SUCURSAL.

VENTA con SUCURSAL, USUARIO y, opcionalmente, CLIENTE.

DETALLE_VENTA con VENTA y PRODUCTO.

PAGO con VENTA y METODO_PAGO.

La columna VENTA.id_cliente admite valores NULL, por lo que una venta puede registrarse sin asociarla a un cliente registrado. En cambio, las referencias a sucursal y usuario son obligatorias.

6. Columna calculada del precio de venta

En la tabla PRODUCTO, el precio de venta se calcula a partir del precio de costo y el porcentaje de ganancia mediante la siguiente expresion:

precio_costo * (1 + porcentaje_ganancia / 100.0)

El resultado se convierte a DECIMAL(10,2) y se define como una columna calculada mediante AS ... PERSISTED.

Esto permite obtener el precio de venta a partir de los valores de origen, evitando tener que mantener manualmente un precio derivado independiente. Al ser persistida, SQL Server almacena fisicamente el resultado calculado y lo actualiza cuando cambian sus valores de origen.

7. Control de inventario por sucursal

La tabla INVENTARIO contiene las columnas id_producto e id_sucursal, ademas de stock y stock_minimo.

La restriccion UQ_INVENTARIO_PRODUCTO_SUCURSAL establece que la combinacion (id_producto, id_sucursal) debe ser unica. De esta manera, un mismo producto no puede tener dos registros de inventario para una misma sucursal.

Esta restriccion permite controlar las existencias de forma independiente en cada sucursal y evita duplicaciones de la misma asociacion producto-sucursal.

8. Relacion entre perfiles y funcionalidades

La relacion entre PERFIL y FUNCIONALIDAD es de muchos a muchos: un perfil puede disponer de varias funcionalidades y una funcionalidad puede asignarse a distintos perfiles.

Esta relacion se implementa mediante la tabla intermedia PERFIL_FUNCIONALIDAD, que contiene las claves foraneas id_perfil e id_funcionalidad. Su clave primaria compuesta impide registrar dos veces la misma asignacion.

9. Conservacion del precio historico de las ventas

La tabla DETALLE_VENTA contiene precio_unitario_catalogo, que almacena el precio unitario aplicado al producto en el momento de la operacion.

Aunque el precio de venta del catalogo pueda cambiar posteriormente, el detalle conserva el valor registrado en la venta original. Esto permite mantener el historial de los importes cobrados y evita que una modificacion posterior del catalogo altere retroactivamente los precios historicos.

10. Tratamiento de atributos multivaluados

Los telefonos se almacenan en tablas independientes: CLIENTE_TELEFONO, USUARIO_TELEFONO y SUCURSAL_TELEFONO.

Esta decision permite que cada cliente, usuario o sucursal tenga varios numeros telefonicos sin incorporar multiples columnas de telefono en la tabla principal. Ademas, las claves foraneas vinculan cada numero con su entidad y las claves primarias compuestas evitan repetir el mismo numero para una misma entidad.

11. Bajas logicas

Varias tablas incluyen la columna eliminado_en, de tipo DATETIME, que admite valores NULL.

Esta columna permite representar una baja logica mediante el registro de una fecha y hora de eliminacion, en lugar de borrar fisicamente el registro. Un valor NULL indica que no se registro una baja logica en esa columna; un valor informado permite identificar cuando se registro.

Este mecanismo facilita conservar informacion historica. No obstante, para que las consultas excluyan los registros dados de baja, deben incorporar los filtros correspondientes.

12. Restricciones de integridad y valores predeterminados

La implementacion incorpora restricciones para evitar datos invalidos:

En PRODUCTO, precio_costo debe ser mayor que cero y porcentaje_ganancia debe ser mayor o igual que cero.

En DIRECCION, altura debe ser mayor que cero.

En INVENTARIO, stock y stock_minimo deben ser mayores o iguales que cero.

En VENTA, tipo_factura solo admite los valores A, B o C, y descuento debe estar entre cero y cien.

En DETALLE_VENTA, cantidad y precio_unitario_catalogo deben ser mayores que cero.

En PAGO, monto debe ser mayor que cero.

Tambien se utilizan restricciones UNIQUE para evitar duplicaciones en atributos como nombres de provincias, categorias, perfiles, metodos de pago y sucursales, codigos de barras, codigo de funcionalidad, DNI, nombre de usuario y correo electronico, segun la tabla correspondiente.

En cuanto a los valores predeterminados, VENTA.fecha_hora utiliza DEFAULT GETDATE() para asignar la fecha y hora actuales cuando no se proporciona un valor. Por su parte, VENTA.descuento utiliza DEFAULT 0.00 cuando no se especifica un descuento.

13. Conclusion

La implementacion fisica traduce el diseño de la base de datos de la ferreteria a estructuras concretas de SQL Server. El uso de claves primarias y foraneas, restricciones de unicidad, validaciones, valores predeterminados y columnas calculadas contribuye a preservar la integridad de los datos.

Asimismo, la separacion de telefonos, la gestion del inventario por sucursal, la asignacion de funcionalidades a perfiles y la conservacion de precios historicos permiten representar adecuadamente las necesidades operativas del sistema y facilitan el mantenimiento de la informacion.
