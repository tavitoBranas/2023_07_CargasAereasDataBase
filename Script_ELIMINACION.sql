create database eliminacion
go
USE DBCARGAS
GO

delete from Carga

Select * from CARGA;
Select * from AEROPUERTO;
Select * from DCONTAINER;
Select * from AVION;
Select * from CLIENTE;


delete from CARGA 
delete from AEROPUERTO;
delete from DCONTAINER;
delete from AVION;
delete from CLIENTE;

drop table CARGA;
drop table AEROPUERTO;
drop table DCONTAINER;
drop table AVION;
drop table CLIENTE;
drop table AuditContainer;
