/*
--> SELF JOIN... (AFSATE!)
14) Indicar todos los instructores que tengan un supervisor. Mostrar:
*/

SELECT ins1.cuil AS "Cuil Instructor", ins1.nombre AS "Nombre Instructor",
ins1.apellido AS "Apellido Instructor", ins2.cuil AS "Cuil Supervisor",
ins2.nombre AS "Nombre Supervisor", ins2.apellido AS "Apellido Supervisor"
FROM afatse.instructores ins1 INNER JOIN afatse.instructores ins2
ON ins1.cuil_supervisor = ins2.cuil;
