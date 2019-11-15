/*
11) Crear dos procedimientos almacenados, aplicando conceptos de reutilización de código: stock_ingreso
dado el código de material y la cantidad ingresada (número positivo) que realice un ingreso de mercadería.
stock_egreso dado el código de material y la cantidad egresada (número positivo) que realice un ingreso de mercadería.
Ambos procedimiento deberán devolver la cantidad restante en stock. Realizar las validaciones pertinentes.

# Solución: Crear un procedimiento almacenado llamado stock_movimiento...
*/

SET @stock = NULL;
call stock_ingreso("UT-002", 2, @stock); # Mensaje: Se actualizó
call stock_egreso("UT-002", 2, @stock); # Mensaje: Se actualizó
call stock_egreso("UT-002", 20, @stock); # Mensaje: Excede cantidad

############

/*
12) Crear un procedimiento almacenado llamado alumno_anula_inscripcion que elimine la inscripción del alumno.
El mismo deberá tener en cuenta que el alumno no haya pagado ninguna cuota antes de eliminarlo.
Si hay cuotas ya generadas pero impagas las mismas deberán ser eliminadas.
*/

call alumno_anula_inscripcion(24242424, "Marketing 3", 1);
