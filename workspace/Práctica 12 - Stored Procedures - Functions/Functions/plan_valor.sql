CREATE DEFINER=`root`@`localhost` FUNCTION `plan_valor`(nom_plan varchar(20), fecha date) RETURNS float(9,3)
BEGIN
	SELECT max(VP.fecha_desde_plan) INTO @fecha_ult
		FROM afatse.valores_plan as VP
        WHERE VP.nom_plan = nom_plan
        and VP.fecha_desde_plan <= fecha
        GROUP BY VP.nom_plan;

	SELECT VP.valor_plan INTO @valor_plan
		FROM afatse.valores_plan as VP
        WHERE VP.nom_plan = nom_plan
        and VP.fecha_desde_plan = @fecha_ult;
RETURN @valor_plan;
END