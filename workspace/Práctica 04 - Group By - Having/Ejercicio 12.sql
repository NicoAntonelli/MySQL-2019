/*
12) Cantidad de solicitudes por empresas y cargos. 
*/

SELECT emp.cuit, emp.razon_social, se.cod_cargo, count(*) "Cantidad"
FROM agencia_personal.solicitudes_empresas se
INNER JOIN agencia_personal.empresas emp ON se.cuit = emp.cuit
GROUP BY 1,3 ORDER BY 1;
