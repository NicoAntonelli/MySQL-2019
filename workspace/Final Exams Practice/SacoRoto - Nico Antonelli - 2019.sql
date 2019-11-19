# Resolución (para Practicar) del Final SacoRoto
# Nico Antonelli, Noviembre 2019

# EJERCICIO DDL
# Nota: Primero Ejecutar el DUMP para generar el Scheme "saco_roto"

# 1) Completar la Tabla "prendas" desde Workbench y pegar el código generado (Consigna Eliminatoria)

ALTER TABLE `saco_roto`.`prendas` 
ADD INDEX `prendas_pedidos_idx` (`nro_pedido` ASC) VISIBLE,
ADD INDEX `prendas_tipos_prendas_idx` (`cod_tipo_prenda` ASC) VISIBLE;
;
ALTER TABLE `saco_roto`.`prendas` 
ADD CONSTRAINT `prendas_pedidos`
  FOREIGN KEY (`nro_pedido`)
  REFERENCES `saco_roto`.`pedidos` (`nro_pedido`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `prendas_personas`
  FOREIGN KEY (`nro_persona`)
  REFERENCES `saco_roto`.`personas` (`nro_persona`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `prendas_tipos_prendas`
  FOREIGN KEY (`cod_tipo_prenda`)
  REFERENCES `saco_roto`.`tipos_prendas` (`cod_tipo_prenda`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

########################

# EJERCICIOS DML

# 2) Listado de prendas sin confeccionar: Listado de prendas que aún no se han terminado de confeccionar.
# Mostrar: Nombre y apellido de la persona, descripción de la prenda, fecha del pedido, fecha fin estimada de la prenda,
# fecha_entrega_requerida y cantidad de días de demora en función de la fecha requerida a hoy (función DATEDIFF).

SELECT per.nombre, per.apellido, tp.desc_tipo_prenda, ped.fecha_hora_pedido,
pre.fecha_fin_est, pre.fecha_entrega, datediff(current_date(), pre.fecha_entrega) dias_demora
FROM prendas pre
INNER JOIN personas per ON pre.nro_persona = per.nro_persona
INNER JOIN tipos_prendas tp ON pre.cod_tipo_prenda = tp.cod_tipo_prenda
INNER JOIN pedidos ped ON pre.nro_pedido = ped.nro_pedido
WHERE pre.fecha_fin_real IS NULL
ORDER BY dias_demora DESC;

######

# 3) Estadística de tipos de prendas: Mostrar los tipos de prendas que nunca se han vendido.
# Indicando código del tipo de prenda y descripción.

SELECT tp.cod_tipo_prenda, tp.desc_tipo_prenda
FROM tipos_prendas tp
LEFT JOIN prendas pre ON tp.cod_tipo_prenda = pre.cod_tipo_prenda
WHERE pre.cod_tipo_prenda IS NULL;

# También se puede resolver con una Subconsulta y el uso de NOT IN, pero es más eficiente con LEFT JOIN

######

# 4) Última fecha de prueba: Realizar el procedimiento "ult_prueba" que dada una fecha muestre por cada persona y tipo de prenda,
# cuál fue la última prueba realizada. Mostrar número y nombres de las personas, tipo de prenda, descripción del tipo de prenda y
# fecha de última prueba. Si una persona tiene varias pruebas del mismo tipo de prenda el mismo día mostrar una sola vez.
# Ordenar por fecha en forma descendente y por apellido en forma ascendente. Probar el procedimiento con la fecha: 5/11/2013.

# Stored Procedure:
USE `saco_roto`;
DROP procedure IF EXISTS `ult_prueba`;

DELIMITER $$
USE `saco_roto`$$
CREATE PROCEDURE `ult_prueba` (IN fecha_in DATE)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS temp_last_pruebas;
	CREATE TEMPORARY TABLE temp_last_pruebas
		SELECT per.nro_persona, tp.cod_tipo_prenda, max(pru.fecha_prueba) ultima_fecha
        FROM pruebas pru
        INNER JOIN personas per ON pru.nro_persona = per.nro_persona
        INNER JOIN tipos_prendas tp ON pru.cod_tipo_prenda = tp.cod_tipo_prenda
        WHERE pru.fecha_prueba <= fecha_in
        GROUP BY per.nro_persona, tp.cod_tipo_prenda;
        
	SELECT per.nro_persona, per.nombre, per.apellido, tp.cod_tipo_prenda,
	tp.desc_tipo_prenda, tlp.ultima_fecha
	FROM temp_last_pruebas tlp
	INNER JOIN personas per ON tlp.nro_persona = per.nro_persona
	INNER JOIN tipos_prendas tp ON tlp.cod_tipo_prenda = tp.cod_tipo_prenda
	ORDER BY tlp.ultima_fecha DESC, per.apellido ASC;
END$$

DELIMITER ;

# Llamada al SP:
CALL ult_prueba("2013/11/15");

########################

# EJERCICIOS TCL/DDL

# 5) La tabla MATERIALES tiene el atributo unidad de medida que el usuario registra manualmente sin la posibilidad de
# controlar la integridad del dato. Se requiere entonces mantener la tabla unidades_medida que contenga los distintos valores
# de las unidades de medida hasta ahora registrados para luego vincularla a la tabla materiales. Para ello se requiere:

# a) Crear la tabla: UNIDADES_MEDIDA con los atributos cod_unidad (clave primaria) y desc_unidad.
# Nota: Se sugiere indicar el atributo cod_unidad como auto-incremental.

CREATE TABLE `saco_roto`.`unidades_medida` (
  `cod_unidad` INT NOT NULL AUTO_INCREMENT,
  `desc_unidad` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_unidad`));

# b) Registrar en la tabla UNIDADES_MEDIDA creada las diferentes unidades de medida que existan en la tabla de MATERIALES.

START TRANSACTION;
	INSERT INTO unidades_medida(desc_unidad)
		SELECT DISTINCT mat.unidad 
        FROM materiales mat;
COMMIT;

# c) Agregar el atributo cod_unidad a la tabla de MATERIALES.

ALTER TABLE `saco_roto`.`materiales` 
ADD COLUMN `cod_unidad` INT NULL AFTER `unidad`;

# d) Actualizar el atributo cod_unidad de la tabla de MATERIALES con el correspondiente cod_unidad de la tabla UNIDADES_MEDIDA.

START TRANSACTION;
	UPDATE materiales SET cod_unidad = (
		SELECT um.cod_unidad
        FROM unidades_medida um
        WHERE um.desc_unidad = materiales.unidad);
COMMIT;

# e) Completar la definición de la tabla MATERIALES para lograr controlar la integridad referencial.

ALTER TABLE `saco_roto`.`materiales` 
DROP COLUMN `unidad`,
ADD INDEX `materiales_unidades_medida_idx` (`cod_unidad` ASC) VISIBLE;
;
ALTER TABLE `saco_roto`.`materiales` 
ADD CONSTRAINT `materiales_unidades_medida`
  FOREIGN KEY (`cod_unidad`)
  REFERENCES `saco_roto`.`unidades_medida` (`cod_unidad`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

########################
