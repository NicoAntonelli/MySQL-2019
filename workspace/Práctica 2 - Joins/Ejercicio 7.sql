/*
7) Seleccionar para la empresa Viejos amigos: fechas de solicitudes, descripción del cargo
solicitado y edad máxima y mínima. Si alguna no fuese requerida mostrar “Sin especificar”.
Encabezado: Empresa - Fecha Solicitud - Cargo - Edad Mín - Edad Máx -
Puntaje total en c/Entrevista
*/

SELECT emp.razon_social AS "Empresa", se.fecha_solicitud AS "Fecha Solicitud",
car.desc_cargo AS "Cargo", ifnull(se.edad_minima, "Sin Especificar") AS "Edad Mín",
ifnull(se.edad_maxima, "Sin Especificar") AS "Edad Máx",
ent.resultado_final AS "Puntaje total en c/Entrevista"
FROM agencia_personal.solicitudes_empresas se
INNER JOIN agencia_personal.empresas emp ON se.cuit = emp.cuit
INNER JOIN agencia_personal.cargos car ON se.cod_cargo = car.cod_cargo
INNER JOIN agencia_personal.entrevistas ent
ON se.cuit = ent.cuit AND se.cod_cargo = ent.cod_cargo AND se.fecha_solicitud = ent.fecha_solicitud
# La clave primaria anteriors de solicitudes_empresas tenía 3 atributos
WHERE emp.razon_social = "Viejos Amigos";

/*
INNER JOIN agencia_personal.entrevistas_evaluaciones ee ON ent.nro_entrevista = ee.nro_entrevista
Si es que quisiera los puntajes reales de las evaluaciones
*/
