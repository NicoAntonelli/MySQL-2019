/*
15) Indicar los cargos que hayan sido solicitados menos de 2 veces 
*/

SELECT car.cod_cargo, car.desc_cargo, count(se.cod_cargo) "Cantidad de Solicitudes"
FROM agencia_personal.cargos car
LEFT JOIN agencia_personal.solicitudes_empresas se ON car.cod_cargo = se.cod_cargo
GROUP BY 1 HAVING count(se.cod_cargo) < 2 ORDER BY 3 DESC;
