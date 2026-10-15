-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PROVINCIA: listado de provincias usadas para las direcciones
-- del sistema (clientes, usuarios, sucursales).
-- ============================================================
INSERT INTO PROVINCIA (nombre_provincia) VALUES
('Corrientes'), ('Chaco'), ('Misiones'), ('Jujuy'), ('Salta'),
('Entre Rios'), ('Buenos Aires'), ('Cordoba'),('Santa Fe'),
('Mendoza'),('San Juan'),('San Luis'),('La Rioja'),('Catamarca'),
('Tucuman'),('Santiago del Estero');

-- Verificacion: muestra las provincias cargadas
SELECT * FROM PROVINCIA ORDER BY id_provincia ASC;


-- ========================================================================================================================================================
-- ========================================================================================================================================================
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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
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



-- ========================================================================================================================================================
-- ========================================================================================================================================================
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
('7791234561008', 'Casco de seguridad', 'Casco de seguridad clase B con ajuste tipo cricket', 40.00, 8),
('7791234561009', 'Destornillador Phillips','Destornillador Phillips con mango antideslizante de 6 pulgadas', 25.00, 1),
('7791234561010', 'Destornillador plano','Destornillador plano con mango aislante de 6 pulgadas', 25.00, 1),
('7791234561011', 'Pinza universal 8 pulgadas','Pinza universal de acero con mangos antideslizantes', 30.00, 1),
('7791234561012', 'Alicate de corte','Alicate de corte diagonal para cables y alambres', 28.00, 1),
('7791234561013', 'Llave inglesa 10 pulgadas','Llave ajustable de acero para tuercas y tornillos', 35.00, 1),
('7791234561014', 'Serrucho manual','Serrucho de mano con hoja de acero para cortar madera', 32.00, 1),
('7791234561015', 'Cinta metrica 5 metros','Cinta metrica retráctil de 5 metros con traba', 30.00, 1),
('7791234561016', 'Nivel de burbuja 40 cm','Nivel manual de aluminio de 40 centimetros', 30.00, 1),
('7791234561017', 'Maza de 1 kg','Maza con cabeza de acero y mango reforzado',35.00, 1),
('7791234561018', 'Llave combinada 13 mm', 'Llave de acero con boca fija y estrella de 13 mm', 30.00, 1),
('7791234561019', 'Arco de sierra manual', 'Arco de sierra para cortes manuales en metal',32.00, 1),
('7791234561020', 'Formon para madera', 'Formon de acero para trabajos de carpinteria', 38.00, 1),
('7791234561021', 'Juego de llaves Allen','Juego de llaves Allen de distintas medidas', 35.00, 1),
    
('7791234561022', 'Taladro percutor 650W', 'Taladro electrico con funcion de percusion', 28.00, 2),
('7791234561023', 'Lijadora orbital 240W','Lijadora orbital electrica para superficies de madera', 30.00, 2),
('7791234561024', 'Sierra circular 1400W', 'Sierra circular electrica para cortes de madera', 27.00, 2),
('7791234561025', 'Atornillador electrico','Atornillador electrico para trabajos de montaje', 32.00, 2),
('7791234561026', 'Rotomartillo 800W','Rotomartillo electrico para perforacion en mamposteria', 29.00, 2),

('7791234561027', 'Tornillo para madera x100','Caja de 100 tornillos para fijacion en madera', 45.00, 3),
('7791234561028', 'Tuerca hexagonal M8 x50','Bolsa de 50 tuercas hexagonales metricas M8', 40.00, 3),
('7791234561029', 'Arandela plana M8 x100','Bolsa de 100 arandelas planas de acero M8', 38.00, 3),
('7791234561030', 'Tarugo nylon 8 mm x50', 'Bolsa de 50 tarugos de nylon de 8 mm', 45.00, 3),
('7791234561031', 'Bulon hexagonal M10 x20','Caja de 20 bulones hexagonales metricos M10', 40.00, 3),

('7791234561032', 'Pintura latex exterior 4L','Pintura latex blanca para paredes exteriores', 35.00, 4),
('7791234561033', 'Esmalte sintetico 1L','Esmalte sintetico para superficies de metal y madera', 32.00, 4),
('7791234561034', 'Rodillo para pintar 22 cm','Rodillo para aplicacion de pintura en paredes', 40.00, 4),
('7791234561035', 'Pincel chato 2 pulgadas','Pincel chato de cerdas sinteticas para pintura',38.00, 4),
('7791234561036', 'Aguarras 1L', 'Solvente para dilucion de pinturas sinteticas', 30.00, 4),

('7791234561037', 'Cable unipolar 2.5 mm','Rollo de cable unipolar de 2.5 mm cuadrados', 30.00, 5),
('7791234561038', 'Tomacorriente doble','Tomacorriente doble para instalacion electrica', 35.00, 5),
('7791234561039', 'Interruptor de luz','Interruptor simple para encendido de iluminacion',35.00, 5),
('7791234561040', 'Portalámparas E27','Portalamparas con rosca E27 para iluminacion', 32.00, 5),
('7791234561041', 'Cinta aisladora 20 m', 'Cinta aisladora para trabajos electricos', 40.00, 5),

('7791234561042', 'Canilla de cocina', 'Canilla monocomando para instalacion de cocina',30.00, 6),
('7791234561043', 'Flexible para agua 40 cm', 'Flexible de conexion para instalaciones de agua', 35.00, 6),
