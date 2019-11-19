/*
5) Mostrar los datos de ej. Anterior, pero para las personas 27890765, 29345777 y 31345778.
Ordenadas por fecha de Nacimiento
*/

SELECT concat(nombre, ' ', apellido) AS "Apellido y Nombre", fecha_nacimiento AS "Fecha Nac.", telefono AS "Teléfono", direccion AS "Dirección"
FROM agencia_personal.personas
WHERE dni IN("27890765", "29345777", "31345778")
ORDER BY fecha_nacimiento;
