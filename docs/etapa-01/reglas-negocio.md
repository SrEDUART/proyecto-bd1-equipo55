# Reglas de Negocio -- Ferretería Multisucursal

A continuación se detallan las reglas de negocio que rigen las operaciones y el modelado de la base de datos del sistema.

| Código | Regla de Negocio | Descripción |
| :--- | :--- | :--- |
| **RN.01** | **Gestión de Stock** | Cada producto tiene un stock independiente por sucursal. No se puede registrar una venta ni el detalle de una venta si la cantidad solicitada supera el stock disponible del producto en esa sucursal. |
| **RN.02** | **Reposición por Stock Mínimo** | Todo registro de inventario define un stock actual y un stock mínimo. Cuando el stock actual llega o cae por debajo del mínimo, el sistema debe señalar la necesidad de reposición. |
| **RN.03** | **Registro de Clientes** | Todo cliente debe registrarse con documento, nombre, apellido y dirección antes de asociarse a una venta. El número de documento es único e irrepetible. |
| **RN.04** | **Historial de Precios Unitarios** | El precio unitario de cada producto se copia al detalle de la venta al momento del registro. Modificaciones posteriores en el catálogo no afectan las ventas pasadas, preservando el valor histórico. |
| **RN.05** | **Métodos de Pago** | Una venta puede saldarse con uno o varios métodos de pago (efectivo, tarjetas, transferencias, etc.). La suma de los montos debe ser exactamente igual al total de la venta. |
| **RN.06** | **Cálculo del Precio de Venta** | El precio de venta no se carga manualmente: se calcula automáticamente a partir del precio de costo y el porcentaje de ganancia definido para el producto. |
| **RN.07** | **Control de Accesos por Perfil** | Cada usuario tiene un único perfil asignado. Cada perfil habilita un conjunto específico de funcionalidades del sistema a las cuales el usuario puede acceder. |
| **RN.08** | **Bajas Lógicas** | Ninguna entidad principal se elimina físicamente de la base de datos. Toda baja se registra completando la fecha de eliminación (`eliminado_en`), preservando la integridad referencial e histórica. |
