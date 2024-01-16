Create database DBCARGAS_TRIGGERS
GO
USE DBCARGAS
GO
set dateformat dmy
GO

-- a. Realizar un disparador que lleve un mantenimiento de la cantidad de cargas acumuladas de un cliente, 
	--este disparador debe controlar tanto los ingresos de cargas como el borrado de cargas.

create trigger TR_MantenimientoCarga
on Carga
After insert, delete
as
begin
	if exists (select * from inserted) and not exists (select * from deleted)	
		begin
			update Carga set cargaKilos = (select dcontCapacidad * 1000 from Dcontainer d where Carga.dContID = d.dContID)
				--se incluye el update de carga kilos del conteiner en carga
			update Cliente set cliCantCargas += (select COUNT(i.idCarga) from inserted i where i.cliID = Cliente.cliID)
		end
	if not exists (select * from inserted) and exists (select * from deleted)
		update Cliente set cliCantCargas += (select COUNT(d.idCarga) from deleted d where d.cliID = Cliente.cliID)
end
go

-- b. Hacer un disparador que, ante la modificación de cualquier medida de un contenedor, lleve un registro 
	--detallado en la tabla AuditContainer (ver estructura de la tabla en el anexo del presente obligatorio).

create trigger TR_AuditContainer
on Dcontainer
after update
as
begin
	if exists(select * from inserted) and exists (select * from deleted)
		insert into AuditContainer						
			select GETDATE(), HOST_NAME(),d.dContLargo, d.dContAncho, d.dcontAlto, d.dcontCapacidad, 
					i.dContLargo, i.dContAncho, i.dcontAlto, i.dcontCapacidad,i.dContID
				from inserted i, deleted d where i.dContID = d.dContID
end
go

--c. Realizar un disparador que cuando se registra una nueva carga se valide que el avión tiene capacidad suficiente 
	--para almacenarla, esta verificación debe tener en cuenta todas las cargas que se están haciendo en ese avión en la misma fecha.

create trigger TR_CheckeoCarga
on Carga
after insert
as 
begin
	if exists(
		select * 
		from carga c, avion a 
		where c.avionID = a.avionID 
		group by c.cargaFch, a.avionCapacidad
		having SUM(c.cargaKilos) > a.avionCapacidad*1000
		)
			rollback
end
go