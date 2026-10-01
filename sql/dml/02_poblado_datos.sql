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
