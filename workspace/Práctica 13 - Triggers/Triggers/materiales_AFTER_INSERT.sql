CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`materiales_AFTER_INSERT` AFTER INSERT ON `materiales` FOR EACH ROW
BEGIN
	# Si cant_disponible fuese NULL quiere decir que es un Apunte, es decir, no posee movimientos de Stock
	IF new.cant_disponible IS NOT NULL THEN
		INSERT INTO stock_movimientos(cod_material, cantidad_movida, cantidad_restante, usuario_movimiento)
		VALUES (new.cod_material, new.cant_disponible, new.cant_disponible, CURRENT_USER);
	END IF;
END
