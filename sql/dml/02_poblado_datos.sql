-- ============================================================
-- PROVINCIA: listado de provincias usadas para las direcciones
-- del sistema (clientes, usuarios, sucursales).
-- ============================================================
INSERT INTO PROVINCIA (nombre_provincia) VALUES
('Corrientes'), ('Chaco'), ('Misiones'), ('Jujuy'), ('Salta'),
('Entre Rios'), ('Buenos Aires'), ('Cordoba');

-- Verificacion: muestra las provincias cargadas
SELECT * FROM PROVINCIA ORDER BY id_provincia ASC;


-- ============================================================
-- PERFIL: roles de usuario del sistema, usados para controlar
-- que funcionalidades puede usar cada empleado.
-- ============================================================
INSERT INTO PERFIL (nombre_perfil, descripcion_perfil) VALUES
('Administrador', 'Acceso total al sistema'),
('Vendedor', 'Atencion al cliente y emision de comprobantes de venta'),
('Cajero', 'Cobro de ventas y arqueo de caja diario'),
('Encargado de Stock', 'Gestion de inventario y recepcion de mercaderia'),
('Gerente de Sucursal', 'Supervision de operaciones y reportes locales'),
('Auditor', 'Solo lectura para revision de ventas y contabilidad'),
('Soporte Tecnico', 'Mantenimiento de usuarios y funciones del sistema'),
('Comprador', 'Gestion de pedidos a proveedores y reposicion');

-- Verificacion: muestra los perfiles cargados
SELECT * FROM PERFIL ORDER BY id_perfil ASC;


-- ============================================================
-- CATEGORIA: rubros en los que se agrupan los productos del
-- catalogo (modulo de Integrante 3).
-- ============================================================
INSERT INTO CATEGORIA (nombre_cat, descripcion_cat) VALUES
('Herramientas', 'Herramientas de mano'),
('Herramientas Electricas', 'Taladros, amoladoras, sierras y lijadoras'),
('Buloneria y Fijaciones', 'Tornillos, tuercas, arandelas y tarugos'),
('Pintureria', 'Pinturas, pinceles, rodillos y solventes'),
('Electricidad', 'Cables, llaves termicas, tomacorrientes e iluminacion'),
('Plomeria y Agua', 'Canos, conexiones, griferia y selladores'),
('Jardineria y Camping', 'Mangueras, bordadoras, palas y accesorios'),
('Seguridad Industrial', 'Cascos, guantes, antiparras y calzado de proteccion');

-- Verificacion: muestra las categorias cargadas
SELECT * FROM CATEGORIA ORDER BY id_categoria ASC;


-- ============================================================
-- METODO_PAGO: formas de pago disponibles para registrar
-- un cobro en una venta.
-- ============================================================
INSERT INTO METODO_PAGO (nombre, descripcion) VALUES
('Efectivo', 'Pago contado en caja'),
('Tarjeta de Debito', 'Cobro electronico mediante posnet en un solo pago'),
('Tarjeta de Credito', 'Cobro electronico con posibilidad de cuotas'),
('Transferencia Bancaria', 'Acreditacion directa a la cuenta de la empresa'),
('Mercado Pago QR', 'Escaneo de codigo QR desde billetera virtual'),
('Cuenta Corriente', 'Credito otorgado a clientes habituales a pagar en fecha'),
('Cheque', 'Pago diferido mediante documento bancario');

-- Verificacion: muestra los metodos de pago cargados
SELECT * FROM METODO_PAGO ORDER BY id_metodo_pago ASC;
--


-- Carga de productos de prueba: un producto por cada categoria existente.
-- El ultimo valor de cada fila es el id_categoria al que pertenece
-- (1=Herramientas, 2=Herramientas Electricas, 3=Buloneria y Fijaciones,
-- 4=Pintureria, 5=Electricidad, 6=Plomeria y Agua, 7=Jardineria y Camping,
-- 8=Seguridad Industrial).
INSERT INTO PRODUCTO (codigo_barra, nombre_producto, descripcion, porcentaje_ganancia, id_categoria) VALUES
('7791234561001', 'Martillo carpintero', 'Martillo de carpintero, mango de madera, cabeza de acero de 300g', 40.00, 1),
('7791234561002', 'Amoladora angular 4-1/2', 'Amoladora angular de 750W con disco de corte incluido', 30.00, 2),
('7791234561003', 'Tornillo autoperforante x100', 'Caja de 100 tornillos autoperforantes punta mecha', 50.00, 3),
('7791234561004', 'Pintura latex interior 4L', 'Pintura latex blanco mate para interiores, balde de 4 litros', 35.00, 4),
('7791234561005', 'Llave termica 16A', 'Llave termica monofasica curva C de 16 amperes', 32.00, 5),
('7791234561006', 'Cano PVC 110mm x 3m', 'Cano de PVC de 110mm de diametro para desague cloacal', 26.00, 6),
('7791234561007', 'Manguera de riego 15m', 'Manguera reforzada de 15 metros con conectores', 30.00, 7),
('7791234561008', 'Casco de seguridad', 'Casco de seguridad clase B con ajuste tipo cricket', 40.00, 8);

-- Verificacion: muestra todo lo que quedo cargado en la tabla
SELECT * FROM PRODUCTO ORDER BY id_producto ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error al ejecutar).
-- Se repite a proposito el codigo_barra del primer producto para
-- demostrar que la restriccion UNIQUE de esa columna funciona.
INSERT INTO PRODUCTO (codigo_barra, nombre_producto, descripcion, porcentaje_ganancia, id_categoria) VALUES
('7791234561001', 'Martillo duplicado', 'Prueba de codigo de barra repetido', 40.00, 1);

-- Prueba de Restriccion CHECK (esto tambien DEBE tirar error).
-- Se carga un porcentaje_ganancia negativo a proposito para
-- demostrar que la restriccion CHECK (porcentaje_ganancia >= 0) funciona.
INSERT INTO PRODUCTO (codigo_barra, nombre_producto, descripcion, porcentaje_ganancia, id_categoria) VALUES
('7791234561099', 'Producto con margen invalido', 'Prueba de CHECK porcentaje_ganancia', -10.00, 1);

-- Ejemplo de UPDATE 1: corregir el margen de ganancia de un producto
-- (se busca por id_producto)
UPDATE PRODUCTO
SET porcentaje_ganancia = 45.00
WHERE id_producto = 1;

-- Ejemplo de UPDATE 2: actualizar la descripcion de un producto
-- por un cambio de presentacion (se busca por codigo_barra)
UPDATE PRODUCTO
SET descripcion = 'Pintura latex blanco mate para interiores, balde de 4 litros, nueva formula'
WHERE codigo_barra = '7791234561004';


-- Carga de localidades de prueba. El ultimo valor de cada fila
-- es el id_provincia al que pertenece (1=Corrientes, 2=Chaco,
-- 3=Misiones, segun el orden en que se cargo PROVINCIA).
INSERT INTO LOCALIDAD (nombre_localidad, codigo_postal, id_provincia) VALUES
('Corrientes Capital', '3400', 1),
('Goya', '3450', 1),
('Mercedes', '3470', 1),
('San Luis del Palmar', '3413', 1),
('Resistencia', '3500', 2),
('Saenz Pena', '3700', 2),
('Posadas', '3300', 3),
('Obera', '3360', 3);

-- Verificacion: muestra las localidades cargadas
SELECT * FROM LOCALIDAD ORDER BY id_localidad ASC;

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error al ejecutar).
-- Se usa un id_provincia que no existe (999) para demostrar que
-- la restriccion FK_LOCALIDAD_PROVINCIA funciona.
INSERT INTO LOCALIDAD (nombre_localidad, codigo_postal, id_provincia) VALUES
('Localidad Invalida', '0000', 999);

-- Ejemplo de UPDATE: corregir el codigo postal de una localidad
UPDATE LOCALIDAD
SET codigo_postal = '3401'
WHERE nombre_localidad = 'Corrientes Capital';


-- Carga de funcionalidades de prueba, una por cada perfil existente.
-- El ultimo valor de cada fila es el id_perfil al que corresponde
-- (1=Administrador, 2=Vendedor, 3=Cajero, 4=Encargado de Stock,
-- 5=Gerente de Sucursal, 6=Auditor, 7=Soporte Tecnico, 8=Comprador).
INSERT INTO FUNCIONALIDAD (codigo_funcionalidad, nombre_funcionalidad, descripcion_funcionalidad, id_perfil) VALUES
(101, 'Gestionar Usuarios', 'Alta, baja y modificacion de usuarios del sistema', 1),
(102, 'Registrar Venta', 'Emitir un comprobante de venta y cobrar', 2),
(103, 'Arquear Caja', 'Realizar el arqueo de caja al cierre del turno', 3),
(104, 'Ajustar Stock', 'Modificar el stock de un producto por recepcion de mercaderia', 4),
(105, 'Ver Reportes de Sucursal', 'Consultar reportes de ventas y stock de la sucursal', 5),
(106, 'Auditar Ventas', 'Revisar en modo lectura las ventas y pagos registrados', 6),
(107, 'Administrar Perfiles', 'Configurar perfiles y funcionalidades del sistema', 7),
(108, 'Generar Pedido a Proveedor', 'Crear un pedido de reposicion a un proveedor', 8);

-- Verificacion: muestra las funcionalidades cargadas
SELECT * FROM FUNCIONALIDAD ORDER BY id_funcionalidad ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error al ejecutar).
-- Se repite a proposito el codigo_funcionalidad 101 para demostrar
-- que la restriccion UNIQUE de esa columna funciona.
INSERT INTO FUNCIONALIDAD (codigo_funcionalidad, nombre_funcionalidad, descripcion_funcionalidad, id_perfil) VALUES
(101, 'Funcionalidad Duplicada', 'Prueba de codigo repetido', 1);

-- Ejemplo de UPDATE: actualizar la descripcion de una funcionalidad
UPDATE FUNCIONALIDAD
SET descripcion_funcionalidad = 'Alta, baja, modificacion y bloqueo de usuarios del sistema'
WHERE codigo_funcionalidad = 101;

-- ============================================================
-- DIRECCION: direcciones utilizadas por clientes, usuarios
-- y sucursales del sistema.
-- ============================================================
INSERT INTO DIRECCION (calle, altura, id_localidad) VALUES
('Junin', 1250, 1),
('San Juan', 845, 1),
('Cordoba', 1560, 1),
('Colon', 720, 2),
('Belgrano', 980, 3),
('9 de Julio', 1340, 5);

-- Verificacion: muestra las direcciones cargadas
SELECT * FROM DIRECCION ORDER BY id_direccion ASC;

-- Prueba de Restriccion CHECK (esto DEBE tirar error al ejecutar).
-- Se usa una altura igual a 0 para demostrar que la restriccion
-- CHECK (altura > 0) funciona.
INSERT INTO DIRECCION (calle, altura, id_localidad) VALUES
('Direccion Invalida', 0, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un id_localidad inexistente.
INSERT INTO DIRECCION (calle, altura, id_localidad) VALUES
('Calle Inexistente', 500, 999);

-- Ejemplo de UPDATE: modificar la altura de una direccion
UPDATE DIRECCION
SET altura = 1300
WHERE id_direccion = 1;


-- ============================================================
-- CLIENTE: clientes registrados en la ferreteria.
-- ============================================================
INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion) VALUES
('Martin', 'Gomez', 35123456, 'martin.gomez@mail.com', 1),
('Laura', 'Fernandez', 36789412, 'laura.fernandez@mail.com', 2),
('Carlos', 'Ramirez', 38945612, 'carlos.ramirez@mail.com', 4),
('Sofia', 'Benitez', 40123789, 'sofia.benitez@mail.com', 5);

-- Verificacion: muestra los clientes cargados
SELECT * FROM CLIENTE ORDER BY id_cliente ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error).
-- Se repite el DNI de un cliente existente.
INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion) VALUES
('Cliente', 'Duplicado', 35123456, 'cliente.duplicado@mail.com', 3);

-- Ejemplo de UPDATE: actualizar el correo de un cliente
UPDATE CLIENTE
SET correo = 'martin.gomez.nuevo@mail.com'
WHERE id_cliente = 1;


-- ============================================================
-- SUCURSAL: sucursales disponibles de la ferreteria.
-- ============================================================
INSERT INTO SUCURSAL (nombre, id_direccion) VALUES
('Sucursal Centro', 3),
('Sucursal Goya', 4),
('Sucursal Mercedes', 5);

-- Verificacion: muestra las sucursales cargadas
SELECT * FROM SUCURSAL ORDER BY id_sucursal ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error).
-- Se repite el nombre de una sucursal existente.
INSERT INTO SUCURSAL (nombre, id_direccion) VALUES
('Sucursal Centro', 6);

-- Ejemplo de UPDATE: modificar el nombre de una sucursal
UPDATE SUCURSAL
SET nombre = 'Sucursal Centro Corrientes'
WHERE id_sucursal = 1;


-- ============================================================
-- USUARIO: usuarios que operan el sistema.
-- ============================================================
INSERT INTO USUARIO (
    nombre,
    apellido,
    dni,
    nombre_usuario,
    contraseña_hash,
    correo,
    fecha_nacimiento,
    id_direccion,
    id_perfil,
    id_sucursal
) VALUES
('Juan', 'Perez', 32123456, 'jperez', 'hash_usuario_01',
 'juan.perez@ferreteria.com', '1990-05-15', 1, 1, 1),

('Maria', 'Lopez', 35456789, 'mlopez', 'hash_usuario_02',
 'maria.lopez@ferreteria.com', '1993-08-22', 2, 2, 1),

('Pedro', 'Acosta', 37896541, 'pacosta', 'hash_usuario_03',
 'pedro.acosta@ferreteria.com', '1988-11-10', 4, 3, 2),

('Ana', 'Gimenez', 40234567, 'agimenez', 'hash_usuario_04',
 'ana.gimenez@ferreteria.com', '1998-03-25', 5, 4, 3);

-- Verificacion: muestra los usuarios cargados
SELECT * FROM USUARIO ORDER BY id_usuario ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error).
-- Se repite a proposito el nombre_usuario jperez.
INSERT INTO USUARIO (
    nombre,
    apellido,
    dni,
    nombre_usuario,
    contraseña_hash,
    correo,
    fecha_nacimiento,
    id_direccion,
    id_perfil,
    id_sucursal
) VALUES
('Usuario', 'Duplicado', 41234567, 'jperez', 'hash_prueba',
 'usuario.duplicado@ferreteria.com', '2000-01-15', 3, 2, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un id_sucursal que no existe.
INSERT INTO USUARIO (
    nombre,
    apellido,
    dni,
    nombre_usuario,
    contraseña_hash,
    correo,
    fecha_nacimiento,
    id_direccion,
    id_perfil,
    id_sucursal
) VALUES
('Usuario', 'Invalido', 42345678, 'uinvalido', 'hash_prueba',
 'usuario.invalido@ferreteria.com', '1995-06-20', 3, 2, 999);

-- Ejemplo de UPDATE: modificar el perfil de un usuario
UPDATE USUARIO
SET id_perfil = 5
WHERE id_usuario = 2;


-- ============================================================
-- INVENTARIO: stock de productos por sucursal.
-- ============================================================
INSERT INTO INVENTARIO (stock, stock_minimo, id_producto, id_sucursal) VALUES
(50, 10, 1, 1),
(30, 5, 2, 1),
(100, 20, 3, 1),
(25, 5, 4, 2),
(40, 8, 5, 2),
(15, 3, 6, 3);

-- Verificacion: muestra el inventario cargado
SELECT * FROM INVENTARIO ORDER BY id_inventario ASC;

-- Prueba de Restriccion CHECK (esto DEBE tirar error).
-- Se intenta cargar stock negativo.
INSERT INTO INVENTARIO (stock, stock_minimo, id_producto, id_sucursal) VALUES
(-5, 2, 1, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un id_producto inexistente.
INSERT INTO INVENTARIO (stock, stock_minimo, id_producto, id_sucursal) VALUES
(10, 2, 999, 1);

-- Ejemplo de UPDATE: modificar el stock de un producto
UPDATE INVENTARIO
SET stock = 45
WHERE id_inventario = 1;


-- ============================================================
-- VENTA: ventas realizadas en las sucursales.
-- ============================================================
INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) VALUES
('B', 0.00, 1, 1, 1),
('C', 5.00, 2, 3, 3),
('A', 10.00, 3, 4, 4);

-- Verificacion: muestra las ventas cargadas
SELECT * FROM VENTA ORDER BY id_venta ASC;

-- Prueba de Restriccion CHECK (esto DEBE tirar error).
-- Se utiliza un tipo de factura no permitido.
INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) VALUES
('X', 0.00, 1, 1, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un cliente inexistente.
INSERT INTO VENTA (tipo_factura, descuento, id_sucursal, id_cliente, id_usuario) VALUES
('B', 0.00, 1, 999, 1);

-- Ejemplo de UPDATE: modificar el descuento de una venta
UPDATE VENTA
SET descuento = 8.00
WHERE id_venta = 2;


-- ============================================================
-- DETALLE_VENTA: productos incluidos en cada venta.
-- ============================================================
INSERT INTO DETALLE_VENTA (
    cantidad,
    precio_unitario_catalogo,
    id_producto,
    id_inventario,
    id_venta
) VALUES
(2, 15000.00, 1, 1, 1),
(1, 65000.00, 2, 2, 1),
(5, 3500.00, 3, 3, 2),
(2, 22000.00, 4, 4, 2),
(3, 8500.00, 5, 5, 3);

-- Verificacion: muestra los detalles cargados
SELECT * FROM DETALLE_VENTA ORDER BY id_detalle ASC;

-- Prueba de Restriccion CHECK (esto DEBE tirar error).
-- Se intenta registrar una cantidad igual a cero.
INSERT INTO DETALLE_VENTA (
    cantidad,
    precio_unitario_catalogo,
    id_producto,
    id_inventario,
    id_venta
) VALUES
(0, 15000.00, 1, 1, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un inventario inexistente.
INSERT INTO DETALLE_VENTA (
    cantidad,
    precio_unitario_catalogo,
    id_producto,
    id_inventario,
    id_venta
) VALUES
(1, 15000.00, 1, 999, 1);

-- Ejemplo de UPDATE: modificar la cantidad de un detalle
UPDATE DETALLE_VENTA
SET cantidad = 3
WHERE id_detalle = 1;


-- ============================================================
-- PAGO: pagos asociados a las ventas.
-- ============================================================
INSERT INTO PAGO (monto, id_venta, id_metodo_pago) VALUES
(95000.00, 1, 1),
(38500.00, 2, 2),
(25500.00, 3, 4);

-- Verificacion: muestra los pagos cargados
SELECT * FROM PAGO ORDER BY id_pago ASC;

-- Prueba de Restriccion CHECK (esto DEBE tirar error).
-- Se intenta registrar un pago con monto igual a cero.
INSERT INTO PAGO (monto, id_venta, id_metodo_pago) VALUES
(0.00, 1, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un metodo de pago inexistente.
INSERT INTO PAGO (monto, id_venta, id_metodo_pago) VALUES
(10000.00, 1, 999);

-- Ejemplo de UPDATE: modificar el monto de un pago
UPDATE PAGO
SET monto = 40000.00
WHERE id_pago = 2;
-- ============================================================
-- SUCURSAL_TELEFONO: telefonos de las sucursales.
-- Una sucursal puede tener mas de un telefono.
-- ============================================================
INSERT INTO SUCURSAL_TELEFONO (telefono, id_sucursal) VALUES
('3794123456', 1),
('3794654321', 1),
('3794789012', 2),
('3794890123', 2),
('3794901234', 3),
('3794012345', 3),
('3795123456', 4),
('3795234567', 4),
('3795345678', 5),
('3795456789', 5);

-- Verificacion: muestra los telefonos de sucursales cargados
SELECT * FROM SUCURSAL_TELEFONO ORDER BY id_sucursal ASC, telefono ASC;


-- ============================================================
-- CLIENTE_TELEFONO: telefonos de los clientes.
-- Un cliente puede tener mas de un telefono.
-- ============================================================
INSERT INTO CLIENTE_TELEFONO (telefono, id_cliente) VALUES
('3794111111', 1),
('3794222222', 1),
('3794333333', 2),
('3794444444', 3),
('3794555555', 3),
('3794666666', 4),
('3794777777', 5),
('3794888888', 6),
('3794999999', 7),
('3794000000', 8);

-- Verificacion: muestra los telefonos de clientes cargados
SELECT * FROM CLIENTE_TELEFONO ORDER BY id_cliente ASC, telefono ASC;


-- ============================================================
-- USUARIO_TELEFONO: telefonos de los usuarios del sistema.
-- Un usuario puede tener mas de un telefono.
-- ============================================================
INSERT INTO USUARIO_TELEFONO (telefono, id_usuario) VALUES
('3796111111', 1),
('3796222222', 2),
('3796333333', 3),
('3796444444', 4),
('3796555555', 5),
('3796666666', 6),
('3796777777', 7),
('3796888888', 8),
('3796999999', 9),
('3796000000', 10);

-- Verificacion: muestra los telefonos de usuarios cargados
SELECT * FROM USUARIO_TELEFONO ORDER BY id_usuario ASC, telefono ASC;
