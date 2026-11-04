# Decisiones de diseño

Las siguientes decisiones se observan en el modelo relacional y en el script de creación de tablas.

### Separación entre PRODUCTO y CATEGORIA
- **Decisión tomada:** `PRODUCTO` referencia a `CATEGORIA` mediante `id_categoria`.
- **Motivo:** Los productos comparten categorías y la descripción de cada categoría se almacena una sola vez.
- **Beneficio:** Se evita repetir los datos de categoría en cada producto.

### Inventario por producto y sucursal
- **Decisión tomada:** `INVENTARIO` relaciona productos con sucursales y almacena el stock y el stock mínimo. La combinación `(id_producto, id_sucursal)` es única.
- **Motivo:** Cada sucursal administra su propio stock para cada producto.
- **Beneficio:** Se evita duplicar el registro de inventario de un mismo producto en una sucursal.

### Separación entre VENTA y DETALLE_VENTA
- **Decisión tomada:** `VENTA` guarda los datos generales de la operación y `DETALLE_VENTA` sus productos, cantidades y precios unitarios.
- **Motivo:** Una venta puede contener varios productos y el precio aplicado debe conservarse en el detalle.
- **Beneficio:** Se pueden registrar varios ítems por venta y preservar el precio usado en cada operación.

### Separación entre VENTA y PAGO
- **Decisión tomada:** `PAGO` relaciona cada importe con una venta y un método de pago definido en `METODO_PAGO`.
- **Motivo:** Una venta puede tener uno o varios pagos y utilizar distintos métodos.
- **Beneficio:** Se representan pagos combinados sin repetir columnas de métodos e importes en `VENTA`.

### Jerarquía de ubicación geográfica
- **Decisión tomada:** Las ubicaciones se organizan en `PROVINCIA`, `LOCALIDAD` y `DIRECCION`; clientes, usuarios y sucursales referencian direcciones.
- **Motivo:** El sistema registra las ubicaciones de las personas y sucursales dentro de una misma estructura.
- **Beneficio:** Se comparten los datos geográficos y se evita repetir provincia y localidad en cada entidad.

### Separación entre PERFIL, USUARIO y FUNCIONALIDAD
- **Decisión tomada:** `USUARIO` referencia un `PERFIL`; `PERFIL_FUNCIONALIDAD` vincula perfiles con funcionalidades.
- **Motivo:** Un perfil puede asociarse a varias funcionalidades y una funcionalidad a varios perfiles.
- **Beneficio:** Los datos descriptivos de perfiles y funcionalidades se mantienen separados de los usuarios.

### Integridad mediante claves y restricciones
- **Decisión tomada:** Las tablas definen claves primarias y foráneas; también se usan restricciones `UNIQUE` y `CHECK` en atributos seleccionados.
- **Motivo:** El modelo identifica cada registro, vincula entidades relacionadas y limita algunos valores, como precios y cantidades.
- **Beneficio:** Se previenen identificadores duplicados, referencias inexistentes y valores que incumplen las condiciones definidas en el DDL.

### Bajas lógicas en entidades seleccionadas
- **Decisión tomada:** Algunas tablas, como `PRODUCTO`, `CATEGORIA`, `CLIENTE`, `SUCURSAL` y `USUARIO`, incluyen `eliminado_en`.
- **Motivo:** Las reglas de negocio documentan el uso de bajas lógicas para conservar la información.
- **Beneficio:** El modelo permite registrar la fecha de baja sin que el campo implique por sí solo un borrado físico.

### Análisis de normalización
- **Decisión tomada:** El modelo se analiza en `normalizacion.md` hasta 3FN, separando detalles de venta, pagos, categorías, perfiles y métodos de pago.
- **Motivo:** Esas separaciones evitan grupos repetitivos y mantienen los datos descriptivos en sus entidades.
- **Beneficio:** Se reduce la repetición de datos. El análisis también aclara que no se debe afirmar que el modelo alcanza estrictamente 3FN mientras permanezcan atributos derivados almacenados, como `PRODUCTO.precio_venta`.
