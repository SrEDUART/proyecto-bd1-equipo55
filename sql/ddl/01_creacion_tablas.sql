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

-- PRODUCTO: catalogo de productos de la ferreteria (Integrante 3)
CREATE TABLE PRODUCTO (
    id_producto INT IDENTITY(1,1),
    codigo_barra VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    porcentaje_ganancia DECIMAL(5,2) NOT NULL CHECK (porcentaje_ganancia >= 0),
    id_categoria INT NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),
    CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);
