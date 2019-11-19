/*
3) Crear un nuevo plan: Marketing 1 Presen, con los mismos datos que el plan Marketing 1 pero con modalidad presencial.
Este plan tendrá los mismos temas, exámenes y materiales que Marketing 1 pero con un costo un 50% superior, para todos
los períodos del año 2009 que ya estén definidos costos del plan (2009 porque era el "actual" cuando se hizo el ejercicio).
*/

# Importante haber realizado los EJs 1 y 2 para realizar este EJ correctamente
START TRANSACTION;
	INSERT INTO plan_capacitacion
	SELECT 'Marketing 1 Presen', desc_plan, hs, 'Presencial'
	FROM plan_capacitacion WHERE nom_plan = 'Marketing 1';
	
    INSERT INTO plan_temas
	SELECT 'Marketing 1 Presen', titulo, detalle
	FROM plan_temas WHERE nom_plan = 'Marketing 1';
    
    INSERT INTO examenes
	SELECT 'Marketing 1 Presen', nro_examen
	FROM examenes WHERE nom_plan = 'Marketing 1';
    
	INSERT INTO examenes_temas
	SELECT 'Marketing 1 Presen', titulo, nro_examen
	FROM examenes_temas WHERE nom_plan = 'Marketing 1';
    
	INSERT INTO valores_plan (nom_plan, fecha_desde_plan, valor_plan)
	SELECT 'Marketing 1 Presen', fecha_desde_plan, valor_plan * 1.5
	FROM valores_plan WHERE nom_plan = 'Marketing 1' AND year(fecha_desde_plan) = 2009;
COMMIT;
