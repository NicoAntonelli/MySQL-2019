CREATE DEFINER=`root`@`localhost` PROCEDURE `alumnos_pagos_deudas_a_fecha`(IN fecha_limite DATE, IN dni_alumno INTEGER(11),
OUT pagado FLOAT(9,3), OUT cant_adeudado INTEGER(11))
BEGIN
	SELECT @pagado := sum(cuo.importe_pagado) AS "Importe Pagado", @cant_adeudado := count(*) as "Cuotas Adeudadas"
	FROM cuotas cuo
	WHERE cuo.dni = dni_alumno AND cuo.fecha_pago IS NOT NULL AND cuo.fecha_emision <= fecha_limite;
    
    # Si se requiere, se pueden poner las variables @pagado y @cant_adeudado en 2 select aparte
	
    SET pagado := @pagado;
	SET cant_adeudado := @cant_adeudado;
END