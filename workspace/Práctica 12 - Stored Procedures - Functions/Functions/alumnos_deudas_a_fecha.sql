CREATE DEFINER=`root`@`localhost` FUNCTION `alumnos_deudas_a_fecha`(fecha_limite DATE, dni_alumno INTEGER(11)) RETURNS int(11)
BEGIN
	DECLARE cant_adeudado integer(11);
	SELECT count(*) INTO cant_adeudado
	FROM cuotas cuo
	WHERE cuo.dni = dni_alumno AND cuo.fecha_pago IS NULL AND cuo.fecha_emision <= fecha_limite;
	RETURN cant_adeudado;
END