CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`inscripciones_AFTER_DELETE` AFTER DELETE ON `inscripciones` FOR EACH ROW
BEGIN
	UPDATE cursos SET cant_inscriptos=cant_inscriptos-1
	WHERE nom_plan=old.nom_plan AND nro_curso=old.nro_curso;
END
