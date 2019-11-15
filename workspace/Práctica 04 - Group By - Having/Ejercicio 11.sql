/*
11) Cantidad de solicitudes por empresas. 
*/

SELECT emp.cuit, emp.razon_social, count(*) "Cantidad"
FROM agencia_personal.solicitudes_empresas se
INNER JOIN agencia_personal.empresas emp ON se.cuit = emp.cuit
GROUP BY 1 ORDER BY 1;
