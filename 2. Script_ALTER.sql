Create database DBCARGAS_ALTER
GO
USE DBCARGAS
GO

--CLIENTE
ALTER TABLE CLIENTE ADD PRIMARY KEY(cliID)
ALTER TABLE CLIENTE ADD CONSTRAINT UK_Email_Cliente unique(cliMail)
ALTER TABLE CLIENTE ALTER COLUMN cliCantCargas int not null
GO

--AVION
ALTER TABLE AVION ADD PRIMARY KEY(avionID);
ALTER TABLE AVION ADD CONSTRAINT CK_avion_AvionID CHECK(LEN(avionID) = 10);
ALTER TABLE AVION ADD CONSTRAINT CK_avion_MAT CHECK(avionMAT like('%[A-Za-z]%') and avionMAT like('%[0-9]%') and avionMAT not like ('%[^0-9a-z]%'))
ALTER TABLE AVION ALTER COLUMN avionCapacidad decimal(4,1) not null;
ALTER TABLE AVION ADD CONSTRAINT CK_avion_Capacidad CHECK(avionCapacidad between 0.1 and 150);
GO

--DCONTAINER
ALTER TABLE DCONTAINER ALTER COLUMN dContID char(6) not null;
ALTER TABLE DCONTAINER ADD PRIMARY KEY(dContID) ;
ALTER TABLE DCONTAINER ADD dContDescripcion varchar(50);
ALTER TABLE DCONTAINER ALTER COLUMN dContLargo decimal(2,1) not null;
ALTER TABLE DCONTAINER ALTER COLUMN dContAncho decimal(2,1) not null;
ALTER TABLE DCONTAINER ALTER COLUMN dContAlto decimal(2,1) not null;
ALTER TABLE DCONTAINER ALTER COLUMN dContCapacidad decimal(2,1) not null;
ALTER TABLE DCONTAINER ADD CONSTRAINT CK_dContID CHECK(dContID like '[A-Za-z][A-Za-z][A-Za-z][0-9][0-9][0-9]');
ALTER TABLE DCONTAINER ADD CONSTRAINT CK_dCont_Largo CHECK(dContLargo between 0.1 and 2.5);
ALTER TABLE DCONTAINER ADD CONSTRAINT CK_dCont_Ancho CHECK(dContAncho between 0.1 and 3.5);
ALTER TABLE DCONTAINER ADD CONSTRAINT CK_dCont_Alto CHECK(dContAlto between 0.1 and 2.5);
ALTER TABLE DCONTAINER ADD CONSTRAINT CK_dcont_Capacidad CHECK(dContCapacidad between 0.1 and 7.0)
GO

--AEROPUERTO
ALTER TABLE AEROPUERTO ADD PRIMARY KEY(codIATA);
GO

--CARGA
ALTER TABLE CARGA ADD PRIMARY KEY(idCarga);
ALTER TABLE CARGA ALTER COLUMN dContID char(6) not null;
ALTER TABLE CARGA ALTER COLUMN cargaFch date not null;
ALTER TABLE CARGA ALTER COLUMN cargaKilos int;
ALTER TABLE CARGA ALTER COLUMN cargaStatus varchar(10) not null;
ALTER TABLE CARGA ALTER COLUMN cliID int not null;
ALTER TABLE CARGA ALTER COLUMN aeroOrigen char(3) not null;
ALTER TABLE CARGA ALTER COLUMN aeroDestino char(3) not null;
ALTER TABLE CARGA ADD CONSTRAINT FK_avionID_Avion FOREIGN KEY(avionID) References Avion(avionID);
ALTER TABLE CARGA ADD CONSTRAINT FK_dContID_Dcontainer FOREIGN KEY(dContID) References Dcontainer(dContID);
ALTER TABLE CARGA ADD CONSTRAINT FK_cliID_Cliente FOREIGN KEY(cliID) References cliente(cliID);
ALTER TABLE CARGA ADD CONSTRAINT FK_aeroOrigen_Aeropuerto FOREIGN KEY(aeroOrigen) References Aeropuerto(codIATA);
ALTER TABLE CARGA ADD CONSTRAINT FK_aeroDestino_Aeropuerto FOREIGN KEY(aeroDestino) References Aeropuerto(codIATA);
ALTER TABLE CARGA ADD CONSTRAINT CK_aeroOrigen_aeroDestino CHECK(aeroOrigen != aeroDestino);
ALTER TABLE CARGA ADD CONSTRAINT CK_cargaStatus CHECK(cargaStatus IN('Reservado', 'Cargado', 'Transito', 'Descargado', 'Entregado'));
ALTER TABLE CARGA ADD CONSTRAINT UK_avionID_dContID_cargaFch_Carga unique(avionID,dContID,cargaFch);
GO

--AuditContainer
ALTER TABLE AuditContainer ADD PRIMARY KEY(AuditID)
ALTER TABLE AuditContainer ADD dContID char(6) not null
ALTER TABLE AuditContainer ADD CONSTRAINT FK_dContID_DContainer_Audit FOREIGN KEY(dContID) References DContainer(dContID)
ALTER TABLE AuditContainer ALTER COLUMN AuditFecha datetime not null
ALTER TABLE AuditContainer ALTER COLUMN AuditHost varchar(30) not null
ALTER TABLE AuditContainer ALTER COLUMN LargoAnterior decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN LargoActual decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN AnchoAnterior decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN AnchoActual decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN AltoAnterior decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN AltoActual decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN CapAnterior decimal(2,1) not null
ALTER TABLE AuditContainer ALTER COLUMN CapActual decimal(2,1) not null