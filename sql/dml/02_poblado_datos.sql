
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
INSERT INTO PRODUCTO (codigo_barra, nombre_producto, descripcion, precio_costo, porcentaje_ganancia, id_categoria) VALUES
('7791234561001', 'Martillo carpintero', 'Martillo de carpintero, mango de madera, cabeza de acero de 300g', 10714.29, 40.00, 1),
('7791234561002', 'Amoladora angular 4-1/2', 'Amoladora angular de 750W con disco de corte incluido', 50000.00, 30.00, 2),
('7791234561003', 'Tornillo autoperforante x100', 'Caja de 100 tornillos autoperforantes punta mecha', 2333.33, 50.00, 3),
('7791234561004', 'Pintura latex interior 4L', 'Pintura latex blanco mate para interiores, balde de 4 litros', 16296.30, 35.00, 4),
('7791234561005', 'Llave termica 16A', 'Llave termica monofasica curva C de 16 amperes', 6439.39, 32.00, 5),
('7791234561006', 'Cano PVC 110mm x 3m', 'Cano de PVC de 110mm de diametro para desague cloacal', 9500.00, 26.00, 6),
('7791234561007', 'Manguera de riego 15m', 'Manguera reforzada de 15 metros con conectores', 12000.00, 30.00, 7),
('7791234561008', 'Casco de seguridad', 'Casco de seguridad clase B con ajuste tipo cricket', 8500.00, 40.00, 8),
('7791234561009', 'Destornillador Phillips','Destornillador Phillips con mango antideslizante de 6 pulgadas', 6500.00, 25.00, 1),
('7791234561010', 'Destornillador plano','Destornillador plano con mango aislante de 6 pulgadas', 6200.00, 25.00, 1),
('7791234561011', 'Pinza universal 8 pulgadas','Pinza universal de acero con mangos antideslizantes', 9500.00, 30.00, 1),
('7791234561012', 'Alicate de corte','Alicate de corte diagonal para cables y alambres', 7800.00, 28.00, 1),
('7791234561013', 'Llave inglesa 10 pulgadas','Llave ajustable de acero para tuercas y tornillos', 10500.00, 35.00, 1),
('7791234561014', 'Serrucho manual','Serrucho de mano con hoja de acero para cortar madera', 9000.00, 32.00, 1),
('7791234561015', 'Cinta metrica 5 metros','Cinta metrica retráctil de 5 metros con traba', 4800.00, 30.00, 1),
('7791234561016', 'Nivel de burbuja 40 cm','Nivel manual de aluminio de 40 centimetros', 7600.00, 30.00, 1),
('7791234561017', 'Maza de 1 kg','Maza con cabeza de acero y mango reforzado',12500.00, 35.00, 1),
('7791234561018', 'Llave combinada 13 mm', 'Llave de acero con boca fija y estrella de 13 mm', 5400.00, 30.00, 1),
('7791234561019', 'Arco de sierra manual', 'Arco de sierra para cortes manuales en metal',8200.00, 32.00, 1),
('7791234561020', 'Formon para madera', 'Formon de acero para trabajos de carpinteria', 6800.00, 38.00, 1),
('7791234561021', 'Juego de llaves Allen','Juego de llaves Allen de distintas medidas', 7200.00, 35.00, 1),
    
('7791234561022', 'Taladro percutor 650W', 'Taladro electrico con funcion de percusion', 42000.00, 28.00, 2),
('7791234561023', 'Lijadora orbital 240W','Lijadora orbital electrica para superficies de madera', 38000.00, 30.00, 2),
('7791234561024', 'Sierra circular 1400W', 'Sierra circular electrica para cortes de madera', 75000.00, 27.00, 2),
('7791234561025', 'Atornillador electrico','Atornillador electrico para trabajos de montaje', 32000.00, 32.00, 2),
('7791234561026', 'Rotomartillo 800W','Rotomartillo electrico para perforacion en mamposteria', 68000.00, 29.00, 2),

('7791234561027', 'Tornillo para madera x100','Caja de 100 tornillos para fijacion en madera', 3200.00, 45.00, 3),
('7791234561028', 'Tuerca hexagonal M8 x50','Bolsa de 50 tuercas hexagonales metricas M8', 2800.00, 40.00, 3),
('7791234561029', 'Arandela plana M8 x100','Bolsa de 100 arandelas planas de acero M8', 2200.00, 38.00, 3),
('7791234561030', 'Tarugo nylon 8 mm x50', 'Bolsa de 50 tarugos de nylon de 8 mm', 2600.00, 45.00, 3),
('7791234561031', 'Bulon hexagonal M10 x20','Caja de 20 bulones hexagonales metricos M10', 4200.00, 40.00, 3),

('7791234561032', 'Pintura latex exterior 4L','Pintura latex blanca para paredes exteriores', 18000.00, 35.00, 4),
('7791234561033', 'Esmalte sintetico 1L','Esmalte sintetico para superficies de metal y madera', 12500.00, 32.00, 4),
('7791234561034', 'Rodillo para pintar 22 cm','Rodillo para aplicacion de pintura en paredes', 5200.00, 40.00, 4),
('7791234561035', 'Pincel chato 2 pulgadas','Pincel chato de cerdas sinteticas para pintura',2800.00, 38.00, 4),
('7791234561036', 'Aguarras 1L', 'Solvente para dilucion de pinturas sinteticas', 4500.00, 30.00, 4),

('7791234561037', 'Cable unipolar 2.5 mm','Rollo de cable unipolar de 2.5 mm cuadrados', 18500.00, 30.00, 5),
('7791234561038', 'Tomacorriente doble','Tomacorriente doble para instalacion electrica', 4200.00, 35.00, 5),
('7791234561039', 'Interruptor de luz','Interruptor simple para encendido de iluminacion',3500.00, 35.00, 5),
('7791234561040', 'Portalámparas E27','Portalamparas con rosca E27 para iluminacion', 2600.00, 32.00, 5),
('7791234561041', 'Cinta aisladora 20 m', 'Cinta aisladora para trabajos electricos', 1800.00, 40.00, 5),

('7791234561042', 'Canilla de cocina', 'Canilla monocomando para instalacion de cocina',22000.00, 30.00, 6),
('7791234561043', 'Flexible para agua 40 cm', 'Flexible de conexion para instalaciones de agua', 4800.00, 35.00, 6),
('7791234561044', 'Codo PVC 90 grados', 'Codo de PVC de 110 mm para desague', 5200.00, 32.00, 6),
('7791234561045', 'Cinta de teflon','Cinta selladora para conexiones roscadas', 1500.00, 45.00, 6),
('7791234561046', 'Valvula de esfera 1/2 pulgada', 'Valvula de esfera para corte de paso de agua', 7500.00, 30.00, 6),

('7791234561047', 'Pala de punta', 'Pala de punta de acero con mango de madera', 14500.00, 35.00, 7),
('7791234561048', 'Tijera de podar','Tijera manual para poda de ramas y plantas', 8800.00, 38.00, 7),
('7791234561049', 'Aspersor de riego', 'Aspersor plastico para riego de jardines', 6200.00, 35.00, 7),
('7791234561050', 'Linterna LED recargable','Linterna LED portatil para actividades al aire libre', 13500.00, 32.00, 7),
('7791234561051', 'Cantimplora 1 litro', 'Cantimplora reutilizable para camping y excursiones', 5200.00, 30.00, 7),

('7791234561052', 'Guantes de seguridad', 'Guantes de proteccion para trabajos generales', 4800.00, 40.00, 8),
('7791234561053', 'Antiparras transparentes', 'Antiparras de proteccion ocular contra particulas',3900.00, 35.00, 8),
('7791234561054', 'Protector auditivo','Protector auditivo tipo copa para ambientes ruidosos',11500.00, 32.00, 8),
('7791234561055', 'Botines de seguridad','Botines de trabajo con puntera de proteccion',28000.00, 30.00, 8),
('7791234561056', 'Chaleco reflectivo','Chaleco de alta visibilidad para trabajos industriales', 4200.00, 35.00, 8);

-- Verificacion: muestra todo lo que quedo cargado en la tabla
SELECT * FROM PRODUCTO ORDER BY id_producto ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error al ejecutar).
-- Se repite a proposito el codigo_barra del primer producto para
-- demostrar que la restriccion UNIQUE de esa columna funciona.
INSERT INTO PRODUCTO (codigo_barra, nombre_producto, descripcion, precio_costo, porcentaje_ganancia, id_categoria) VALUES
('7791234561001', 'Martillo duplicado', 'Prueba de codigo de barra repetido', 10000.00, 40.00, 1);

-- Prueba de Restriccion CHECK (esto tambien DEBE tirar error).
-- Se carga un porcentaje_ganancia negativo a proposito para
-- demostrar que la restriccion CHECK (porcentaje_ganancia >= 0) funciona.
INSERT INTO PRODUCTO (codigo_barra, nombre_producto, descripcion, precio_costo, porcentaje_ganancia, id_categoria) VALUES
('7791234561099', 'Producto con margen invalido', 'Prueba de CHECK porcentaje_ganancia', 1000.00, -10.00, 1);

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
INSERT INTO FUNCIONALIDAD (codigo_funcionalidad, nombre_funcionalidad, descripcion_funcionalidad) VALUES
-- Perfil 1: Administrador
(101, 'Gestionar Usuarios', 'Alta, baja y modificacion de usuarios del sistema'),
(109, 'Configurar Parametros', 'Modificar la configuracion general y parametros del sistema'),
(110, 'Gestionar Sucursales', 'Alta, baja y modificacion de sucursales en la base de datos'),

-- Perfil 2: Vendedor
(102, 'Registrar Venta', 'Emitir un comprobante de venta y cobrar'),
(111, 'Consultar Catalogo', 'Buscar productos, precios y disponibilidad en inventario'),
(112, 'Registrar Cliente', 'Alta de nuevos clientes durante la atencion en mostrador'),

-- Perfil 3: Cajero
(103, 'Arquear Caja', 'Realizar el arqueo de caja al cierre del turno'),
(113, 'Anular Comprobante', 'Procesar la anulacion o nota de credito de una venta'),
(114, 'Consultar Pagos', 'Verificar estado de transacciones y medios de pago'),

-- Perfil 4: Encargado de Stock
(104, 'Ajustar Stock', 'Modificar el stock de un producto por recepcion de mercaderia'),
(115, 'Transferir Mercaderia', 'Registrar movimientos de stock entre distintas sucursales'),
(116, 'Alertas de Stock Minimo', 'Consultar listado de productos proximos a agotarse'),

-- Perfil 5: Gerente de Sucursal
(105, 'Ver Reportes de Sucursal', 'Consultar reportes de ventas y stock de la sucursal'),
(117, 'Aprobar Descuentos', 'Autorizar descuentos especiales en ventas de la sucursal'),
(118, 'Evaluar Vendedores', 'Consultar metricas y volumen de ventas por empleado'),

-- Perfil 6: Auditor
(106, 'Auditar Ventas', 'Revisar en modo lectura las ventas y pagos registrados'),
(119, 'Exportar Registro de Auditoria', 'Generar reportes en PDF/Excel de movimientos de sistema'),
(120, 'Consultar Historial de Precios', 'Revisar la trazabilidad de modificaciones de precios'),

-- Perfil 7: Soporte Tecnico
(107, 'Administrar Perfiles', 'Configurar perfiles y funcionalidades del sistema'),
(121, 'Resetear Claves', 'Blanqueo y restablecimiento de contraseñas de usuarios'),
(122, 'Ver Logs del Sistema', 'Consultar registro de errores y eventos del servidor'),

-- Perfil 8: Comprador
(108, 'Generar Pedido a Proveedor', 'Crear un pedido de reposicion a un proveedor'),
(123, 'Gestionar Proveedores', 'Alta y actualizacion de datos de proveedores habituales'),
(124, 'Evaluar Costos', 'Comparar presupuestos y listas de precios de proveedores');

-- Verificacion: muestra las funcionalidades cargadas
SELECT * FROM FUNCIONALIDAD ORDER BY id_funcionalidad ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error al ejecutar).
-- Se repite a proposito el codigo_funcionalidad 101 para demostrar
-- que la restriccion UNIQUE de esa columna funciona.
INSERT INTO FUNCIONALIDAD (codigo_funcionalidad, nombre_funcionalidad, descripcion_funcionalidad) VALUES
(101, 'Funcionalidad Duplicada', 'Prueba de codigo repetido');

-- Ejemplo de UPDATE: actualizar la descripcion de una funcionalidad
UPDATE FUNCIONALIDAD
SET descripcion_funcionalidad = 'Alta, baja, modificacion y bloqueo de usuarios del sistema'
WHERE codigo_funcionalidad = 101;

-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PERFIL_FUNCIONALIDAD: relacion entre perfiles y funcionalidades.
-- Permite que una funcionalidad pueda ser utilizada por varios perfiles.
-- El Administrador tiene acceso a todas las funcionalidades cargadas.
-- ============================================================
INSERT INTO PERFIL_FUNCIONALIDAD (id_perfil, id_funcionalidad) VALUES
-- Perfil 1: Administrador - acceso total
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6),
(1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12),
(1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18),
(1, 19), (1, 20), (1, 21), (1, 22), (1, 23), (1, 24),

-- Perfil 2: Vendedor
(2, 4), (2, 5), (2, 6),

-- Perfil 3: Cajero
(3, 7), (3, 8), (3, 9),

-- Perfil 4: Encargado de Stock
(4, 10), (4, 11), (4, 12),

-- Perfil 5: Gerente de Sucursal
(5, 13), (5, 14), (5, 15),

-- Perfil 6: Auditor
(6, 16), (6, 17), (6, 18),

-- Perfil 7: Soporte Tecnico
(7, 19), (7, 20), (7, 21),

-- Perfil 8: Comprador
(8, 22), (8, 23), (8, 24);

-- Verificacion: muestra las funcionalidades asignadas a cada perfil
SELECT * FROM PERFIL_FUNCIONALIDAD
ORDER BY id_perfil ASC, id_funcionalidad ASC;


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
('Ayacucho', 168, 90),
('Independencia', 341, 91),
('Libertad', 514, 92),
('Mitre', 687, 93),
('Alberdi', 860, 94),
('Alvear', 1033, 95),
('Pueyrredon', 1206, 96),
('Saavedra', 1379, 97),
('Castelli', 1552, 98),
('Velez Sarsfield', 1725, 99),
('Las Heras', 1898, 100),
('Monteagudo', 2071, 101),
('French', 2244, 102),
('Berutti', 2417, 103),
('Ituzaingo', 2590, 104),
('Paraguay', 2763, 105),
('Ecuador', 2936, 106),
('Chile', 3109, 107),
('Mexico', 3282, 108),
('Espana', 3455, 109),
('Italia', 3628, 110),
('Suipacha', 3801, 111),
('Maipu', 3974, 112),
('Alsina', 247, 113),
('Dorrego', 420, 114),
('Brown', 593, 115),
('Guemes', 766, 116),
('Balcarce', 939, 117),
('Almafuerte', 1112, 118),
('Pringles', 1285, 119),
('Laprida', 1458, 120),
('San Martin', 1631, 121),
('Belgrano', 1804, 122),
('Junin', 1977, 123),
('Cordoba', 2150, 124),
('Colon', 2323, 125),
('9 de Julio', 2496, 126),
('Santa Fe', 2669, 127),
('La Rioja', 2842, 128),
('Catamarca', 3015, 1),
('Mendoza', 3188, 2),
('Salta', 3361, 3),
('Buenos Aires', 3534, 4),
('Lavalle', 3707, 5),
('Rivadavia', 3880, 6),
('Sarmiento', 153, 7),
('25 de Mayo', 326, 8),
('Hipolito Yrigoyen', 499, 9),
('Quintana', 672, 10),
('Pellegrini', 845, 11),
('Bolivar', 1018, 12),
('Moreno', 1191, 13),
('Necochea', 1364, 14),
('Peru', 1537, 15),
('Brasil', 1710, 16),
('Chacabuco', 1883, 17),
('Entre Rios', 2056, 18),
('San Juan', 2229, 19),
('Tucuman', 2402, 20),
('Uruguay', 2575, 21),
('Ayacucho', 2748, 22),
('Independencia', 2921, 23),
('Libertad', 3094, 24),
('Mitre', 3267, 25),
('Alberdi', 3440, 26),
('Alvear', 3613, 27),
('Pueyrredon', 3786, 28),
('Saavedra', 3959, 29),
('Castelli', 232, 30),
('Velez Sarsfield', 405, 31),
('Las Heras', 578, 32),
('Monteagudo', 751, 33),
('French', 924, 34),
('Berutti', 1097, 35),
('Ituzaingo', 1270, 36),
('Paraguay', 1443, 37),
('Ecuador', 1616, 38),
('Chile', 1789, 39),
('Mexico', 1962, 40),
('Espana', 2135, 41),
('Italia', 2308, 42),
('Suipacha', 2481, 43),
('Maipu', 2654, 44),
('Alsina', 2827, 45),
('Dorrego', 3000, 46),
('Brown', 3173, 47),
('Guemes', 3346, 48),
('Balcarce', 3519, 49),
('Almafuerte', 3692, 50),
('Pringles', 3865, 51),
('Laprida', 138, 52),
('San Martin', 311, 53),
('Belgrano', 484, 54),
('Junin', 657, 55),
('Cordoba', 830, 56),
('Colon', 1003, 57),
('9 de Julio', 1176, 58),
('Santa Fe', 1349, 59),
('La Rioja', 1522, 60),
('Catamarca', 1695, 61),
('Mendoza', 1868, 62),
('Salta', 2041, 63),
('Buenos Aires', 2214, 64),
('Lavalle', 2387, 65),
('Rivadavia', 2560, 66),
('Sarmiento', 2733, 67),
('25 de Mayo', 2906, 68),
('Hipolito Yrigoyen', 3079, 69),
('Quintana', 3252, 70),
('Pellegrini', 3425, 71),
('Bolivar', 3598, 72),
('Moreno', 3771, 73),
('Necochea', 3944, 74),
('Peru', 217, 75),
('Brasil', 390, 76),
('Chacabuco', 563, 77),
('Entre Rios', 736, 78),
('San Juan', 909, 79),
('Tucuman', 1082, 80),
('Uruguay', 1255, 81),
('Ayacucho', 1428, 82),
('Independencia', 1601, 83),
('Libertad', 1774, 84),
('Mitre', 1947, 85),
('Alberdi', 2120, 86),
('Alvear', 2293, 87),
('Pueyrredon', 2466, 88),
('Saavedra', 2639, 89),
('Castelli', 2812, 90),
('Velez Sarsfield', 2985, 91),
('Las Heras', 3158, 92),
('Monteagudo', 3331, 93),
('French', 3504, 94),
('Berutti', 3677, 95),
('Ituzaingo', 3850, 96),
('Paraguay', 123, 97),
('Ecuador', 296, 98),
('Chile', 469, 99),
('Mexico', 642, 100),
('Espana', 815, 101),
('Italia', 988, 102),
('Suipacha', 1161, 103),
('Maipu', 1334, 104),
('Alsina', 1507, 105),
('Dorrego', 1680, 106),
('Brown', 1853, 107),
('Guemes', 2026, 108),
('Balcarce', 2199, 109),
('Almafuerte', 2372, 110),
('Pringles', 2545, 111),
('Laprida', 2718, 112),
('San Martin', 2891, 113),
('Belgrano', 3064, 114),
('Junin', 3237, 115),
('Cordoba', 3410, 116),
('Colon', 3583, 117),
('9 de Julio', 3756, 118),
('Santa Fe', 3929, 119),
('La Rioja', 202, 120),
('Catamarca', 375, 121),
('Mendoza', 548, 122),
('Salta', 721, 123),
('Buenos Aires', 894, 124),
('Lavalle', 1067, 125),
('Rivadavia', 1240, 126),
('Sarmiento', 1413, 127),
('25 de Mayo', 1586, 128),
('Hipolito Yrigoyen', 1759, 1),
('Quintana', 1932, 2),
('Pellegrini', 2105, 3),
('Bolivar', 2278, 4),
('Moreno', 2451, 5),
('Necochea', 2624, 6),
('Peru', 2797, 7),
('Brasil', 2970, 8),
('Chacabuco', 3143, 9),
('Entre Rios', 3316, 10),
('San Juan', 3489, 11),
('Tucuman', 3662, 12),
('Uruguay', 3835, 13),
('Ayacucho', 108, 14),
('Independencia', 281, 15),
('Libertad', 454, 16),
('Mitre', 627, 17),
('Alberdi', 800, 18),
('Alvear', 973, 19),
('Pueyrredon', 1146, 20),
('Saavedra', 1319, 21),
('Castelli', 1492, 22),
('Velez Sarsfield', 1665, 23),
('Las Heras', 1838, 24),
('Monteagudo', 2011, 25),
('French', 2184, 26),
('Berutti', 2357, 27),
('Ituzaingo', 2530, 28),
('Paraguay', 2703, 29),
('Ecuador', 2876, 30),
('Chile', 3049, 31),
('Mexico', 3222, 32),
('Espana', 3395, 33),
('Italia', 3568, 34),
('Suipacha', 3741, 35),
('Maipu', 3914, 36),
('Alsina', 187, 37),
('Dorrego', 360, 38),
('Brown', 533, 39),
('Guemes', 706, 40),
('Balcarce', 879, 41),
('Almafuerte', 1052, 42),
('Pringles', 1225, 43),
('Laprida', 1398, 44);

-- Verificacion: deben quedar 330 direcciones
SELECT COUNT(*) AS cantidad_direcciones FROM DIRECCION;
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
('Milagros', 'Torres', 45000124, 'milagros.torres.124@clientes.test', 154),
('Benjamin', 'Ruiz', 45000125, 'benjamin.ruiz.125@clientes.test', 155),
('Agustina', 'Vera', 45000126, 'agustina.vera.126@clientes.test', 156),
('Lautaro', 'Navarro', 45000127, 'lautaro.navarro.127@clientes.test', 157),
('Antonella', 'Ferreyra', 45000128, 'antonella.ferreyra.128@clientes.test', 158),
('Gonzalo', 'Quiroga', 45000129, 'gonzalo.quiroga.129@clientes.test', 159),
('Rocio', 'Benitez', 45000130, 'rocio.benitez.130@clientes.test', 160),
('Facundo', 'Gimenez', 45000131, 'facundo.gimenez.131@clientes.test', 161),
('Candela', 'Caceres', 45000132, 'candela.caceres.132@clientes.test', 162),
('Emiliano', 'Sanchez', 45000133, 'emiliano.sanchez.133@clientes.test', 163),
('Josefina', 'Barrios', 45000134, 'josefina.barrios.134@clientes.test', 164),
('Marcos', 'Cabral', 45000135, 'marcos.cabral.135@clientes.test', 165),
('Belen', 'Paredes', 45000136, 'belen.paredes.136@clientes.test', 166),
('Ramiro', 'Ramirez', 45000137, 'ramiro.ramirez.137@clientes.test', 167),
('Daniela', 'Lopez', 45000138, 'daniela.lopez.138@clientes.test', 168),
('Thiago', 'Mendez', 45000139, 'thiago.mendez.139@clientes.test', 169),
('Malena', 'Garcia', 45000140, 'malena.garcia.140@clientes.test', 170),
('Diego', 'Cardozo', 45000141, 'diego.cardozo.141@clientes.test', 171),
('Carla', 'Villalba', 45000142, 'carla.villalba.142@clientes.test', 172),
('Leandro', 'Molina', 45000143, 'leandro.molina.143@clientes.test', 173),
('Noelia', 'Fernandez', 45000144, 'noelia.fernandez.144@clientes.test', 174),
('Sebastian', 'Acosta', 45000145, 'sebastian.acosta.145@clientes.test', 175),
('Natalia', 'Ortiz', 45000146, 'natalia.ortiz.146@clientes.test', 176),
('Ezequiel', 'Gonzalez', 45000147, 'ezequiel.gonzalez.147@clientes.test', 177),
('Gabriela', 'Godoy', 45000148, 'gabriela.godoy.148@clientes.test', 178),
('Cristian', 'Morales', 45000149, 'cristian.morales.149@clientes.test', 179),
('Marina', 'Leiva', 45000150, 'marina.leiva.150@clientes.test', 180),
('Lucas', 'Gomez', 45000151, 'lucas.gomez.151@clientes.test', 181),
('Mateo', 'Aguirre', 45000152, 'mateo.aguirre.152@clientes.test', 182),
('Sofia', 'Silva', 45000153, 'sofia.silva.153@clientes.test', 183),
('Valentina', 'Rodriguez', 45000154, 'valentina.rodriguez.154@clientes.test', 184),
('Martin', 'Maidana', 45000155, 'martin.maidana.155@clientes.test', 185),
('Camila', 'Flores', 45000156, 'camila.flores.156@clientes.test', 186),
('Nicolas', 'Ledesma', 45000157, 'nicolas.ledesma.157@clientes.test', 187),
('Lucia', 'Valdez', 45000158, 'lucia.valdez.158@clientes.test', 188),
('Joaquin', 'Romero', 45000159, 'joaquin.romero.159@clientes.test', 189),
('Martina', 'Medina', 45000160, 'martina.medina.160@clientes.test', 190),
('Tomas', 'Diaz', 45000161, 'tomas.diaz.161@clientes.test', 191),
('Julieta', 'Ojeda', 45000162, 'julieta.ojeda.162@clientes.test', 192),
('Agustin', 'Alvarez', 45000163, 'agustin.alvarez.163@clientes.test', 193),
('Micaela', 'Ibarra', 45000164, 'micaela.ibarra.164@clientes.test', 194),
('Franco', 'Suarez', 45000165, 'franco.suarez.165@clientes.test', 195),
('Carolina', 'Sosa', 45000166, 'carolina.sosa.166@clientes.test', 196),
('Federico', 'Rojas', 45000167, 'federico.rojas.167@clientes.test', 197),
('Florencia', 'Pereira', 45000168, 'florencia.pereira.168@clientes.test', 198),
('Bruno', 'Escobar', 45000169, 'bruno.escobar.169@clientes.test', 199),
('Paula', 'Nunez', 45000170, 'paula.nunez.170@clientes.test', 200),
('Santiago', 'Dominguez', 45000171, 'santiago.dominguez.171@clientes.test', 201),
('Victoria', 'Rivero', 45000172, 'victoria.rivero.172@clientes.test', 202),
('Ignacio', 'Martinez', 45000173, 'ignacio.martinez.173@clientes.test', 203),
('Milagros', 'Torres', 45000174, 'milagros.torres.174@clientes.test', 204),
('Benjamin', 'Ruiz', 45000175, 'benjamin.ruiz.175@clientes.test', 205),
('Agustina', 'Vera', 45000176, 'agustina.vera.176@clientes.test', 206),
('Lautaro', 'Navarro', 45000177, 'lautaro.navarro.177@clientes.test', 207),
('Antonella', 'Ferreyra', 45000178, 'antonella.ferreyra.178@clientes.test', 208),
('Gonzalo', 'Quiroga', 45000179, 'gonzalo.quiroga.179@clientes.test', 209),
('Rocio', 'Benitez', 45000180, 'rocio.benitez.180@clientes.test', 210),
('Facundo', 'Gimenez', 45000181, 'facundo.gimenez.181@clientes.test', 211),
('Candela', 'Caceres', 45000182, 'candela.caceres.182@clientes.test', 212),
('Emiliano', 'Sanchez', 45000183, 'emiliano.sanchez.183@clientes.test', 213),
('Josefina', 'Barrios', 45000184, 'josefina.barrios.184@clientes.test', 214),
('Marcos', 'Cabral', 45000185, 'marcos.cabral.185@clientes.test', 215),
('Belen', 'Paredes', 45000186, 'belen.paredes.186@clientes.test', 216),
('Ramiro', 'Ramirez', 45000187, 'ramiro.ramirez.187@clientes.test', 217),
('Daniela', 'Lopez', 45000188, 'daniela.lopez.188@clientes.test', 218),
('Thiago', 'Mendez', 45000189, 'thiago.mendez.189@clientes.test', 219),
('Malena', 'Garcia', 45000190, 'malena.garcia.190@clientes.test', 220),
('Diego', 'Cardozo', 45000191, 'diego.cardozo.191@clientes.test', 221),
('Carla', 'Villalba', 45000192, 'carla.villalba.192@clientes.test', 222),
('Leandro', 'Molina', 45000193, 'leandro.molina.193@clientes.test', 223),
('Noelia', 'Fernandez', 45000194, 'noelia.fernandez.194@clientes.test', 224),
('Sebastian', 'Acosta', 45000195, 'sebastian.acosta.195@clientes.test', 225),
('Natalia', 'Ortiz', 45000196, 'natalia.ortiz.196@clientes.test', 226),
('Ezequiel', 'Gonzalez', 45000197, 'ezequiel.gonzalez.197@clientes.test', 227),
('Gabriela', 'Godoy', 45000198, 'gabriela.godoy.198@clientes.test', 228),
('Cristian', 'Morales', 45000199, 'cristian.morales.199@clientes.test', 229),
('Marina', 'Leiva', 45000200, 'marina.leiva.200@clientes.test', 230),
('Lucas', 'Gomez', 45000201, 'lucas.gomez.201@clientes.test', 231),
('Mateo', 'Aguirre', 45000202, 'mateo.aguirre.202@clientes.test', 232),
('Sofia', 'Silva', 45000203, 'sofia.silva.203@clientes.test', 233),
('Valentina', 'Rodriguez', 45000204, 'valentina.rodriguez.204@clientes.test', 234),
('Martin', 'Maidana', 45000205, 'martin.maidana.205@clientes.test', 235),
('Camila', 'Flores', 45000206, 'camila.flores.206@clientes.test', 236),
('Nicolas', 'Ledesma', 45000207, 'nicolas.ledesma.207@clientes.test', 237),
('Lucia', 'Valdez', 45000208, 'lucia.valdez.208@clientes.test', 238),
('Joaquin', 'Romero', 45000209, 'joaquin.romero.209@clientes.test', 239),
('Martina', 'Medina', 45000210, 'martina.medina.210@clientes.test', 240),
('Tomas', 'Diaz', 45000211, 'tomas.diaz.211@clientes.test', 241),
('Julieta', 'Ojeda', 45000212, 'julieta.ojeda.212@clientes.test', 242),
('Agustin', 'Alvarez', 45000213, 'agustin.alvarez.213@clientes.test', 243),
('Micaela', 'Ibarra', 45000214, 'micaela.ibarra.214@clientes.test', 244),
('Franco', 'Suarez', 45000215, 'franco.suarez.215@clientes.test', 245),
('Carolina', 'Sosa', 45000216, 'carolina.sosa.216@clientes.test', 246),
('Federico', 'Rojas', 45000217, 'federico.rojas.217@clientes.test', 247),
('Florencia', 'Pereira', 45000218, 'florencia.pereira.218@clientes.test', 248),
('Bruno', 'Escobar', 45000219, 'bruno.escobar.219@clientes.test', 249),
('Paula', 'Nunez', 45000220, 'paula.nunez.220@clientes.test', 250),
('Santiago', 'Dominguez', 45000221, 'santiago.dominguez.221@clientes.test', 251),
('Victoria', 'Rivero', 45000222, 'victoria.rivero.222@clientes.test', 252),
('Ignacio', 'Martinez', 45000223, 'ignacio.martinez.223@clientes.test', 253),
('Milagros', 'Torres', 45000224, 'milagros.torres.224@clientes.test', 254),
('Benjamin', 'Ruiz', 45000225, 'benjamin.ruiz.225@clientes.test', 255),
('Agustina', 'Vera', 45000226, 'agustina.vera.226@clientes.test', 256),
('Lautaro', 'Navarro', 45000227, 'lautaro.navarro.227@clientes.test', 257),
('Antonella', 'Ferreyra', 45000228, 'antonella.ferreyra.228@clientes.test', 258),
('Gonzalo', 'Quiroga', 45000229, 'gonzalo.quiroga.229@clientes.test', 259),
('Rocio', 'Benitez', 45000230, 'rocio.benitez.230@clientes.test', 260),
('Facundo', 'Gimenez', 45000231, 'facundo.gimenez.231@clientes.test', 261),
('Candela', 'Caceres', 45000232, 'candela.caceres.232@clientes.test', 262),
('Emiliano', 'Sanchez', 45000233, 'emiliano.sanchez.233@clientes.test', 263),
('Josefina', 'Barrios', 45000234, 'josefina.barrios.234@clientes.test', 264),
('Marcos', 'Cabral', 45000235, 'marcos.cabral.235@clientes.test', 265),
('Belen', 'Paredes', 45000236, 'belen.paredes.236@clientes.test', 266),
('Ramiro', 'Ramirez', 45000237, 'ramiro.ramirez.237@clientes.test', 267),
('Daniela', 'Lopez', 45000238, 'daniela.lopez.238@clientes.test', 268),
('Thiago', 'Mendez', 45000239, 'thiago.mendez.239@clientes.test', 269),
('Malena', 'Garcia', 45000240, 'malena.garcia.240@clientes.test', 270),
('Diego', 'Cardozo', 45000241, 'diego.cardozo.241@clientes.test', 271),
('Carla', 'Villalba', 45000242, 'carla.villalba.242@clientes.test', 272),
('Leandro', 'Molina', 45000243, 'leandro.molina.243@clientes.test', 273),
('Noelia', 'Fernandez', 45000244, 'noelia.fernandez.244@clientes.test', 274),
('Sebastian', 'Acosta', 45000245, 'sebastian.acosta.245@clientes.test', 275),
('Natalia', 'Ortiz', 45000246, 'natalia.ortiz.246@clientes.test', 276),
('Ezequiel', 'Gonzalez', 45000247, 'ezequiel.gonzalez.247@clientes.test', 277),
('Gabriela', 'Godoy', 45000248, 'gabriela.godoy.248@clientes.test', 278),
('Cristian', 'Morales', 45000249, 'cristian.morales.249@clientes.test', 279),
('Marina', 'Leiva', 45000250, 'marina.leiva.250@clientes.test', 280),
('Lucas', 'Gomez', 45000251, 'lucas.gomez.251@clientes.test', 281),
('Mateo', 'Aguirre', 45000252, 'mateo.aguirre.252@clientes.test', 282),
('Sofia', 'Silva', 45000253, 'sofia.silva.253@clientes.test', 283),
('Valentina', 'Rodriguez', 45000254, 'valentina.rodriguez.254@clientes.test', 284),
('Martin', 'Maidana', 45000255, 'martin.maidana.255@clientes.test', 285),
('Camila', 'Flores', 45000256, 'camila.flores.256@clientes.test', 286),
('Nicolas', 'Ledesma', 45000257, 'nicolas.ledesma.257@clientes.test', 287),
('Lucia', 'Valdez', 45000258, 'lucia.valdez.258@clientes.test', 288),
('Joaquin', 'Romero', 45000259, 'joaquin.romero.259@clientes.test', 289),
('Martina', 'Medina', 45000260, 'martina.medina.260@clientes.test', 290),
('Tomas', 'Diaz', 45000261, 'tomas.diaz.261@clientes.test', 291),
('Julieta', 'Ojeda', 45000262, 'julieta.ojeda.262@clientes.test', 292),
('Agustin', 'Alvarez', 45000263, 'agustin.alvarez.263@clientes.test', 293),
('Micaela', 'Ibarra', 45000264, 'micaela.ibarra.264@clientes.test', 294),
('Franco', 'Suarez', 45000265, 'franco.suarez.265@clientes.test', 295),
('Carolina', 'Sosa', 45000266, 'carolina.sosa.266@clientes.test', 296),
('Federico', 'Rojas', 45000267, 'federico.rojas.267@clientes.test', 297),
('Florencia', 'Pereira', 45000268, 'florencia.pereira.268@clientes.test', 298),
('Bruno', 'Escobar', 45000269, 'bruno.escobar.269@clientes.test', 299),
('Paula', 'Nunez', 45000270, 'paula.nunez.270@clientes.test', 300),
('Santiago', 'Dominguez', 45000271, 'santiago.dominguez.271@clientes.test', 301),
('Victoria', 'Rivero', 45000272, 'victoria.rivero.272@clientes.test', 302),
('Ignacio', 'Martinez', 45000273, 'ignacio.martinez.273@clientes.test', 303),
('Milagros', 'Torres', 45000274, 'milagros.torres.274@clientes.test', 304),
('Benjamin', 'Ruiz', 45000275, 'benjamin.ruiz.275@clientes.test', 305),
('Agustina', 'Vera', 45000276, 'agustina.vera.276@clientes.test', 306),
('Lautaro', 'Navarro', 45000277, 'lautaro.navarro.277@clientes.test', 307),
('Antonella', 'Ferreyra', 45000278, 'antonella.ferreyra.278@clientes.test', 308),
('Gonzalo', 'Quiroga', 45000279, 'gonzalo.quiroga.279@clientes.test', 309),
('Rocio', 'Benitez', 45000280, 'rocio.benitez.280@clientes.test', 310),
('Facundo', 'Gimenez', 45000281, 'facundo.gimenez.281@clientes.test', 311),
('Candela', 'Caceres', 45000282, 'candela.caceres.282@clientes.test', 312),
('Emiliano', 'Sanchez', 45000283, 'emiliano.sanchez.283@clientes.test', 313),
('Josefina', 'Barrios', 45000284, 'josefina.barrios.284@clientes.test', 314),
('Marcos', 'Cabral', 45000285, 'marcos.cabral.285@clientes.test', 315),
('Belen', 'Paredes', 45000286, 'belen.paredes.286@clientes.test', 316),
('Ramiro', 'Ramirez', 45000287, 'ramiro.ramirez.287@clientes.test', 317),
('Daniela', 'Lopez', 45000288, 'daniela.lopez.288@clientes.test', 318),
('Thiago', 'Mendez', 45000289, 'thiago.mendez.289@clientes.test', 319),
('Malena', 'Garcia', 45000290, 'malena.garcia.290@clientes.test', 320),
('Diego', 'Cardozo', 45000291, 'diego.cardozo.291@clientes.test', 321),
('Carla', 'Villalba', 45000292, 'carla.villalba.292@clientes.test', 322),
('Leandro', 'Molina', 45000293, 'leandro.molina.293@clientes.test', 323),
('Noelia', 'Fernandez', 45000294, 'noelia.fernandez.294@clientes.test', 324),
('Sebastian', 'Acosta', 45000295, 'sebastian.acosta.295@clientes.test', 325),
('Natalia', 'Ortiz', 45000296, 'natalia.ortiz.296@clientes.test', 326),
('Ezequiel', 'Gonzalez', 45000297, 'ezequiel.gonzalez.297@clientes.test', 327),
('Gabriela', 'Godoy', 45000298, 'gabriela.godoy.298@clientes.test', 328),
('Cristian', 'Morales', 45000299, 'cristian.morales.299@clientes.test', 329),
('Marina', 'Leiva', 45000300, 'marina.leiva.300@clientes.test', 330);

-- Verificacion: deben quedar 300 clientes
SELECT COUNT(*) AS cantidad_clientes FROM CLIENTE;
SELECT * FROM CLIENTE ORDER BY id_cliente ASC;

-- Prueba de Restriccion UNIQUE (esto DEBE tirar error).
-- Se repite el DNI del primer cliente.
INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion) VALUES
('Cliente', 'Duplicado', 45000001, 'cliente.duplicado@mail.com', 31);

-- Ejemplo de UPDATE: actualizar el correo de un cliente
UPDATE CLIENTE
SET correo = 'lucas.gomez.nuevo@clientes.test'
WHERE id_cliente = 1;


/*
-- ALTERNATIVA: carga masiva de 300 clientes con WHILE
DECLARE @i INT = 1, @localidad INT, @id_direccion INT;
DECLARE @nombre VARCHAR(50), @apellido VARCHAR(50), @calle VARCHAR(50);

WHILE @i <= 300
BEGIN
    SET @localidad = ((@i - 1) % 128) + 1;

    SET @nombre = CHOOSE(((@i - 1) % 20) + 1,
        'Lucas','Mateo','Sofia','Valentina','Martin',
        'Camila','Nicolas','Lucia','Joaquin','Martina',
        'Tomas','Julieta','Agustin','Micaela','Franco',
        'Carolina','Federico','Florencia','Bruno','Paula');

    SET @apellido = CHOOSE((((@i - 1) * 7) % 20) + 1,
        'Gomez','Fernandez','Ramirez','Benitez','Martinez',
        'Sosa','Romero','Aguirre','Acosta','Lopez',
        'Gimenez','Torres','Rojas','Medina','Silva',
        'Ortiz','Mendez','Caceres','Ruiz','Pereira');

    SET @calle = CHOOSE(((@i - 1) % 15) + 1,
        'San Martin','Belgrano','Junin','Cordoba','Colon',
        '9 de Julio','Santa Fe','La Rioja','Catamarca','Mendoza',
        'Salta','Buenos Aires','Lavalle','Rivadavia','Sarmiento');

    INSERT INTO DIRECCION (calle, altura, id_localidad)
    VALUES (@calle, 100 + ((@i * 173) % 3900), @localidad);

    SET @id_direccion = SCOPE_IDENTITY();

    INSERT INTO CLIENTE (nombre, apellido, dni, correo, id_direccion)
    VALUES (
        @nombre,
        @apellido,
        45000000 + @i,
        LOWER(CONCAT(@nombre,'.',@apellido,'.',@i,'@clientes.test')),
        @id_direccion
    );

    INSERT INTO CLIENTE_TELEFONO (telefono, id_cliente)
    VALUES (
        CONCAT('371', RIGHT('0000000' + CAST(@i AS VARCHAR(7)), 7)),
        SCOPE_IDENTITY()
    );

    SET @i = @i + 1;
END;
*/


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- SUCURSAL: sucursales disponibles de la ferreteria.
-- ============================================================
INSERT INTO SUCURSAL (nombre, id_direccion) VALUES
('Sucursal Centro', 1),
('Sucursal Goya', 11),
('Sucursal Mercedes', 21);

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


/*
-- ALTERNATIVA: carga masiva de 30 usuarios con WHILE
DECLARE @i INT = 1, @sucursal INT, @localidad INT, @perfil INT, @id_direccion INT;
DECLARE @nombre VARCHAR(50), @apellido VARCHAR(50), @calle VARCHAR(50);

WHILE @i <= 30
BEGIN
    SET @sucursal = ((@i - 1) / 10) + 1;

    SELECT @localidad = D.id_localidad
    FROM SUCURSAL S
    INNER JOIN DIRECCION D ON S.id_direccion = D.id_direccion
    WHERE S.id_sucursal = @sucursal;

    SET @perfil = CASE ((@i - 1) % 10) + 1
        WHEN 1 THEN 1
        WHEN 2 THEN 2
        WHEN 3 THEN 2
        WHEN 4 THEN 2
        WHEN 5 THEN 3
        WHEN 6 THEN 4
        WHEN 7 THEN 5
        WHEN 8 THEN 6
        WHEN 9 THEN 7
        WHEN 10 THEN 8
    END;

    SET @nombre = CHOOSE(((@i - 1) % 10) + 1,
        'Juan','Maria','Pedro','Ana','Diego',
        'Lucia','Matias','Florencia','Federico','Julieta');

    SET @apellido = CHOOSE(((@i - 1) % 10) + 1,
        'Perez','Lopez','Acosta','Gimenez','Fernandez',
        'Gomez','Sosa','Ramirez','Benitez','Romero');

    SET @calle = CHOOSE(((@i - 1) % 10) + 1,
        'San Martin','Belgrano','Junin','Cordoba','Colon',
        '9 de Julio','Santa Fe','La Rioja','Mendoza','Salta');

    INSERT INTO DIRECCION (calle, altura, id_localidad)
    VALUES (@calle, 300 + ((@i * 157) % 2700), @localidad);

    SET @id_direccion = SCOPE_IDENTITY();

    INSERT INTO USUARIO (
        nombre, apellido, dni, nombre_usuario, contraseña_hash,
        correo, fecha_nacimiento, id_direccion, id_perfil, id_sucursal
    )
    VALUES (
        @nombre,
        @apellido,
        32000000 + (@i * 13791),
        LOWER(CONCAT(LEFT(@nombre,1), @apellido, @sucursal, @i)),
        CONCAT('hash_usuario_', @i),
        LOWER(CONCAT(@nombre,'.',@apellido,'.',@i,'@ferreteria.test')),
        DATEADD(DAY, @i * 197, '1985-01-01'),
        @id_direccion,
        @perfil,
        @sucursal
    );

    INSERT INTO USUARIO_TELEFONO (telefono, id_usuario)
    VALUES (
        CONCAT('372', RIGHT('0000000' + CAST(@i AS VARCHAR(7)), 7)),
        SCOPE_IDENTITY()
    );

    SET @i = @i + 1;
END;
*/


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
('B', 0.00, 1, 1, 2),
('C', 5.00, 2, 3, 12),
('A', 10.00, 3, 4, 22),
('B', 3.00, 1, 4, 1),
('C', 0.00, 1, 5, 2),
('A', 5.00, 1, 6, 3),
('B', 10.00, 1, 7, 4),
('C', 8.00, 1, 8, 5),
('A', 3.00, 1, 9, 6),
('B', 0.00, 1, 10, 7),
('C', 5.00, 1, 11, 8),
('A', 10.00, 1, 12, 9),
('B', 8.00, 1, 13, 10),
('C', 3.00, 1, 14, 1),
('A', 0.00, 1, 15, 2),
('B', 5.00, 1, 16, 3),
('C', 10.00, 1, 17, 4),
('A', 8.00, 1, 18, 5),
('B', 3.00, 1, 19, 6),
('C', 0.00, 1, 20, 7),
('A', 5.00, 1, 21, 8),
('B', 10.00, 1, 22, 9),
('C', 8.00, 1, 23, 10),
('A', 3.00, 1, 24, 1),
('B', 0.00, 1, 25, 2),
('C', 5.00, 1, 26, 3),
('A', 10.00, 1, 27, 4),
('B', 8.00, 1, 28, 5),
('C', 3.00, 1, 29, 6),
('A', 0.00, 1, 30, 7),
('B', 5.00, 1, 31, 8),
('C', 10.00, 1, 32, 9),
('A', 8.00, 1, 33, 10),
('B', 3.00, 1, 34, 1),
('C', 0.00, 1, 35, 2),
('A', 5.00, 1, 36, 3),
('B', 10.00, 2, 37, 11),
('C', 8.00, 2, 38, 12),
('A', 3.00, 2, 39, 13),
('B', 0.00, 2, 40, 14),
('C', 5.00, 2, 41, 15),
('A', 10.00, 2, 42, 16),
('B', 8.00, 2, 43, 17),
('C', 3.00, 2, 44, 18),
('A', 0.00, 2, 45, 19),
('B', 5.00, 2, 46, 20),
('C', 10.00, 2, 47, 11),
('A', 8.00, 2, 48, 12),
('B', 3.00, 2, 49, 13),
('C', 0.00, 2, 50, 14),
('A', 5.00, 2, 51, 15),
('B', 10.00, 2, 52, 16),
('C', 8.00, 2, 53, 17),
('A', 3.00, 2, 54, 18),
('B', 0.00, 2, 55, 19),
('C', 5.00, 2, 56, 20),
('A', 10.00, 2, 57, 11),
('B', 8.00, 2, 58, 12),
('C', 3.00, 2, 59, 13),
('A', 0.00, 2, 60, 14),
('B', 5.00, 2, 61, 15),
('C', 10.00, 2, 62, 16),
('A', 8.00, 2, 63, 17),
('B', 3.00, 2, 64, 18),
('C', 0.00, 2, 65, 19),
('A', 5.00, 2, 66, 20),
('B', 10.00, 2, 67, 11),
('C', 8.00, 2, 68, 12),
('A', 3.00, 3, 69, 21),
('B', 0.00, 3, 70, 22),
('C', 5.00, 3, 71, 23),
('A', 10.00, 3, 72, 24),
('B', 8.00, 3, 73, 25),
('C', 3.00, 3, 74, 26),
('A', 0.00, 3, 75, 27),
('B', 5.00, 3, 76, 28),
('C', 10.00, 3, 77, 29),
('A', 8.00, 3, 78, 30),
('B', 3.00, 3, 79, 21),
('C', 0.00, 3, 80, 22),
('A', 5.00, 3, 81, 23),
('B', 10.00, 3, 82, 24),
('C', 8.00, 3, 83, 25),
('A', 3.00, 3, 84, 26),
('B', 0.00, 3, 85, 27),
('C', 5.00, 3, 86, 28),
('A', 10.00, 3, 87, 29),
('B', 8.00, 3, 88, 30),
('C', 3.00, 3, 89, 21),
('A', 0.00, 3, 90, 22),
('B', 5.00, 3, 91, 23),
('C', 10.00, 3, 92, 24),
('A', 8.00, 3, 93, 25),
('B', 3.00, 3, 94, 26),
('C', 0.00, 3, 95, 27),
('A', 5.00, 3, 96, 28),
('B', 10.00, 3, 97, 29),
('C', 8.00, 3, 98, 30),
('A', 3.00, 3, 99, 21),
('B', 0.00, 3, 100, 22);    

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
    id_venta
) VALUES
(2, 15000.00, 1, 1),
(1, 65000.00, 2, 1),
(5, 3500.00, 3, 2),
(2, 22000.00, 4, 2),
(3, 8500.00, 5, 3),
(1, 15000.00, 1, 4),
(1, 65000.00, 2, 4),
(2, 65000.00, 2, 5),
(2, 3500.00, 3, 5),
(3, 3500.00, 3, 6),
(1, 22000.00, 4, 6),
(1, 22000.00, 4, 7),
(2, 8500.00, 5, 7),
(2, 8500.00, 5, 8),
(1, 12000.00, 6, 8),
(3, 12000.00, 6, 9),
(2, 15600.00, 7, 9),
(1, 15600.00, 7, 10),
(1, 11900.00, 8, 10),
(2, 11900.00, 8, 11),
(2, 15000.00, 1, 11),
(3, 15000.00, 1, 12),
(1, 65000.00, 2, 12),
(1, 65000.00, 2, 13),
(2, 3500.00, 3, 13),
(2, 3500.00, 3, 14),
(1, 22000.00, 4, 14),
(3, 22000.00, 4, 15),
(2, 8500.00, 5, 15),
(1, 8500.00, 5, 16),
(1, 12000.00, 6, 16),
(2, 12000.00, 6, 17),
(2, 15600.00, 7, 17),
(3, 15600.00, 7, 18),
(1, 11900.00, 8, 18),
(1, 11900.00, 8, 19),
(2, 15000.00, 1, 19),
(2, 15000.00, 1, 20),
(1, 65000.00, 2, 20),
(3, 65000.00, 2, 21),
(2, 3500.00, 3, 21),
(1, 3500.00, 3, 22),
(1, 22000.00, 4, 22),
(2, 22000.00, 4, 23),
(2, 8500.00, 5, 23),
(3, 8500.00, 5, 24),
(1, 12000.00, 6, 24),
(1, 12000.00, 6, 25),
(2, 15600.00, 7, 25),
(2, 15600.00, 7, 26),
(1, 11900.00, 8, 26),
(3, 11900.00, 8, 27),
(2, 15000.00, 1, 27),
(1, 15000.00, 1, 28),
(1, 65000.00, 2, 28),
(2, 65000.00, 2, 29),
(2, 3500.00, 3, 29),
(3, 3500.00, 3, 30),
(1, 22000.00, 4, 30),
(1, 22000.00, 4, 31),
(2, 8500.00, 5, 31),
(2, 8500.00, 5, 32),
(1, 12000.00, 6, 32),
(3, 12000.00, 6, 33),
(2, 15600.00, 7, 33),
(1, 15600.00, 7, 34),
(1, 11900.00, 8, 34),
(2, 11900.00, 8, 35),
(2, 15000.00, 1, 35),
(3, 15000.00, 1, 36),
(1, 65000.00, 2, 36),
(1, 65000.00, 2, 37),
(2, 3500.00, 3, 37),
(2, 3500.00, 3, 38),
(1, 22000.00, 4, 38),
(3, 22000.00, 4, 39),
(2, 8500.00, 5, 39),
(1, 8500.00, 5, 40),
(1, 12000.00, 6, 40),
(2, 12000.00, 6, 41),
(2, 15600.00, 7, 41),
(3, 15600.00, 7, 42),
(1, 11900.00, 8, 42),
(1, 11900.00, 8, 43),
(2, 15000.00, 1, 43),
(2, 15000.00, 1, 44),
(1, 65000.00, 2, 44),
(3, 65000.00, 2, 45),
(2, 3500.00, 3, 45),
(1, 3500.00, 3, 46),
(1, 22000.00, 4, 46),
(2, 22000.00, 4, 47),
(2, 8500.00, 5, 47),
(3, 8500.00, 5, 48),
(1, 12000.00, 6, 48),
(1, 12000.00, 6, 49),
(2, 15600.00, 7, 49),
(2, 15600.00, 7, 50),
(1, 11900.00, 8, 50),
(3, 11900.00, 8, 51),
(2, 15000.00, 1, 51),
(1, 15000.00, 1, 52),
(1, 65000.00, 2, 52),
(2, 65000.00, 2, 53),
(2, 3500.00, 3, 53),
(3, 3500.00, 3, 54),
(1, 22000.00, 4, 54),
(1, 22000.00, 4, 55),
(2, 8500.00, 5, 55),
(2, 8500.00, 5, 56),
(1, 12000.00, 6, 56),
(3, 12000.00, 6, 57),
(2, 15600.00, 7, 57),
(1, 15600.00, 7, 58),
(1, 11900.00, 8, 58),
(2, 11900.00, 8, 59),
(2, 15000.00, 1, 59),
(3, 15000.00, 1, 60),
(1, 65000.00, 2, 60),
(1, 65000.00, 2, 61),
(2, 3500.00, 3, 61),
(2, 3500.00, 3, 62),
(1, 22000.00, 4, 62),
(3, 22000.00, 4, 63),
(2, 8500.00, 5, 63),
(1, 8500.00, 5, 64),
(1, 12000.00, 6, 64),
(2, 12000.00, 6, 65),
(2, 15600.00, 7, 65),
(3, 15600.00, 7, 66),
(1, 11900.00, 8, 66),
(1, 11900.00, 8, 67),
(2, 15000.00, 1, 67),
(2, 15000.00, 1, 68),
(1, 65000.00, 2, 68),
(3, 65000.00, 2, 69),
(2, 3500.00, 3, 69),
(1, 3500.00, 3, 70),
(1, 22000.00, 4, 70),
(2, 22000.00, 4, 71),
(2, 8500.00, 5, 71),
(3, 8500.00, 5, 72),
(1, 12000.00, 6, 72),
(1, 12000.00, 6, 73),
(2, 15600.00, 7, 73),
(2, 15600.00, 7, 74),
(1, 11900.00, 8, 74),
(3, 11900.00, 8, 75),
(2, 15000.00, 1, 75),
(1, 15000.00, 1, 76),
(1, 65000.00, 2, 76),
(2, 65000.00, 2, 77),
(2, 3500.00, 3, 77),
(3, 3500.00, 3, 78),
(1, 22000.00, 4, 78),
(1, 22000.00, 4, 79),
(2, 8500.00, 5, 79),
(2, 8500.00, 5, 80),
(1, 12000.00, 6, 80),
(3, 12000.00, 6, 81),
(2, 15600.00, 7, 81),
(1, 15600.00, 7, 82),
(1, 11900.00, 8, 82),
(2, 11900.00, 8, 83),
(2, 15000.00, 1, 83),
(3, 15000.00, 1, 84),
(1, 65000.00, 2, 84),
(1, 65000.00, 2, 85),
(2, 3500.00, 3, 85),
(2, 3500.00, 3, 86),
(1, 22000.00, 4, 86),
(3, 22000.00, 4, 87),
(2, 8500.00, 5, 87),
(1, 8500.00, 5, 88),
(1, 12000.00, 6, 88),
(2, 12000.00, 6, 89),
(2, 15600.00, 7, 89),
(3, 15600.00, 7, 90),
(1, 11900.00, 8, 90),
(1, 11900.00, 8, 91),
(2, 15000.00, 1, 91),
(2, 15000.00, 1, 92),
(1, 65000.00, 2, 92),
(3, 65000.00, 2, 93),
(2, 3500.00, 3, 93),
(1, 3500.00, 3, 94),
(1, 22000.00, 4, 94),
(2, 22000.00, 4, 95),
(2, 8500.00, 5, 95),
(3, 8500.00, 5, 96),
(1, 12000.00, 6, 96),
(1, 12000.00, 6, 97),
(2, 15600.00, 7, 97),
(2, 15600.00, 7, 98),
(1, 11900.00, 8, 98),
(3, 11900.00, 8, 99),
(2, 15000.00, 1, 99),
(1, 15000.00, 1, 100),
(1, 65000.00, 2, 100);    

-- Verificacion: muestra los detalles cargados
SELECT * FROM DETALLE_VENTA ORDER BY id_detalle ASC;

-- Prueba de Restriccion CHECK (esto DEBE tirar error).
-- Se intenta registrar una cantidad igual a cero.
INSERT INTO DETALLE_VENTA (
    cantidad,
    precio_unitario_catalogo,
    id_producto,
    id_venta
) VALUES
(0, 15000.00, 1, 1);

-- Prueba de Restriccion FOREIGN KEY (esto DEBE tirar error).
-- Se utiliza un id_producto inexistente.
INSERT INTO DETALLE_VENTA (
    cantidad,
    precio_unitario_catalogo,
    id_producto,
    id_venta
) VALUES
(1, 15000.00, 999, 1);

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
(25500.00, 3, 4),
(79200.00, 4, 1),
(134260.00, 5, 2),
(31525.00, 6, 3),
(37440.00, 7, 4),
(27550.00, 8, 5),
(63168.00, 9, 1),
(25575.00, 10, 2),
(49496.00, 11, 3),
(100100.00, 12, 4),
(64800.00, 13, 5),
(29000.00, 14, 1),
(82170.00, 15, 2),
(20090.00, 16, 3),
(53544.00, 17, 4),
(56352.00, 18, 5),
(39805.00, 19, 1),
(89300.00, 20, 2),
(187860.00, 21, 3),
(23460.00, 22, 4),
(55510.00, 23, 5),
(33750.00, 24, 1),
(43200.00, 25, 2),
(42669.00, 26, 3),
(64386.00, 27, 4),
(77600.00, 28, 5),
(131520.00, 29, 1),
(30875.00, 30, 2),
(36660.00, 31, 3),
(26970.00, 32, 4),
(61824.00, 33, 5),
(25025.00, 34, 1),
(48420.00, 35, 2),
(110000.00, 36, 3),
(71280.00, 37, 4),
(28420.00, 38, 5),
(80510.00, 39, 1),
(19680.00, 40, 2),
(52440.00, 41, 3),
(55178.00, 42, 4),
(38967.00, 43, 5),
(87400.00, 44, 1),
(183820.00, 45, 2),
(22950.00, 46, 3),
(61000.00, 47, 4),
(37125.00, 48, 5),
(42336.00, 49, 1),
(41807.00, 50, 2),
(63072.00, 51, 3),
(76000.00, 52, 4),
(128780.00, 53, 5),
(30225.00, 54, 1),
(35880.00, 55, 2),
(26390.00, 56, 3),
(60480.00, 57, 4),
(27500.00, 58, 5),
(53262.00, 59, 1),
(107800.00, 60, 2),
(69840.00, 61, 3),
(27840.00, 62, 4),
(78850.00, 63, 5),
(19270.00, 64, 1),
(51336.00, 65, 2),
(54004.00, 66, 3),
(38129.00, 67, 4),
(85500.00, 68, 5),
(202000.00, 69, 1),
(25245.00, 70, 2),
(59780.00, 71, 3),
(36375.00, 72, 4),
(41472.00, 73, 5),
(40945.00, 74, 1),
(61758.00, 75, 2),
(74400.00, 76, 3),
(126040.00, 77, 4),
(29575.00, 78, 5),
(35100.00, 79, 1),
(29000.00, 80, 2),
(66528.00, 81, 3),
(26950.00, 82, 4),
(52186.00, 83, 5),
(105600.00, 84, 1),
(68400.00, 85, 2),
(27260.00, 86, 3),
(77190.00, 87, 4),
(18860.00, 88, 5),
(50232.00, 89, 1),
(52830.00, 90, 2),
(41900.00, 91, 3),
(94050.00, 92, 4),
(197960.00, 93, 5),
(24735.00, 94, 1),
(58560.00, 95, 2),
(35625.00, 96, 3),
(40608.00, 97, 4),
(40083.00, 98, 5),
(60444.00, 99, 1),
(72800.00, 100, 2);    

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
-- SUCURSAL_TELEFONO: 2 telefonos por cada una de las 3 sucursales.
-- ============================================================
INSERT INTO SUCURSAL_TELEFONO (telefono, id_sucursal) VALUES
('3794100001', 1),
('3794100002', 1),
('3794200001', 2),
('3794200002', 2),
('3794300001', 3),
('3794300002', 3);

SELECT COUNT(*) AS cantidad_telefonos_sucursales FROM SUCURSAL_TELEFONO;
SELECT * FROM SUCURSAL_TELEFONO ORDER BY id_sucursal ASC, telefono ASC;


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- CLIENTE_TELEFONO: un telefono por cada uno de los 300 clientes.
-- ============================================================
INSERT INTO CLIENTE_TELEFONO (telefono, id_cliente) VALUES
('3795000001', 1),
('3795000002', 2),
('3795000003', 3),
('3795000004', 4),
('3795000005', 5),
('3795000006', 6),
('3795000007', 7),
('3795000008', 8),
('3795000009', 9),
('3795000010', 10),
('3795000011', 11),
('3795000012', 12),
('3795000013', 13),
('3795000014', 14),
('3795000015', 15),
('3795000016', 16),
('3795000017', 17),
('3795000018', 18),
('3795000019', 19),
('3795000020', 20),
('3795000021', 21),
('3795000022', 22),
('3795000023', 23),
('3795000024', 24),
('3795000025', 25),
('3795000026', 26),
('3795000027', 27),
('3795000028', 28),
('3795000029', 29),
('3795000030', 30),
('3795000031', 31),
('3795000032', 32),
('3795000033', 33),
('3795000034', 34),
('3795000035', 35),
('3795000036', 36),
('3795000037', 37),
('3795000038', 38),
('3795000039', 39),
('3795000040', 40),
('3795000041', 41),
('3795000042', 42),
('3795000043', 43),
('3795000044', 44),
('3795000045', 45),
('3795000046', 46),
('3795000047', 47),
('3795000048', 48),
('3795000049', 49),
('3795000050', 50),
('3795000051', 51),
('3795000052', 52),
('3795000053', 53),
('3795000054', 54),
('3795000055', 55),
('3795000056', 56),
('3795000057', 57),
('3795000058', 58),
('3795000059', 59),
('3795000060', 60),
('3795000061', 61),
('3795000062', 62),
('3795000063', 63),
('3795000064', 64),
('3795000065', 65),
('3795000066', 66),
('3795000067', 67),
('3795000068', 68),
('3795000069', 69),
('3795000070', 70),
('3795000071', 71),
('3795000072', 72),
('3795000073', 73),
('3795000074', 74),
('3795000075', 75),
('3795000076', 76),
('3795000077', 77),
('3795000078', 78),
('3795000079', 79),
('3795000080', 80),
('3795000081', 81),
('3795000082', 82),
('3795000083', 83),
('3795000084', 84),
('3795000085', 85),
('3795000086', 86),
('3795000087', 87),
('3795000088', 88),
('3795000089', 89),
('3795000090', 90),
('3795000091', 91),
('3795000092', 92),
('3795000093', 93),
('3795000094', 94),
('3795000095', 95),
('3795000096', 96),
('3795000097', 97),
('3795000098', 98),
('3795000099', 99),
('3795000100', 100),
('3795000101', 101),
('3795000102', 102),
('3795000103', 103),
('3795000104', 104),
('3795000105', 105),
('3795000106', 106),
('3795000107', 107),
('3795000108', 108),
('3795000109', 109),
('3795000110', 110),
('3795000111', 111),
('3795000112', 112),
('3795000113', 113),
('3795000114', 114),
('3795000115', 115),
('3795000116', 116),
('3795000117', 117),
('3795000118', 118),
('3795000119', 119),
('3795000120', 120),
('3795000121', 121),
('3795000122', 122),
('3795000123', 123),
('3795000124', 124),
('3795000125', 125),
('3795000126', 126),
('3795000127', 127),
('3795000128', 128),
('3795000129', 129),
('3795000130', 130),
('3795000131', 131),
('3795000132', 132),
('3795000133', 133),
('3795000134', 134),
('3795000135', 135),
('3795000136', 136),
('3795000137', 137),
('3795000138', 138),
('3795000139', 139),
('3795000140', 140),
('3795000141', 141),
('3795000142', 142),
('3795000143', 143),
('3795000144', 144),
('3795000145', 145),
('3795000146', 146),
('3795000147', 147),
('3795000148', 148),
('3795000149', 149),
('3795000150', 150),
('3795000151', 151),
('3795000152', 152),
('3795000153', 153),
('3795000154', 154),
('3795000155', 155),
('3795000156', 156),
('3795000157', 157),
('3795000158', 158),
('3795000159', 159),
('3795000160', 160),
('3795000161', 161),
('3795000162', 162),
('3795000163', 163),
('3795000164', 164),
('3795000165', 165),
('3795000166', 166),
('3795000167', 167),
('3795000168', 168),
('3795000169', 169),
('3795000170', 170),
('3795000171', 171),
('3795000172', 172),
('3795000173', 173),
('3795000174', 174),
('3795000175', 175),
('3795000176', 176),
('3795000177', 177),
('3795000178', 178),
('3795000179', 179),
('3795000180', 180),
('3795000181', 181),
('3795000182', 182),
('3795000183', 183),
('3795000184', 184),
('3795000185', 185),
('3795000186', 186),
('3795000187', 187),
('3795000188', 188),
('3795000189', 189),
('3795000190', 190),
('3795000191', 191),
('3795000192', 192),
('3795000193', 193),
('3795000194', 194),
('3795000195', 195),
('3795000196', 196),
('3795000197', 197),
('3795000198', 198),
('3795000199', 199),
('3795000200', 200),
('3795000201', 201),
('3795000202', 202),
('3795000203', 203),
('3795000204', 204),
('3795000205', 205),
('3795000206', 206),
('3795000207', 207),
('3795000208', 208),
('3795000209', 209),
('3795000210', 210),
('3795000211', 211),
('3795000212', 212),
('3795000213', 213),
('3795000214', 214),
('3795000215', 215),
('3795000216', 216),
('3795000217', 217),
('3795000218', 218),
('3795000219', 219),
('3795000220', 220),
('3795000221', 221),
('3795000222', 222),
('3795000223', 223),
('3795000224', 224),
('3795000225', 225),
('3795000226', 226),
('3795000227', 227),
('3795000228', 228),
('3795000229', 229),
('3795000230', 230),
('3795000231', 231),
('3795000232', 232),
('3795000233', 233),
('3795000234', 234),
('3795000235', 235),
('3795000236', 236),
('3795000237', 237),
('3795000238', 238),
('3795000239', 239),
('3795000240', 240),
('3795000241', 241),
('3795000242', 242),
('3795000243', 243),
('3795000244', 244),
('3795000245', 245),
('3795000246', 246),
('3795000247', 247),
('3795000248', 248),
('3795000249', 249),
('3795000250', 250),
('3795000251', 251),
('3795000252', 252),
('3795000253', 253),
('3795000254', 254),
('3795000255', 255),
('3795000256', 256),
('3795000257', 257),
('3795000258', 258),
('3795000259', 259),
('3795000260', 260),
('3795000261', 261),
('3795000262', 262),
('3795000263', 263),
('3795000264', 264),
('3795000265', 265),
('3795000266', 266),
('3795000267', 267),
('3795000268', 268),
('3795000269', 269),
('3795000270', 270),
('3795000271', 271),
('3795000272', 272),
('3795000273', 273),
('3795000274', 274),
('3795000275', 275),
('3795000276', 276),
('3795000277', 277),
('3795000278', 278),
('3795000279', 279),
('3795000280', 280),
('3795000281', 281),
('3795000282', 282),
('3795000283', 283),
('3795000284', 284),
('3795000285', 285),
('3795000286', 286),
('3795000287', 287),
('3795000288', 288),
('3795000289', 289),
('3795000290', 290),
('3795000291', 291),
('3795000292', 292),
('3795000293', 293),
('3795000294', 294),
('3795000295', 295),
('3795000296', 296),
('3795000297', 297),
('3795000298', 298),
('3795000299', 299),
('3795000300', 300);

SELECT COUNT(*) AS cantidad_telefonos_clientes FROM CLIENTE_TELEFONO;
SELECT * FROM CLIENTE_TELEFONO ORDER BY id_cliente ASC, telefono ASC;


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- USUARIO_TELEFONO: un telefono por cada uno de los 30 usuarios.
-- ============================================================
INSERT INTO USUARIO_TELEFONO (telefono, id_usuario) VALUES
('3796000001', 1),
('3796000002', 2),
('3796000003', 3),
('3796000004', 4),
('3796000005', 5),
('3796000006', 6),
('3796000007', 7),
('3796000008', 8),
('3796000009', 9),
('3796000010', 10),
('3796000011', 11),
('3796000012', 12),
('3796000013', 13),
('3796000014', 14),
('3796000015', 15),
('3796000016', 16),
('3796000017', 17),
('3796000018', 18),
('3796000019', 19),
('3796000020', 20),
('3796000021', 21),
('3796000022', 22),
('3796000023', 23),
('3796000024', 24),
('3796000025', 25),
('3796000026', 26),
('3796000027', 27),
('3796000028', 28),
('3796000029', 29),
('3796000030', 30);

SELECT COUNT(*) AS cantidad_telefonos_usuarios FROM USUARIO_TELEFONO;
SELECT * FROM USUARIO_TELEFONO ORDER BY id_usuario ASC, telefono ASC;
