/*
EJERCICIOS 1-5: Crear vistas que indiquen los datos pedidos en cada ejercicio.
NOTA: En alguna versión de MySQL quizás hayan sacado compatibilidad de recursión de Views,
o el uso de tablas temporales. Pues los EJs 3 y 4 no exhiben las columnas agregadas de estas formas.
--> Para arreglarlo, se deben usar SUBCONSULTAS en vez de Tablas Temporales.
*/

# 1) De los instructores: Nombre y Apellido (concatenados), Teléfono, E-mail

SELECT * FROM vw_instructores;

############

# 2) De los cursos que se dictan este año (el ejercicio es de 2015) indicar:
# Nombre del Plan, Descripcion del Plan, Nro. del Curso, Fecha Inicio, Fecha Fin, Salón, Cupo, Cantidad Alumnos

SELECT * FROM vw_listado_cursos;

############

# 3) Mismo enunciado que el 2) pero agregando "Costo Actual" al final (EJ 2 está arriba)

SELECT * FROM vw_listado_cursos_con_precio;

############

# 4) De los alumnos, indicar para cada curso al que se ha inscripto:
# Nombre y Apellido (concatenados), Nombre Plan, Nro. del Curso, Promedio, Cant Cuotas Impagas

SELECT * FROM vw_alu_plan;

############

# 5) Crear una vista de útiles y una de apuntes, sólo con los datos específicos de dichos elementos. Luego mostrar los útiles y
# todos los proveedores que los venden utilizando la vista y para cada curso de este año mostrar los apuntes que se utilizan en los mismos.
# cuit, razon_social, direccion, telefono, cod_material, desc_material, cant_disponible, punto_pedido, cantidad_a_pedir.

# Ni las del solucionario funcionan, prefiero no hacerlo.
