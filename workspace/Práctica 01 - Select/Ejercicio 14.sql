/*
14) Seleccionar los contratos con un salario pactado mayor que 2000 y que no hayan sido
terminado.
*/

SELECT * FROM agencia_personal.contratos WHERE sueldo>2000 AND fecha_caducidad IS NULL;
