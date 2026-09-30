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

