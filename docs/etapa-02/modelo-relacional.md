# Modelo Relacional
*(primera version)*
# Modelo Relacional

# Tablas principales

 SUCURSAL
- id_sucursal (PK)
- nombre
- telefono
- id_direccion (FK)
- eliminado_en

#Usuarios y control de acceso

USUARIO
- id_usuario (PK)
- id_perfil (FK)
- id_sucursal (FK)
- id_direccion (FK)
- nombre
- apellido
- dni
- telefono
- nombre_usuario
- contraseña_hash
- correo
- sexo
- fecha_nacimiento
- eliminado_en

 PERFIL
- id_perfil (PK)
- nombre
- descripcion
- eliminado_en

 FUNCIONALIDAD
- id_funcionalidad (PK)
- codigo
- nombre
- descripcion
- eliminado_en

 PERFIL_FUNCIONALIDAD
- id_perfil (PK, FK)
- id_funcionalidad (PK, FK)

# Productos

 CATEGORIA
- id_categoria (PK)
- nombre
- descripcion
- eliminado_en

 PRODUCTO
- id_producto (PK)
- id_categoria (FK)
- codigo_barra
- nombre
- descripcion
- precio_costo
- porcentaje_ganancia
- precio_venta
- eliminado_en
