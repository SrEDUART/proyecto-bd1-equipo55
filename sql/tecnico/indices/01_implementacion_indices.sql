USE ProyectoFerreteria;
GO

-- Se crea tabla masiva VENTA_HISTORICA 
IF OBJECT_ID('VENTA_HISTORICA', 'U') IS NOT NULL
    DROP TABLE VENTA_HISTORICA;
GO

CREATE TABLE VENTA_HISTORICA (
    id_venta INT IDENTITY(1,1) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    domicilio_entrega VARCHAR(150) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    fecha_venta DATETIME NOT NULL,
    id_usuario INT NOT NULL
);
GO

-- Se carga 1.000.000 de registros de prueba. La tabla queda sin indices
-- para que la demostracion pueda medir primero el escenario base.
SET NOCOUNT ON;
GO

WITH numeros AS (
    SELECT TOP (1000000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO VENTA_HISTORICA (estado, domicilio_entrega, total, fecha_venta, id_usuario)
SELECT 
    CASE n % 3 
        WHEN 0 THEN 'Pendiente'
        WHEN 1 THEN 'Entregado'
        ELSE 'Cancelado' 
    END,
    'Domicilio de prueba ' + CAST(n AS VARCHAR(10)),
    CAST((ABS(CHECKSUM(NEWID())) % 1000000) / 100.0 + 1 AS DECIMAL(10,2)),
    DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 86400,
            DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1826, CAST('2020-01-01' AS DATETIME))),
    (n % 10) + 1
FROM numeros;
GO
