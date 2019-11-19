/*
6) Crear un procedimiento almacenado llamado alumnos_pagos_deudas_a_fecha que dada una fecha
y un alumno indique cuanto ha pagado hasta esa fecha y cuantas cuotas adeudaba a dicha fecha
(cuotas emitidas y no pagadas). Devolver los resultados en parámetros de salida.
*/

# Seteo variables a NULL
SET @pagado = NULL; SET @cant_adeudado = NULL;

# Llamo al Stored Procedure con las variables de Output y luego exhibo las variables cargadas
call alumnos_pagos_deudas_a_fecha(curdate(), 24242424, @pagado, @cant_adeudado);

############

/*
7) Crear una función llamada alumnos_deudas_a_fecha que dado un alumno y una fecha
indique cuantas cuotas adeuda a la fecha.
*/

# En este caso, utilizo una función a diferencia del Stored Procedure anterior
select alumnos_deudas_a_fecha(curdate(), 24242424) AS "Deudas del Alumno";
