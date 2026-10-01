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
