/*
8) Crear un procedimiento almacenado llamado alumno_inscripcion que dados los datos de un alumno y un curso
lo inscriba en dicho curso el día de hoy y genere la primera cuota con fecha de emisión hoy para el mes próximo.
*/

# DNI Alumno, Plan, Curso
call alumno_inscripcion(24242424, "Marketing 3", 1);

############

/*
9) Modificar el procedimiento almacenado creado en 8) para que antes de inscribir a un alumno valide que el mismo
no esté ya inscripto.
*/

# DNI Alumno, Plan, Curso
call alumno_inscripcion_mejorado(11111111, "Marketing 3", 1);

############

/*
10) Modificar el procedimiento almacenado editado en 9) para que realice el proceso en una transacción.
Además luego de inscribirlo y generar la cuota verificar si la cantidad de inscriptos supera el cupo,
en ese caso realizar un ROLLBACK. Si la cantidad de inscriptos es correcta ejecutar un COMMIT.
*/

# DNI Alumno, Plan, Curso
call alumno_inscripcion_mejorado_final(14141414, "Marketing 3", 1);
