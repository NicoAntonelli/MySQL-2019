# PREPARCIAL GESTION DE DATOS - SQL

# ALUMNO: ANTONELLI, NICOLÁS
# LEGAJO: 44852
# COMISIÓN: 303
# FECHA: 23/09/19

/*
1) 1,5 pts. De los artistas registrados listar sus datos y la cantidad de espectáculos en los que hayan participado.
De aquellos artistas que no hayan participado en ningún espectáculo indicar 0.
*/

SELECT art.cuit, art.descripcion, art.telefono, art.email, art.actividad,
ifnull(art.nombre_comercial, "NO ES UN GRUPO") nombre_comercial, ifnull(art.nombre, "NO ES INDIVIDUAL") nombre,
ifnull(art.apellido, "NO ES INDIVIDUAL") apellido, count(esp.cuit_artista) "Cantidad de Espectáculos"
FROM comuna.artista art
LEFT JOIN comuna.espectaculo esp ON art.cuit = esp.cuit_artista
GROUP BY art.cuit, art.descripcion, art.telefono, art.email, art.actividad,
art.nombre_comercial, art.nombre, art.apellido;

############

/*
2) 1,75 pts. De las personas que hayan participado en competencias listar aquellas que hayan salido más de una vez entre los
tres primeros puestos. Indicar datos de las personas y cantidad de veces en que el puesto haya sido uno de los tres primeros.
*/

SELECT par.dni_persona, per.nombre, per.apellido, count(*) cantidad_premios
FROM comuna.participante par
INNER JOIN comuna.persona per ON par.dni_persona = per.dni
WHERE par.puesto IN (1, 2, 3)
GROUP BY par.dni_persona, per.nombre, per.apellido HAVING cantidad_premios > 1;

############

/*
3) 1.5 pts. Listar los tipos de competencias que se realizaron el año pasado pero no este año. Indicar Código y Descripción
del Tipo de Competencia.
*/

# Tabla Temporal Competencias de 2019
DROP TEMPORARY TABLE IF EXISTS temp_tipos_comp;
CREATE TEMPORARY TABLE temp_tipos_comp
	SELECT DISTINCT tc.codigo
    FROM comuna.tipo_competencia tc
    INNER JOIN comuna.competencia com
    ON tc.codigo = com.codigo_tipo_competencia
    WHERE year(com.fecha_hora_ini) = year(curdate());

SELECT DISTINCT tc.codigo, tc.descripcion
FROM comuna.tipo_competencia tc
INNER JOIN comuna.competencia com ON tc.codigo = com.codigo_tipo_competencia
WHERE year(com.fecha_hora_ini) = 2018 AND tc.codigo NOT IN (SELECT * FROM temp_tipos_comp);

############

/*
4) 2,5 pts. Listar los recursos cuyo valor actual supere al promedio de los valores actuales. Indicar: Código, descripción
del recurso, valor actual y diferencia con el promedio de los valores actuales.
*/

# Tabla Temporal con las últimas fechas de precios de los productos
DROP TEMPORARY TABLE IF EXISTS temp_valores;
CREATE TEMPORARY TABLE temp_valores
	SELECT vd.codigo_recurso, max(vd.fecha_desde) fecha
    FROM comuna.valor_diario vd
	GROUP BY vd.codigo_recurso;

# Variable con el promedio de valores actuales
SELECT round(avg(vd.valor), 2) INTO @var_prom_valor
FROM temp_valores tv
INNER JOIN valor_diario vd ON tv.codigo_recurso = vd.codigo_recurso
WHERE tv.fecha = vd.fecha_desde;

# Para Ver el Promedio: SELECT @var_prom_valor;

SELECT vd.codigo_recurso, vd.fecha_desde, vd.valor,
round((vd.valor - @var_prom_valor), 2) "Diferencia con el Promedio"
FROM temp_valores tv
INNER JOIN valor_diario vd ON tv.codigo_recurso = vd.codigo_recurso
WHERE tv.fecha = vd.fecha_desde AND vd.valor > @var_prom_valor;

############

/*
5) 1,25 pts. Crear el evento "Día de la Madre 2019" con los mismos datos del Evento "Día de la Madre 2018"
(considerar que la fecha este año es el 20/10/2019). Los espectáculos serán los mismos que los del año 2018.

-- Lo cambio por "Feria Just Do It" (evento de 2018) y creo "Feria Just Do It 2019" porque no poseo dia de las madres 2018
*/

# Error en la Transaction: En vez de poner solo "13" en el ID, debí haber consultado con una Query el ID con max(eve.nro)
# SELECT max(eve.nro)+1 INTO @new_id FROM comuna.evento eve;

START TRANSACTION;
	INSERT INTO evento
    SELECT 13, "feria just do it 2019", adddate(eve.fecha_hora_ini, interval 1 year),
    adddate(eve.fecha_hora_fin, interval 1 year)
    FROM evento eve WHERE eve.nro = 10;
    # La eve.descripcion es "feria just do it"
    
    INSERT INTO espectaculo
	SELECT 13, esp.nro_espectaculo, esp.nombre, adddate(esp.fecha_hora_ini, interval 1 year),
    adddate(esp.fecha_hora_fin, interval 1 year), esp.costo_cont, esp.cuit_artista, esp.codigo_lugar
	FROM espectaculo esp WHERE esp.nro_evento = 10;
COMMIT;

############

/*
6) 1,5 pts. Listar los lugares y la cantidad de espectáculos que se hayan realizado allí en un año en particular. La cantidad
de espectáculos debe calcularse en una función creada a tal efecto que reciba el código del lugar y el año que se quiera listar.
*/

# El Código de "Rosario" en mi DB es 1, por ejemplo
SELECT lug.codigo, lug.nombre,
func_espectaculos(2018, lug.codigo) "Cantidad de Espectáculos"
FROM comuna.lugar lug;

# Función Creada en "Functions" de la DB Comuna:
USE `comuna`;
DROP function IF EXISTS `func_espectaculos`;

DELIMITER $$
USE `comuna`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `func_espectaculos`(anio INTEGER(10), city INTEGER(10)) RETURNS int(10)
BEGIN
	DECLARE cant_esp INTEGER(10);
	SELECT count(*) INTO cant_esp
	FROM espectaculo esp
    WHERE esp.codigo_lugar = city;
	RETURN cant_esp;
END$$

DELIMITER ;

############
