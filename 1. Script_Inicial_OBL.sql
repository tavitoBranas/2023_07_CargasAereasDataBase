CREATE DATABASE DBCARGAS
GO
USE DBCARGAS
GO
/* Creacion de tablas SIN restricciones */
CREATE TABLE Cliente(cliID int identity not null,
                     cliNom varchar(30) not null,
					 cliMail varchar(50),
					 cliCantCargas int)
GO
CREATE TABLE Avion(avionID char(10) not null,
                   avionMAT varchar(20) not null,
				   avionMarca varchar(30) not null,
				   avionModelo varchar(30) not null,
				   avionCapacidad decimal)
GO
CREATE TABLE Dcontainer(dContID char(3) not null,
                       	dContLargo decimal,
						dContAncho decimal,
						dcontAlto decimal,
						dcontCapacidad decimal)
GO
CREATE TABLE Aeropuerto(codIATA char(3) not null,
                        aeroNombre varchar(30) not null,
						aeroPais varchar(30) not null)
GO
CREATE TABLE Carga(idCarga int identity not null,
                   avionID char(10) not null,
				   dContID char(3) not null,
				   cargaFch date,
				   cargaKilos decimal,
				   cliID int,
				   aeroOrigen char(3),
				   aeroDestino char(3),
				   cargaStatus char(1))
GO
CREATE TABLE AuditContainer(AuditID int identity not null,
                            AuditFecha datetime,
							AuditHost varchar(30),
                       	    LargoAnterior decimal,
						    AnchoAnterior decimal,
						    AltoAnterior decimal,
						    CapAnterior decimal,
							LargoActual decimal,
						    AnchoActual decimal,
						    AltoActual decimal,
						    CapActual decimal)
GO							