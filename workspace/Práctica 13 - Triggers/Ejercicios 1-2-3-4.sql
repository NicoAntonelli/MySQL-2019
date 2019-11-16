# EJERCICIOS 1-4: Crear Triggers según los requerimientos pedidos en cada ejercicio.
# Nota: Se debe utilizar la DB Afatse, o crear una nueva con las tablas requeridas en las FK.

# Ejercicio 1
# a) Crear una tabla para registrar el histórico de cambios en los datos de los alumnos con el siguiente script:
CREATE TABLE `alumnos_historico` (
`dni` int(11) NOT NULL,
`fecha_hora_cambio` datetime NOT NULL,
`nombre` varchar(20) default NULL,
`apellido` varchar(20) default NULL,
`tel` varchar(20) default NULL,
`email` varchar(50) default NULL,
`direccion` varchar(50) default NULL,
`usuario_modificacion` varchar(50) default NULL,
PRIMARY KEY (`dni`,`fecha_hora_cambio`),
CONSTRAINT `alumnos_historico_alumnos_fk` FOREIGN KEY (`dni`) REFERENCES
`alumnos` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# b) Luego crear TRIGGERS para insertar los nuevos valores en archivo_historico cuando los alumnos sean ingresados,
# o sus datos sean modificados. Registrar la fecha y hora actual con CURRENT_TIMESTAMP y el usuario actual con CURRENT_USER.

-- Trigger de tipo "After Insert" creado en la Tabla "alumnos". Se podría haber utilizado sin problemas "Before Insert".
-- Trigger de tipo "After Update" creado en la Tabla "alumnos". Se podría haber utilizado sin problemas "Before Update".

# c) Probarlo ejecutando INSERTS y UPDATES dentro de transacciones. Probar con ROLLBACK y luego con COMMIT.
START TRANSACTION;
	INSERT alumnos VALUES ("42424242", "Nico", "Antonelli", "4242424", "nico@ant.com", "Micasa 4242");
    INSERT alumnos VALUES ("33333333", "Marcia", "Nito", "3333333", "marcianito@deimos.com", "Sucasa 3333");
# ROLLBACK;
COMMIT;

START TRANSACTION;
	UPDATE alumnos SET direccion="Mars Colony 4242" WHERE dni="42424242";
    UPDATE alumnos SET direccion="Deimos 3333" WHERE dni="33333333";
# ROLLBACK;
COMMIT;

############

# Ejercicio 2
# a) Crear la tabla stock_movimientos para registrar las cambios en las existencias de artículos con el siguiente script:
CREATE TABLE `stock_movimientos` (
`cod_material` char(6) NOT NULL,
`fecha_movimiento` timestamp NOT NULL default CURRENT_TIMESTAMP
on update CURRENT_TIMESTAMP,
`cantidad_movida` int(11) NOT NULL,
`cantidad_restante` int(11) NOT NULL,
`usuario_movimiento` varchar(50) NOT NULL,
PRIMARY KEY (`cod_material`,`fecha_movimiento`),
CONSTRAINT `stock_movimientos_fk` FOREIGN KEY (`cod_material`) REFERENCES
`materiales` (`cod_material`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
Aclaración: En este caso utilizamos el tipo de datos timestamp en lugar de datetime para registrar la fecha y hora de
la modificación. En el ejercicio anterior utilizamos el tipo de dato datetime pero entonces debemos registrar el dato
a nosotros (en ese caso lo hicimos con CURRENT_TIMESTAMP). En los casos donde queremos hacer históricos o asegurarnos de
que se registra el momento exacto en que se inserta un dato es mejor utilizar el tipo de dato timestamp que hace esto
automáticamente pero en los INSERT que realicemos sobre las tablas con estos datos deberemos omitir este campo.

Nota: CURRENT_TIMESTAMP y CURRENT_TIMESTAMP() son equivalentes a NOW().
*/

# b) Crear TRIGGERS para registrar los movimientos en las cantidades de los materiales en la tabla del histórico.
# En el caso de un nuevo material se debe registrar la cantidad inicial como la cantidad movida y SÓLO en el caso de un
# cambio en la cantidad registrar el cambio.

-- Trigger de tipo "After Insert" creado en la Tabla "materiales". Se podría haber utilizado sin problemas "Before Insert".
-- Trigger de tipo "Before Update" creado en la Tabla "materiales". Se podría haber utilizado sin problemas "After Update".

# c) Probarlo ejecutando INSERTS y UPDATES dentro de transacciones. Probar con ROLLBACK y luego con COMMIT.

# UPDATE materiales SET cant_disponible=NULL WHERE cod_material LIKE "%AP%";
# Me aparecían en cero las cantidades de los Apuntes, no en NULL. Es importante para que no los tengan en cuenta los Triggers.

START TRANSACTION;
	INSERT materiales VALUES ("UT-012", "RTX 2080", NULL, NULL, NULL, NULL, 6200, 2000, 4000);
    INSERT materiales VALUES ("AP-012", "Cómo Aprobar GDD", "www.afatse.com.ar/apuntes?AP=012", "Julio Profe Net", 4.000, CURDATE(), NULL, NULL, NULL);
# ROLLBACK;
COMMIT;

START TRANSACTION;
	UPDATE materiales SET cant_disponible=6000 WHERE cod_material="UT-012";
    UPDATE materiales SET autores="Julio Profe" WHERE cod_material="AP-012";
# ROLLBACK;
COMMIT;

############

# Ejercicio 3
# a) Modificar la tabla cursos, agregarle una columna llamada cant_inscriptos que será un atributo calculado
# de la cantidad de inscriptos al curso con el siguiente script:
ALTER TABLE `cursos`
ADD COLUMN cant_inscriptos int(11) default NULL;

# b) Completar el campo con la cantidad actual de inscriptos con el script:
START TRANSACTION;
	DROP TEMPORARY TABLE IF EXISTS insc_curso;
	CREATE TEMPORARY TABLE insc_curso
		SELECT cur.nom_plan, cur.nro_curso, count(ins.nro_curso) cant
		FROM cursos cur LEFT JOIN inscripciones ins
		ON cur.nom_plan = ins.nom_plan AND cur.nro_curso = ins.nro_curso
		GROUP BY cur.nom_plan, cur.nro_curso;
		
	UPDATE `cursos` cur INNER JOIN `insc_curso` ic
    ON cur.`nom_plan` = ic.`nom_plan` AND cur.`nro_curso` = ic.`nro_curso`
	SET cur.`cant_inscriptos` = ic.cant;
COMMIT;

# c) Hacer obligatorio el campo cant_inscriptos con el script:
ALTER TABLE `cursos`
MODIFY cant_inscriptos int(11) NOT NULL;

# d) Crear los TRIGGERS necesarios para actualizar la cantidad de inscriptos del curso, los mismos deberán dispararse
# al inscribir un nuevo alumno y al eliminar una inscripción.

-- Trigger de tipo "After Insert" creado en la Tabla "inscripciones". Se podría haber utilizado sin problemas "Before Insert".
-- Trigger de tipo "After Delete" creado en la Tabla "inscripciones". Se podría haber utilizado sin problemas "Before Delete".

# e) Probarlo inscribiendo y anulando inscripciones dentro de transacciones. Realizar las pruebas con ROLLBACK y con COMMIT.
START TRANSACTION;
	INSERT inscripciones VALUES ("Reparacion PC", 1, "42424242", CURDATE());
	INSERT inscripciones VALUES ("Reparacion PC", 1, "33333333", CURDATE());
# ROLLBACK;
COMMIT;

START TRANSACTION;
	DELETE FROM inscripciones WHERE dni="42424242" AND nom_plan="Reparacion PC" AND nro_curso=1;
	DELETE FROM inscripciones WHERE dni="33333333" AND nom_plan="Reparacion PC" AND nro_curso=1;
# ROLLBACK;
COMMIT;

############

# Ejercicio 4
# a) Agregar la columna usuario_alta a la tabla valores_plan con el siguiente script:
ALTER TABLE `valores_plan`
ADD COLUMN usuario_alta varchar(50);

# b) Crear un TRIGGER que una vez insertado el nuevo precio registre el usuario que lo ingresó.

-- Trigger de tipo "After Insert" creado en la Tabla "valores_plan". Este TRIGGER tiene que ser si o si BEFORE,
-- osea ANTES de insertar, porque no se puede modificar el valor de la nueva fila (new) si ya se insertó.

# c) Probar el TRIGGER dentro de una transacción. Realizar las pruebas con ROLLABACK y COMMIT.
START TRANSACTION;
	INSERT valores_plan(nom_plan, fecha_desde_plan, valor_plan) VALUES ("Reparacion PC", CURDATE(), 90);
	INSERT valores_plan(nom_plan, fecha_desde_plan, valor_plan) VALUES ("Marketing 3", CURDATE(), 300);
# ROLLBACK;
COMMIT;

# No hay Trigger de Delete, pongo esta Transaction solo para Borrar las Inscripciones
START TRANSACTION;
	DELETE FROM valores_plan WHERE nom_plan="Reparacion PC" AND valor_plan=90;
	DELETE FROM valores_plan WHERE nom_plan="Marketing 3" AND valor_plan=300;
# ROLLBACK;
COMMIT;
