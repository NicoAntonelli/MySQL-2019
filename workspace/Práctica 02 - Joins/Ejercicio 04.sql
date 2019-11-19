/*
4) Listar todos los candidatos con título de bachiller o un título de educación no formal.
Mostrar nombre y apellido, descripción del título y DNI.
*/

SELECT per.dni, per.nombre, per.apellido, tit.desc_titulo
FROM agencia_personal.titulos tit
INNER JOIN agencia_personal.personas_titulos pt USING (cod_titulo)
INNER JOIN agencia_personal.personas per USING (dni)
WHERE tit.desc_titulo = "Bachiller" OR tit.tipo_titulo = "Educacion no formal"
ORDER BY per.dni;
