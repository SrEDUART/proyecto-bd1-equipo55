Reglas de negocio:
RN.01 – Gestión de stock. Cada producto tiene un stock independiente por sucursal. No se
 puede registrar una venta ni el detalle de una venta si la cantidad solicitada supera el stock
 disponible del producto en esa sucursal.
RN.02 – Reposición por stock mínimo. Todo registro de inventario define, además del stock
 actual, un stock mínimo. Cuando el stock actual llega o cae por debajo de ese mínimo, el sistema
 debe poder señalar la necesidad de reposición del producto en esa sucursal.
RN.03 – Registro de clientes. Todo cliente debe registrarse con documento, nombre, apellido y
 dirección antes de poder asociarse a una venta. El número de documento es único y no puede
 repetirse entre clientes.
RN.04 – Historial de precios unitarios en el detalle de venta. El precio unitario de cada
 producto se copia al detalle de la venta en el momento en que esta se registra. Si con
 posterioridad cambia el precio de venta del producto en el catálogo, las ventas ya registradas no
 se ven afectadas, preservando así el valor real de la operación y evitando cambios retroactivos.
RN.05 – Métodos de pago. Una venta puede saldarse con uno o más métodos de pago. La suma
 de los montos registrados en los pagos asociados a una venta debe ser igual al total de dicha
 venta.
RN.06 – Cálculo del precio de venta. El precio de venta de un producto no se carga de forma
 manual: se calcula automáticamente a partir de su precio de costo y el porcentaje de ganancia
 definido para ese producto.
RN.07 – Control de accesos por perfil. Cada usuario tiene asignado un único perfil, y cada perfil
 habilita un conjunto de funcionalidades del sistema. Un usuario solo puede acceder a las
 funcionalidades habilitadas para su perfil.
RN.08 – Bajas lógicas. Ninguna entidad del sistema (productos, clientes, usuarios, sucursales,
 etc.) se elimina físicamente de la base de datos: toda baja se registra completando la fecha de
 eliminación correspondiente, preservando la integridad del historial de ventas e inventario.
