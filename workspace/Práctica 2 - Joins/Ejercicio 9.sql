/*
9) Mostrar todas las evaluaciones realizadas para cada solicitud ordenar en forma ascendente
por empresa y descendente por cargo: Empresa - Cargo - Desc_Evaluacion - Resultado
*/

SELECT emp.razon_social AS "Empresa", car.desc_cargo AS "Cargo",
eva.desc_evaluacion AS "Desc_Evaluacion", ee.resultado AS "Resultao"
FROM agencia_personal.empresas AS emp
INNER JOIN agencia_personal.solicitudes_empresas se ON emp.cuit = se.cuit
INNER JOIN agencia_personal.cargos car ON se.cod_cargo = car.cod_cargo
INNER JOIN agencia_personal.entrevistas ent
ON se.cuit = ent.cuit AND se.cod_cargo = ent.cod_cargo AND se.fecha_solicitud = ent.fecha_solicitud
INNER JOIN agencia_personal.entrevistas_evaluaciones ee USING (nro_entrevista)
INNER JOIN agencia_personal.evaluaciones eva USING (cod_evaluacion)
ORDER BY emp.razon_social ASC, car.desc_cargo DESC;
