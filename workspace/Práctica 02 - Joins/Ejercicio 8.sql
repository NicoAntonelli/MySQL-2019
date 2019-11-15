/*
8) Mostrar los antecedentes de cada postulante:
Postulante (nombre y apellido) - Cargo (descripción del cargo)
*/

SELECT concat(per.nombre, " ", per.apellido) AS "Postulante", car.desc_cargo AS "Cargo"
FROM agencia_personal.entrevistas ent
INNER JOIN agencia_personal.personas per USING (dni)
INNER JOIN agencia_personal.cargos car USING (cod_cargo);
