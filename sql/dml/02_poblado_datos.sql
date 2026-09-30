INSERT INTO PROVINCIA (nombre_provincia) VALUES 
('Corrientes'), ('Chaco'), ('Misiones'), ('Jujuy'), ('Salta'), ('Entre Rios'), ('Buenos Aires'), ('Cordoba');

SELECT * FROM PROVINCIA ORDER BY id_provincia ASC;



INSERT INTO PERFIL (nombre_perfil, descripcion_perfil) VALUES 
('Administrador', 'Acceso total al sistema'), ('Vendedor', 'Atención al cliente y emisión de comprobantes de venta'),
('Cajero', 'Cobro de ventas y arqueo de caja diario'),
('Encargado de Stock', 'Gestión de inventario y recepción de mercadería'),
('Gerente de Sucursal', 'Supervisión de operaciones y reportes locales'),
('Auditor', 'Solo lectura para revisión de ventas y contabilidad'),
('Soporte Técnico', 'Mantenimiento de usuarios y funciones del sistema'), 
('Comprador', 'Gestión de pedidos a proveedores y reposición');

SELECT * FROM PERFIL ORDER BY id_perfil ASC;



INSERT INTO CATEGORIA (nombre_cat, descripcion_cat) VALUES 
('Herramientas', 'Herramientas de mano'),
('Herramientas Eléctricas', 'Taladros, amoladoras, sierras y lijadoras'),
('Bulonería y Fijaciones', 'Tornillos, tuercas, arandelas y tarugos'),
('Pinturería', 'Pinturas, pinceles, rodillos y solventes'),
('Electricidad', 'Cables, llaves térmicas, tomacorrientes e iluminación'),
('Plomería y Agua', 'Caños, conexiones, grifería y selladores'),
('Jardinería y Camping', 'Mangueras, bordadoras, palas y accesorios'),
('Seguridad Industrial', 'Cascos, guantes, antiparras y calzado de protección');

SELECT * FROM CATEGORIA ORDER BY id_categoria ASC;



INSERT INTO METODO_PAGO (nombre, descripcion) VALUES 
('Efectivo', 'Pago contado en caja'),
('Tarjeta de Débito', 'Cobro electrónico mediante posnet en un solo pago'),
('Tarjeta de Crédito', 'Cobro electrónico con posibilidad de cuotas'),
('Transferencia Bancaria', 'Acreditación directa a la cuenta de la empresa'),
('Mercado Pago QR', 'Escaneo de código QR desde billetera virtual'),
('Cuenta Corriente', 'Crédito otorgado a clientes habituales a pagar en fecha'),
('Cheque', 'Pago diferido mediante documento bancario');

SELECT * FROM METODO_PAGO ORDER BY id_metodo_pago ASC;
