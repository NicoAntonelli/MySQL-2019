CREATE DEFINER=`root`@`localhost` TRIGGER `inscripciones_AFTER_INSERT` AFTER INSERT ON `inscripciones` FOR EACH ROW BEGIN
	UPDATE cursos SET cant_inscriptos=cant_inscriptos+1
	WHERE nom_plan=new.nom_plan AND nro_curso=new.nro_curso;
END
