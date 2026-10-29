# Etapa V — Integrante 5: Trigger de Bloqueo e Integración

## 1. Definición y objetivo

Un **trigger** es un objeto de SQL Server que se ejecuta automáticamente 
en respuesta a un evento sobre una tabla (`INSERT`, `UPDATE`, `DELETE`). 
Existen dos modalidades: `AFTER` (se ejecuta después de la operación) e 
`INSTEAD OF` (reemplaza la operación original, que nunca llega a 
ejecutarse).

El objetivo de este trabajo es implementar un trigger de **bloqueo**: 
impedir que se eliminen físicamente registros de una tabla crítica del 
sistema, emitiendo un mensaje explicativo al usuario que intenta la 
operación.

## 2. Ventajas y aplicaciones

- Protege la integridad referencial del sistema evitando pérdidas 
  accidentales de datos.
- Preserva la trazabilidad histórica cuando otras tablas dependen del 
  registro (en este caso, el historial de ventas).
- Refuerza en la base de datos una regla de negocio que no debería 
  depender solo de la disciplina del usuario o la aplicación cliente.
- Se complementa con el patrón de **baja lógica**: en vez de borrar, se 
  marca el registro como inactivo.

## 3. Implementación en SQL Server Express

```sql
CREATE TRIGGER nombre_trigger
ON nombre_tabla
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('mensaje explicativo', 16, 1);
END;
```

La cláusula `INSTEAD OF DELETE` es más eficiente que un `AFTER DELETE` 
con `ROLLBACK`, porque intercepta la operación antes de que el motor 
borre físicamente la fila.

## 4. Caso concreto aplicado al sistema de ventas

**Tabla elegida:** `PRODUCTO`.

**Justificación:** la tabla `PRODUCTO` ya contempla en su diseño la baja 
lógica, mediante las columnas `activo` (bit) y `eliminado_en` 
(datetime2). Además, `PRODUCTO` está referenciada desde 
`DETALLE_VENTA`: si se permitiera un `DELETE` físico, se perdería la 
trazabilidad de las ventas históricas.

**Regla de negocio implementada:** ningún usuario puede eliminar 
físicamente un producto. La baja debe hacerse mediante 
`UPDATE PRODUCTO SET activo = 0 WHERE id_producto = ...`.

## 5. Script de demostración y resultados obtenidos

Script completo: [`sql/ddl/02_trigger_bloqueo_producto.sql`](../../sql/ddl/02_trigger_bloqueo_producto.sql)

### Prueba 1 — Creación del trigger
Resultado: *"Los comandos se han completado correctamente."*

### Prueba 2 — Intento de DELETE sobre un producto existente (id_producto = 30)

```sql
DELETE FROM PRODUCTO WHERE id_producto = 30;
```

Resultado obtenido:
