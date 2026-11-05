# Proyecto BD1 — Equipo 55

## Sistema de Gestión Comercial para Ferretería Multisucursal

Proyecto integrador de **Bases de Datos I**, correspondiente a la **Licenciatura en Sistemas de Información**. El proyecto diseña e implementa una base de datos en Microsoft SQL Server para una ferretería multisucursal, incluyendo productos, categorías, inventario, sucursales, clientes, usuarios, ventas y pagos. La base de datos del proyecto se llama `ProyectoFerreteria`.

<a id="tabla-de-contenidos"></a>
## Tabla de contenidos

- [Sobre el proyecto](#sobre-el-proyecto)
- [Etapa 1 — Análisis del dominio](#etapa-1)
- [Etapa 2 — Modelado y normalización](#etapa-2)
- [Etapa 3 — Implementación física](#etapa-3)
- [Etapa 4 — Consultas y casos de uso](#etapa-4)
- [Etapa 5 — Temas técnicos](#etapa-5)
- [Ejecución del proyecto](#ejecución-del-proyecto)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Integrantes](#integrantes)
- [Información académica](#información-académica)

<a id="sobre-el-proyecto"></a>
## Sobre el proyecto

El repositorio reúne los documentos y scripts SQL elaborados en las distintas etapas: análisis del dominio, modelado, implementación física, consultas de negocio y temas técnicos de SQL Server. Las tablas y relaciones se crean en `ProyectoFerreteria`; los scripts de carga, consulta y demostración trabajan sobre esa base.

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="etapa-1"></a>
## Etapa 1 — Análisis del dominio

Esta etapa describe el contexto de la ferretería multisucursal, delimita el sistema y reúne las reglas de negocio que guían su diseño.

| Documento | Contenido |
|---|---|
| [descripcion-caso.md](docs/etapa-01/descripcion-caso.md) | Contexto y necesidades del negocio. |
| [alcance.md](docs/etapa-01/alcance.md) | Áreas funcionales incluidas en el sistema. |
| [reglas-negocio.md](docs/etapa-01/reglas-negocio.md) | Reglas que condicionan los datos y las operaciones. |

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="etapa-2"></a>
## Etapa 2 — Modelado y normalización

Esta etapa presenta los modelos de datos y el análisis de normalización que fundamentan la estructura relacional.

| Documento o recurso | Contenido |
|---|---|
| [der-modelo-conceptual.png](docs/etapa-02/der-modelo-conceptual.png) | Diagrama entidad-relación conceptual. |
| [der-modelo-relacional.png](docs/etapa-02/der-modelo-relacional.png) | Diagrama del modelo relacional. |
| [modelo-relacional.md](docs/etapa-02/modelo-relacional.md) | Tablas, atributos y relaciones del modelo. |
| [normalizacion.md](docs/etapa-02/normalizacion.md) | Análisis de normalización. |
| [decisiones-diseno.md](docs/etapa-02/decisiones-diseno.md) | Decisiones de diseño documentadas a partir del modelo. |

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="etapa-3"></a>
## Etapa 3 — Implementación física

Esta etapa traslada el modelo relacional a SQL Server y documenta restricciones, integridad y pruebas de validación.

| Documento | Contenido |
|---|---|
| [implementacion.md](docs/etapa-03/implementacion.md) | Implementación física de la base de datos. |
| [restricciones-integridad.md](docs/etapa-03/restricciones-integridad.md) | Restricciones de integridad definidas en el esquema. |
| [pruebas-validacion.md](docs/etapa-03/pruebas-validacion.md) | Pruebas intencionales de validación del DML. |

| Script | Descripción |
|---|---|
| [01_creacion_tablas.sql](sql/ddl/01_creacion_tablas.sql) | Crea y selecciona `ProyectoFerreteria`, si aún no existe, y crea las tablas. |
| [02_poblado_datos.sql](sql/dml/02_poblado_datos.sql) | Carga los datos del proyecto. |

Orden de ejecución: primero `01_creacion_tablas.sql` y luego `02_poblado_datos.sql`.

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="etapa-4"></a>
## Etapa 4 — Consultas y casos de uso

Esta etapa documenta casos de uso y consultas para consultar comprobantes e informes y analizar ventas por período, categoría, producto y sucursal.

| Caso / recurso | Documento | Script |
|---|---|---|
| Casos de uso | [casos-uso.md](docs/etapa-04/casos-uso.md) | — |
| Comprobante de venta | [comprobante-venta.md](docs/etapa-04/comprobante-venta.md) | [comprobante_venta.sql](sql/consultas/comprobante_venta.sql) |
| Informe de ventas por vendedor y categoría | [informe-ventas.md](docs/etapa-04/informe-ventas.md) | [informe_ventas.sql](sql/consultas/informe_ventas.sql) |
| Consulta avanzada | [consulta-avanzada.md](docs/etapa-04/consulta-avanzada.md) | [consulta_avanzada.sql](sql/consultas/consulta_avanzada.sql) |

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="etapa-5"></a>
## Etapa 5 — Temas técnicos

Esta etapa reúne mecanismos de SQL Server aplicados al sistema: procedimientos, funciones, transacciones, triggers, seguridad e índices.

| Tema | Documento | Implementación | Demostración | Evidencias |
|---|---|---|---|---|
| Procedimientos | [procedimientos-funciones.md](docs/etapa-05/procedimientos-funciones.md) | [01_implementacion_procedimientos.sql](sql/tecnico/procedimientos/01_implementacion_procedimientos.sql) | [02_demostracion_procedimientos.sql](sql/tecnico/procedimientos/02_demostracion_procedimientos.sql) | [evidencias/](sql/tecnico/procedimientos/evidencias/) |
| Funciones | [procedimientos-funciones.md](docs/etapa-05/procedimientos-funciones.md) | [01_implementacion_funciones.sql](sql/tecnico/funciones/01_implementacion_funciones.sql) | [02_demostracion_funciones.sql](sql/tecnico/funciones/02_demostracion_funciones.sql) | [evidencias/](sql/tecnico/funciones/evidencias/) |
| Transacciones | [transacciones.md](docs/etapa-05/transacciones.md) | [01_implementacion_transacciones.sql](sql/tecnico/transacciones/01_implementacion_transacciones.sql) | [02_demostracion_transacciones.sql](sql/tecnico/transacciones/02_demostracion_transacciones.sql) | [README](sql/tecnico/transacciones/evidencias/README.md) · [Caso exitoso](sql/tecnico/transacciones/evidencias/01_transaccion_exitosa.png) · [Rollback](sql/tecnico/transacciones/evidencias/02_transaccion_rollback.png) |
| Triggers | [triggers-auditoria.md](docs/etapa-05/triggers-auditoria.md) | [01_implementacion_triggers_auditoria.sql](sql/tecnico/triggers/01_implementacion_triggers_auditoria.sql) · [03_implementacion_trigger_bloqueo.sql](sql/tecnico/triggers/03_implementacion_trigger_bloqueo.sql) | [02_demostracion_triggers_auditoria.sql](sql/tecnico/triggers/02_demostracion_triggers_auditoria.sql) · [04_demostracion_trigger_bloqueo.sql](sql/tecnico/triggers/04_demostracion_trigger_bloqueo.sql) | [evidencias/](sql/tecnico/triggers/evidencias/) |
| Seguridad | [seguridad.md](docs/etapa-05/seguridad.md) | [01_implementacion_seguridad.sql](sql/tecnico/seguridad/01_implementacion_seguridad.sql) | [02_demostracion_seguridad.sql](sql/tecnico/seguridad/02_demostracion_seguridad.sql) | [evidencias/](sql/tecnico/seguridad/evidencias/) |
| Índices | [indices-optimizacion.md](docs/etapa-05/indices-optimizacion.md) | [01_implementacion_indices.sql](sql/tecnico/indices/01_implementacion_indices.sql) | [02_demostracion_indices.sql](sql/tecnico/indices/02_demostracion_indices.sql) | [evidencias/](sql/tecnico/indices/evidencias/) |

El módulo de triggers incluye auditoría de `UPDATE` y `DELETE` sobre `PRODUCTO`, y el bloqueo del borrado físico de `CLIENTE`.

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="ejecución-del-proyecto"></a>
## Ejecución del proyecto

**Requisitos:** Microsoft SQL Server y SQL Server Management Studio (SSMS).

1. Ejecutar [sql/ddl/01_creacion_tablas.sql](sql/ddl/01_creacion_tablas.sql), que crea y selecciona `ProyectoFerreteria`.
2. Ejecutar [sql/dml/02_poblado_datos.sql](sql/dml/02_poblado_datos.sql).
3. Ejecutar los scripts de [sql/consultas/](sql/consultas/) según la consulta requerida.
4. Para cada tema técnico, ejecutar primero el script de implementación y luego su demostración.

Algunos scripts de prueba del DML provocan errores intencionales para comprobar restricciones.

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="estructura-del-repositorio"></a>
## Estructura del repositorio

```text
docs/
├── etapa-01/
├── etapa-02/
├── etapa-03/
├── etapa-04/
└── etapa-05/

sql/
├── ddl/
├── dml/
├── consultas/
└── tecnico/
    ├── procedimientos/
    ├── funciones/
    ├── transacciones/
    ├── triggers/
    ├── seguridad/
    └── indices/

README.md
```

| Carpeta | Contenido |
|---|---|
| [docs/](docs/) | Documentación de las etapas. |
| [sql/ddl/](sql/ddl/) | Creación de la base y las tablas. |
| [sql/dml/](sql/dml/) | Carga de datos. |
| [sql/consultas/](sql/consultas/) | Consultas e informes SQL. |
| [sql/tecnico/](sql/tecnico/) | Implementaciones, demostraciones y evidencias de temas técnicos. |

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="integrantes"></a>
## Integrantes

- Ignacio Valentín Pereira
- Matías Daniel Zacarías
- Josué Eduardo Aponte
- Carlos Exequiel Melgarejo Jaras
- Josías Francisco Correa Cuevas

[⬆ Volver al índice](#tabla-de-contenidos)

<a id="información-académica"></a>
## Información académica

| Campo | Información |
|---|---|
| Carrera | Licenciatura en Sistemas de Información |
| Asignatura | Bases de Datos I |
| Trabajo | Proyecto integrador |
| Equipo | 55 |
| Año | 2026 |

[⬆ Volver al índice](#tabla-de-contenidos)
