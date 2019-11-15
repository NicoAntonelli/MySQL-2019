/*
13) Seleccionar las solicitudes cuya fecha sea mayor que ‘21/09/2013’ (cambio a 2014 porque
sino son todas las fechas correctas), y el código de cargo sea 6; o hayan solicitado
aspirantes de sexo femenino.
*/

SELECT * FROM agencia_personal.solicitudes_empresas
WHERE fecha_solicitud>"2014-09-21" AND cod_cargo=6 OR sexo="Femenino";
