# Evidencias de Ejecución - Módulo de Procedimientos Almacenados (CRUD)

## 1. Captura: `implementacion_procedimientos.png`
Demostración de ejecución del script `01_implementacion_procedimientos.sql` en SQL Server Management Studio (SSMS):
- Muestra la compilación y creación exitosa de los procedimientos almacenados `sp_InsertarCliente`, `sp_ModificarCliente` y `sp_EliminarCliente`, finalizando con el mensaje `Commands completed successfully.`

## 2. Captura: `demostracion_procedimientos.png`
Demostración de ejecución del script `02_demostracion_procedimientos.sql` en SSMS:
- **Prueba 1 (Inserción):** Verificación en la primera grilla de resultados del registro creado en la tabla `CLIENTE` mediante `sp_InsertarCliente`.
- **Prueba 2 (Modificación):** Verificación en la segunda grilla de la actualización de datos (nombre modificado a *Carlos Alberto*) a través de `sp_ModificarCliente`.
- **Prueba 3 (Baja Lógica):** Verificación en la tercera grilla del borrado lógico mediante el estampado de fecha/hora en la columna `eliminado_en` ejecutado por `sp_EliminarCliente`.
