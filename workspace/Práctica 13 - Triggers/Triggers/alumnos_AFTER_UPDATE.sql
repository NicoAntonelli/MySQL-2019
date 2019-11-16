CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`alumnos_AFTER_UPDATE` AFTER UPDATE ON `alumnos` FOR EACH ROW
BEGIN
	INSERT INTO alumnos_historico
	VALUES (new.dni, CURRENT_TIMESTAMP, new.nombre, new.apellido, new.tel, new.email, new.direccion, CURRENT_USER);
END
