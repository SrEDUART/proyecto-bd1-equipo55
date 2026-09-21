# Modelo Relacional
*(primera version)*
# Modelo Relacional

# Tablas principales

 SUCURSAL
- id_sucursal (PK)
- nombre
- telefono
- id_direccion (FK)
- eliminado_en

#Usuarios y control de acceso

USUARIO
- id_usuario (PK)
- id_perfil (FK)
- id_sucursal (FK)
- id_direccion (FK)
- nombre
- apellido
- dni
- telefono
- nombre_usuario
- contraseña_hash
- correo
- sexo
- fecha_nacimiento
- eliminado_en

 PERFIL
- id_perfil (PK)
- nombre
- descripcion
- eliminado_en

 FUNCIONALIDAD
- id_funcionalidad (PK)
- codigo
- nombre
- descripcion
- eliminado_en

 PERFIL_FUNCIONALIDAD
- id_perfil (PK, FK)
- id_funcionalidad (PK, FK)

# Productos

 CATEGORIA
- id_categoria (PK)
- nombre
- descripcion
- eliminado_en

 PRODUCTO
- id_producto (PK)
- id_categoria (FK)
- codigo_barra
- nombre
- descripcion
- precio_costo
- porcentaje_ganancia
- precio_venta
- eliminado_en
# Ventas y pagos

* transformación a tablas de Venta, Detalle_Venta, Metodo_Pago y Pago, con sus claves primarias y foráneas

```sql
-- VENTA: registra cada operación de venta. Se relaciona con SUCURSAL dónde se
-- concretó, USUARIO (quién la atendió) y CLIENTE (a quién se le vendió, opcional).
-- subtotal/descuento/total se guardan calculados para conservar el importe
-- facturado de forma estable, sin depender de recalcular todo el detalle.
CREATE TABLE VENTA (
    id_venta        INT           IDENTITY(1,1) PRIMARY KEY,
    id_cliente      INT           NULL,        -- venta sin cliente asociado = consumidor final
    id_usuario      INT           NOT NULL,    -- vendedor/cajero que atendió
    id_sucursal     INT           NOT NULL,    -- sucursal donde se concretó
    fecha_hora      DATETIME      NOT NULL,
    tipo_factura    VARCHAR(10)   NOT NULL,
    subtotal        DECIMAL(12,2) NOT NULL,
    descuento       DECIMAL(12,2) NOT NULL DEFAULT 0,
    total           DECIMAL(12,2) NOT NULL,
    eliminado_en    DATETIME      NULL,        -- baja lógica (RN.08), no se borra la fila
    CONSTRAINT fk_venta_cliente  FOREIGN KEY (id_cliente)  REFERENCES CLIENTE(id_cliente),
    CONSTRAINT fk_venta_usuario  FOREIGN KEY (id_usuario)  REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_venta_sucursal FOREIGN KEY (id_sucursal) REFERENCES SUCURSAL(id_sucursal)
);
```
#DETALLE_VENTA
```sql
-- DETALLE_VENTA: una fila por cada producto incluido en una venta (resuelve la
-- relación N:M entre VENTA y PRODUCTO). precio_unitario es una COPIA del precio
-- al momento de vender (RN.04): si después cambia el precio del producto en el
-- catálogo, esta venta ya registrada no se ve afectada.
CREATE TABLE DETALLE_VENTA (
    id_detalle_venta INT           IDENTITY(1,1) PRIMARY KEY,
    id_venta          INT           NOT NULL,
    id_producto       INT           NOT NULL,
    cantidad          INT           NOT NULL,
    precio_unitario   DECIMAL(12,2) NOT NULL,  -- snapshot histórico, no se recalcula desde PRODUCTO
    subtotal          DECIMAL(12,2) NOT NULL,
    eliminado_en      DATETIME      NULL,
    CONSTRAINT fk_detalle_venta    FOREIGN KEY (id_venta)    REFERENCES VENTA(id_venta),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    CONSTRAINT ck_cantidad_positiva CHECK (cantidad > 0)
    -- La validación de que "cantidad" no supere el stock (RN.01) se controla a nivel
    -- de aplicación contra INVENTARIO, porque involucra otra tabla (no es un simple CHECK).
);
```
#METODO_PAGO
```sql
-- METODO_PAGO: catálogo fijo de formas de pago disponibles (efectivo, débito,
-- crédito, transferencia, etc.). Tabla aparte para no repetir nombre/descripcion
-- en cada pago registrado.
CREATE TABLE METODO_PAGO (
    id_metodo_pago INT          IDENTITY(1,1) PRIMARY KEY,
    nombre         VARCHAR(30)  NOT NULL,
    descripcion    VARCHAR(100) NULL,
    eliminado_en   DATETIME     NULL
);
```
