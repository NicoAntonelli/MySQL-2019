CREATE DEFINER=`root`@`localhost` PROCEDURE `stock_movimiento`(IN cod_mat VARCHAR(6), IN cant_movida INTEGER(11), OUT stock INTEGER(11))
BEGIN
	DECLARE url VARCHAR(50);
	START TRANSACTION;
		# Consulto por la url para saber si es un apunte o un útil (los útiles tienen NULL en la URL)
		SELECT url_descarga INTO url
		FROM materiales WHERE cod_material = cod_mat;
		
		IF (url IS NULL)
        THEN
			UPDATE materiales SET cant_disponible = cant_disponible + cant_movida
			WHERE cod_material = cod_mat;
		
			SELECT cant_disponible INTO stock
			FROM materiales WHERE cod_material = cod_mat;
			IF (stock >= 0)
			THEN
				COMMIT;
                SELECT "Stock actualizado correctamente" AS "Aviso";
			ELSE
				ROLLBACK;
                SELECT "El Stock no se actualizó porque excede la cantidad disponible" AS "Aviso";
				SELECT cant_disponible INTO stock
				FROM materiales WHERE cod_material = cod_mat;
			END IF;
        END IF;    
END