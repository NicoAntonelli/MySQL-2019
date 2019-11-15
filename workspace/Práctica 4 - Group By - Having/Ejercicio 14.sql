/*
14) Indicar para cada cargo la cantidad de veces que fue solicitado. Ordenado en forma descendente
por cantidad de solicitudes. Si un cargo nunca fue solicitado, mostrar 0.
Agregar algún cargo que nunca haya sido solicitado ¿?
*/

SELECT car.cod_cargo, car.desc_cargo, count(se.cod_cargo) "Cantidad de Solicitudes"
FROM agencia_personal.cargos car
LEFT JOIN agencia_personal.solicitudes_empresas se ON car.cod_cargo = se.cod_cargo
GROUP BY 1 ORDER BY 3 DESC;
