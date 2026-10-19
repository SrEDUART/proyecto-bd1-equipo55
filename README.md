🧰 Proyecto BD1 — Equipo 55

Sistema de Gestión Comercial para Ferretería Multisucursal

Proyecto integrador de la asignatura Bases de Datos I, correspondiente a la Licenciatura en Sistemas de Información.

El proyecto consiste en el diseño e implementación de una base de datos relacional destinada a administrar las operaciones de una ferretería con múltiples sucursales. Su finalidad es centralizar la información comercial, mantener la consistencia de los datos y facilitar el registro y seguimiento de las operaciones del negocio.

La solución contempla la administración de productos, categorías, inventario, sucursales, clientes, usuarios, ventas y pagos, utilizando Microsoft SQL Server como sistema gestor de bases de datos.

⸻

📑 Índice

* 1. Objetivos del proyecto
* 2. Alcance y funcionalidades
* 3. Diseño de la base de datos
* 4. Reglas de negocio e integridad
* 5. Organización del repositorio
* 6. Instalación y ejecución
* 7. Consultas e informes SQL
* 8. Integrantes
* 9. Información académica

⸻

🎯 1. Objetivos del proyecto

Objetivo general

Diseñar e implementar una base de datos relacional que permita gestionar de manera organizada y consistente las operaciones de una ferretería multisucursal, aplicando los conceptos de modelado, normalización, integridad referencial y lenguaje SQL estudiados en la asignatura.

Objetivos específicos

* Identificar las entidades, atributos, relaciones y reglas de negocio del sistema.
* Diseñar los modelos conceptual, lógico y físico de la base de datos.
* Reducir la redundancia mediante la normalización de las estructuras.
* Implementar claves primarias, claves foráneas y restricciones de integridad.
* Cargar datos de prueba que permitan validar las relaciones entre las tablas.
* Desarrollar consultas SQL para obtener información útil sobre las operaciones comerciales.
* Documentar las decisiones de diseño y los procedimientos de implementación.
* Organizar los entregables correspondientes a las distintas etapas del proyecto.

🏪 2. Alcance y funcionalidades

La base de datos contempla los principales procesos de gestión de una ferretería, desde la organización del catálogo de productos hasta el registro de las ventas y sus correspondientes pagos.

Módulo	Descripción
Productos y categorías	Organización del catálogo, clasificación de artículos y administración de precios.
Inventario	Administración de existencias asociadas a los productos y las sucursales.
Sucursales y ubicaciones	Registro de establecimientos, direcciones y datos geográficos.
Clientes	Almacenamiento de la información de los clientes.
Usuarios y perfiles	Organización de los usuarios y sus permisos según el perfil asignado.
Ventas	Registro de operaciones comerciales, fechas, vendedores y montos.
Detalle de venta	Identificación de los productos vendidos, las cantidades y los precios aplicados.
Pagos	Registro de los medios de pago y los importes asociados a las ventas.

La estructura busca mantener separada la información de cada entidad y relacionarla mediante identificadores, evitando duplicaciones innecesarias y facilitando las consultas.

🗃️ 3. Diseño de la base de datos

El diseño se desarrolla a partir del análisis de los requerimientos del negocio y se representa mediante distintos modelos que permiten pasar de la descripción conceptual a una implementación física en SQL Server.

Modelado de datos

El proceso de diseño contempla:

1. Modelo conceptual: identificación de las entidades y sus relaciones.
2. Modelo relacional: definición de las tablas, atributos, claves y cardinalidades.
3. Normalización: revisión de las dependencias entre atributos para reducir redundancias y anomalías.
4. Modelo físico: implementación de las estructuras mediante sentencias SQL.

Podés consultar los materiales disponibles en la carpeta Documentación del proyecto y, en particular, la documentación de la etapa de modelado.

Relaciones principales

Entre las relaciones relevantes del sistema se encuentran:

* Producto y categoría: permite clasificar los artículos del catálogo.
* Producto y sucursal: permite organizar las existencias por establecimiento.
* Venta y usuario: vincula cada operación con el usuario que la registra.
* Venta y detalle de venta: permite representar los productos y las cantidades incluidos en cada operación.
* Venta y pago: permite asociar los pagos correspondientes a una venta.
* Cliente y venta: permite relacionar las operaciones con sus respectivos clientes cuando corresponde.

Estas relaciones se implementan mediante claves primarias y foráneas, respetando las reglas definidas para cada entidad.

🔐 4. Reglas de negocio e integridad

La implementación contempla mecanismos para proteger la consistencia de la información almacenada.

Entre los aspectos considerados se encuentran:

* Integridad de entidad: cada registro debe poder identificarse mediante su clave primaria.
* Integridad referencial: las claves foráneas deben mantener relaciones válidas entre las tablas.
* Validación de valores: las restricciones permiten limitar los valores admitidos en determinados atributos.
* Consistencia comercial: los importes de las ventas, los detalles y los pagos deben corresponder con las operaciones registradas.
* Coherencia de usuarios: las operaciones deben respetar las reglas definidas para los perfiles habilitados.
* Calidad de los datos: los datos de prueba deben respetar las relaciones y restricciones de la base de datos.

Las reglas específicas y las decisiones adoptadas durante el diseño se documentan en los materiales correspondientes de la carpeta docs.

📂 5. Organización del repositorio

El repositorio se divide en dos áreas principales: documentación y scripts SQL. Cada etapa reúne los entregables correspondientes al desarrollo del proyecto.

Recurso	Contenido
📁 docs/	Documentación, modelos, análisis y decisiones de diseño.
📁 docs/etapa-01/	Análisis del problema, requerimientos y reglas de negocio.
📁 docs/etapa-02/	Modelado conceptual y relacional, normalización y decisiones de diseño.
📁 docs/etapa-03/	Documentación y entregables correspondientes a la tercera etapa.
📁 docs/etapa-04/	Documentación y entregables correspondientes a la cuarta etapa.
📁 sql/	Scripts para la creación, carga y consulta de la base de datos.
📄 README.md	Presentación general y guía de navegación del proyecto.

Scripts SQL principales

* Creación de tablas — DDL: define la estructura de la base de datos, sus tablas y las restricciones correspondientes.
* Poblado de datos — DML: contiene los datos iniciales utilizados para probar las estructuras y relaciones.

La carpeta SQL reúne los scripts disponibles para implementar y trabajar con la base de datos.

⚙️ 6. Instalación y ejecución

Requisitos

* Microsoft SQL Server.
* SQL Server Management Studio (SSMS) u otra herramienta compatible.
* Acceso a los archivos SQL del repositorio.

Procedimiento

1. Clonar el repositorio o descargarlo desde GitHub.
2. Abrir SQL Server Management Studio y conectarse a la instancia correspondiente.
3. Revisar el script de creación de tablas.
4. Ejecutar el script para crear las estructuras y relaciones.
5. Revisar y ejecutar el script de poblado de datos.
6. Verificar que las tablas contengan los datos esperados y que las relaciones se hayan establecido correctamente.

Importante: antes de ejecutar los scripts, revisá si contienen instrucciones para crear, eliminar o modificar bases de datos. Las pruebas de restricciones también pueden provocar errores intencionales cuando buscan comprobar que una validación funciona correctamente.

📊 7. Consultas e informes SQL

Las consultas SQL permiten recuperar y analizar la información almacenada, transformando los datos operativos en resultados útiles para comprender el funcionamiento del negocio.

Entre los análisis que pueden desarrollarse a partir de la estructura se encuentran:

* Cantidad de ventas realizadas durante un período.
* Unidades vendidas por producto o categoría.
* Importes de ventas y montos registrados en los detalles.
* Análisis de pagos asociados a las operaciones comerciales.
* Comparaciones de ventas entre períodos o sucursales.

Los informes se construyen utilizando consultas SQL y las relaciones entre las tablas involucradas. Para mantener la consistencia de los resultados, es importante considerar las claves de relación, evitar duplicaciones producidas por los JOIN y aplicar correctamente las funciones de agregación.

Los archivos de cada informe y su documentación deben consultarse en la carpeta SQL y en la sección de documentación correspondiente.

👥 8. Integrantes

* Ignacio Valentín Pereira
* Matías Daniel Zacarías
* Josué Eduardo Aponte
* Carlos Exequiel Melgarejo Jaras
* Josías Francisco Correa Cuevas

🎓 9. Información académica

Campo	Información
Carrera	Licenciatura en Sistemas de Información
Asignatura	Bases de Datos I
Trabajo	Proyecto integrador
Equipo	55
Año	2026

⸻

Repositorio: SrEDUART/proyecto-bd1-equipo55
