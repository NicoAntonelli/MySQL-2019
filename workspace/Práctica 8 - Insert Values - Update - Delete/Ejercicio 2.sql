/*
2) Ingresar un nuevo plan de capacitación con sus datos, costo, temas, exámenes y materiales:

Plan:
Nombre: Administrador de BD.
Descripción: Instalación y configuración MySQL. Lenguaje SQL. Usuarios y permisos.
HS: 300.
Modalidad: Presencial.

Temas: 4
Titulo						Detalle
1- Instalación MySQL		Distintas configuraciones de instalación
2- Configuración DBMS		Variables de entorno, su uso y configuración
3- Lenguaje SQL				DML, DDL y TCL
4- Usuarios y Permisos		Permisos de usuarios y DCL

Exámenes: 4
Examen		Temas que incluye
1			1- Instalación MySQL
2			2- Configuración DBMS
3			3- Lenguaje SQL
4			4- Usuarios y Permisos

Materiales Existentes que entrega : Código UT-001, UT-002, UT-003 y UT-004

Nuevos Materiales:
Código		Desc.			URL descarga						Autor		Tam		Fecha Creación
AP-010		DBA en MySQL	www.afatse.com.ar/apuntes?AP=010	José Román	2MB		01/03/09
AP-011		SQL en MySQL	www.afatse.com.ar/apuntes?AP=011	Juan López	3MB		01/04/09

Valor: $ 150 desde el 01/02/2009
*/

START TRANSACTION;
INSERT INTO plan_capacitacion VALUES
	("Administrador de BD", "Instalación y configuración MySQL. Lenguaje SQL. Usuarios y permisos", 300, "Presencial");
INSERT INTO plan_temas VALUES
	("Administrador de BD", "Instalación MySQL", "Distintas configuraciones de instalación"),
	("Administrador de BD", "Configuración DBMS", "Variables de entorno, su uso y configuración"),
	("Administrador de BD", "Lenguaje SQL", " DML, DDL y TCL"),
	("Administrador de BD", "Usuarios y Permisos", "Permisos de usuarios y DCL");
INSERT INTO examenes VALUES
	("Administrador de BD", 1),
	("Administrador de BD", 2),
	("Administrador de BD", 3),
	("Administrador de BD", 4);
INSERT INTO examenes_temas VALUES
	("Administrador de BD", "Instalación MySQL", 1),
	("Administrador de BD", "Configuración DBMS", 2),
	("Administrador de BD", "Lenguaje SQL", 3),
	("Administrador de BD", "Usuarios y Permisos", 4);
-- Agrego los materiales nuevos:
INSERT INTO materiales (cod_material, desc_material, url_descarga, autores, tamanio, fecha_creacion, cant_disponible, punto_pedido, cantidad_a_pedir) VALUES
	("AP-010", "DBA en MySQL", "www.afatse.com.ar/apuntes?AP=010", "José Román", 2, "2009/03/01", 0, 0, 0),
	("AP-011", "SQL en MySQL", " www.afatse.com.ar/apuntes?AP=011", "Juan López", 3, "2009/04/01", 0, 0, 0);
INSERT INTO materiales_plan VALUES
	("Administrador de BD", "UT-001", 0),
	("Administrador de BD", "UT-002", 0),
	("Administrador de BD", "UT-003", 0),
	("Administrador de BD", "UT-004", 0),
	("Administrador de BD", "AP-010", 0),
	("Administrador de BD", "AP-011", 0);
INSERT INTO valores_plan VALUES ("Administrador de BD", "2009/02/01", 150);
COMMIT;
