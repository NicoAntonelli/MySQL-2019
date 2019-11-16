CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`valores_plan_BEFORE_INSERT` BEFORE INSERT ON `valores_plan` FOR EACH ROW
BEGIN
	# ATENCIÓN con el SET. Es como si fuese una variable.
	SET new.usuario_alta=CURRENT_USER;
END
