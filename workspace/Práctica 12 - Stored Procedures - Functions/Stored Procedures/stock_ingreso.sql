CREATE DEFINER=`root`@`localhost` PROCEDURE `stock_ingreso`(IN cod_mat VARCHAR(6), IN cant_movida INTEGER(11), OUT stock INTEGER(11))
BEGIN
	call stock_movimiento(cod_mat, cant_movida, stock);
END