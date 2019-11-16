# Resolución (para Practicar) del Final Alquieres_VA
# Nico Antonelli, Noviembre 2019

# EJERCICIO DDL
# Nota: Primero Ejecutar el DUMP para generar el Scheme "va_alquileres"

# 1) Completar la Tabla "contrata" desde Workbench y pegar el código generado (Consigna Eliminatoria)
ALTER TABLE `va_alquileres`.`contrata` 
ADD COLUMN `CUIL` VARCHAR(20) NULL AFTER `CodServicio`,
ADD PRIMARY KEY (`NroEvento`, `CodInstalacion`, `fechadesde`, `horadesde`, `CodServicio`);
;
ALTER TABLE `va_alquileres`.`contrata` 
ADD INDEX `contrata_servicios_idx` (`CodServicio` ASC) VISIBLE,
ADD INDEX `contrata_empleados_idx` (`CUIL` ASC) VISIBLE;
;
ALTER TABLE `va_alquileres`.`contrata` 
ADD CONSTRAINT `contrata_servicios`
  FOREIGN KEY (`CodServicio`)
  REFERENCES `va_alquileres`.`servicios` (`CodServicio`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `contrata_instalaciones_eventos`
  FOREIGN KEY (`NroEvento` , `CodInstalacion` , `fechadesde` , `horadesde`)
  REFERENCES `va_alquileres`.`instalaciones_eventos` (`NroEvento` , `CodInstalacion` , `fechadesde` , `horadesde`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `contrata_empleados`
  FOREIGN KEY (`CUIL`)
  REFERENCES `va_alquileres`.`empleados` (`cuil`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

########################

# EJERCICIOS DML

# 2) Indicar por empleado la cantidad de eventos que tuvo como coordinador. Mostrar CUIL, apellido, nombres y
# cantidad de eventos. Aquellos empleados que no fueron coordinadores en ningún evento indicar 0.

SELECT emp.cuil, emp.apellido, emp.nombre, count(eve.NroEvento) "Cantidad Eventos"
FROM empleados emp LEFT JOIN eventos eve ON emp.cuil = eve.CuilEmpleado
GROUP BY emp.cuil, emp.apellido, emp.nombre;

######

# 3) Ranking de servicios contratados indicando: datos del servicio, suma de la cantidad del servicio contratado
# para todos los eventos y porcentaje de esta suma sobre la suma total de las cantidades de servicios contratados. 
# Los servicios que no hayan sido contratados deberán figurar en la lista con cantidad total 0.
# Ordenar el ranking en forma descendente por porcentaje.

SELECT SUM(con.cantidad) INTO @cant_total
FROM contrata con;

SELECT ser.CodServicio, ser.DescServicio, ifnull(sum(con.cantidad), 0) "Cantidad Contratada",
concat(round((ifnull(sum(con.cantidad), 0) / @cant_total) * 100, 3), "%") Porcentaje
FROM servicios ser LEFT JOIN contrata con ON ser.CodServicio = con.CodServicio
GROUP BY ser.CodServicio, ser.DescServicio
ORDER BY Porcentaje DESC;

######

# 4) Calcular el total a pagar del Evento 5. El total debe incluir: la suma de los valores pactados por las
# instalaciones más la suma de los totales de servicios contratados. NOTA: el total de un servicio se calcula
# como la cantidad del servicio contratada por el valor del servicio a la fecha del contrato del evento.

SELECT eve.fechacontrato INTO @fechaEvento
FROM eventos eve
WHERE eve.NroEvento = 5;

SELECT sum(ie.valorpactado) valor INTO @precioInstalaciones
FROM instalaciones_eventos ie
WHERE ie.NroEvento = 5;

DROP TEMPORARY TABLE IF EXISTS temp_fechas_precios;
CREATE TEMPORARY TABLE temp_fechas_precios
	SELECT vs.CodServicio, max(vs.fechadesde) fecha
    FROM valores_servicios vs
    WHERE vs.fechadesde <= @fechaEvento
    GROUP BY vs.CodServicio;

DROP TEMPORARY TABLE IF EXISTS temp_precios_reales;
CREATE TEMPORARY TABLE temp_precios_reales
	SELECT vs.CodServicio, vs.valor
    FROM valores_servicios vs
    INNER JOIN temp_fechas_precios tfp
    ON vs.CodServicio = tfp.CodServicio AND vs.fechadesde = tfp.fecha;

SELECT round(@precioInstalaciones + sum(tpr.valor * con.cantidad), 2) "Precio Final"
FROM contrata con
INNER JOIN temp_precios_reales tpr
ON con.CodServicio = tpr.CodServicio
WHERE con.NroEvento = 5;

######

# 5) STORE PROCEDURE (SP): Desarrollar un SP que dada una nueva descripción de un tipo de evento lo registre
# en la tabla correspondiente manteniendo la correlatividad de los códigos de tipos de evento

# Stored Procedure:
USE `va_alquileres`;
DROP procedure IF EXISTS `nuevo_tipo_evento`;

DELIMITER $$
USE `va_alquileres`$$
CREATE PROCEDURE `nuevo_tipo_evento` (IN descripcion VARCHAR(20))
BEGIN
	SELECT max(te.CodTipoEvento)+1 INTO @id
    FROM tipos_evento te;
    
	START TRANSACTION;
		INSERT INTO tipos_evento VALUES(@id, descripcion);
    COMMIT;
END$$

DELIMITER ;

# Llamada al SP:
CALL nuevo_tipo_evento("Examen de GDD");

########################

# EJERCICIO TCL

# 6) Registrar los nuevos valores de servicios para la fecha de hoy en función de su valor anterior más un 20%.

DROP TEMPORARY TABLE IF EXISTS temp_fechas_precios;
CREATE TEMPORARY TABLE temp_fechas_precios
	SELECT vs.CodServicio, max(vs.fechadesde) fecha
    FROM valores_servicios vs
    GROUP BY vs.CodServicio;

START TRANSACTION;
	INSERT INTO valores_servicios
    SELECT vs.CodServicio, current_date(), vs.valor * 1.2
    FROM valores_servicios vs
    INNER JOIN temp_fechas_precios tpf
    ON vs.CodServicio = tpf.CodServicio AND vs.fechadesde = tpf.fecha;
COMMIT;

########################
