# Resolución (para Practicar) del Final RRHH
# Nico Antonelli, Noviembre 2019

# EJERCICIO DDL
# Nota: Primero Ejecutar el DUMP para generar el Scheme "recursos_humanos"

# 1) Completar la Tabla "proceso_seleccion" desde Workbench y pegar el código generado (Consigna Eliminatoria)

ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
CHANGE COLUMN `cod_area` `cod_area` INT(3) NOT NULL ,
CHANGE COLUMN `cod_puesto` `cod_puesto` INT(3) NOT NULL ,
CHANGE COLUMN `fecha_solic` `fecha_solic` DATE NOT NULL ,
CHANGE COLUMN `tipo_doc` `tipo_doc` CHAR(7) NOT NULL ,
CHANGE COLUMN `nro_doc` `nro_doc` INT(9) NOT NULL ,
CHANGE COLUMN `fecha_hora` `fecha_hora` DATETIME NOT NULL ,
CHANGE COLUMN `legajo` `legajo` INT(9) NOT NULL ,
CHANGE COLUMN `cod_estado` `cod_estado` INT(3) NOT NULL ,
ADD PRIMARY KEY (`cod_area`, `cod_puesto`, `fecha_solic`, `tipo_doc`, `nro_doc`, `fecha_hora`),
ADD INDEX `proceso_seleccion_empleados_idx` (`legajo` ASC) VISIBLE,
ADD INDEX `proceso_seleccion_personas_idx` (`tipo_doc` ASC, `nro_doc` ASC) VISIBLE,
ADD INDEX `proceso_seleccion_estados_idx` (`cod_estado` ASC) VISIBLE;
;
ALTER TABLE `recursos_humanos`.`proceso_seleccion` 
ADD CONSTRAINT `proceso_seleccion_solicitudes_puestos`
  FOREIGN KEY (`cod_area` , `cod_puesto` , `fecha_solic`)
  REFERENCES `recursos_humanos`.`solicitudes_puestos` (`cod_area` , `cod_puesto` , `fecha_solic`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `proceso_seleccion_empleados`
  FOREIGN KEY (`legajo`)
  REFERENCES `recursos_humanos`.`empleados` (`legajo`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `proceso_seleccion_personas`
  FOREIGN KEY (`tipo_doc` , `nro_doc`)
  REFERENCES `recursos_humanos`.`personas` (`tipo_doc` , `nro_doc`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `proceso_seleccion_estados`
  FOREIGN KEY (`cod_estado`)
  REFERENCES `recursos_humanos`.`estados` (`cod_estado`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

########################

# EJERCICIOS DML

# 2) Indicar de los empleados que actualmente trabajan en el área de RRHH, de cuántas personas han realizado registro
# en el proceso de selección en el presente año. Mostrar Legajo, apellido y nombres del empleado y cantidad de personas de
# las que han realizado registro en el proceso de selección. Aquellos empleados que actualmente trabajan en el área de RRHH
# y que no han hecho registro en el proceso de selección listarlos con cantidad en cero.

# NOTAS:
# -Para saber donde trabajan los empleados actualmente buscar el último cambio de puesto del empleado a la
# fecha de hoy y luego verificar si el empleado trabaja en el área de RRHH en ese cambio
# -Para la cantidad de personas se cuentan las distintas personas para las cuales el empleado de RRHH tiene
# registros en la tabla proceso de selección

DROP TEMPORARY TABLE IF EXISTS temp_ultimos_puestos;
CREATE TEMPORARY TABLE temp_ultimos_puestos
	SELECT ep.legajo, max(ep.fecha_ini) fecha
    FROM empleados_puestos ep
    WHERE ep.fecha_ini <= current_date()
    GROUP BY ep.legajo;

SELECT ar.cod_area INTO @area_RRHH
FROM areas ar
WHERE ar.denominacion = "RRHH";

SELECT tup.legajo, emp.apellido, emp.nombre, count(distinct(concat(ps.tipo_doc, ps.nro_doc))) cant_registros
FROM temp_ultimos_puestos tup
INNER JOIN empleados emp ON tup.legajo = emp.legajo
INNER JOIN empleados_puestos ep ON emp.legajo = ep.legajo
LEFT JOIN proceso_seleccion ps ON emp.legajo = ps.legajo
WHERE ep.cod_area = @area_RRHH AND year(ps.fecha_hora) = 2018  # Puse 2018 porque year(current_date()) aparecía vacío
GROUP BY tup.legajo, emp.apellido, emp.nombre;

######

# 3) Ranking de solicitudes para puestos de trabajo indicando: código y denominación del área, código y descripción del puesto
# de trabajo, cantidad de solicitudes registradas, porcentaje de solicitudes por puesto sobre la cantidad total de solicitudes
# registradas y suma de las cantidades de puestos solicitados. Ordenar el ranking en forma descendente por porcentaje de solicitudes.

# NOTA: el porcentaje deberá calcularse con solo dos dígitos decimales.

SELECT count(*) INTO @cant_solicitudes
FROM solicitudes_puestos sp;

SELECT ar.cod_area, ar.denominacion, pt.cod_puesto, pt.descripcion, count(sp.cod_puesto) solicitudes,
round((count(sp.cod_puesto) / @cant_solicitudes) * 100, 2) porcentaje, sum(sp.cant_puestos_solic) puestos
FROM solicitudes_puestos sp
INNER JOIN areas ar ON sp.cod_area = ar.cod_area
INNER JOIN puestos_de_trabajo pt ON sp.cod_puesto = pt.cod_puesto
GROUP BY ar.cod_area, ar.denominacion, pt.cod_puesto, pt.descripcion
ORDER BY porcentaje DESC;

######

# 4) STORE PROCEDURE (SP): Desarrollar un SP para el registro inicial del proceso de selección, recibiendo como parámetros la
# fecha del día y el legajo del empleado que lanza el proceso. Tener en cuenta que para cada solicitud de puesto de trabajo activa
# (no tiene fecha de cancelación) se deberán registrar las personas que continuarán luego el proceso de selección:

# Las personas seleccionadas:
# - No deben ser o haber sido empleados de la empresa
# - No deben estar participando ya del proceso de selección para la solicitud
# - Debe haber una coincidencia en al menos dos de las competencias requeridas para el puesto de trabajo como
# excluyentes y las competencias que la persona incluyó en su curriculum.

# Stored Procedure:
USE `recursos_humanos`;
DROP procedure IF EXISTS `start_proceso_seleccion`;

DELIMITER $$
USE `recursos_humanos`$$
CREATE PROCEDURE `start_proceso_seleccion` (IN fecha_in datetime, IN legajo_in INT)
BEGIN
	SELECT est.cod_estado INTO @estado_inicial
    FROM estados est
    WHERE est.desripcion = "Iniciado";
    
    START TRANSACTION;
		INSERT INTO proceso_seleccion
        SELECT sp.cod_area, sp.cod_puesto, sp.fecha_solic, cur.tipo_doc, cur.nro_doc,
        fecha_in, legajo_in, "", @estado_inicial
        FROM solicitudes_puestos sp
        INNER JOIN puestos_competencias pc
        ON sp.cod_area = pc.cod_area AND sp.cod_puesto = pc.cod_puesto
        INNER JOIN curriculum cur ON pc.cod_competencia = cur.cod_competencia
        LEFT JOIN empleados emp ON emp.tipo_doc = cur.tipo_doc AND emp.nro_doc = cur.nro_doc
		LEFT JOIN proceso_seleccion ps ON ps.cod_area = sp.cod_area AND ps.cod_puesto = sp.cod_puesto
		AND ps.fecha_solic = sp.fecha_solic AND ps.tipo_doc = c.tipo_doc AND ps.nro_doc = c.nro_doc
        WHERE sp.fecha_canc IS NULL  # Solo Solicitudes Activas (Fecha Cancelación NULL)
        AND pc.excluyente = 'SI'  # Solo tener en cuenta para el Count los Excluyentes
		AND ps.legajo IS NULL  # No tomar Personas que ya se encuentran en proceso_selecccion
		AND ps.nro_doc IS NULL  # Lo mismo que arriba, y también filtra que NO sea Empleado de la Empresa
		GROUP BY sp.cod_area, sp.cod_puesto, sp.fecha_solic, cur.tipo_doc, cur.nro_doc
		HAVING count(distinct(cur.cod_competencia)) >= 2;  # Coincidencia de al menos 2 Excluyentes
    COMMIT;
END$$

DELIMITER ;

# Selecciono un Legajo:
SET @legajo = "169";

# Llamada al SP:
CALL start_proceso_seleccion(timestamp(), @legajo);

########################

# EJERCICIO TCL

# 5) Registrar los nuevos valores hora para los puestos de trabajo para ser aplicados a partir del primer día del mes
# que viene. Los nuevos valores tendrán el siguiente incremento: para aquellos valores hora menores a $150 se
# realizará un incremento del 25%, para los mayores o iguales a $150 el incremento será de un 20%.

DROP TEMPORARY TABLE IF EXISTS temp_last_salarios;
CREATE TEMPORARY TABLE temp_last_salarios
	SELECT sal.cod_area, sal.cod_puesto, max(sal.fecha) fecha
    FROM salario sal
    WHERE sal.fecha <= current_date()
    GROUP BY sal.cod_area, sal.cod_puesto;

START TRANSACTION;
	INSERT INTO salarios
    SELECT sal.cod_area, sal.cod_puesto, "2019/12/01", CASE	WHEN sal.valor_hora >= 150
															THEN round((valor_hora)*1.2, 2)
															ELSE round((valor_hora)*1.25, 2)
                                                       END
	FROM temp_last_salarios tls
    INNER JOIN salario sal ON tls.cod_area = sal.cod_area AND tls.cod_puesto = sal.cod_puesto
    AND tls.fecha = sal.fecha;
    # También se podrían haber hecho 2 INSERT distintos con WHERE despues de los JOIN y listo
COMMIT;

########################
