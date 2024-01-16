Create database DBCARGAS_QUERIES
GO
USE DBCARGAS
GO
set dateformat dmy
GO

--CONSULTA 1
--Mostrar los datos de los clientes que cargaron más kilos este año que el promedio total
--de kilos cargados por todos los clientes el año pasado

select * from Cliente where cliID in (
	select cliID from Carga where YEAR(cargaFch) = YEAR(Getdate())  
	group by cliID 	
	having SUM (cargaKilos) > (select AVG(CargaKilos) from Carga where 
			cargaFch >= CAST('01/01/'+ convert(varchar(4),(convert(int,YEAR(GetDate()))-1)) as date) and
		    cargaFch <= CAST('31/12/'+ convert(varchar(4),(convert(int,YEAR(GetDate()))-1)) as date)))
--se esperan clientes 1(49000 kilos), 2(5000 kilos) y 3(3100 kilos) 
--el cliente 4 no cumple (3000 kilos) ya que el AVG del año pasado fue de 3000
GO

--CONSULTA 2
--Del total de kilos cargados por cada avión, mostrar cual fue el mayor valor, cual fue el
--promedio y cuál fue el menor valor.

select AvionId as Avion, avg(cargaKilos) as PromedioKilos, min(cargaKilos) as MinimaCarga, max(cargaKilos) as MaximaCarga from Carga
		where cargaStatus != 'Reservado'
Group by AvionId
GO

--CONSULTA 3

--Para cada tipo de contenedor, mostrar sus datos, la cantidad de cargas en los que fue
--utilizado y el total de kilos cargados, si algún tipo de contenedor nuca fue utilizado,
--también deben mostrarse sus datos.

select d.dContID, D.dContLargo, D.dContAncho, D.dcontAlto, d.dcontCapacidad, D.dContDescripcion, 
	COUNT(C.cargaKilos) as CantidadCargas, SUM(cargaKilos) as SumaKilos 
	from Dcontainer D left join carga C on D.dContID = C.dContID
Group by d.dContID, D.dContLargo, D.dContAncho, D.dcontAlto, d.dcontCapacidad, D.dContDescripcion
GO

--CONSULTA 4
--Mostrar los datos de los clientes que utilizaron todos los aviones disponibles para sus cargas.

SELECT cl.cliID, cl.cliNom, cl.cliMail, cl.cliCantCargas FROM Cliente cl
INNER JOIN Carga c ON c.cliID = cl.cliID
INNER JOIN Avion a ON a.avionID = c.avionID
GROUP BY cl.cliID, cl.cliNom, cl.cliMail, cl.cliCantCargas
HAVING COUNT (distinct a.avionID) = (SELECT COUNT (avionID) FROM Avion)
--se espera cliente 1 (transporto 6 de 6 aviones)
--el cliente 4 solo transporto en 5 de 6 aviones
GO                                    

--CONSULTA 5
--Mostrar el identificador de la carga, la fecha y los nombres de los aeropuertos de origen 
--y destino para todas las cargas del año actual que utilizan aviones con una capacidad mayor a las 100 toneladas.

SELECT c.idCarga, c.cargaFch, aO.aeroNombre as AeropuertoOrigen, aD.aeroNombre as AeropuertoDestino FROM Carga c
INNER JOIN Aeropuerto aO ON aO.codIATA = c.aeroOrigen
INNER JOIN Aeropuerto aD ON aD.codIATA = c.aeroDestino
INNER JOIN Avion a ON a.avionID = c.avionID
WHERE YEAR(c.cargaFch) = YEAR(GETDATE()) AND a.avionCapacidad > 100; 
--se esperan cargas idCarga: 49, 50, 51, 52, 55, 56
--el avion 3 posee transporte en el año actual pero toneladas permitidas (100) son menores a las permitidas
--avion 4 posee transporte en el año actual pero toneladas permitidas (99.9) son menores a las permitidas
GO

--CONSULTA 6
--Mostrar los datos del aeropuerto que recibió la mayor cantidad de kilos de los últimos 5 años

SELECT a.codIATA, a.aeroNombre, a.aeroPais FROM Carga c
INNER JOIN Aeropuerto a ON a.codIATA = c.aeroDestino
GROUP BY a.codIATA, a.aeroNombre, a.aeroPais
HAVING SUM(c.cargaKilos) IN(
			SELECT TOP 1 SUM(cargaKilos) AS TotalKg 
			FROM carga 
			WHERE cargaFch >= DATEFROMPARTS(YEAR(GETDATE())-5,1,1) and cargaStatus in ('Descargado', 'Entregado')
			GROUP BY  aeroDestino
			ORDER BY TotalKg DESC
)
--se espera codIATA 123 y PAN ambos con 76100 kilos mientras que 456 recibio 76000
GO