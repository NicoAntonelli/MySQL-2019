/*
7) Mostrar los empleados cuyo salario supere al promedio de sueldo de la empresa que los
contrató.
*/

DROP TEMPORARY TABLE IF EXISTS temp_proms;
CREATE TEMPORARY TABLE temp_proms
	SELECT sub_emp.cuit, avg(sub_con.sueldo) prom
	FROM agencia_personal.contratos sub_con
	INNER JOIN agencia_personal.empresas sub_emp ON sub_con.cuit = sub_emp.cuit
	GROUP BY sub_emp.cuit;

SELECT DISTINCT con.cuit, con.dni, con.sueldo, temp_proms.prom
FROM agencia_personal.contratos con
INNER JOIN temp_proms ON con.cuit = temp_proms.cuit
WHERE con.sueldo > temp_proms.prom GROUP BY con.cuit, con.dni, con.sueldo, temp_proms.prom;
