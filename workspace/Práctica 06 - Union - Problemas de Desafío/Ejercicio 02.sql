/*
2) De las empresas registradas interesa la cantidad de personas que podemos tener como contacto por haber sido contratadas y cantidad de
personas que podemos tener como contacto por ser registrada como antecedente. Mostrar también las empresas que no tienen personas como
contacto tanto en contratos como en antecedentes. Indicar el porcentaje que representa respecto al total de personas que tenemos registradas.
*/

SELECT count(*) INTO @cant_personas_var FROM agencia_personal.personas per;

SELECT emp.cuit, emp.razon_social, count(con.dni) "cantidad", concat(((count(con.dni) / @cant_personas_var) * 100), "%") "porcentaje"
FROM agencia_personal.contratos con
RIGHT JOIN agencia_personal.empresas emp ON con.cuit = emp.cuit
GROUP BY emp.cuit, emp.razon_social
UNION
SELECT emp.cuit, emp.razon_social, count(ant.dni) "cantidad", concat(((count(ant.dni) / @cant_personas_var) * 100), "%") "porcentaje"
FROM agencia_personal.antecedentes ant
RIGHT JOIN agencia_personal.empresas emp ON ant.cuit = emp.cuit
GROUP BY emp.cuit, emp.razon_social;
