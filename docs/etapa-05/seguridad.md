# Seguridad: usuarios, roles y permisos

## 1. Objetivo

El módulo muestra cómo controlar el acceso a `CLIENTE` en `ProyectoFerreteria` mediante usuarios de base de datos, roles y permisos. Los scripts de prueba usan usuarios `WITHOUT LOGIN`, por lo que sirven para comprobar permisos internos sin crear cuentas de conexión al servidor.

## 2. Autenticación de SQL Server

El modo de autenticación es una configuración de la instancia y no se cambia desde estos scripts de forma portable. La demostración consulta `SERVERPROPERTY('IsIntegratedSecurityOnly')`:

- `0`: está habilitada la autenticación mixta (Windows y SQL Server).
- `1`: está habilitada únicamente la autenticación de Windows.

Para activar la autenticación mixta, en SQL Server Management Studio abrir las propiedades del servidor, ir a **Seguridad**, seleccionar **Modo de autenticación de SQL Server y Windows** y confirmar el cambio. Luego se debe reiniciar el servicio de SQL Server para que la configuración tenga efecto. La instancia debe permitir este modo para usar inicios de sesión de SQL Server.

## 3. Roles y usuarios implementados

El script [`01_implementacion_seguridad.sql`](../../sql/tecnico/seguridad/01_implementacion_seguridad.sql) conserva `rol_operador_ventas` y `usuario_vendedor`, y agrega:

- `usuario_administrador`, usuario `WITHOUT LOGIN` asignado al rol integrado `db_owner` para la prueba de administración.
- `rol_lectura`, con `SELECT` sobre `dbo.CLIENTE`, `DENY` para `INSERT`, `UPDATE` y `DELETE` directos, y `EXECUTE` sobre `dbo.sp_InsertarCliente`.
- `usuario_lectura_1` y `usuario_lectura_2`, ambos `WITHOUT LOGIN` y miembros del mismo `rol_lectura`.

El permiso para ejecutar `sp_InsertarCliente` permite altas controladas por ese procedimiento aunque el rol tenga denegada la inserción directa en la tabla. El procedimiento y el script de seguridad deben pertenecer al mismo esquema/propietario para que se aplique la cadena de propiedad de SQL Server.

La implementación verifica que `dbo.sp_InsertarCliente` exista, por lo que primero debe ejecutarse [`01_implementacion_procedimientos.sql`](../../sql/tecnico/procedimientos/01_implementacion_procedimientos.sql).

## 4. Pruebas y resultados

Ejecutar [`02_demostracion_seguridad.sql`](../../sql/tecnico/seguridad/02_demostracion_seguridad.sql) después de la implementación. La demostración obtiene una dirección existente y genera DNI y correo únicos para las filas temporales. Las pruebas se ejecutan dentro de una transacción que termina con `ROLLBACK`; no dejan clientes de prueba en la base.

El script comprueba lo siguiente:

1. **Administrador:** puede insertar directamente en `CLIENTE` y consultar la fila creada durante la prueba.
2. **Primer usuario de lectura:** puede consultar `CLIENTE`; su `INSERT` directo se rechaza; puede insertar mediante `dbo.sp_InsertarCliente` y consultar el resultado.
3. **Segundo usuario de lectura:** recibe los mismos resultados que el primero por ser miembro del mismo rol: lectura permitida, inserción directa denegada e inserción mediante el procedimiento permitida.
4. **Limpieza:** al terminar el `ROLLBACK`, consulta los correos usados para verificar que las filas temporales ya no existen.

La demostración informa además el modo de autenticación de la instancia. Los usuarios `WITHOUT LOGIN` prueban la autorización dentro de la base, pero no prueban una conexión al servidor ni sustituyen la verificación de autenticación mixta.

## 5. Conclusión

Los roles reúnen permisos para asignarlos de forma consistente. El administrador puede realizar operaciones directas, mientras que los usuarios de lectura consultan la tabla y realizan altas únicamente mediante el procedimiento autorizado. Las pruebas muestran que ambos usuarios del rol heredan el mismo comportamiento.
