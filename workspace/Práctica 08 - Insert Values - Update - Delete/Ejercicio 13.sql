/*
13) Eliminar todos los apuntes que tengan como autora o coautora a Erica de Forifregoro
*/

# Verifico los apuntes de Erica de Forifregoro:
SELECT * FROM materiales WHERE autores LIKE "%Erica de Forifregoro%";
# Puede observarse que solo esta en el material de código "AP-006"

# Verifico en qué planes se usa:
SELECT * FROM materiales_plan WHERE cod_material = "AP-006";

# Elimino primero el cod_material en materiales_plan y luego en materiales
START TRANSACTION;
	DELETE FROM materiales_plan WHERE cod_material = "AP-006";
	DELETE FROM materiales WHERE autores LIKE "%Erica de Forifregoro%";
COMMIT;
