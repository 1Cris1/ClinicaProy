USE [bd_clinica];
GO

-- 1. Crear tabla si no existe (Tabla Maestra Farmacia TEDEF 2026)
IF OBJECT_ID('farmacia_tedef', 'U') IS NOT NULL
    DROP TABLE farmacia_tedef;
GO

CREATE TABLE farmacia_tedef (
    VCODIAFAS_FAC VARCHAR(100),
    VCODIPRESS_FAC VARCHAR(100),
    VTDOCPAGO_FAC VARCHAR(10),
    VNDOCPAGO_FAC VARCHAR(100),
    VCORRPRESTA_ATE INT,
    VCORRPRODFARATE_FAR INT,
    VCODCATALOGO_FAR_020 VARCHAR(50),
    VCODPROD_FAR_020 VARCHAR(50),
    VCODIGEMID_FAR_020 VARCHAR(50),
    VTPROD_FAR_003 VARCHAR(10),
    VCODCATALOGO_FAR_003 VARCHAR(50),
    VCODPROD_FAR_003 VARCHAR(50),
    VNUNMVENTPROD_FAR DECIMAL(18, 4),
    VTUNIDISP_FAR INT,
    VMONTUNISIMP_FAR DECIMAL(18, 4),
    VCOPAGOPRODFAR_FAR DECIMAL(18, 4),
    VMONTPRODFAR_FAR DECIMAL(18, 4),
    VMONTNCUBFAR_FAR DECIMAL(18, 4),
    VDIAGASOCPRODFAR_FAR VARCHAR(50),
    VPRODEXENIGV_FAR VARCHAR(10),
    DFECRECEP_PQ DATETIME,
    UBIGEO VARCHAR(10)
);
GO

-- 2. Importar datos masivamente desde el CSV
BULK INSERT farmacia_tedef
FROM 'C:\Users\RYZEN\Desktop\ClinicaProy\clinica\PCM_BD_farmacia_tedef_2026_marzo.csv'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    CODEPAGE = '65001', -- UTF-8
    TABLOCK,
    ERRORFILE = 'C:\Users\RYZEN\Desktop\ClinicaProy\clinica\import_errors.log'
);
GO

-- 3. Crear índices para búsquedas rápidas (Recomendación para el backend)
CREATE INDEX IX_Farmacia_Gemid ON farmacia_tedef(VCODPROD_FAR_003);
CREATE INDEX IX_Farmacia_Ubigeo ON farmacia_tedef(UBIGEO);
GO
