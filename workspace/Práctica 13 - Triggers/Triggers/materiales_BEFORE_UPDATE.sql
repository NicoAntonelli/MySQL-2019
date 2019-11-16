CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`materiales_BEFORE_UPDATE` BEFORE UPDATE ON `materiales` FOR EACH ROW
BEGIN
	# Si cant_disponible fuese NULL quiere decir que es un Apunte, es decir, no posee movimientos de Stock
	IF new.cant_disponible IS NOT NULL THEN
		# Para obtener la cantidad_movida, calculamos la diferencia entre la row old y new
		SET @cant_movida=new.cant_disponible-old.cant_disponible;
		IF @cant_movida!=0 THEN
			INSERT INTO stock_movimientos(cod_material, cantidad_movida, cantidad_restante, usuario_movimiento)
			VALUES (new.cod_material, @cant_movida, new.cant_disponible, CURRENT_USER);
		END IF;
	END IF;
END
