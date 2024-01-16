Create database DBCARGAS_ProceduresFunctions
GO
USE DBCARGAS
GO
set dateformat dmy
GO

-- a. Escribir un procedimiento almacenado que reciba como parámetros un rango de fecha y retorne 
	--también por parámetros el identificador de avión que cargó más kilos en dicho rango de fechas 
	--y el nombre del cliente que cargó más kilos en dicho rango (si hay más de uno, mostrar el primero).

create procedure PR_MaximoKilosEntreFechas @fechaIni date, @fechaFin date, @avionId char(10) output, @cliNom varchar(30) output
as 
begin
	select top 1 @avionId = ca.avionID  
		from Carga ca join Cliente cl on ca.cliID = cl.cliID
		where ca.cargaFch between @fechaIni and @fechaFin and ca.cargaStatus in ('Cargado', 'Transito', 'Descargado', 'Entregado')
		group by ca.avionID, cl.cliNom, ca.cargaFch
		Order by SUM(ca.cargaKilos) desc, ca.cargaFch asc
	select top 1 @cliNom = cl.cliNom  
		from Carga ca join Cliente cl on ca.cliID = cl.cliID
		where ca.cargaFch between @fechaIni and @fechaFin and ca.cargaStatus in ('Cargado', 'Transito', 'Descargado', 'Entregado')
		group by cl.cliNom, ca.cargaFch
		Order by SUM(ca.cargaKilos) desc, ca.cargaFch asc
end 
go

-- b. Realizar un procedimiento almacenado que dadas las 3 medidas de un contenedor (largo x ancho x alto) 
	--retorne en una tabla los datos de los contenedores que coinciden con dichas medidas, de no existir ninguno 
	--se debe retornar un mensaje.

create procedure PR_ContenedorSegunMedidas @largo decimal(2,1), @ancho decimal(2,1), @alto decimal(2,1)
as
begin
	if exists(select * from Dcontainer where @largo = dContLargo and @ancho = dContAncho and @alto = dcontAlto)
		select * from Dcontainer 
			where @largo = dContLargo and @ancho = dContAncho and @alto = dcontAlto
	else
		print 'No se encontraron containers que cumplan con las medidas indicadas'
end
go

-- c. Hacer una función que reciba un código de aeropuerto y retorne la cantidad de kilos recibidos 
	-- de carga cuando ese aeropuerto fue destino.

create function FN_CantidadKilosRecibidos (@codIATA char(3)) returns decimal(18,0)
as
begin
	declare @cantidadKilos decimal(18,0)
	select @cantidadKilos = SUM(c.cargaKilos)
		from Aeropuerto a, Carga c 
		where a.codIATA = @codIATA and a.codIATA = c.aeroDestino and c.cargaStatus in ('Descargado', 'Entregado')
	return @cantidadKilos
end
go

-- d.Hacer una función que, para un cliente dado, retorne la cantidad total de 
	--kilos transportados por dicho cliente a aeropuertos de diferente país. 

create function FN_KilosTotalesCliente (@cliId int) returns decimal(18,0)
as
begin
	declare @kilosTotales decimal(18,0)
	select @kilosTotales = SUM(cargaKilos)
		from Carga 
		where cliID = @cliId and cargaStatus not in ('Reservado', 'Cargado')
	return @kilosTotales
end
go