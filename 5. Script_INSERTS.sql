CREATE DATABASE DBCARGAS_INSERTS
GO
USE DBCARGAS
GO
set dateformat dmy
GO

--CLIENTE
	--CLIENTE CANTIDAD DE CARGAS va a tener un trigger
INSERT INTO Cliente values('Cliente 1','cli1@mail',0),
						  ('Cliente 2','cli2@mail',0),
						  ('Cliente 3','cli3@mail',0),
						  ('Cliente 4','cli4@mail',0),
						  ('Cliente 5','cli5@mail',0),
						  ('Cliente 6','cli6@mail',0),
						  ('Cliente 7','cli7@mail',0)
GO

--AVION
INSERT INTO AVION values('0000000001','aaaaaaaaa1','vw','modelo',101),
						('0000000002','1aaaaaaaaa','vw','modelo',100.1),
						('0000000003','aaaaaa1aaa','vw','modelo',100.0),
						('0000000004','111111111a','vw','modelo',99.9),
						('0000000005','a111111111','vw','modelo',150),
						('0000000006','1111a11111','vw','modelo',150)
GO

--DCONTAINER
INSERT INTO Dcontainer values('ABC001',2.5,3.5,2.5,1.0,'Descrpcion 1000 kilos'),
							 ('ABC002',0.2,0.2,0.2,2.0,'Descrpcion 2000 kilos'),
							 ('ABC003',0.3,0.3,0.3,3.0,'Descrpcion 3000 kilos'),
							 ('ABC004',0.4,0.4,0.4,4.0,'Descrpcion 4000 kilos'),
							 ('ABC005',0.5,0.5,0.5,5.0,'Descrpcion 5000 kilos'),
							 ('ABC006',2.5,3.5,2.5,6.0,'Descrpcion 6000 kilos'),
							 ('ABC007',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC010',2.5,3.5,2.5,0.1,'Descrpcion 100 kilos'),
							 ('ABC011',2.5,3.5,2.5,3.1,'Descrpcion 3100 kilos'),
							 ('ABC100',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC110',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC120',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC130',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC140',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC150',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC160',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC170',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC180',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC190',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC200',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC210',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos'),
							 ('ABC211',2.5,3.5,2.5,7.0,'Descrpcion 7000 kilos')
GO

--AEROPUERTO
INSERT INTO Aeropuerto values('ABC','Aeropuerto de Carrasco','Uruguay'),
							 ('123','Aeropuerto de Lima','Peru'),
							 ('PAN','Aeropuerto de Panama','Panama'),
							 ('456','Aeropuerto de Brasilia','Brasil'),
							 ('USA',' Aeropuerto de Miami', 'USA'),
							 ('789',' Aeropuerto de Ezeiza', 'Argentina')
GO

--CARGA
INSERT INTO Carga (avionID, dContID, cargaFch, cliID, aeroOrigen,aeroDestino,cargaStatus) values
	-- 2017
	('0000000001','ABC007','01/01/2017',4,'ABC','USA','Entregado'),
	('0000000002','ABC007','02/02/2017',4,'ABC','USA','Entregado'),
	('0000000003','ABC007','03/03/2017',4,'ABC','USA','Entregado'),
	('0000000004','ABC007','04/04/2017',4,'ABC','USA','Entregado'),
	('0000000005','ABC007','05/05/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','06/06/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','07/07/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','08/08/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','09/09/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','10/10/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','11/11/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','30/12/2017',4,'ABC','USA','Entregado'),
	('0000000001','ABC007','31/12/2017',4,'ABC','USA','Entregado'),
	-- 2018
	('0000000001','ABC007','01/01/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','02/02/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','03/03/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','04/04/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','05/05/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','06/06/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','07/07/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC001','08/08/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC011','09/09/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','10/10/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','09/09/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC007','30/12/2018',5,'ABC','PAN','Entregado'),
	('0000000001','ABC002','31/12/2018',5,'ABC','PAN','Entregado'),
	-- 2019
	('0000000001','ABC007','01/01/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','02/02/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','03/03/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','04/04/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','05/05/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','06/06/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','07/07/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','31/12/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','08/08/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC007','09/09/2019',6,'ABC','456','Entregado'),
	('0000000001','ABC006','10/10/2019',6,'ABC','456','Entregado'),
	-- 2020
	('0000000001','ABC007','01/01/2020',7,'ABC','789','Entregado'),
	('0000000001','ABC007','02/02/2020',7,'ABC','789','Entregado'),
	('0000000001','ABC007','03/03/2020',7,'ABC','789','Entregado'),
	('0000000001','ABC007','04/04/2020',7,'ABC','789','Entregado'),
	('0000000001','ABC007','05/05/2020',7,'ABC','789','Entregado'),
	('0000000001','ABC007','06/06/2020',7,'ABC','789','Entregado'),
	('0000000001','ABC007','31/12/2020',7,'ABC','789','Entregado'),
	-- 2021
	('0000000001','ABC007','06/03/2021',1,'ABC','123','Entregado'),
	-- 2022
	('0000000001','ABC002','01/01/2022',2,'ABC','123','Descargado'),
	('0000000002','ABC003','02/03/2022',2,'ABC','123','Entregado'),
	('0000000003','ABC004','31/12/2022',1,'ABC','123','Entregado'),
	-- 2023
	('0000000001','ABC007','01/01/2023',1,'ABC','123','Descargado'),
	('0000000002','ABC005','01/01/2023',2,'ABC','123','Descargado'),
	('0000000002','ABC007','02/03/2023',1,'ABC','123','Cargado'),
	('0000000001','ABC007','03/03/2023',1,'ABC','123','Cargado'),
	('0000000004','ABC007','04/03/2023',1,'ABC','123','Reservado'),
	('0000000004','ABC007','04/01/2023',1,'ABC','123','Entregado'),
	('0000000005','ABC007','05/03/2023',1,'ABC','123','Cargado'),
	('0000000006','ABC007','06/03/2023',1,'ABC','123','Entregado'), 
	('0000000003','ABC011','06/02/2023',3,'ABC','123','Entregado'),
    ('0000000003','ABC003','06/02/2023',4,'ABC','123','Cargado')
GO