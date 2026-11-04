# Evidencias de Ejecución - Módulo de Seguridad

## 1. Captura: `implementacion_seguridad.png`
Demostración de ejecución del script `01_implementacion_seguridad.sql` en SQL Server Management Studio (SSMS):
- Muestra la creación del rol `rol_operador_ventas`, la aplicación de restricciones `DENY`, la asignación de permisos `GRANT` y la creación del usuario `usuario_vendedor` finalizando con el mensaje `Commands completed successfully.`

## 2. Captura: `demostracion_seguridad_1.png`
Demostración de la Prueba 1 del script `02_demostracion_seguridad.sql`:
- **Pestaña Mensajes:** Muestra el resultado `(0 filas afectadas)` y la captura del bloque `TRY...CATCH` confirmando la denegación explícita: `Resultado esperado: The INSERT permission was denied on the object 'CLIENTE', database 'proyectoFerreteria', schema 'dbo'.`

## 3. Captura: `demostracion_seguridad_2.png`
Demostración de la Prueba 2 del script `02_demostracion_seguridad.sql`:
- **Pestaña Resultados:** Muestra la fila del cliente (*Mariana Gomez*, DNI 47111222) insertada correctamente a través de la ejecución del procedimiento almacenado `sp_InsertarCliente` bajo la identidad de `usuario_vendedor`.
