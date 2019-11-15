/*
5) Ídem 4) pero utilizar variables para obtener el cuil de los 3 instructores.
--> El 4) Convertir a Daniel Tapia en el supervisor de Henri Amiel y Franz Kafka. Utilizar el cuil de
cada uno.
*/

SELECT cuil INTO @supervisor FROM instructores WHERE cuil = "44-44444444-4";
SELECT cuil INTO @intructor1 FROM instructores WHERE cuil = "55-55555555-5";
SELECT cuil INTO @intructor2 FROM instructores WHERE cuil = "66-66666666-6";

START TRANSACTION;   
	UPDATE instructores SET cuil_supervisor = @supervisor
	WHERE cuil IN (@instructor1,@instructor2);
COMMIT;
