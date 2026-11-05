# Evidencias de Ejecución - Módulo de Procedimientos Almacenados (CRUD)

## 1. Captura: `Implementacion_procedimientos.png`
Demostración de ejecución del script `01_implementacion_procedimientos.sql` en SQL Server Management Studio (SSMS):
- Muestra la compilación y creación exitosa de los procedimientos almacenados `sp_InsertarCliente`, `sp_ModificarCliente` y `sp_EliminarCliente`, finalizando con el mensaje `Commands completed successfully.`

## 2. Captura: `Demostracion_procedimientos.png`
Demostración de ejecución del script `02_demostracion_procedimientos.sql` en SSMS:
- **Prueba 1 (Inserción):** muestra el registro creado mediante `sp_InsertarCliente`.
- **Prueba 2 (Modificación):** muestra la actualización realizada mediante `sp_ModificarCliente`.
- **Prueba 3 (Baja lógica):** muestra la fecha registrada en `eliminado_en` mediante `sp_EliminarCliente`.

El script actual usa un cliente temporal con DNI y correo únicos, identifica el
`id_cliente` creado y ejecuta las tres pruebas dentro de una transacción que
finaliza con `ROLLBACK`. La captura existente documenta el flujo CRUD; los
valores visibles pertenecen a la ejecución registrada en esa imagen.

## 3. Evidencia final: `03_comparacion_inserciones.png`

La captura existente muestra la comparación agregada al final de
`02_demostracion_procedimientos.sql`:

- La ejecución del `INSERT ... SELECT` directo para cinco clientes y la medición de `SET STATISTICS TIME`.
- La ejecución de `sp_InsertarCliente` para cinco clientes y su medición de `SET STATISTICS TIME`.
- La grilla que informa cinco filas para cada alternativa.
- La verificación posterior al `ROLLBACK`, con cero filas de prueba restantes.

La imagen contiene los resultados reales de SSMS, incluyendo las mediciones de
la pestaña **Mensajes**. Los tiempos pueden variar según el entorno y no deben
interpretarse como una ventaja universal de una alternativa.
