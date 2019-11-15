CREATE OR REPLACE VIEW `vw_instructores` AS
	SELECT concat(ins.nombre, ' ', ins.apellido) AS "Nombre y Apellido", ins.tel AS "Teléfono", ins.email AS "E-mail"
    FROM instructores ins
