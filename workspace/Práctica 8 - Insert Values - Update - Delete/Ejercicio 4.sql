/*
4) Convertir a Daniel Tapia en el supervisor de Henri Amiel y Franz Kafka. Utilizar el cuil de
cada uno.
*/

START TRANSACTION;
	UPDATE instructores SET cuil_supervisor = "44-44444444-4"
    WHERE cuil IN("55-55555555-5","66-66666666-6");
COMMIT;
