/*
11) Mostrar los contratos cuyo salario sea mayor que 2000 y trabajen en las empresas
30-10504876-5 o 30-21098732-4. Rotule el encabezado: Nro Contrato - DNI - Salario - CUIL
*/

SELECT nro_contrato AS "Nro Contrato", dni AS "DNI", sueldo AS "Salario", cuit AS "CUIL"
FROM agencia_personal.contratos
WHERE sueldo>2000 AND cuit="30-10504876-5" OR cuit="30-21098732-4"
ORDER BY nro_contrato;

/*
También podía ponerse la comparación como:
WHERE sueldo>2000 AND cuit IN("30-10504876-5", "30-21098732-4")
*/
