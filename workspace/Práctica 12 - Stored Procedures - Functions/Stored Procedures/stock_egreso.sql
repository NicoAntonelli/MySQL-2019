CREATE DEFINER=`root`@`localhost` PROCEDURE `stock_egreso`(IN cod_mat VARCHAR(6), IN cant_movida INTEGER(11), OUT stock INTEGER(11))
BEGIN
	# Pasamos cant_movida a negativo
	call stock_movimiento(cod_mat, (-1) * cant_movida, stock);
END