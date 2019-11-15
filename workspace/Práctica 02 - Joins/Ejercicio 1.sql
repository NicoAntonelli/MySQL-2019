/*
1) Mostrar del Contrato 5: DNI, Apellido y Nombre de la persona contratada y el sueldo
acordado en el contrato.
*/

# Poner solamente "Join" es equivalente a "Inner Join" (es el Default)

SELECT per.dni, per.apellido, per.nombre, cont.sueldo
FROM agencia_personal.contratos cont INNER JOIN agencia_personal.personas per
ON cont.dni = per.dni
WHERE nro_contrato=5;

# En vez de: ON cont.dni = per.dni, se podía poner simplemente: USING (dni)
