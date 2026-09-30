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

