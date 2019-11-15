/*
2) ¿Quiénes fueron contratados por la empresa Viejos Amigos y Tráigame Eso? Mostrar el
DNI, número de contrato, fecha de incorporación, fecha de solicitud en la agencia de los
contratados y fecha de caducidad (si no tiene fecha de caducidad colocar ‘Sin Fecha’).
Ordenado por fecha de contrato y nombre de empresa.
*/

SELECT per.dni, cont.nro_contrato, cont.fecha_incorporacion, cont.fecha_solicitud,
ifnull(cont.fecha_caducidad, "Sin Fecha") AS "fecha_caducidad"
FROM agencia_personal.contratos cont
INNER JOIN agencia_personal.empresas emp USING (cuit)
INNER JOIN agencia_personal.personas per ON cont.dni = per.dni
WHERE emp.razon_social IN ("Viejos Amigos", "Tráigame Eso")
ORDER BY cont.fecha_solicitud, emp.razon_social;
