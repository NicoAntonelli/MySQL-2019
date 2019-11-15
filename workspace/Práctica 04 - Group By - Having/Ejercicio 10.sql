/*
10) Mostar la cantidad de empresas diferentes que han realizado solicitudes y la diferencia respecto al total de solicitudes. 
*/

SELECT count(distinct se.cuit) "Cantidad", (count(*) - count(distinct se.cuit)) "Diferencia"
FROM agencia_personal.solicitudes_empresas se;

# No hace falta Group By?
