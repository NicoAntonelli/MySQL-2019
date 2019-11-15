/*
14) Alumnos que tengan todas sus cuotas pagas hasta la fecha.
*/

DROP TEMPORARY TABLE IF EXISTS temp_cli_deben;
CREATE TEMPORARY TABLE temp_cli_deben
	SELECT DISTINCT cuo.dni
    FROM afatse.cuotas cuo
    WHERE cuo.fecha_pago IS NULL;

SELECT DISTINCT alu.*
FROM afatse.alumnos alu
INNER JOIN afatse.cuotas cuo ON alu.dni = cuo.dni
WHERE alu.dni NOT IN (SELECT tcd.dni FROM temp_cli_deben tcd)
ORDER BY alu.dni;
