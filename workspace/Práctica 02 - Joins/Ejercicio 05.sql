/*
5) Realizar el punto 4 sin mostrar el campo DNI pero para todos los títulos.
[... El 4) era: Listar todos los candidatos con título de bachiller o un título de educación no
formal. Mostrar nombre y apellido, descripción del título y DNI ]
*/

SELECT per.nombre, per.apellido, tit.desc_titulo
FROM agencia_personal.titulos tit
INNER JOIN agencia_personal.personas_titulos pt USING (cod_titulo)
INNER JOIN agencia_personal.personas per USING (dni)
ORDER BY per.dni;
