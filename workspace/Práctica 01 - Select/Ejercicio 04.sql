/*
4) Mostrar de la persona con DNI nro. 28675888. El nombre y apellido, fecha de nacimiento,
teléfono, y su dirección. Las cabeceras de las columnas serán:
Apellido y Nombre (concatenados) - Fecha Nac - Teléfono - Dirección
*/

SELECT concat(nombre, ' ', apellido) AS "Apellido y Nombre", fecha_nacimiento AS "Fecha Nac.", telefono AS "Teléfono", direccion AS "Dirección"
FROM agencia_personal.personas
WHERE dni="28675888";
