-- ============================================================
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
('Añatuya', '3760', 16)
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
