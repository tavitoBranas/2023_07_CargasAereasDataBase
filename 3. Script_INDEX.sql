Create database DBCARGAS_INDEX
GO
USE DBCARGAS
GO

CREATE INDEX IDX_CargaDcontainer ON Carga(dContID)
CREATE INDEX IDX_CargaCliente ON Carga(cliID)
CREATE INDEX IDX_CargaAeroOrigen ON Carga(aeroOrigen)
CREATE INDEX IDX_CargaAeroDestino ON Carga(aeroDestino)
CREATE INDEX IDX_iDContainer ON AuditContainer(dContID)
GO
