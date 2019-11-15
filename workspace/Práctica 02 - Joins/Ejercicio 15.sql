/*
15) Ídem 14) pero para todos los instructores. Si no tiene supervisor mostrar esos campos en blanco
--> El 14) Era: Indicar todos los instructores que tengan un supervisor. Mostrar:
*/

SELECT ins1.cuil AS "Cuil Instructor", ins1.nombre AS "Nombre Instructor",
ins1.apellido AS "Apellido Instructor", ifnull(ins2.cuil, "") AS "Cuil Supervisor",
ifnull(ins2.nombre, "") AS "Nombre Supervisor", ifnull(ins2.apellido, "") AS "Apellido Supervisor"
FROM afatse.instructores ins1 LEFT JOIN afatse.instructores ins2
ON ins1.cuil_supervisor = ins2.cuil;
