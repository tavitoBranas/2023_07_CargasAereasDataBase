CREATE DATABASE DBCARGAS_VALIDACION
GO
USE DBCARGAS
GO
set dateformat dmy;

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--CLIENTE

--Control mail unique
INSERT INTO Cliente values('Cliente','cli1@mail',0)

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--AVION

--control de capacidad < 0
INSERT INTO AVION values('0000000007','aaaaaaaaa1','vw','modelo',-0.1)
--control de capacidad = 0
INSERT INTO AVION values('0000000007','aaaaaaaaa1','vw','modelo',0)
--control de capacidad >150 
INSERT INTO AVION values('0000000007','aaaaaaaaa1','vw','modelo',150.1)
INSERT INTO AVION values('0000000007','aaaaaaaaa1','vw','modelo',151)

--control de lenght <10
INSERT INTO AVION values('5','aaaaaaaa1','vw','modelo',149)
--control de lenght >10 no es necesario por el char(10)

--control de solo letras de MATRICULA
INSERT INTO AVION values('0000000008','aaaaaaaaaa','vw','modelo',149)
--control de solo numeros de MATRICULA
INSERT INTO AVION values('0000000009','1111111111','vw','modelo',149)
--control de caracteres no alfanumericos de MATRICULA
INSERT INTO AVION values('0000000004','aaaaaaaa1!','vw','modelo',149)

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--DCONTAINER

--control de DcontId
INSERT INTO Dcontainer values('ABCA06',2.5,3.5,2.5,7.0,'Descrpcion 1')
INSERT INTO Dcontainer values('0BC006',2.5,3.5,2.5,7.0,'Descrpcion 1')
INSERT INTO Dcontainer values('A0C006',2.5,3.5,2.5,7.0,'Descrpcion 1')
INSERT INTO Dcontainer values('ABC0B6',2.5,3.5,2.5,7.0,'Descrpcion 1')
INSERT INTO Dcontainer values('ABC00C',2.5,3.5,2.5,7.0,'Descrpcion 1')
INSERT INTO Dcontainer values('6BC006',2.5,3.5,2.5,7.0,'Descrpcion 1')

--control de largo < 0 
INSERT INTO Dcontainer values('ABC002',-0.1,3.5,2.5,7,'Descrpcion 1')
--control de largo = 0 
INSERT INTO Dcontainer values('ABC002',0,3.5,2.5,7,'Descrpcion 1')
--control de largo maxima 
INSERT INTO Dcontainer values('ABC002',2.6,3.5,2.5,7,'Descrpcion 1')

--control de ancho < 0  
INSERT INTO Dcontainer values('ABC003',2.5,-0.1,2.5,7,'Descrpcion 1')
--control de ancho = 0  
INSERT INTO Dcontainer values('ABC003',2.5,0,2.5,7,'Descrpcion 1')
--control de ancho maxima 
INSERT INTO Dcontainer values('ABC003',2.5,3.6,2.5,7,'Descrpcion 1')

--control de alto < 0  
INSERT INTO Dcontainer values('ABC004',2.5,3.5,-0.1,7,'Descrpcion 1')
--control de alto = 0  
INSERT INTO Dcontainer values('ABC004',2.5,3.5,0,7,'Descrpcion 1')
--control de alto maximo 
INSERT INTO Dcontainer values('ABC004',2.5,3.5,2.6,7,'Descrpcion 1')

--control de capacidad < 0  
INSERT INTO Dcontainer values('ABC005',2.5,3.5,2.5,-0.1,'Descrpcion 1')
--control de capacidad = 0  
INSERT INTO Dcontainer values('ABC005',2.5,3.5,2.5,0,'Descrpcion 1')
--control de capacidad maximo 
INSERT INTO Dcontainer values('ABC005',2.5,3.5,2.5,7.1,'Descrpcion 1')

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
		
--CARGA

--Control aeropuerto inicial diferente a destino
INSERT INTO Carga (avionID, dContID, cargaFch, cliID, aeroOrigen,aeroDestino,cargaStatus) values
	('0000000001','ABC001','01/02/2023',1,'123','123','Cargado')

--Control status de la carga acepta valores permitidos
INSERT INTO Carga (avionID, dContID, cargaFch, cliID, aeroOrigen,aeroDestino,cargaStatus) values
	('0000000001','ABC001','01/02/2023',1,'ABC','123','Cargados')

--Control (AvionId, DContId, CargaFech) unique
INSERT INTO Carga (avionID, dContID, cargaFch, cliID, aeroOrigen,aeroDestino,cargaStatus) values
	('0000000001','ABC007','01/01/2017',4,'ABC','123','Cargado')

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--PROCEDURES
	
--PR_MaximoKilosEntreFechas
declare @fechaIni date
declare @fechaFin date
declare @avionId char(10)
declare @cliNom varchar(30)
set @fechaIni = convert(date, '2022-01-01')
set @fechaFin = convert(date, '2024-01-01')

exec PR_MaximoKilosEntreFechas @fechaIni, @fechaFin, @avionId output, @cliNom output
print 'Entre las fechas ' + convert (varchar,@fechaIni) + ' y ' + convert (varchar,@fechaFin) +
	' el identificador de avion que transporto mayor kilaje fue ' + convert (varchar,@avionId) + 
	' y el cliente que transporto mas kilaje fue ' + convert (varchar,@cliNom)
go

		--SOLUCION avion con mas carga dentro de esas fechas 
		select ca.avionID as Avion, Sum(ca.cargaKilos) as KilosTotales
		From Carga ca 
		where ca.cargaFch between convert(date, '2022-01-01') and convert(date, '2024-01-01') 
			and ca.cargaStatus in ('Cargado', 'Transito', 'Descargado', 'Entregado')
		Group by ca.avionID
		order by SUM(ca.cargaKilos) desc
		GO

		--SOLUCION cliente con mas carga dentro de esas fechas 
		select SUM(ca.cargaKilos) as KilosTotales, cl.cliNom as NombreCliente 
		from Carga ca join Cliente cl on ca.cliID = cl.cliID
		where ca.cargaFch between convert(date, '2022-01-01') and convert(date, '2024-01-01')
			and ca.cargaStatus in ('Cargado', 'Transito', 'Descargado', 'Entregado')
		Group by cl.cliNom
		order by SUM(ca.cargaKilos) desc
		GO

--PR_ContenedorSegunMedidas
declare @largo decimal(2,1)
declare @ancho decimal(2,1)
declare @alto decimal(2,1)
set @largo = 2.5
set @ancho = 3.5
set @alto = 2.5

exec PR_ContenedorSegunMedidas @largo, @ancho, @alto
go

		--SOLUCION 
		select * from Dcontainer
		go

--FN_CantidadKilosRecibidos
declare @cantidadKilos decimal(18,0)
declare @aeroIATA char(3)
set @aeroIATA = 'PAN'
set @cantidadKilos = dbo.FN_CantidadKilosRecibidos(@aeroIATA)
if (@cantidadKilos is not null)
	print 'La cantidad de kilos recibidos en el aeropuerto ' + @aeroIATA + ' fue de ' + 
		convert(varchar, @cantidadKilos)
else 
	print 'No existen registros'
go

		--SOLUCION
		select a.codIATA as CodigoAeropuerto, SUM(c.cargaKilos) KilosTotales 
		from Aeropuerto a left join carga c on (a.codIATA = c.aeroDestino and c.cargaStatus in ('Descargado', 'Entregado'))
		group by a.codIATA
		go

--FN_KilosTotalesCliente
declare @kilosTotales decimal(18,0)
declare @cliId int
set @cliId = 1
set @kilosTotales = dbo.FN_KilosTotalesCliente(@cliId)

if (@kilosTotales is not null)
	print 'La cantidad de kilos transportados por el cliente ' + convert(varchar, @cliId) + ' fue de ' + 
		convert(varchar, @kilosTotales)
else 
	print 'No existen registros'
go

		--SOLUCION
		select SUM(c.cargaKilos) as KilosTotales
		from Carga c
		where c.cargaStatus not in ('Reservado', 'Cargado') and c.cliID = 1 and aeroDestino != aeroOrigen
		go

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
		
--Triggers

--trigger TR_MantenimientoCarga
insert into Carga (avionID, dContID, cargaFch, cliID, aeroOrigen,aeroDestino,cargaStatus) values
		('0000000003','ABC007','31/12/2024',1,'ABC','USA','Reservado')
delete from Carga where cargaFch = '31/12/2024'
select * from cliente
go

--trigger TR_AuditContainer
update Dcontainer set dcontLargo = 0.5 where dContID = 'ABC003'
select * from AuditContainer 
go

--trigger TR_CheckeoCarga
insert into Carga (avionID, dContID, cargaFch, cliID, aeroOrigen,aeroDestino,cargaStatus) values
				('0000000003','ABC007','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC100','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC110','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC120','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC130','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC140','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC150','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC160','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC170','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC180','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC190','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC200','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC210','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC211','01/01/2024',1,'ABC','USA','Reservado'),
				('0000000003','ABC002','01/01/2024',1,'ABC','USA','Reservado')
				--,('0000000003','ABC010','01/01/2024',1,'ABC','USA','Reservado')
				--si se agrega esta ultima linea entonces se exede el limite del avion por 0.1 toneladas y no se accepta los insert
go

