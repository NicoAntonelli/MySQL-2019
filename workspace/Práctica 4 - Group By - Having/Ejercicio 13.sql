/*
--> LEFT AND RIGHT JOIN...
13) Listar las empresas, indicando todos sus datos y la cantidad de personas diferentes que han mencionado
dicha empresa como antecedente laboral. Si alguna empresa NO fue mencionada como antecedente laboral
deberá indicar 0 en la cantidad de personas. 
*/

SELECT emp.cuit, emp.razon_social, count(ant.cuit) "Cantidad de Personas"
FROM agencia_personal.empresas emp
LEFT JOIN agencia_personal.antecedentes ant ON emp.cuit = ant.cuit
GROUP BY 1;
