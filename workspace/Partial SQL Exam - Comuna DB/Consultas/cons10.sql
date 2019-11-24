/*
Consulta 10:
Seleccionar los espectáculos que tengan un costo de contrato mayor al promedio de todos los espectáculos. Mostrando número de espectáculo,
nombre, fecha y hora de inicio, fecha y hora de finalización, costo del contrato y el promedio de todos los espectáculos.
*/

select avg(costo_cont) into @promedioEsp
from espectaculo;

select nro_espectaculo, nombre, fecha_hora_ini, fecha_hora_fin, costo_cont, @promedioEsp promedio_espectaculos
from espectaculo
where costo_cont>@promedioEsp;
