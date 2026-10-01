CREATE TABLE PROVINCIA (
    id_provincia INT IDENTITY(1,1) NOT NULL,
    nombre_provincia VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT PK_PROVINCIA PRIMARY KEY (id_provincia)
);

CREATE TABLE PERFIL (
    id_perfil INT IDENTITY(1,1),
    nombre_perfil VARCHAR(50) NOT NULL UNIQUE,
    descripcion_perfil VARCHAR(100) NOT NULL,
    CONSTRAINT PK_PERFIL PRIMARY KEY (id_perfil)
);

CREATE TABLE CATEGORIA (
    id_categoria INT IDENTITY(1,1),
    nombre_cat VARCHAR(50) NOT NULL UNIQUE,
    descripcion_cat VARCHAR(100) NOT NULL,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria)
);

CREATE TABLE METODO_PAGO (
    id_metodo_pago INT IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(100) NOT NULL,
    CONSTRAINT PK_METODO_PAGO PRIMARY KEY (id_metodo_pago)
);

-- PRODUCTO: catalogo de productos de la ferreteria 
CREATE TABLE PRODUCTO (
    id_producto INT IDENTITY(1,1) NOT NULL,
    codigo_barra VARCHAR(50) NOT NULL UNIQUE,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    porcentaje_ganancia DECIMAL(5,2) NOT NULL CHECK (porcentaje_ganancia >= 0),
    id_categoria INT NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),
    CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);


-- LOCALIDAD: localidades pertenecientes a una provincia, usadas
-- en las direcciones del sistema (clientes, usuarios, sucursales).
CREATE TABLE LOCALIDAD (
    id_localidad INT IDENTITY(1,1) NOT NULL,
    nombre_localidad VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    id_provincia INT NOT NULL,
    CONSTRAINT PK_LOCALIDAD PRIMARY KEY (id_localidad),
    CONSTRAINT FK_LOCALIDAD_PROVINCIA FOREIGN KEY (id_provincia) REFERENCES PROVINCIA(id_provincia)
);

-- FUNCIONALIDAD: funcionalidades del sistema que pueden
-- habilitarse para cada perfil de usuario.
CREATE TABLE FUNCIONALIDAD (
    id_funcionalidad INT IDENTITY(1,1) NOT NULL,
    codigo_funcionalidad INT NOT NULL UNIQUE,
    nombre_funcionalidad VARCHAR(50) NOT NULL,
    descripcion_funcionalidad VARCHAR(150) NOT NULL,
    id_perfil INT NOT NULL,
    CONSTRAINT PK_FUNCIONALIDAD PRIMARY KEY (id_funcionalidad),
    CONSTRAINT FK_FUNCIONALIDAD_PERFIL FOREIGN KEY (id_perfil) REFERENCES PERFIL(id_perfil)
);
