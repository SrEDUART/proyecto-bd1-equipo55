# 🧰 Proyecto BD1 — Equipo 55

# 🏪 Sistema de Gestión Comercial para Ferretería Multisucursal

**Proyecto Integrador — Bases de Datos I**

![Materia](https://img.shields.io/badge/Materia-Bases%20de%20Datos%20I-blue)
![Equipo](https://img.shields.io/badge/Equipo-55-green)
![SQL](https://img.shields.io/badge/SQL-T--SQL-orange)
![Estado](https://img.shields.io/badge/Estado-En%20desarrollo-yellow)

---

## 📑 Índice

- [📌 Presentación y contexto](#-presentación-y-contexto)
- [❗ Problemática](#-problemática)
- [💡 Solución propuesta](#-solución-propuesta)
- [🎯 Objetivo general](#-objetivo-general)
- [🎯 Objetivos específicos](#-objetivos-específicos)
- [📦 Alcance del sistema](#-alcance-del-sistema)
- [🚫 Fuera del alcance](#-fuera-del-alcance)
- [🧱 Modelo de negocio](#-modelo-de-negocio)
- [📋 Reglas de negocio](#-reglas-de-negocio)
- [🗂️ Modelo de datos](#️-modelo-de-datos)
- [🔗 Relaciones principales](#-relaciones-principales)
- [💰 Productos y precios](#-productos-y-precios)
- [📦 Gestión de inventario](#-gestión-de-inventario)
- [👤 Gestión de clientes](#-gestión-de-clientes)
- [🧑‍💼 Gestión de usuarios](#-gestión-de-usuarios)
- [🔐 Perfiles y funcionalidades](#-perfiles-y-funcionalidades)
- [🧾 Gestión de ventas](#-gestión-de-ventas)
- [🛒 Detalle de venta](#-detalle-de-venta)
- [🕒 Historial de precios](#-historial-de-precios)
- [💳 Métodos de pago](#-métodos-de-pago)
- [💵 Pagos combinados](#-pagos-combinados)
- [☎️ Atributos multivaluados](#️-atributos-multivaluados)
- [🌎 Gestión de ubicaciones](#-gestión-de-ubicaciones)
- [⚙️ Restricciones de integridad](#️-restricciones-de-integridad)
- [🧩 Decisiones de diseño](#-decisiones-de-diseño)
- [🧮 Normalización](#-normalización)
- [🧱 Implementación física](#-implementación-física)
- [💾 DDL](#-ddl)
- [📥 DML](#-dml)
- [🧪 Datos de prueba](#-datos-de-prueba)
- [🔄 Cargas alternativas con WHILE](#-cargas-alternativas-con-while)
- [✅ Pruebas de restricciones](#-pruebas-de-restricciones)
- [✏️ Ejemplos de UPDATE](#️-ejemplos-de-update)
- [⚠️ Reglas que requieren lógica adicional](#️-reglas-que-requieren-lógica-adicional)
- [📚 Etapas del proyecto](#-etapas-del-proyecto)
- [📁 Estructura del repositorio](#-estructura-del-repositorio)
- [▶️ Ejecución del proyecto](#️-ejecución-del-proyecto)
- [📊 Flujo general de una venta](#-flujo-general-de-una-venta)
- [📊 Flujo general del inventario](#-flujo-general-del-inventario)
- [🧠 Conceptos de Bases de Datos aplicados](#-conceptos-de-bases-de-datos-aplicados)
- [📌 Estado actual del proyecto](#-estado-actual-del-proyecto)
- [👥 Integrantes](#-integrantes)
- [🎓 Información académica](#-información-académica)

---

## 📌 Presentación y contexto

El presente proyecto consiste en el análisis, diseño, normalización e implementación de una **base de datos relacional para la gestión comercial de una ferretería multisucursal**.

La organización trabaja mediante distintas sucursales ubicadas en diferentes localidades y necesita centralizar la información relacionada con sus operaciones comerciales.

El sistema fue pensado para representar y relacionar información correspondiente a:

- sucursales;
- provincias, localidades y direcciones;
- usuarios internos;
- perfiles y funcionalidades;
- clientes;
- productos;
- categorías;
- inventario;
- ventas;
- detalles de venta;
- métodos de pago;
- pagos;
- teléfonos asociados a clientes, usuarios y sucursales.

Cada sucursal administra su propio inventario y cuenta con usuarios internos responsables de operar el sistema.

Los productos se organizan mediante categorías y se identifican por un código de barras único. Cada producto posee además un precio de costo y un porcentaje de ganancia, a partir de los cuales se calcula automáticamente su precio de venta.

Las ventas quedan asociadas a una sucursal y a un usuario responsable. También pueden relacionarse con un cliente registrado.

Cada venta puede contener varios productos y utilizar uno o varios métodos de pago.

El proyecto fue desarrollado para la asignatura **Bases de Datos I**, correspondiente a la carrera **Licenciatura en Sistemas de Información**.

---

## ❗ Problemática

La gestión de una ferretería con múltiples sucursales presenta diferentes dificultades cuando la información se administra de manera independiente o sin una estructura centralizada.

Entre los principales problemas identificados se encuentran:

- dificultad para conocer el stock disponible de cada producto en cada sucursal;
- posibilidad de registrar información duplicada;
- falta de trazabilidad de las operaciones;
- dificultad para relacionar cada venta con el empleado que la realizó;
- dificultad para mantener información centralizada de clientes;
- inconsistencias entre productos, categorías e inventario;
- pérdida del precio histórico utilizado en una venta si posteriormente cambia el precio del producto;
- dificultad para administrar distintos métodos de pago;
- falta de control sobre qué operaciones puede realizar cada usuario;
- dificultad para consultar información consolidada de distintas sucursales.

Un mismo producto puede encontrarse disponible en diferentes cantidades según la sucursal.

Ejemplo:

```text
Producto: Martillo carpintero

Sucursal Centro     → Stock: 50
Sucursal Goya       → Stock: 20
Sucursal Mercedes   → Stock: 15
```

Por este motivo, el stock no se almacena directamente dentro de `PRODUCTO`, sino mediante la entidad:

```text
INVENTARIO
```

que relaciona:

```text
PRODUCTO + SUCURSAL
```

---

## 💡 Solución propuesta

Se propone implementar una base de datos relacional que centralice la información comercial de la ferretería.

La solución contempla cuatro grandes áreas:

### Gestión comercial

- clientes;
- productos;
- ventas;
- detalle de ventas;
- métodos de pago;
- pagos.

### Gestión de inventario

- stock actual;
- stock mínimo;
- disponibilidad de productos;
- inventario independiente por sucursal.

### Gestión interna

- usuarios;
- perfiles;
- funcionalidades;
- sucursales.

### Gestión geográfica

- provincias;
- localidades;
- direcciones.

La base de datos integra todas estas áreas en un único modelo relacional.

---

## 🎯 Objetivo general

Diseñar e implementar una base de datos relacional que permita representar de forma consistente las operaciones principales de una ferretería multisucursal.

---

## 🎯 Objetivos específicos

1. Analizar el dominio del negocio y determinar las entidades necesarias.
2. Identificar los atributos correspondientes a cada entidad.
3. Definir las relaciones existentes entre las entidades.
4. Establecer las reglas de negocio.
5. Construir el modelo conceptual mediante un Diagrama Entidad-Relación.
6. Transformar el modelo conceptual al modelo relacional.
7. Definir claves primarias y claves foráneas.
8. Aplicar restricciones de integridad.
9. Analizar y aplicar normalización.
10. Representar atributos multivaluados mediante estructuras adecuadas.
11. Implementar físicamente el modelo utilizando SQL.
12. Poblar la base de datos con datos de prueba.
13. Verificar claves, relaciones y restricciones.
14. Organizar la documentación del proyecto por etapas.

---

## 📦 Alcance del sistema

| Área | Descripción |
|---|---|
| **Provincias** | Registro de provincias utilizadas en las direcciones. |
| **Localidades** | Registro de localidades pertenecientes a una provincia. |
| **Direcciones** | Direcciones de clientes, usuarios y sucursales. |
| **Sucursales** | Administración de las distintas sucursales. |
| **Productos** | Registro del catálogo de productos comercializados. |
| **Categorías** | Clasificación de productos por rubro. |
| **Inventario** | Control del stock por producto y sucursal. |
| **Clientes** | Registro y administración de clientes. |
| **Usuarios** | Registro de usuarios internos. |
| **Perfiles** | Definición de roles. |
| **Funcionalidades** | Definición de operaciones disponibles para los perfiles. |
| **Ventas** | Registro de operaciones comerciales. |
| **Detalle de venta** | Productos, cantidades y precios de cada venta. |
| **Métodos de pago** | Formas de pago disponibles. |
| **Pagos** | Registro de uno o varios pagos por venta. |
| **Teléfonos** | Múltiples teléfonos para clientes, usuarios y sucursales. |

---

## 🚫 Fuera del alcance

Actualmente quedan fuera del alcance:

- facturación electrónica ante organismos fiscales;
- integración con AFIP;
- comercio electrónico;
- aplicaciones móviles para clientes;
- gestión integral de proveedores;
- compras a proveedores;
- logística de reposición entre sucursales;
- sistemas contables externos.

---

## 🧱 Modelo de negocio

La ferretería trabaja con múltiples sucursales.

Cada sucursal:

- posee una dirección;
- puede tener varios teléfonos;
- tiene usuarios asignados;
- administra su propio inventario;
- registra ventas.

Los productos pertenecen a categorías como:

```text
Herramientas
Herramientas Electricas
Buloneria y Fijaciones
Pintureria
Electricidad
Plomeria y Agua
Jardineria y Camping
Seguridad Industrial
```

Cada producto posee:

```text
codigo_barra
nombre_producto
descripcion
precio_costo
porcentaje_ganancia
precio_venta
categoria
```

---

## 📋 Reglas de negocio

### RN.01 — Gestión de Stock

Cada producto tiene un stock independiente por sucursal.

No se debe registrar una venta cuando la cantidad solicitada supera el stock disponible.

### RN.02 — Reposición por Stock Mínimo

Cada registro de inventario almacena:

```text
stock
stock_minimo
```

Cuando:

```text
stock <= stock_minimo
```

el producto puede considerarse pendiente de reposición.

### RN.03 — Registro de Clientes

Los clientes pueden registrarse con:

```text
nombre
apellido
dni
correo
direccion
telefonos
```

El DNI y el correo son únicos.

Una venta puede estar asociada a un cliente registrado o realizarse sin cliente asociado.

### RN.04 — Historial de Precios

El precio utilizado en una venta se almacena en:

```text
DETALLE_VENTA.precio_unitario_catalogo
```

Los cambios posteriores en `PRODUCTO` no alteran las ventas históricas.

### RN.05 — Métodos de Pago

Una venta puede tener uno o varios pagos asociados.

### RN.06 — Cálculo del Precio de Venta

```text
precio_venta =
precio_costo × (1 + porcentaje_ganancia / 100)
```

### RN.07 — Control de Acceso por Perfil

Cada usuario posee un perfil.

Cada perfil puede tener varias funcionalidades y una misma funcionalidad puede pertenecer a varios perfiles.

La relación se resuelve mediante:

```text
PERFIL_FUNCIONALIDAD
```

### RN.08 — Bajas Lógicas

Las entidades principales que requieren conservar información histórica utilizan:

```text
eliminado_en
```

---

## 🗂️ Modelo de datos

El modelo contiene actualmente **19 tablas**.

### Ubicación

```text
PROVINCIA
LOCALIDAD
DIRECCION
```

### Productos

```text
CATEGORIA
PRODUCTO
```

### Sucursales

```text
SUCURSAL
SUCURSAL_TELEFONO
```

### Clientes

```text
CLIENTE
CLIENTE_TELEFONO
```

### Usuarios y seguridad

```text
PERFIL
FUNCIONALIDAD
PERFIL_FUNCIONALIDAD
USUARIO
USUARIO_TELEFONO
```

### Inventario

```text
INVENTARIO
```

### Ventas

```text
VENTA
DETALLE_VENTA
```

### Pagos

```text
METODO_PAGO
PAGO
```

---

## 🔗 Relaciones principales

```text
PROVINCIA 1 ─── N LOCALIDAD
LOCALIDAD 1 ─── N DIRECCION

CATEGORIA 1 ─── N PRODUCTO

PERFIL N ─── M FUNCIONALIDAD
        mediante PERFIL_FUNCIONALIDAD

PERFIL 1 ─── N USUARIO
SUCURSAL 1 ─── N USUARIO

PRODUCTO 1 ─── N INVENTARIO
SUCURSAL 1 ─── N INVENTARIO

CLIENTE 1 ─── N VENTA
USUARIO 1 ─── N VENTA
SUCURSAL 1 ─── N VENTA

VENTA 1 ─── N DETALLE_VENTA
PRODUCTO 1 ─── N DETALLE_VENTA

VENTA 1 ─── N PAGO
METODO_PAGO 1 ─── N PAGO
```

---

## 💰 Productos y precios

Cada producto posee:

```text
codigo_barra
nombre_producto
descripcion
precio_costo
porcentaje_ganancia
precio_venta
categoria
```

El precio de venta se calcula automáticamente.

Ejemplo:

```text
Precio de costo: $10.000
Ganancia: 40 %

Precio de venta:
10.000 × 1,40 = $14.000
```

---

## 📦 Gestión de inventario

`INVENTARIO` relaciona:

```text
PRODUCTO
+
SUCURSAL
```

y almacena:

```text
stock
stock_minimo
id_producto
id_sucursal
```

La restricción:

```sql
UNIQUE (id_producto, id_sucursal)
```

evita duplicar el inventario de un mismo producto en una misma sucursal.

---

## 👤 Gestión de clientes

`CLIENTE` almacena:

```text
nombre
apellido
dni
correo
direccion
```

Además, los teléfonos se almacenan en:

```text
CLIENTE_TELEFONO
```

---

## 🧑‍💼 Gestión de usuarios

Cada usuario almacena:

```text
nombre
apellido
dni
nombre_usuario
contraseña_hash
correo
fecha_nacimiento
direccion
perfil
sucursal
```

Cada usuario pertenece a:

```text
1 PERFIL
1 SUCURSAL
```

---

## 🔐 Perfiles y funcionalidades

Entre los perfiles de prueba se encuentran:

```text
Administrador
Vendedor
Cajero
Encargado de Stock
Gerente de Sucursal
Auditor
Soporte Tecnico
Comprador
```

La relación entre perfiles y funcionalidades se implementa mediante:

```text
PERFIL_FUNCIONALIDAD
```

---

## 🧾 Gestión de ventas

Cada venta almacena:

```text
fecha_hora
tipo_factura
descuento
sucursal
cliente
usuario
```

El cliente puede ser opcional.

---

## 🛒 Detalle de venta

Una venta puede contener múltiples productos.

Cada detalle almacena:

```text
cantidad
precio_unitario_catalogo
producto
venta
```

Ejemplo:

```text
VENTA 1
├── 2 × Martillo carpintero
└── 1 × Amoladora angular
```

---

## 🕒 Historial de precios

Si un producto vale hoy:

```text
$15.000
```

y luego pasa a:

```text
$18.000
```

una venta antigua conserva el valor original gracias a:

```text
DETALLE_VENTA.precio_unitario_catalogo
```

---

## 💳 Métodos de pago

Métodos de prueba utilizados:

```text
Efectivo
Tarjeta de Debito
Tarjeta de Credito
Transferencia Bancaria
Mercado Pago QR
Cuenta Corriente
Cheque
```

---

## 💵 Pagos combinados

Una misma venta puede tener múltiples pagos.

Ejemplo:

```text
Venta: $100.000

Pago 1
Efectivo → $40.000

Pago 2
Tarjeta de Credito → $60.000
```

---

## ☎️ Atributos multivaluados

Los teléfonos se separan en:

```text
CLIENTE_TELEFONO
USUARIO_TELEFONO
SUCURSAL_TELEFONO
```

Esto evita guardar varios teléfonos dentro de una sola columna.

---

## 🌎 Gestión de ubicaciones

```text
PROVINCIA
    1
    |
    N
LOCALIDAD
    1
    |
    N
DIRECCION
```

Las direcciones son utilizadas por:

```text
CLIENTE
USUARIO
SUCURSAL
```

---

## ⚙️ Restricciones de integridad

### PRIMARY KEY

Cada entidad posee una clave primaria.

### FOREIGN KEY

Las claves foráneas mantienen las relaciones entre tablas.

### UNIQUE

Se utilizan en campos como:

```text
codigo_barra
dni
correo
nombre_usuario
codigo_funcionalidad
```

### CHECK

Ejemplos:

```text
stock >= 0
stock_minimo >= 0
cantidad > 0
monto > 0
precio_costo > 0
porcentaje_ganancia >= 0
```

### DEFAULT

Ejemplo:

```sql
fecha_hora DATETIME NOT NULL DEFAULT GETDATE()
```

---

## 🧩 Decisiones de diseño

### Inventario separado de Producto

El stock depende de la sucursal.

### Precio histórico en Detalle de Venta

Evita alterar ventas anteriores.

### Teléfonos en tablas separadas

Se representan como atributos multivaluados.

### Perfil y Funcionalidad N:M

Se utiliza:

```text
PERFIL_FUNCIONALIDAD
```

### Cliente opcional en Venta

`id_cliente` puede ser `NULL`.

---

## 🧮 Normalización

El modelo fue trabajado aplicando criterios de normalización para:

- reducir redundancias;
- evitar grupos repetitivos;
- separar atributos multivaluados;
- resolver relaciones N:M;
- mejorar la consistencia.

Ejemplos:

```text
PERFIL ↔ FUNCIONALIDAD
```

se resuelve mediante:

```text
PERFIL_FUNCIONALIDAD
```

y:

```text
PRODUCTO ↔ SUCURSAL
```

se resuelve mediante:

```text
INVENTARIO
```

---

## 🧱 Implementación física

La implementación utiliza sintaxis compatible con:

```text
Microsoft SQL Server / T-SQL
```

Incluye:

```text
CREATE TABLE
IDENTITY
PRIMARY KEY
FOREIGN KEY
CHECK
UNIQUE
DEFAULT
GETDATE()
columnas calculadas
```

---

## 💾 DDL

Archivo:

```text
sql/ddl/01_creacion_tablas.sql
```

Contiene:

- creación de tablas;
- claves primarias;
- claves foráneas;
- restricciones;
- relaciones;
- columnas calculadas.

---

## 📥 DML

Archivo:

```text
sql/dml/02_poblado_datos.sql
```

Contiene cargas para:

- provincias;
- perfiles;
- categorías;
- métodos de pago;
- productos;
- localidades;
- funcionalidades;
- perfil-funcionalidad;
- direcciones;
- clientes;
- sucursales;
- usuarios;
- inventario;
- ventas;
- detalle de venta;
- pagos;
- teléfonos.

---

## 🧪 Datos de prueba

Actualmente se cargan, entre otros:

```text
16 provincias
8 perfiles
8 categorías
7 métodos de pago
56 productos
128 localidades
330 direcciones
300 clientes
30 usuarios
3 sucursales
```

Además se incluyen registros de:

- inventario;
- ventas;
- detalles de venta;
- pagos;
- teléfonos.

---

## 🔄 Cargas alternativas con WHILE

El DML incluye ejemplos comentados con:

```sql
WHILE
```

para mostrar una alternativa de carga masiva.

Se mantienen comentados para no interferir con la ejecución normal.

---

## ✅ Pruebas de restricciones

El DML incluye pruebas intencionales para verificar:

```text
UNIQUE
CHECK
FOREIGN KEY
```

Ejemplos:

```text
producto con código repetido
stock negativo
provincia inexistente
usuario duplicado
```

---

## ✏️ Ejemplos de UPDATE

También se incluyen ejemplos como:

```text
modificar margen de ganancia
actualizar descripción
modificar correo
actualizar stock
modificar descuento
```

---

## ⚠️ Reglas que requieren lógica adicional

Algunas reglas están representadas en el modelo, pero necesitan lógica adicional para automatizarse.

### Validación automática de stock

Puede requerir:

```text
procedimientos
triggers
lógica de aplicación
```

### Alertas de stock mínimo

Puede consultarse mediante:

```sql
WHERE stock <= stock_minimo
```

### Validación del total de pagos

Puede verificarse mediante lógica adicional que compare la suma de pagos con el total de la venta.

---

## 📚 Etapas del proyecto

### Etapa 01 — Requerimientos y dominio del negocio

Ubicación:

```text
docs/etapa-01/
```

Incluye:

- descripción del caso;
- alcance;
- reglas de negocio.

### Etapa 02 — Modelado conceptual y lógico

Ubicación:

```text
docs/etapa-02/
```

Incluye:

- DER;
- modelo relacional;
- normalización;
- decisiones de diseño.

### Etapa 03 — Implementación física

Ubicación:

```text
sql/ddl/
sql/dml/
```

Incluye:

- DDL;
- DML;
- pruebas;
- carga de datos.

---

## 📁 Estructura del repositorio

```text
proyecto-bd1-equipo55/
│
├── docs/
│   ├── etapa-01/
│   │   ├── alcance.md
│   │   ├── descripcion-caso.md
│   │   └── reglas-negocio.md
│   │
│   ├── etapa-02/
│   │   ├── decisiones-diseno.md
│   │   ├── modelo-relacional.md
│   │   ├── normalizacion.md
│   │   ├── der-modelo-conceptual.png
│   │   └── der-modelo-relacional.png
│   │
│   └── etapa-03/
│
├── sql/
│   ├── ddl/
│   │   └── 01_creacion_tablas.sql
│   │
│   └── dml/
│       └── 02_poblado_datos.sql
│
└── README.md
```

---

## ▶️ Ejecución del proyecto

### 1. Ejecutar el DDL

```text
sql/ddl/01_creacion_tablas.sql
```

### 2. Ejecutar el DML

```text
sql/dml/02_poblado_datos.sql
```

El DML incluye algunas instrucciones diseñadas intencionalmente para producir errores y verificar restricciones.

---

## 📊 Flujo general de una venta

```text
CLIENTE
   |
   v
VENTA <──── USUARIO
   |
   +──── SUCURSAL
   |
   v
DETALLE_VENTA
   |
   v
PRODUCTO

VENTA
   |
   v
PAGO
   |
   v
METODO_PAGO
```

---

## 📊 Flujo general del inventario

```text
CATEGORIA
    |
    v
PRODUCTO
    |
    v
INVENTARIO
    |
    v
SUCURSAL
```

---

## 🧠 Conceptos de Bases de Datos aplicados

- modelo conceptual;
- Diagrama Entidad-Relación;
- modelo relacional;
- entidades;
- atributos;
- claves primarias;
- claves foráneas;
- relaciones 1:N;
- relaciones N:M;
- atributos multivaluados;
- restricciones;
- normalización;
- DDL;
- DML;
- integridad referencial.

---

## 📌 Estado actual del proyecto

```text
✅ análisis del caso
✅ alcance
✅ reglas de negocio
✅ modelo conceptual
✅ modelo relacional
✅ normalización
✅ creación física de tablas
✅ restricciones
✅ carga de datos
✅ pruebas de integridad
✅ perfiles y funcionalidades
✅ inventario por sucursal
✅ ventas, detalles y pagos
```

---

## 👥 Integrantes

| Integrante | DNI |
|---|---:|
| Pereira, Ignacio Valentin | 43.930.596 |
| Zacarias, Matias Daniel | 43.746.504 |
| Aponte, Josue Eduardo | — |
| Melgarejo Jaras, Carlos Exequiel | 40.877.202 |
| Correa Cuevas, Josias Francisco | 42.061.409 |

---

## 🎓 Información académica

**Carrera:** Licenciatura en Sistemas de Información  
**Asignatura:** Bases de Datos I  
**Trabajo:** Proyecto Integrador  
**Equipo:** 55  
**Año:** 2026

---

## 📌 Resumen

El proyecto representa una solución de base de datos para una ferretería con múltiples sucursales.

La estructura desarrollada permite centralizar la información correspondiente a productos, inventario, clientes, usuarios, ventas y pagos, manteniendo la integridad de los datos mediante claves, relaciones y restricciones.

El modelo fue diseñado para representar correctamente el dominio del negocio y servir como base para futuras ampliaciones del sistema.
