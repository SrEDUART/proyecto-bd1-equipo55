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
('7791234561016', 'Nivel de burbuja 40 cm','Nivel manual de aluminio de 40 centimetros', 30.00, 1);
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
('7791234561044', 'Codo PVC 90 grados', 'Codo de PVC de 110 mm para desague', 32.00, 6),
('7791234561045', 'Cinta de teflon','Cinta selladora para conexiones roscadas', 45.00, 6),
('7791234561046', 'Valvula de esfera 1/2 pulgada', 'Valvula de esfera para corte de paso de agua', 30.00, 6),

('7791234561047', 'Pala de punta', 'Pala de punta de acero con mango de madera', 35.00, 7),
('7791234561048', 'Tijera de podar','Tijera manual para poda de ramas y plantas', 38.00, 7),
('7791234561049', 'Aspersor de riego', 'Aspersor plastico para riego de jardines', 35.00, 7),
('7791234561050', 'Linterna LED recargable','Linterna LED portatil para actividades al aire libre', 32.00, 7),
('7791234561051', 'Cantimplora 1 litro', 'Cantimplora reutilizable para camping y excursiones', 30.00, 7),

('7791234561052', 'Guantes de seguridad', 'Guantes de proteccion para trabajos generales', 40.00, 8),
('7791234561053', 'Antiparras transparentes', 'Antiparras de proteccion ocular contra particulas',35.00, 8),
('7791234561054', 'Protector auditivo','Protector auditivo tipo copa para ambientes ruidosos',32.00, 8),
('7791234561055', 'Botines de seguridad','Botines de trabajo con puntera de proteccion',30.00, 8),
('7791234561056', 'Chaleco reflectivo','Chaleco de alta visibilidad para trabajos industriales', 35.00, 8);

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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
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
('Obera', '3360', 3), 

('Bella Vista', '3432', 1),
('Curuzu Cuatia', '3460', 1),
('Santo Tome', '3340', 1),
('Paso de los Libres', '3230', 1),
('Esquina', '3196', 1),
('Itati', '3414', 1),
('Empedrado', '3418', 1),
('Santa Lucia', '3440', 1),

('Villa Angela', '3540', 2),
('Charata', '3730', 2),
('General San Martin', '3509', 2),
('Juan Jose Castelli', '3705', 2),
('Quitilipi', '3530', 2), 
('Machagai', '3534', 2),
('Las Breñas', '3722', 2),
('Corzuela', '3718', 2),

('Eldorado', '3380', 3),
('Puerto Iguazu', '3370', 3),
('Apostoles', '3350', 3),
('Leandro N. Alem', '3315', 3),
('Montecarlo', '3384', 3),
('Jardin America', '3328', 3),
('San Vicente', '3364', 3),
('Puerto Rico', '3334', 3),

('San Salvador de Jujuy', '4600', 4),
('Palpala', '4612', 4),
('Perico', '4610', 4),
('Libertador General San Martin', '4512', 4),
('Humahuaca', '4630', 4),
('Tilcara', '4624', 4),
('La Quiaca', '4650', 4),
('El Carmen', '4603', 4),

('Salta Capital', '4400', 5),
('Tartagal', '4560', 5),
('Oran', '4530', 5),
('Metan', '4440', 5),
('Cafayate', '4427', 5),
('Rosario de la Frontera', '4190', 5),
('General Guemes', '4430', 5),
('San Antonio de los Cobres', '4411', 5),

('Parana', '3100', 6),
('Concordia', '3200', 6),
('Gualeguaychu', '2820', 6),
('Concepcion del Uruguay', '3260', 6),
('Villaguay', '3240', 6),
('Colon', '3280', 6),
('Federacion', '3206', 6),
('Victoria', '3153', 6),

('La Plata', '1900', 7),
('Mar del Plata', '7600', 7),
('Bahia Blanca', '8000', 7),
('Tandil', '7000', 7),
('Olavarria', '7400', 7),
('Necochea', '7630', 7),
('Pergamino', '2700', 7),
('Junin', '6000', 7),

('Villa Carlos Paz', '5152', 8),
('Rio Cuarto', '5800', 8),
('Villa Maria', '5900', 8),
('San Francisco', '2400', 8),
('Alta Gracia', '5186', 8),
('Bell Ville', '2550', 8),
('Rio Tercero', '5850', 8),
('Cosquin', '5166', 8),

('Rosario', '2000', 9),
('Santa Fe Capital', '3000', 9),
('Rafaela', '2300', 9),
('Venado Tuerto', '2600', 9),
('Reconquista', '3560', 9),
('Esperanza', '3080', 9),
('Santo Tome', '3016', 9),
('Casilda', '2170', 9),    

('Mendoza Capital', '5500', 10),
('San Rafael', '5600', 10),
('Godoy Cruz', '5501', 10),
('Guaymallen', '5519', 10),
('Malargue', '5613', 10),
('Tunuyan', '5560', 10),
('San Martin', '5570', 10),
('General Alvear', '5620', 10),    

('San Juan Capital', '5400', 11),
('Rawson', '5425', 11),
('Rivadavia', '5400', 11),
('Caucete', '5442', 11),
('Jachal', '5460', 11),
('Pocito', '5427', 11),
('Calingasta', '5403', 11),
('San Jose de Jachal', '5460', 11),    

('San Luis Capital', '5700', 12),
('Villa Mercedes', '5730', 12),
('Merlo', '5881', 12),
('La Punta', '5710', 12),
('Juana Koslay', '5701', 12),
('Justo Daract', '5738', 12),
('Quines', '5711', 12),
('Tilisarao', '5773', 12),    

('La Rioja Capital', '5300', 13),
('Chilecito', '5360', 13),
('Aimogasta', '5310', 13),
('Chamical', '5380', 13),
('Villa Union', '5350', 13),
('Chepes', '5470', 13),
('Villa Castelli', '5355', 13),
('Famatina', '5365', 13),    

('San Fernando del Valle de Catamarca', '4700', 14),
('Andalgala', '4740', 14),
('Belén', '4750', 14),
('Tinogasta', '5340', 14),
('Santa Maria', '4139', 14),
('Recreo', '5260', 14),
('Santa Maria', '4139', 14),
('Belen', '4750', 14),    

('San Miguel de Tucuman', '4000', 15),
('Tafi Viejo', '4103', 15),
('Yerba Buena', '4107', 15),
('Concepcion', '4146', 15),
('Banda del Rio Sali', '4109', 15),
('Monteros', '4142', 15),
('Aguilares', '4152', 15),
('Famailla', '4132', 15),    

('Santiago del Estero Capital', '4200', 16),
('La Banda', '4300', 16),
('Termas de Rio Hondo', '4220', 16),
('Frias', '4230', 16),
('Añatuya', '3760', 16),
('Quimili', '3740', 16),
('Monte Quemado', '3714', 16),
('Fernandez', '4322', 16);    


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



-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- Carga de funcionalidades de prueba (3 por cada perfil existente)
-- El ultimo valor de cada fila es el id_perfil al que corresponde
-- (1=Administrador, 2=Vendedor, 3=Cajero, 4=Encargado de Stock,
-- 5=Gerente de Sucursal, 6=Auditor, 7=Soporte Tecnico, 8=Comprador).
INSERT INTO FUNCIONALIDAD (codigo_funcionalidad, nombre_funcionalidad, descripcion_funcionalidad, id_perfil) VALUES
-- Perfil 1: Administrador
(101, 'Gestionar Usuarios', 'Alta, baja y modificacion de usuarios del sistema', 1),
(109, 'Configurar Parametros', 'Modificar la configuracion general y parametros del sistema', 1),
(110, 'Gestionar Sucursales', 'Alta, baja y modificacion de sucursales en la base de datos', 1),

-- Perfil 2: Vendedor
(102, 'Registrar Venta', 'Emitir un comprobante de venta y cobrar', 2),
(111, 'Consultar Catalogo', 'Buscar productos, precios y disponibilidad en inventario', 2),
(112, 'Registrar Cliente', 'Alta de nuevos clientes durante la atencion en mostrador', 2),

-- Perfil 3: Cajero
(103, 'Arquear Caja', 'Realizar el arqueo de caja al cierre del turno', 3),
(113, 'Anular Comprobante', 'Procesar la anulacion o nota de credito de una venta', 3),
(114, 'Consultar Pagos', 'Verificar estado de transacciones y medios de pago', 3),

-- Perfil 4: Encargado de Stock
(104, 'Ajustar Stock', 'Modificar el stock de un producto por recepcion de mercaderia', 4),
(115, 'Transferir Mercaderia', 'Registrar movimientos de stock entre distintas sucursales', 4),
(116, 'Alertas de Stock Minimo', 'Consultar listado de productos proximos a agotarse', 4),

-- Perfil 5: Gerente de Sucursal
(105, 'Ver Reportes de Sucursal', 'Consultar reportes de ventas y stock de la sucursal', 5),
(117, 'Aprobar Descuentos', 'Autorizar descuentos especiales en ventas de la sucursal', 5),
(118, 'Evaluar Vendedores', 'Consultar metricas y volumen de ventas por empleado', 5),

-- Perfil 6: Auditor
(106, 'Auditar Ventas', 'Revisar en modo lectura las ventas y pagos registrados', 6),
(119, 'Exportar Registro de Auditoria', 'Generar reportes en PDF/Excel de movimientos de sistema', 6),
(120, 'Consultar Historial de Precios', 'Revisar la trazabilidad de modificaciones de precios', 6),

-- Perfil 7: Soporte Tecnico
(107, 'Administrar Perfiles', 'Configurar perfiles y funcionalidades del sistema', 7),
(121, 'Resetear Claves', 'Blanqueo y restablecimiento de contraseñas de usuarios', 7),
(122, 'Ver Logs del Sistema', 'Consultar registro de errores y eventos del servidor', 7),

-- Perfil 8: Comprador
(108, 'Generar Pedido a Proveedor', 'Crear un pedido de reposicion a un proveedor', 8),
(123, 'Gestionar Proveedores', 'Alta y actualizacion de datos de proveedores habituales', 8),
(124, 'Evaluar Costos', 'Comparar presupuestos y listas de precios de proveedores', 8);

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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- DIRECCION: 30 direcciones para usuarios y 300 para clientes.
-- Usuarios: 10 en Corrientes Capital, 10 en Goya y 10 en Mercedes.
-- Clientes: distribuidos entre las 128 localidades cargadas.
-- ============================================================
INSERT INTO DIRECCION (calle, altura, id_localidad) VALUES
-- Usuarios (id_direccion 1 a 30)
('San Martin', 300, 1),
('Belgrano', 457, 1),
('Junin', 614, 1),
('Cordoba', 771, 1),
('Colon', 928, 1),
('9 de Julio', 1085, 1),
('Santa Fe', 1242, 1),
('La Rioja', 1399, 1),
('Mendoza', 1556, 1),
('Salta', 1713, 1),
('Buenos Aires', 1870, 2),
('Lavalle', 2027, 2),
('Rivadavia', 2184, 2),
('Sarmiento', 2341, 2),
('25 de Mayo', 2498, 2),
('Hipolito Yrigoyen', 2655, 2),
('Quintana', 2812, 2),
('Pellegrini', 369, 2),
('Bolivar', 526, 2),
('Moreno', 683, 2),
('Necochea', 840, 3),
('Peru', 997, 3),
('Brasil', 1154, 3),
('Chacabuco', 1311, 3),
('Entre Rios', 1468, 3),
('San Juan', 1625, 3),
('Tucuman', 1782, 3),
('Uruguay', 1939, 3),
('Ayacucho', 2096, 3),
('Catamarca', 2253, 3),

-- Clientes (id_direccion 31 a 330)
('San Martin', 371, 1),
('Belgrano', 544, 2),
('Junin', 717, 3),
('Cordoba', 890, 4),
('Colon', 1063, 5),
('9 de Julio', 1236, 6),
('Santa Fe', 1409, 7),
('La Rioja', 1582, 8),
('Catamarca', 1755, 9),
('Mendoza', 1928, 10),
('Salta', 2101, 11),
('Buenos Aires', 2274, 12),
('Lavalle', 2447, 13),
('Rivadavia', 2620, 14),
('Sarmiento', 2793, 15),
('25 de Mayo', 2966, 16),
('Hipolito Yrigoyen', 3139, 17),
('Quintana', 3312, 18),
('Pellegrini', 3485, 19),
('Bolivar', 3658, 20),
('Moreno', 3831, 21),
('Necochea', 104, 22),
('Peru', 277, 23),
('Brasil', 450, 24),
('Chacabuco', 623, 25),
('Entre Rios', 796, 26),
('San Juan', 969, 27),
('Tucuman', 1142, 28),
('Uruguay', 1315, 29),
('Ayacucho', 1488, 30),
('Independencia', 1661, 31),
('Libertad', 1834, 32),
('Mitre', 2007, 33),
('Alberdi', 2180, 34),
('Alvear', 2353, 35),
('Pueyrredon', 2526, 36),
('Saavedra', 2699, 37),
('Castelli', 2872, 38),
('Velez Sarsfield', 3045, 39),
('Las Heras', 3218, 40),
('Monteagudo', 3391, 41),
('French', 3564, 42),
('Berutti', 3737, 43),
('Ituzaingo', 3910, 44),
('Paraguay', 183, 45),
('Ecuador', 356, 46),
('Chile', 529, 47),
('Mexico', 702, 48),
('Espana', 875, 49),
('Italia', 1048, 50),
('Suipacha', 1221, 51),
('Maipu', 1394, 52),
('Alsina', 1567, 53),
('Dorrego', 1740, 54),
('Brown', 1913, 55),
('Guemes', 2086, 56),
('Balcarce', 2259, 57),
('Almafuerte', 2432, 58),
('Pringles', 2605, 59),
('Laprida', 2778, 60),
('San Martin', 2951, 61),
('Belgrano', 3124, 62),
('Junin', 3297, 63),
('Cordoba', 3470, 64),
('Colon', 3643, 65),
('9 de Julio', 3816, 66),
('Santa Fe', 3989, 67),
('La Rioja', 262, 68),
('Catamarca', 435, 69),
('Mendoza', 608, 70),
('Salta', 781, 71),
('Buenos Aires', 954, 72),
('Lavalle', 1127, 73),
('Rivadavia', 1300, 74),
('Sarmiento', 1473, 75),
('25 de Mayo', 1646, 76),
('Hipolito Yrigoyen', 1819, 77),
('Quintana', 1992, 78),
('Pellegrini', 2165, 79),
('Bolivar', 2338, 80),
('Moreno', 2511, 81),
('Necochea', 2684, 82),
('Peru', 2857, 83),
('Brasil', 3030, 84),
('Chacabuco', 3203, 85),
('Entre Rios', 3376, 86),
('San Juan', 3549, 87),
('Tucuman', 3722, 88),
('Uruguay', 3895, 89),

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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- CLIENTE: carga de 300 clientes de prueba.
-- Cada cliente utiliza una de las direcciones 31 a 330.
-- ============================================================
INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion) VALUES
('Lucas', 'Gomez', 45000001, 'lucas.gomez.001@clientes.test', 31),
('Mateo', 'Aguirre', 45000002, 'mateo.aguirre.002@clientes.test', 32),
('Sofia', 'Silva', 45000003, 'sofia.silva.003@clientes.test', 33),
('Valentina', 'Rodriguez', 45000004, 'valentina.rodriguez.004@clientes.test', 34),
('Martin', 'Maidana', 45000005, 'martin.maidana.005@clientes.test', 35),
('Camila', 'Flores', 45000006, 'camila.flores.006@clientes.test', 36),
('Nicolas', 'Ledesma', 45000007, 'nicolas.ledesma.007@clientes.test', 37),
('Lucia', 'Valdez', 45000008, 'lucia.valdez.008@clientes.test', 38),
('Joaquin', 'Romero', 45000009, 'joaquin.romero.009@clientes.test', 39),
('Martina', 'Medina', 45000010, 'martina.medina.010@clientes.test', 40),
('Tomas', 'Diaz', 45000011, 'tomas.diaz.011@clientes.test', 41),
('Julieta', 'Ojeda', 45000012, 'julieta.ojeda.012@clientes.test', 42),
('Agustin', 'Alvarez', 45000013, 'agustin.alvarez.013@clientes.test', 43),
('Micaela', 'Ibarra', 45000014, 'micaela.ibarra.014@clientes.test', 44),
('Franco', 'Suarez', 45000015, 'franco.suarez.015@clientes.test', 45),
('Carolina', 'Sosa', 45000016, 'carolina.sosa.016@clientes.test', 46),
('Federico', 'Rojas', 45000017, 'federico.rojas.017@clientes.test', 47),
('Florencia', 'Pereira', 45000018, 'florencia.pereira.018@clientes.test', 48),
('Bruno', 'Escobar', 45000019, 'bruno.escobar.019@clientes.test', 49),
('Paula', 'Nunez', 45000020, 'paula.nunez.020@clientes.test', 50),
('Santiago', 'Dominguez', 45000021, 'santiago.dominguez.021@clientes.test', 51),
('Victoria', 'Rivero', 45000022, 'victoria.rivero.022@clientes.test', 52),
('Ignacio', 'Martinez', 45000023, 'ignacio.martinez.023@clientes.test', 53),
('Milagros', 'Torres', 45000024, 'milagros.torres.024@clientes.test', 54),
('Benjamin', 'Ruiz', 45000025, 'benjamin.ruiz.025@clientes.test', 55),
('Agustina', 'Vera', 45000026, 'agustina.vera.026@clientes.test', 56),
('Lautaro', 'Navarro', 45000027, 'lautaro.navarro.027@clientes.test', 57),
('Antonella', 'Ferreyra', 45000028, 'antonella.ferreyra.028@clientes.test', 58),
('Gonzalo', 'Quiroga', 45000029, 'gonzalo.quiroga.029@clientes.test', 59),
('Rocio', 'Benitez', 45000030, 'rocio.benitez.030@clientes.test', 60),
('Facundo', 'Gimenez', 45000031, 'facundo.gimenez.031@clientes.test', 61),
('Candela', 'Caceres', 45000032, 'candela.caceres.032@clientes.test', 62),
('Emiliano', 'Sanchez', 45000033, 'emiliano.sanchez.033@clientes.test', 63),
('Josefina', 'Barrios', 45000034, 'josefina.barrios.034@clientes.test', 64),
('Marcos', 'Cabral', 45000035, 'marcos.cabral.035@clientes.test', 65),
('Belen', 'Paredes', 45000036, 'belen.paredes.036@clientes.test', 66),
('Ramiro', 'Ramirez', 45000037, 'ramiro.ramirez.037@clientes.test', 67),
('Daniela', 'Lopez', 45000038, 'daniela.lopez.038@clientes.test', 68),
('Thiago', 'Mendez', 45000039, 'thiago.mendez.039@clientes.test', 69),
('Malena', 'Garcia', 45000040, 'malena.garcia.040@clientes.test', 70),
('Diego', 'Cardozo', 45000041, 'diego.cardozo.041@clientes.test', 71),
('Carla', 'Villalba', 45000042, 'carla.villalba.042@clientes.test', 72),
('Leandro', 'Molina', 45000043, 'leandro.molina.043@clientes.test', 73),
('Noelia', 'Fernandez', 45000044, 'noelia.fernandez.044@clientes.test', 74),
('Sebastian', 'Acosta', 45000045, 'sebastian.acosta.045@clientes.test', 75),
('Natalia', 'Ortiz', 45000046, 'natalia.ortiz.046@clientes.test', 76),
('Ezequiel', 'Gonzalez', 45000047, 'ezequiel.gonzalez.047@clientes.test', 77),
('Gabriela', 'Godoy', 45000048, 'gabriela.godoy.048@clientes.test', 78),
('Cristian', 'Morales', 45000049, 'cristian.morales.049@clientes.test', 79),
('Marina', 'Leiva', 45000050, 'marina.leiva.050@clientes.test', 80),
('Lucas', 'Gomez', 45000051, 'lucas.gomez.051@clientes.test', 81),
('Mateo', 'Aguirre', 45000052, 'mateo.aguirre.052@clientes.test', 82),
('Sofia', 'Silva', 45000053, 'sofia.silva.053@clientes.test', 83),
('Valentina', 'Rodriguez', 45000054, 'valentina.rodriguez.054@clientes.test', 84),
('Martin', 'Maidana', 45000055, 'martin.maidana.055@clientes.test', 85),
('Camila', 'Flores', 45000056, 'camila.flores.056@clientes.test', 86),
('Nicolas', 'Ledesma', 45000057, 'nicolas.ledesma.057@clientes.test', 87),
('Lucia', 'Valdez', 45000058, 'lucia.valdez.058@clientes.test', 88),
('Joaquin', 'Romero', 45000059, 'joaquin.romero.059@clientes.test', 89),
('Martina', 'Medina', 45000060, 'martina.medina.060@clientes.test', 90),
('Tomas', 'Diaz', 45000061, 'tomas.diaz.061@clientes.test', 91),
('Julieta', 'Ojeda', 45000062, 'julieta.ojeda.062@clientes.test', 92),
('Agustin', 'Alvarez', 45000063, 'agustin.alvarez.063@clientes.test', 93),
('Micaela', 'Ibarra', 45000064, 'micaela.ibarra.064@clientes.test', 94),
('Franco', 'Suarez', 45000065, 'franco.suarez.065@clientes.test', 95),
('Carolina', 'Sosa', 45000066, 'carolina.sosa.066@clientes.test', 96),
('Federico', 'Rojas', 45000067, 'federico.rojas.067@clientes.test', 97),
('Florencia', 'Pereira', 45000068, 'florencia.pereira.068@clientes.test', 98),
('Bruno', 'Escobar', 45000069, 'bruno.escobar.069@clientes.test', 99),
('Paula', 'Nunez', 45000070, 'paula.nunez.070@clientes.test', 100),
('Santiago', 'Dominguez', 45000071, 'santiago.dominguez.071@clientes.test', 101),
('Victoria', 'Rivero', 45000072, 'victoria.rivero.072@clientes.test', 102),
('Ignacio', 'Martinez', 45000073, 'ignacio.martinez.073@clientes.test', 103),
('Milagros', 'Torres', 45000074, 'milagros.torres.074@clientes.test', 104),
('Benjamin', 'Ruiz', 45000075, 'benjamin.ruiz.075@clientes.test', 105),
('Agustina', 'Vera', 45000076, 'agustina.vera.076@clientes.test', 106),
('Lautaro', 'Navarro', 45000077, 'lautaro.navarro.077@clientes.test', 107),
('Antonella', 'Ferreyra', 45000078, 'antonella.ferreyra.078@clientes.test', 108),
('Gonzalo', 'Quiroga', 45000079, 'gonzalo.quiroga.079@clientes.test', 109),
('Rocio', 'Benitez', 45000080, 'rocio.benitez.080@clientes.test', 110),
('Facundo', 'Gimenez', 45000081, 'facundo.gimenez.081@clientes.test', 111),
('Candela', 'Caceres', 45000082, 'candela.caceres.082@clientes.test', 112),
('Emiliano', 'Sanchez', 45000083, 'emiliano.sanchez.083@clientes.test', 113),
('Josefina', 'Barrios', 45000084, 'josefina.barrios.084@clientes.test', 114),
('Marcos', 'Cabral', 45000085, 'marcos.cabral.085@clientes.test', 115),
('Belen', 'Paredes', 45000086, 'belen.paredes.086@clientes.test', 116),
('Ramiro', 'Ramirez', 45000087, 'ramiro.ramirez.087@clientes.test', 117),
('Daniela', 'Lopez', 45000088, 'daniela.lopez.088@clientes.test', 118),
('Thiago', 'Mendez', 45000089, 'thiago.mendez.089@clientes.test', 119),
('Malena', 'Garcia', 45000090, 'malena.garcia.090@clientes.test', 120),
('Diego', 'Cardozo', 45000091, 'diego.cardozo.091@clientes.test', 121),
('Carla', 'Villalba', 45000092, 'carla.villalba.092@clientes.test', 122),
('Leandro', 'Molina', 45000093, 'leandro.molina.093@clientes.test', 123),
('Noelia', 'Fernandez', 45000094, 'noelia.fernandez.094@clientes.test', 124),
('Sebastian', 'Acosta', 45000095, 'sebastian.acosta.095@clientes.test', 125),
('Natalia', 'Ortiz', 45000096, 'natalia.ortiz.096@clientes.test', 126),
('Ezequiel', 'Gonzalez', 45000097, 'ezequiel.gonzalez.097@clientes.test', 127),
('Gabriela', 'Godoy', 45000098, 'gabriela.godoy.098@clientes.test', 128),
('Cristian', 'Morales', 45000099, 'cristian.morales.099@clientes.test', 129),
('Marina', 'Leiva', 45000100, 'marina.leiva.100@clientes.test', 130),
('Lucas', 'Gomez', 45000101, 'lucas.gomez.101@clientes.test', 131),
('Mateo', 'Aguirre', 45000102, 'mateo.aguirre.102@clientes.test', 132),
('Sofia', 'Silva', 45000103, 'sofia.silva.103@clientes.test', 133),
('Valentina', 'Rodriguez', 45000104, 'valentina.rodriguez.104@clientes.test', 134),
('Martin', 'Maidana', 45000105, 'martin.maidana.105@clientes.test', 135),
('Camila', 'Flores', 45000106, 'camila.flores.106@clientes.test', 136),
('Nicolas', 'Ledesma', 45000107, 'nicolas.ledesma.107@clientes.test', 137),
('Lucia', 'Valdez', 45000108, 'lucia.valdez.108@clientes.test', 138),
('Joaquin', 'Romero', 45000109, 'joaquin.romero.109@clientes.test', 139),
('Martina', 'Medina', 45000110, 'martina.medina.110@clientes.test', 140),
('Tomas', 'Diaz', 45000111, 'tomas.diaz.111@clientes.test', 141),
('Julieta', 'Ojeda', 45000112, 'julieta.ojeda.112@clientes.test', 142),
('Agustin', 'Alvarez', 45000113, 'agustin.alvarez.113@clientes.test', 143),
('Micaela', 'Ibarra', 45000114, 'micaela.ibarra.114@clientes.test', 144),
('Franco', 'Suarez', 45000115, 'franco.suarez.115@clientes.test', 145),
('Carolina', 'Sosa', 45000116, 'carolina.sosa.116@clientes.test', 146),
('Federico', 'Rojas', 45000117, 'federico.rojas.117@clientes.test', 147),
('Florencia', 'Pereira', 45000118, 'florencia.pereira.118@clientes.test', 148),
('Bruno', 'Escobar', 45000119, 'bruno.escobar.119@clientes.test', 149),
('Paula', 'Nunez', 45000120, 'paula.nunez.120@clientes.test', 150),
('Santiago', 'Dominguez', 45000121, 'santiago.dominguez.121@clientes.test', 151),
('Victoria', 'Rivero', 45000122, 'victoria.rivero.122@clientes.test', 152),
('Ignacio', 'Martinez', 45000123, 'ignacio.martinez.123@clientes.test', 153),

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

/* -- ============================================================
-- CARGA MASIVA DE CLIENTES con el uso de un While
-- Se agregan 300 clientes distribuidos entre las localidades
-- existentes del sistema.
-- ============================================================

DECLARE @cliente_i INT = 1;
DECLARE @cliente_localidad INT;
DECLARE @cliente_direccion INT;
DECLARE @cliente_nombre VARCHAR(50);
DECLARE @cliente_apellido VARCHAR(50);
DECLARE @cliente_calle VARCHAR(50);

WHILE @cliente_i <= 300
BEGIN

    -- Evita cargar nuevamente el mismo cliente
    -- si el script se ejecuta mas de una vez.
    IF NOT EXISTS (
        SELECT 1
        FROM CLIENTE
        WHERE dni = 45000000 + @cliente_i
    )
    BEGIN

     -- Selecciona una localidad existente al azar.
    -- De esta forma los clientes pueden pertenecer a distintas
    -- localidades y provincias cargadas en el sistema.
    SELECT TOP 1
        @cliente_localidad = id_localidad
    FROM LOCALIDAD
    ORDER BY NEWID();

        -- Selecciona nombres de una lista.
        SET @cliente_nombre = CHOOSE(
            ((@cliente_i - 1) % 40) + 1,
            'Lucas', 'Mateo', 'Sofia', 'Valentina', 'Martin',
            'Camila', 'Nicolas', 'Lucia', 'Joaquin', 'Martina',
            'Tomas', 'Julieta', 'Agustin', 'Micaela', 'Franco',
            'Carolina', 'Federico', 'Florencia', 'Bruno', 'Paula',
            'Santiago', 'Victoria', 'Ignacio', 'Milagros', 'Benjamin',
            'Agustina', 'Lautaro', 'Antonella', 'Gonzalo', 'Rocio',
            'Facundo', 'Candela', 'Emiliano', 'Josefina', 'Marcos',
            'Belen', 'Ramiro', 'Daniela', 'Thiago', 'Malena'
        );

        -- Selecciona apellidos de una lista.
       SET @cliente_apellido = CHOOSE(
            ((@cliente_i - 1) % 40) + 1,
            'Gomez', 'Fernandez', 'Ramirez', 'Benitez', 'Martinez',
            'Sosa', 'Romero', 'Aguirre', 'Acosta', 'Lopez',
            'Gimenez', 'Torres', 'Rojas', 'Medina', 'Silva',
            'Ortiz', 'Mendez', 'Caceres', 'Ruiz', 'Pereira',
            'Diaz', 'Rodriguez', 'Gonzalez', 'Garcia', 'Sanchez',
            'Vera', 'Escobar', 'Ojeda', 'Maidana', 'Godoy',
            'Cardozo', 'Barrios', 'Navarro', 'Nunez', 'Alvarez',
            'Flores', 'Morales', 'Villalba', 'Cabral', 'Ferreyra'
        );

        -- Selecciona una calle.
        SET @cliente_calle = CHOOSE(
            ((@cliente_i - 1) % 30) + 1,
            'San Martin', 'Belgrano', 'Junin', 'Cordoba', 'Colon',
            '9 de Julio', 'Santa Fe', 'La Rioja', 'Catamarca', 'Mendoza',
            'Salta', 'Buenos Aires', 'Lavalle', 'Rivadavia', 'Sarmiento',
            '25 de Mayo', 'Hipolito Yrigoyen', 'Quintana', 'Pellegrini', 'Bolivar',
            'Moreno', 'Necochea', 'Peru', 'Brasil', 'Chacabuco',
            'Entre Rios', 'San Juan', 'Tucuman', 'Uruguay', 'Ayacucho'
        );

        -- Primero se crea la direccion del cliente.
        INSERT INTO DIRECCION (
            calle,
            altura,
            id_localidad
        )
        VALUES (
            @cliente_calle,
            100 + ((@cliente_i * 37) % 3900),
            @cliente_localidad
        );

        -- Guarda el id de la direccion que se acaba de crear.
        SET @cliente_direccion = SCOPE_IDENTITY();

        -- Ahora se crea el cliente usando esa direccion.
        INSERT INTO CLIENTE (
            nombre,
            apellido,
            dni,
            correo,
            id_direccion
        )
        VALUES (
            @cliente_nombre,
            @cliente_apellido,
            45000000 + @cliente_i,

            LOWER(
                CONCAT(
                    @cliente_nombre,
                    '.',
                    @cliente_apellido,
                    '.',
                    RIGHT(
                        '0000' + CAST(@cliente_i AS VARCHAR(4)),
                        4
                    ),
                    '@clientes.test'
                )
            ),

            @cliente_direccion
        );

    END;

    SET @cliente_i = @cliente_i + 1;

END;


-- Verificacion
SELECT COUNT(*) AS cantidad_clientes
FROM CLIENTE;
 Fin de la carga con While*/

-- ========================================================================================================================================================
-- ========================================================================================================================================================
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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- USUARIO: 30 usuarios, 10 por sucursal.
-- Distribucion por sucursal:
-- 1 Administrador, 3 Vendedores, 1 Cajero,
-- 1 Encargado de Stock, 1 Gerente, 1 Auditor,
-- 1 Soporte Tecnico y 1 Comprador.
--
-- Direcciones:
-- usuarios 1-10  -> id_direccion 1-10  (Corrientes Capital)
-- usuarios 11-20 -> id_direccion 11-20 (Goya)
-- usuarios 21-30 -> id_direccion 21-30 (Mercedes)
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
('Juan', 'Perez', 32013791, 'jperez11', 'hash_usuario_01', 'juan.perez.s1@ferreteria.test', '1985-01-15', 1, 1, 1),
('Maria', 'Lopez', 32027582, 'mlopez12', 'hash_usuario_02', 'maria.lopez.s1@ferreteria.test', '1985-07-31', 2, 2, 1),
('Pedro', 'Acosta', 32041373, 'pacosta13', 'hash_usuario_03', 'pedro.acosta.s1@ferreteria.test', '1986-02-13', 3, 2, 1),
('Ana', 'Gimenez', 32055164, 'agimenez14', 'hash_usuario_04', 'ana.gimenez.s1@ferreteria.test', '1986-08-29', 4, 2, 1),
('Diego', 'Fernandez', 32068955, 'dfernandez15', 'hash_usuario_05', 'diego.fernandez.s1@ferreteria.test', '1987-03-14', 5, 3, 1),
('Lucia', 'Gomez', 32082746, 'lgomez16', 'hash_usuario_06', 'lucia.gomez.s1@ferreteria.test', '1987-09-27', 6, 4, 1),
('Matias', 'Sosa', 32096537, 'msosa17', 'hash_usuario_07', 'matias.sosa.s1@ferreteria.test', '1988-04-11', 7, 5, 1),
('Florencia', 'Ramirez', 32110328, 'framirez18', 'hash_usuario_08', 'florencia.ramirez.s1@ferreteria.test', '1988-10-25', 8, 6, 1),
('Federico', 'Benitez', 32124119, 'fbenitez19', 'hash_usuario_09', 'federico.benitez.s1@ferreteria.test', '1989-05-10', 9, 7, 1),
('Julieta', 'Romero', 32137910, 'jromero110', 'hash_usuario_10', 'julieta.romero.s1@ferreteria.test', '1989-11-23', 10, 8, 1),
('Marcos', 'Aguirre', 32151701, 'maguirre21', 'hash_usuario_11', 'marcos.aguirre.s2@ferreteria.test', '1990-06-08', 11, 1, 2),
('Victoria', 'Medina', 32165492, 'vmedina22', 'hash_usuario_12', 'victoria.medina.s2@ferreteria.test', '1990-12-22', 12, 2, 2),
('Ignacio', 'Torres', 32179283, 'itorres23', 'hash_usuario_13', 'ignacio.torres.s2@ferreteria.test', '1991-07-07', 13, 2, 2),
('Carla', 'Silva', 32193074, 'csilva24', 'hash_usuario_14', 'carla.silva.s2@ferreteria.test', '1992-01-20', 14, 2, 2),
('Santiago', 'Rojas', 32206865, 'srojas25', 'hash_usuario_15', 'santiago.rojas.s2@ferreteria.test', '1992-08-04', 15, 3, 2),
('Natalia', 'Mendez', 32220656, 'nmendez26', 'hash_usuario_16', 'natalia.mendez.s2@ferreteria.test', '1993-02-17', 16, 4, 2),
('Ezequiel', 'Caceres', 32234447, 'ecaceres27', 'hash_usuario_17', 'ezequiel.caceres.s2@ferreteria.test', '1993-09-02', 17, 5, 2),
('Gabriela', 'Ruiz', 32248238, 'gruiz28', 'hash_usuario_18', 'gabriela.ruiz.s2@ferreteria.test', '1994-03-18', 18, 6, 2),
('Cristian', 'Pereira', 32262029, 'cpereira29', 'hash_usuario_19', 'cristian.pereira.s2@ferreteria.test', '1994-10-01', 19, 7, 2),
('Marina', 'Diaz', 32275820, 'mdiaz210', 'hash_usuario_20', 'marina.diaz.s2@ferreteria.test', '1995-04-16', 20, 8, 2),
('Leandro', 'Rodriguez', 32289611, 'lrodriguez31', 'hash_usuario_21', 'leandro.rodriguez.s3@ferreteria.test', '1995-10-30', 21, 1, 3),
('Noelia', 'Gonzalez', 32303402, 'ngonzalez32', 'hash_usuario_22', 'noelia.gonzalez.s3@ferreteria.test', '1996-05-14', 22, 2, 3),
('Sebastian', 'Garcia', 32317193, 'sgarcia33', 'hash_usuario_23', 'sebastian.garcia.s3@ferreteria.test', '1996-11-27', 23, 2, 3),
('Paula', 'Sanchez', 32330984, 'psanchez34', 'hash_usuario_24', 'paula.sanchez.s3@ferreteria.test', '1997-06-12', 24, 2, 3),
('Bruno', 'Vera', 32344775, 'bvera35', 'hash_usuario_25', 'bruno.vera.s3@ferreteria.test', '1997-12-26', 25, 3, 3),
('Candela', 'Escobar', 32358566, 'cescobar36', 'hash_usuario_26', 'candela.escobar.s3@ferreteria.test', '1998-07-11', 26, 4, 3),
('Emiliano', 'Ojeda', 32372357, 'eojeda37', 'hash_usuario_27', 'emiliano.ojeda.s3@ferreteria.test', '1999-01-24', 27, 5, 3),
('Josefina', 'Maidana', 32386148, 'jmaidana38', 'hash_usuario_28', 'josefina.maidana.s3@ferreteria.test', '1999-08-09', 28, 6, 3),
('Ramiro', 'Godoy', 32399939, 'rgodoy39', 'hash_usuario_29', 'ramiro.godoy.s3@ferreteria.test', '2000-02-22', 29, 7, 3),
('Daniela', 'Cardozo', 32413730, 'dcardozo310', 'hash_usuario_30', 'daniela.cardozo.s3@ferreteria.test', '2000-09-06', 30, 8, 3);

-- Verificacion: 10 usuarios por sucursal
SELECT id_sucursal, COUNT(*) AS cantidad_usuarios
FROM USUARIO
GROUP BY id_sucursal
ORDER BY id_sucursal;

-- Verificacion: distribucion de perfiles por sucursal
SELECT id_sucursal, id_perfil, COUNT(*) AS cantidad
FROM USUARIO
GROUP BY id_sucursal, id_perfil
ORDER BY id_sucursal, id_perfil;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error).
-- Se repite a proposito el nombre_usuario jperez11.
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
('Usuario', 'Duplicado', 41234567, 'jperez11', 'hash_prueba',
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

-- Ejemplo de UPDATE: modificar el correo de un usuario
UPDATE USUARIO
SET correo = 'maria.lopez.actualizado@ferreteria.test'
WHERE id_usuario = 2;



-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- INVENTARIO: stock de productos por sucursal.
-- ============================================================
INSERT INTO INVENTARIO (stock, stock_minimo, id_producto, id_sucursal) VALUES
-- SUCURSAL 1 
(50, 10, 1, 1), (30, 5, 2, 1), (100, 20, 3, 1), (25, 5, 4, 1),
(40, 8, 5, 1), (15, 3, 6, 1), (20, 5, 7, 1), (12, 4, 8, 1),
(45, 10, 9, 1), (35, 10, 10, 1), (18, 5, 11, 1), (22, 5, 12, 1),
(10, 3, 13, 1), (8, 2, 14, 1), (60, 15, 15, 1), (14, 4, 16, 1),
(3, 5, 17, 1), 
(0, 5, 18, 1), 
(25, 5, 19, 1), (12, 3, 20, 1), (30, 8, 21, 1), (10, 2, 22, 1),
(6, 2, 23, 1), (4, 2, 24, 1), (8, 3, 25, 1), (5, 2, 26, 1),
(120, 25, 27, 1), (80, 20, 28, 1), (150, 30, 29, 1), (90, 20, 30, 1),
(45, 10, 31, 1), (18, 5, 32, 1), (22, 5, 33, 1), (30, 8, 34, 1),
(25, 5, 35, 1), (40, 10, 36, 1), (75, 15, 37, 1), (50, 10, 38, 1),
(60, 10, 39, 1), (30, 5, 40, 1), (100, 20, 41, 1), (12, 3, 42, 1),
(35, 8, 43, 1), (40, 10, 44, 1), (80, 15, 45, 1), (15, 4, 46, 1),
(10, 3, 47, 1), (15, 4, 48, 1), (20, 5, 49, 1), (8, 2, 50, 1),
(14, 3, 51, 1), (40, 10, 52, 1), (30, 8, 53, 1), (25, 5, 54, 1),
(10, 3, 55, 1), (18, 4, 56, 1),

-- SUCURSAL 2 
(20, 5, 1, 2), (15, 3, 2, 2), (60, 15, 3, 2), (10, 3, 4, 2),
(20, 5, 5, 2), (8, 2, 6, 2), (2, 5, 7, 2),   
(0, 4, 8, 2),  
(25, 5, 9, 2), (20, 5, 10, 2), (10, 3, 11, 2), (12, 3, 12, 2),
(5, 2, 13, 2), (4, 2, 14, 2), (30, 10, 15, 2), (8, 2, 16, 2),
(15, 5, 17, 2), (10, 3, 18, 2), (12, 3, 19, 2), (6, 2, 20, 2),
(15, 5, 21, 2), (5, 2, 22, 2), (3, 2, 23, 2), (2, 2, 24, 2),
(70, 15, 27, 2), (40, 10, 28, 2), (90, 20, 29, 2), (50, 10, 30, 2),
(40, 10, 37, 2), (30, 8, 38, 2), (35, 8, 39, 2), (50, 10, 41, 2),
(20, 5, 52, 2), (15, 4, 53, 2), (12, 3, 54, 2), (8, 2, 55, 2),

-- SUCURSAL 3 
(15, 5, 1, 3), (10, 3, 2, 3), (40, 10, 3, 3), (12, 3, 4, 3),
(18, 5, 5, 3), (10, 3, 6, 3), (15, 4, 7, 3), (5, 2, 8, 3),
(18, 5, 9, 3), (15, 5, 10, 3), (8, 2, 11, 3), (10, 3, 12, 3),
(40, 10, 15, 3), (1, 5, 17, 3), 
(50, 10, 27, 3), (30, 8, 28, 3), (60, 15, 29, 3), (35, 8, 30, 3),
(30, 8, 37, 3), (20, 5, 38, 3), (25, 5, 39, 3), (40, 10, 41, 3),
(15, 4, 52, 3), (10, 3, 53, 3), (10, 3, 54, 3), (6, 2, 55, 3);

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



-- ========================================================================================================================================================
-- ========================================================================================================================================================
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



-- ========================================================================================================================================================
-- ========================================================================================================================================================
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



-- ========================================================================================================================================================
-- ========================================================================================================================================================
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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
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


-- ========================================================================================================================================================
-- ========================================================================================================================================================
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
