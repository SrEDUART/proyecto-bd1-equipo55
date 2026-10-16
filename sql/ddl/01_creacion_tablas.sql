-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PROVINCIA: listado de provincias utilizadas en las direcciones
-- del sistema.
-- ============================================================
CREATE TABLE PROVINCIA (
    id_provincia INT IDENTITY(1,1) NOT NULL,
    nombre_provincia VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT PK_PROVINCIA PRIMARY KEY (id_provincia)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PERFIL: roles de usuario utilizados para definir los permisos
-- y funcionalidades disponibles dentro del sistema.
-- ============================================================
CREATE TABLE PERFIL (
    id_perfil INT IDENTITY(1,1) NOT NULL,
    nombre_perfil VARCHAR(50) NOT NULL UNIQUE,
    descripcion_perfil VARCHAR(100) NOT NULL,
    eliminado_en DATETIME NULL,
    CONSTRAINT PK_PERFIL PRIMARY KEY (id_perfil)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- CATEGORIA: categorias utilizadas para agrupar los productos
-- comercializados por la ferreteria.
-- ============================================================
CREATE TABLE CATEGORIA (
    id_categoria INT IDENTITY(1,1) NOT NULL,
    nombre_cat VARCHAR(50) NOT NULL UNIQUE,
    descripcion_cat VARCHAR(100) NOT NULL,
    eliminado_en DATETIME NULL,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- METODO_PAGO: formas de pago disponibles para registrar
-- los cobros asociados a las ventas.
-- ============================================================
CREATE TABLE METODO_PAGO (
    id_metodo_pago INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(100) NOT NULL,
    eliminado_en DATETIME NULL,
    CONSTRAINT PK_METODO_PAGO PRIMARY KEY (id_metodo_pago)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PRODUCTO: catalogo de productos de la ferreteria.
-- El precio de venta se calcula automaticamente a partir del
-- precio de costo y el porcentaje de ganancia.
-- ============================================================
CREATE TABLE PRODUCTO (
    id_producto INT IDENTITY(1,1) NOT NULL,
    codigo_barra VARCHAR(50) NOT NULL UNIQUE,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    precio_costo DECIMAL(10,2) NOT NULL CHECK (precio_costo > 0),
    porcentaje_ganancia DECIMAL(5,2) NOT NULL CHECK (porcentaje_ganancia >= 0),

    precio_venta AS
        CAST(
            precio_costo * (1 + porcentaje_ganancia / 100.0)
            AS DECIMAL(10,2)
        ) PERSISTED,

    id_categoria INT NOT NULL,
    eliminado_en DATETIME NULL,

    CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),
    CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- LOCALIDAD: localidades pertenecientes a una provincia, usadas
-- en las direcciones de clientes, usuarios y sucursales.
-- ============================================================
CREATE TABLE LOCALIDAD (
    id_localidad INT IDENTITY(1,1) NOT NULL,
    nombre_localidad VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    id_provincia INT NOT NULL,

    CONSTRAINT PK_LOCALIDAD PRIMARY KEY (id_localidad),
    CONSTRAINT FK_LOCALIDAD_PROVINCIA FOREIGN KEY (id_provincia) REFERENCES PROVINCIA(id_provincia)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- FUNCIONALIDAD: operaciones disponibles dentro del sistema.
-- Las funcionalidades no pertenecen directamente a un perfil.
-- La relacion se resuelve mediante PERFIL_FUNCIONALIDAD.
-- ============================================================
CREATE TABLE FUNCIONALIDAD (
    id_funcionalidad INT IDENTITY(1,1) NOT NULL,
    codigo_funcionalidad INT NOT NULL UNIQUE,
    nombre_funcionalidad VARCHAR(50) NOT NULL,
    descripcion_funcionalidad VARCHAR(150) NOT NULL,
    eliminado_en DATETIME NULL,

    CONSTRAINT PK_FUNCIONALIDAD PRIMARY KEY (id_funcionalidad)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PERFIL_FUNCIONALIDAD: tabla intermedia que resuelve la relacion
-- muchos a muchos entre PERFIL y FUNCIONALIDAD.
--
-- Un perfil puede tener varias funcionalidades y una misma
-- funcionalidad puede ser utilizada por varios perfiles.
-- ============================================================
CREATE TABLE PERFIL_FUNCIONALIDAD (
    id_perfil INT NOT NULL,
    id_funcionalidad INT NOT NULL,

    CONSTRAINT PK_PERFIL_FUNCIONALIDAD PRIMARY KEY (id_perfil, id_funcionalidad),

    CONSTRAINT FK_PERFIL_FUNCIONALIDAD_PERFIL
        FOREIGN KEY (id_perfil)
        REFERENCES PERFIL(id_perfil),

    CONSTRAINT FK_PERFIL_FUNCIONALIDAD_FUNCIONALIDAD
        FOREIGN KEY (id_funcionalidad)
        REFERENCES FUNCIONALIDAD(id_funcionalidad)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- DIRECCION: direcciones de clientes, usuarios y sucursales.
-- ============================================================
CREATE TABLE DIRECCION (
    id_direccion INT IDENTITY(1,1) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    altura INT NOT NULL CHECK (altura > 0),
    id_localidad INT NOT NULL,

    CONSTRAINT PK_DIRECCION PRIMARY KEY (id_direccion),
    CONSTRAINT FK_DIRECCION_LOCALIDAD FOREIGN KEY (id_localidad) REFERENCES LOCALIDAD(id_localidad)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- CLIENTE: datos principales de los clientes de la ferreteria.
-- El DNI y el correo deben ser unicos.
-- ============================================================
CREATE TABLE CLIENTE (
    id_cliente INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni INT NOT NULL UNIQUE,
    correo VARCHAR(100) NOT NULL UNIQUE,
    id_direccion INT NOT NULL,
    eliminado_en DATETIME NULL,

    CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente),
    CONSTRAINT FK_CLIENTE_DIRECCION FOREIGN KEY (id_direccion) REFERENCES DIRECCION(id_direccion)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- SUCURSAL: sucursales de la ferreteria.
-- Cada sucursal posee una direccion y administra su propio
-- inventario, usuarios y ventas.
-- ============================================================
CREATE TABLE SUCURSAL (
    id_sucursal INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    id_direccion INT NOT NULL,
    eliminado_en DATETIME NULL,

    CONSTRAINT PK_SUCURSAL PRIMARY KEY (id_sucursal),
    CONSTRAINT FK_SUCURSAL_DIRECCION FOREIGN KEY (id_direccion) REFERENCES DIRECCION(id_direccion)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- USUARIO: usuarios internos que operan el sistema.
-- Cada usuario pertenece a un perfil y a una sucursal.
-- ============================================================
CREATE TABLE USUARIO (
    id_usuario INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni INT NOT NULL UNIQUE,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    contraseña_hash VARCHAR(255) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,

    id_direccion INT NOT NULL,
    id_perfil INT NOT NULL,
    id_sucursal INT NOT NULL,

    eliminado_en DATETIME NULL,

    CONSTRAINT PK_USUARIO PRIMARY KEY (id_usuario),

    CONSTRAINT FK_USUARIO_DIRECCION
        FOREIGN KEY (id_direccion)
        REFERENCES DIRECCION(id_direccion),

    CONSTRAINT FK_USUARIO_PERFIL
        FOREIGN KEY (id_perfil)
        REFERENCES PERFIL(id_perfil),

    CONSTRAINT FK_USUARIO_SUCURSAL
        FOREIGN KEY (id_sucursal)
        REFERENCES SUCURSAL(id_sucursal)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- INVENTARIO: control de stock de cada producto por sucursal.
-- Un producto solo puede tener un registro de inventario por
-- cada sucursal.
-- ============================================================
CREATE TABLE INVENTARIO (
    id_inventario INT IDENTITY(1,1) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    stock_minimo INT NOT NULL CHECK (stock_minimo >= 0),
    id_producto INT NOT NULL,
    id_sucursal INT NOT NULL,

    CONSTRAINT PK_INVENTARIO PRIMARY KEY (id_inventario),

    CONSTRAINT UQ_INVENTARIO_PRODUCTO_SUCURSAL
        UNIQUE (id_producto, id_sucursal),

    CONSTRAINT FK_INVENTARIO_PRODUCTO
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto),

    CONSTRAINT FK_INVENTARIO_SUCURSAL
        FOREIGN KEY (id_sucursal)
        REFERENCES SUCURSAL(id_sucursal)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- VENTA: encabezado de cada operacion de venta.
-- La venta se realiza en una sucursal, es atendida por un usuario
-- y puede estar asociada o no a un cliente registrado.
-- ============================================================
CREATE TABLE VENTA (
    id_venta INT IDENTITY(1,1) NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT GETDATE(),
    tipo_factura VARCHAR(10) NOT NULL CHECK (tipo_factura IN ('A', 'B', 'C')),
    descuento DECIMAL(5,2) NOT NULL DEFAULT 0.00 CHECK (descuento BETWEEN 0 AND 100),

    id_sucursal INT NOT NULL,
    id_cliente INT NULL,
    id_usuario INT NOT NULL,

    CONSTRAINT PK_VENTA PRIMARY KEY (id_venta),

    CONSTRAINT FK_VENTA_SUCURSAL
        FOREIGN KEY (id_sucursal)
        REFERENCES SUCURSAL(id_sucursal),

    CONSTRAINT FK_VENTA_CLIENTE
        FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE(id_cliente),

    CONSTRAINT FK_VENTA_USUARIO
        FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- DETALLE_VENTA: productos incluidos en una venta.
-- El precio unitario se guarda como copia del precio utilizado
-- al momento de realizar la operacion para conservar el historial.
-- ============================================================
CREATE TABLE DETALLE_VENTA (
    id_detalle INT IDENTITY(1,1) NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario_catalogo DECIMAL(10,2) NOT NULL CHECK (precio_unitario_catalogo > 0),

    id_producto INT NOT NULL,
    id_venta INT NOT NULL,

    CONSTRAINT PK_DETALLE_VENTA PRIMARY KEY (id_detalle),

    CONSTRAINT FK_DETALLE_PRODUCTO
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto),

    CONSTRAINT FK_DETALLE_VENTA
        FOREIGN KEY (id_venta)
        REFERENCES VENTA(id_venta)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- PAGO: pagos asociados a las ventas.
-- Una misma venta puede tener uno o varios registros de pago,
-- permitiendo utilizar distintos metodos de pago.
-- ============================================================
CREATE TABLE PAGO (
    id_pago INT IDENTITY(1,1) NOT NULL,
    monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),

    id_venta INT NOT NULL,
    id_metodo_pago INT NOT NULL,

    CONSTRAINT PK_PAGO PRIMARY KEY (id_pago),

    CONSTRAINT FK_PAGO_VENTA
        FOREIGN KEY (id_venta)
        REFERENCES VENTA(id_venta),

    CONSTRAINT FK_PAGO_METODO
        FOREIGN KEY (id_metodo_pago)
        REFERENCES METODO_PAGO(id_metodo_pago)
);


-- ============================================================
-- TABLAS DE TELEFONOS
--
-- Los telefonos se modelan como atributos multivaluados.
-- Cada cliente, usuario o sucursal puede tener uno o varios
-- numeros telefonicos.
-- ============================================================


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- SUCURSAL_TELEFONO: telefonos asociados a cada sucursal.
-- ============================================================
CREATE TABLE SUCURSAL_TELEFONO (
    telefono VARCHAR(20) NOT NULL,
    id_sucursal INT NOT NULL,

    CONSTRAINT PK_SUCURSAL_TELEFONO PRIMARY KEY (telefono, id_sucursal),

    CONSTRAINT FK_SUCURSAL_TELEFONO_SUCURSAL
        FOREIGN KEY (id_sucursal)
        REFERENCES SUCURSAL(id_sucursal)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- CLIENTE_TELEFONO: telefonos asociados a cada cliente.
-- ============================================================
CREATE TABLE CLIENTE_TELEFONO (
    telefono VARCHAR(20) NOT NULL,
    id_cliente INT NOT NULL,

    CONSTRAINT PK_CLIENTE_TELEFONO PRIMARY KEY (telefono, id_cliente),

    CONSTRAINT FK_CLIENTE_TELEFONO_CLIENTE
        FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE(id_cliente)
);


-- ========================================================================================================================================================
-- ========================================================================================================================================================
-- USUARIO_TELEFONO: telefonos asociados a cada usuario.
-- ============================================================
CREATE TABLE USUARIO_TELEFONO (
    telefono VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,

    CONSTRAINT PK_USUARIO_TELEFONO PRIMARY KEY (telefono, id_usuario),

    CONSTRAINT FK_USUARIO_TELEFONO_USUARIO
        FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
);
