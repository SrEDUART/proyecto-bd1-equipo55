# Evidencias de Ejecución - Módulo de Procedimientos Almacenados (CRUD)

## 1. Captura: `Implementacion_procedimientos.png`
Demostración de ejecución del script `01_implementacion_procedimientos.sql` en SQL Server Management Studio (SSMS):
- Muestra la compilación y creación exitosa de los procedimientos almacenados `sp_InsertarCliente`, `sp_ModificarCliente` y `sp_EliminarCliente`, finalizando con el mensaje `Commands completed successfully.`

## 2. Captura: `Demostracion_procedimientos.png`
Demostración de ejecución del script `02_demostracion_procedimientos.sql` en SSMS:
- **Prueba 1 (Inserción):** Verificación en la primera grilla de resultados del registro creado en la tabla `CLIENTE` mediante `sp_InsertarCliente`.
- **Prueba 2 (Modificación):** Verificación en la segunda grilla de la actualización de datos (nombre modificado a *Carlos Alberto*) a través de `sp_ModificarCliente`.
- **Prueba 3 (Baja Lógica):** Verificación en la tercera grilla del borrado lógico mediante el estampado de fecha/hora en la columna `eliminado_en` ejecutado por `sp_EliminarCliente`.

## 3. Captura nueva: `03_comparacion_inserciones.png`

Debe mostrar la comparación agregada al final de `02_demostracion_procedimientos.sql`:

- La ejecución del `INSERT ... SELECT` directo para cinco clientes y la medición de `SET STATISTICS TIME`.
- La ejecución de `sp_InsertarCliente` para cinco clientes y su medición de `SET STATISTICS TIME`.
- La grilla que informa cinco filas para cada alternativa.
- La verificación posterior al `ROLLBACK`, con cero filas de prueba restantes.

Tomar la captura desde los resultados reales de SSMS, incluyendo las mediciones de la pestaña **Mensajes**. Los tiempos pueden variar según el entorno y no deben completarse con valores inventados.
