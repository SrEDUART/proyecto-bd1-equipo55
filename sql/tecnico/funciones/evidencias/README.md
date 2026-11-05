# Evidencias de Ejecución - Módulo de Funciones Almacenadas

## 1. Captura: `01_creacion_funciones.png`

Demostración de ejecución del script `implementacion_funciones.sql` en SQL Server Management Studio (SSMS):

- Muestra la creación exitosa de las tres funciones almacenadas: `fn_ImporteDetalleVenta`, `fn_TotalGastadoCliente` y `fn_StockDisponible`.
- Se visualizan las tres funciones dentro de la sección **Programación → Funciones → Funciones escalares** de la base de datos `ProyectoFerreteria`.
- La ejecución finaliza correctamente, sin errores.

## 2. Pruebas individuales de funcionamiento

Demostración de ejecución del script `demostracion_funciones.sql` en SSMS:

### 2.1. Captura: `02_fn_importe_detalle.png`

**Prueba 1 (Importe de detalles de venta):**

- Verificación del importe calculado para los primeros diez detalles de venta mediante `fn_ImporteDetalleVenta`.
- Se muestran la cantidad, el precio unitario histórico, el descuento aplicado y el importe final calculado.

### 2.2. Captura: `03_fn_total_gastado_cliente.png`

**Prueba 2 (Total gastado por cliente):**

- Verificación del importe total gastado por cada cliente no eliminado lógicamente mediante `fn_TotalGastadoCliente`.
- Se muestran los identificadores, nombres, apellidos y totales acumulados, ordenados de mayor a menor.

### 2.3. Captura: `04_fn_stock_disponible.png`

**Prueba 3 (Stock por producto y sucursal):**

- Verificación del stock disponible mediante `fn_StockDisponible`.
- Se compara el stock registrado en la tabla `INVENTARIO` con el valor devuelto por la función, comprobando la coincidencia de ambos resultados.

## 3. Comparación de resultados y eficiencia

Demostración de comparación entre consultas SQL directas y consultas que utilizan funciones almacenadas.

Se utilizaron las instrucciones `SET STATISTICS TIME ON` y `SET STATISTICS IO ON` para analizar los tiempos de ejecución y las lecturas realizadas por SQL Server.

### 3.1. Capturas: `05_comparacion_importes_resultados.png` y `06_comparacion_importes_rendimiento.png`

**Comparación 1 (Importe de detalles):**

- Se compara el cálculo del importe mediante una consulta directa con el resultado obtenido a través de `fn_ImporteDetalleVenta`.
- Se registran los tiempos de CPU, tiempos transcurridos y lecturas de datos de ambas alternativas.

### 3.2. Capturas: `07_comparacion_clientes_resultados.png` y `08_comparacion_clientes_rendimiento.png`

**Comparación 2 (Total gastado por cliente):**

- Se compara el cálculo del total gastado mediante una consulta con `JOIN`, `GROUP BY` y `SUM` frente a la utilización de `fn_TotalGastadoCliente`.
- Se analizan las estadísticas de ejecución y las lecturas realizadas por ambas consultas.

### 3.3. Capturas: `09_comparacion_stock_resultados.png` y `10_comparacion_stock_rendimiento.png`

**Comparación 3 (Stock por producto y sucursal):**

- Se compara la consulta directa sobre la tabla `INVENTARIO` con la consulta que utiliza `fn_StockDisponible`.
- Se registran las estadísticas de rendimiento para ambas alternativas.

## 4. Verificación de coincidencia de resultados

Demostración de ejecución de las verificaciones incluidas en `demostracion_funciones.sql`.

### 4.1. Verificación: `11_verificacion_coincidencia_resultados.png`

La captura muestra las tres verificaciones que comparan los cálculos directos con los resultados de las funciones almacenadas:

- **Verificación 1 (Importe de detalles):** comparación de los importes calculados directamente con los devueltos por `fn_ImporteDetalleVenta`.
- **Verificación 2 (Total por cliente):** comparación de los totales acumulados mediante consultas directas con los obtenidos a través de `fn_TotalGastadoCliente`.
- **Verificación 3 (Stock):** comparación del stock registrado en `INVENTARIO` con el devuelto por `fn_StockDisponible`.

Las tres consultas de verificación no devolvieron filas, lo que confirma que no se encontraron diferencias entre los resultados.

### 4.2. Evidencia complementaria: `12_verificacion_ejecucion_correcta.png`

Esta captura complementa la evidencia de que la ejecución finalizó correctamente.
Como muestra un contexto antiguo con el nombre `ferreteria`, no se presenta como
prueba del nombre actual de la base de datos. Los scripts actuales y las restantes
evidencias del módulo corresponden a `ProyectoFerreteria`.
