# ############ Creación o Redefinición Inicial de la BD "Comuna" ############
# Base de Datos desarrollada para el Pre-Parcial de SQL v3

# Quitamos el checkeo de Foreign Keys
SET FOREIGN_KEY_CHECKS=0;

# Si la Base de Datos ya existe, igual la re-creamos de cero
# También definimos UTF-8 en vez de ASCII para los caracteres
DROP DATABASE IF EXISTS `comuna`;
CREATE DATABASE `comuna`
  CHARACTER SET 'utf8'
  COLLATE 'utf8_general_ci';

# Sinónimo en MySQL (5.0.2 en adelante) de CREATE DATABASE:
# CREATE SCHEMA `columna`;

# Lo siguiente sería para no escribir `columna`. en cada tabla
# USE `agencia_personal`;

# ############ Estructura de las Tablas de la Base de Datos ############

# Artista
DROP TABLE IF EXISTS `comuna`.`artista`;
CREATE TABLE `comuna`.`artista` (
  `cuit` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `telefono` INT UNSIGNED NULL,
  `email` VARCHAR(45) NULL,
  `actividad` VARCHAR(45) NOT NULL,
  `nombre_comercial` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Evento
DROP TABLE IF EXISTS `comuna`.`evento`;
CREATE TABLE `comuna`.`evento` (
  `nro` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_hora_ini` DATETIME NOT NULL,
  `fecha_hora_fin` DATETIME NULL,
  PRIMARY KEY (`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Jurado
DROP TABLE IF EXISTS `comuna`.`jurado`;
CREATE TABLE `comuna`.`jurado` (
  `dni` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `especialidades` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Lugar
DROP TABLE IF EXISTS `comuna`.`lugar`;
CREATE TABLE `comuna`.`lugar` (
  `codigo` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `url_gps` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Persona
DROP TABLE IF EXISTS `comuna`.`persona`;
CREATE TABLE `comuna`.`persona` (
  `dni` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` INT UNSIGNED NULL,
  `email` VARCHAR(45) NULL,
  `fecha_nac` DATE NOT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Recurso
DROP TABLE IF EXISTS `comuna`.`recurso`;
CREATE TABLE `comuna`.`recurso` (
  `codigo` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Tipo_Competencia
DROP TABLE IF EXISTS `comuna`.`tipo_competencia`;
CREATE TABLE `comuna`.`tipo_competencia` (
  `codigo` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `reglas` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Valor_Diario
DROP TABLE IF EXISTS `comuna`.`valor_diario`;
CREATE TABLE `comuna`.`valor_diario` (
  `codigo_recurso` INT UNSIGNED NOT NULL,
  `fecha_desde` DATE NOT NULL,
  `valor` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`codigo_recurso`, `fecha_desde`),
  CONSTRAINT `valor_diario_recurso`
    FOREIGN KEY (`codigo_recurso`) REFERENCES `comuna`.`recurso` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Alquiler
DROP TABLE IF EXISTS `comuna`.`alquiler`;
CREATE TABLE `comuna`.`alquiler` (
  `nro_evento` INT UNSIGNED NOT NULL,
  `codigo_recurso` INT UNSIGNED NOT NULL,
  `cantidad` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`nro_evento`, `codigo_recurso`),
  CONSTRAINT `alquiler_evento`
    FOREIGN KEY (`nro_evento`)
    REFERENCES `comuna`.`evento` (`nro`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `alquiler_recurso`
    FOREIGN KEY (`codigo_recurso`)
    REFERENCES `comuna`.`recurso` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Organizador
DROP TABLE IF EXISTS `comuna`.`organizador`;
CREATE TABLE `comuna`.`organizador` (
  `dni_persona` INT UNSIGNED NOT NULL,
  `nro_evento` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dni_persona`, `nro_evento`),
  CONSTRAINT `organizador_persona`
    FOREIGN KEY (`dni_persona`)
    REFERENCES `comuna`.`persona` (`dni`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `organizador_evento`
    FOREIGN KEY (`nro_evento`)
    REFERENCES `comuna`.`evento` (`nro`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Competencia
DROP TABLE IF EXISTS `comuna`.`competencia`;
CREATE TABLE `comuna`.`competencia` (
  `nro_evento` INT UNSIGNED NOT NULL,
  `codigo_tipo_competencia` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_hora_ini` DATETIME NOT NULL,
  `fecha_hora_fin_est` DATETIME NOT NULL,
  `premios` VARCHAR(200) NOT NULL,
  `costo_inscripcion` DECIMAL(10, 2) NOT NULL,
  `dni_jurado` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`nro_evento`, `codigo_tipo_competencia`),
  CONSTRAINT `competencia_evento`
    FOREIGN KEY (`nro_evento`)
    REFERENCES `comuna`.`evento` (`nro`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `competencia_tipo_competencia`
    FOREIGN KEY (`codigo_tipo_competencia`)
    REFERENCES `comuna`.`tipo_competencia` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `competencia_jurado`
    FOREIGN KEY (`dni_jurado`)
    REFERENCES `comuna`.`jurado` (`dni`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Participante
DROP TABLE IF EXISTS `comuna`.`participante`;
CREATE TABLE `comuna`.`participante` (
  `dni_persona` INT UNSIGNED NOT NULL,
  `nro_evento` INT UNSIGNED NOT NULL,
  `codigo_tipo_competencia` INT UNSIGNED NOT NULL,
  `fecha_hora_inscripcion` DATETIME NOT NULL,
  `puesto` INT NULL,
  PRIMARY KEY (`dni_persona`, `nro_evento`, `codigo_tipo_competencia`),
  CONSTRAINT `participante_persona`
    FOREIGN KEY (`dni_persona`)
    REFERENCES `comuna`.`persona` (`dni`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `participante_competencia`
    FOREIGN KEY (`nro_evento`, `codigo_tipo_competencia`)
    REFERENCES `comuna`.`competencia` (`nro_evento`, `codigo_tipo_competencia`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Espectáculo
DROP TABLE IF EXISTS `comuna`.`espectaculo`;
CREATE TABLE `comuna`.`espectaculo` (
  `nro_evento` INT UNSIGNED NOT NULL,
  `nro_espectaculo` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_hora_ini` DATETIME NOT NULL,
  `fecha_hora_fin` DATETIME NULL,
  `costo_cont` DECIMAL(10, 2) NOT NULL,
  `cuit_artista` INT UNSIGNED NULL,
  `codigo_lugar` INT UNSIGNED NULL,
  PRIMARY KEY (`nro_evento`, `nro_espectaculo`),
  CONSTRAINT `espectaculo_evento`
    FOREIGN KEY (`nro_evento`)
    REFERENCES `comuna`.`evento` (`nro`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `espectaculo_artista`
    FOREIGN KEY (`cuit_artista`)
    REFERENCES `comuna`.`artista` (`cuit`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `espectaculo_lugar`
    FOREIGN KEY (`codigo_lugar`)
    REFERENCES `comuna`.`lugar` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# ############ Datos a cargar en cada Tabla de la BD ############

# Artista (LIMIT 0,500)
INSERT INTO `comuna`.`artista` (`cuit`, `descripcion`, `telefono`, `email`, `actividad`, `nombre_comercial`, `nombre`, `apellido`) VALUES
  (112233, 'show les luthiers', 1110111, 'lesluthiers@ticketek.com', 'comedia', 'les luthiers', NULL, NULL),
  (272727, 'artista grunge curco vein', 2700000, 'elcurco@vein.com', 'musical', NULL, 'curco', 'vein'),
  (310013, 'banda nacional sodastereo', 1300013, 'sodastereo@sonymusic.com', 'musical', 'sodastereo', NULL, NULL),
  (445566, 'celebridad marito baracus', 4455660, 'maritobaracus@gmail.com', 'stand up', NULL, 'marito', 'baracus'),
  (555555, 'payaso piñon fijo', 9701212, 'pfshowparachicos@yahoo.com', 'show infantil', NULL, 'piñon', 'fijo'),
  (640320, 'banda nacional guasones', 1882019, 'guasones@sonymusic.com', 'musical', 'guasones', NULL, NULL),
  (700001, 'banda internacional megadeth', '309345506', 'contact@megadeth.com', 'musical', 'megadeth', NULL, NULL),
  (700002, 'banda internacional iron maiden', '568570617', 'contact@ironmaiden.com', 'musical', 'iron maiden', NULL, NULL),
  (700003, 'banda comediante u2', '252213139', 'contact@u2.com', 'comedia', 'u2', NULL, NULL),
  (700004, 'comedia musical hans zimmer', '70208212', 'contact@hanszimmer.com', 'stand up', NULL, 'hans', 'zimmer'),
  (700005, 'diversion con roger waters', '70208212', 'contact@rwaters.com', 'comedia infantil', NULL, 'roger', 'waters'),
  (700006, 'banda internacional greta van fleet', '568570617', 'contact@gretavanfleet.com', 'musical', 'greta van fleet', NULL, NULL);
COMMIT;

# Evento (LIMIT 0,500)
INSERT INTO `comuna`.`evento` (`nro`, `descripcion`, `fecha_hora_ini`, `fecha_hora_fin`) VALUES
  (1, 'torneo asado y show de guasones', '2018-10-01 18:00:00', '2018-12-12 20:00:00'),
  (2, 'torneo embolsados y show de les lutiers', '2018-01-27 18:00:00', '2018-01-28 21:00:00'),
  (3, 'torneos ciclismo y running', '2019-08-27 21:00:00', '2019-08-28 22:30:00'),
  (4, 'torneo a caballo y show piñon fijo', '2019-09-02 17:00:00', '2019-09-02 23:30:00'),
  (5, 'show hans zimmer y show u2', '2019-09-15 21:00:00', '2019-09-16 04:20:00'),
  (6, 'evento ajedrecistico', '2019-10-01 16:00:00', '2019-10-03 22:00:00'),
  (7, 'evento globant', '2019-10-13 14:00:00', '2019-10-16 20:00:00'),
  (8, 'evento agile', '2019-11-27 21:30:00', '2019-11-28 23:15:00'),
  (9, 'feria del arte', '2019-12-02 10:00:00', '2019-12-02 22:00:00'),
  (10, 'feria just do it', '2018-01-10 21:00:00', '2018-01-11 06:00:00'),
  (11, 'evento deep learning', '2020-01-05 12:00:00', '2020-01-06 12:00:00'),
  (12, 'machine learning anniversary', '2020-05-07 12:00:00', '2020-05-09 16:00:00');
COMMIT;

# Jurado (LIMIT 0,500)
INSERT INTO `comuna`.`jurado` ( `dni`, `nombre`, `apellido`, `especialidades`, `telefono`) VALUES
  (100100, 'pepe', 'argento', 'asado profesional y embolsado', '4305510'),
  (300300, 'marcelo', 'polino', 'ciclismo y running', '4108844'),
  (500500, 'john', 'johnson', 'equitacion', '2044901'),
  (555555, 'nunca fui', 'jurado', 'no ser jurado', '4455415');
COMMIT;

# Lugar (LIMIT 0,500)
INSERT INTO `comuna`.`lugar` (`codigo`, `nombre`, `direccion`, `url_gps`) VALUES
  (1, 'rosario', 'zeballos 1341', 'www.rosario.com/gps'),
  (2, 'buenos aires', 'san martin 1212', 'www.bsas.com/gps'),
  (3, 'cordoba', 'sana fe 1111', 'www.cordoba.com/gps'),
  (4, 'la plata', 'parana 9090', 'www.laplata.com/gps'),
  (5, 'miami', '2464 rinehart road', 'www.miami.com/gps'),
  (6, 'new york', '4239 veltri drive', 'www.nyc.com/gps'),
  (7, 'chicago', '834 oak lane', 'www.chicago.com/gps');
COMMIT;

# Persona (LIMIT 0,500)
INSERT INTO `comuna`.`persona` (`dni`, `nombre`, `apellido`, `telefono`, `email`, `fecha_nac`) VALUES
  (111111, 'Joshua', 'Acciari', '153657365', 'joshynob@gmail.com', '1998-07-02'),
  (111222, 'Gaston', 'Amengual', '158268440', 'gastonamengual@icloud.com', '1999-04-03'),
  (222111, 'Nicolas', 'Antonelli', '154983756', 'niconelli2@gmail.com', '1997-12-12'),
  (222222, 'Dolores', 'Biondo', '154764583', 'db@gmail.com', '1998-11-21'),
  (333111, 'Patricio', 'Carestia', '156723659', 'pc@gmail.com', '1999-04-26'),
  (333222, 'Barbara', 'De Leon', '150100200', 'bdl@gmail.com', '1998-10-09'),
  (444111, 'Eliseo', 'Gamba', '156489365', 'eg@gmail.com', '1998-03-05'),
  (444222, 'Franco', 'Giannassi', '150130120', 'fg@gmail.com', '1998-12-31'),
  (555111, 'Federico', 'Katzaroff', '156831483', 'fk@gmail.com', '1996-01-01'),
  (555222, 'Hernan', 'Listorti', '156831483', 'hl@gmail.com', '1998-02-02'),
  (666111, 'Lara', 'Mateo', '150210201', 'lm@gmail.com', '1998-03-14'),
  (666222, 'Aldana', 'Muñoz', '151234567', 'am@gmail.com', '1998-10-10'),
  (777111, 'Martin', 'Oliva', '153687415', 'mo@gmail.com', '1997-09-21'),
  (777222, 'Alejandro', 'Recalde', '157932145', 'ar@gmail.com', '1998-10-13'),
  (888111, 'Vittorio', 'Retrivi', '156831483', 'vr@gmail.com', '1999-02-14');
COMMIT;

# Recurso (LIMIT 0,500)
INSERT INTO `comuna`.`recurso` (`codigo`, `descripcion`) VALUES
  (1, 'luces pack'),
  (2, 'camara pack'),
  (3, 'accion pack'),
  (4, 'scenarie pack'),
  (5, 'Escenario movil');
COMMIT;

# Tipo_Competencia (LIMIT 0,500)
INSERT INTO `comuna`.`tipo_competencia` (`codigo`, `descripcion`, `reglas`) VALUES
  (1, 'competencia de asadores', 'prohibido comer el asado de otro participante'),
  (2, 'carrera de embolsados', 'prohibido tirar a otro participante'),
  (3, 'carrera de bicicletas', 'prohibido robar la bicicleta de otro participante'),
  (4, 'maraton', 'prohibido caminar'),
  (5, 'monta', 'prohibido robar el caballo de otro participante'),
  (6, 'torneo de ajedrez', 'prohibido abandonar');
COMMIT;

# Valor_Diario (LIMIT 0,500)
INSERT INTO `comuna`.`valor_diario` (`codigo_recurso`, `fecha_desde`, `valor`) VALUES
  # FK(codigo_recurso) => recurso(codigo)
  (1, '2018-06-01', 200.00),
  (1, '2019-01-01', 300.00),
  (1, '2019-06-01', 400.00),
  (2, '2018-05-01', 700.00),
  (2, '2019-01-10', 1000.00),
  (2, '2019-08-12', 1200.00),
  (3, '2018-09-01', 1000.00),
  (3, '2019-04-30', 2000.00),
  (3, '2019-07-02', 1500.00),
  (4, '2019-03-02', 750.00),
  (5, '2019-09-19', 2500.00);
COMMIT;

# Alquiler (LIMIT 0,500)
INSERT INTO `comuna`.`alquiler` (`nro_evento`, `codigo_recurso`, `cantidad`) VALUES
  # FK(nro_evento) => evento(nro)
  # FK (codigo_recurso) => recurso(codigo)
  (1, 1, 10),
  (1, 2, 4),
  (1, 3, 1),
  (2, 1, 12),
  (2, 2, 6),
  (2, 3, 2),
  (3, 1, 8),
  (3, 2, 5),
  (3, 3, 1),
  (9, 1, 5),
  (9, 2, 3),
  (9, 3, 3),
  (9, 4, 4);
COMMIT;

# Organizador (LIMIT 0,500)
INSERT INTO `comuna`.`organizador` (`dni_persona`, `nro_evento`) VALUES
  # FK(dni_persona) => persona(dni)
  # FK(nro_evento) => evento(nro)
  (111111, 1),
  (111111, 3),
  (111111, 4),
  (222111, 1),
  (333222, 3),
  (444111, 2),
  (444111, 4);
COMMIT;

# Competencia (LIMIT 0,500)
INSERT INTO `comuna`.`competencia` (`nro_evento`, `codigo_tipo_competencia`, `descripcion`, `fecha_hora_ini`,
`fecha_hora_fin_est`, `premios`, `costo_inscripcion`, `dni_jurado`) VALUES
  # FK(nro_evento) => evento(nro)
  # FK(codigo_tipo_competencia) => tipo_competencia(codigo)
  # FK(dni_jurado) => jurado(dni)
  (1, 1, 'cuarto torneo de asadores arg', '2018-10-01 18:00:00', '2018-12-01 14:00:00', 'playstation 4 pro', 200.00, 100100),
  (1, 2, 'super carrera de embolsados', '2018-10-01 18:00:00', '2018-10-01 19:00:00', 'playstation 3', 300.00, 300300),
  (1, 3, 'maraton 60 km SN-Ros', '2017-10-05 15:20:00', '2017-10-05 22:20:00', 'tv led 52 pulgadas 4k', 200.00, 100100),
  (1, 4, 'carrera en bici por las sierras 15km', '2017-09-02 14:00:00', '2017-09-02 18:00:00', '20.000 pesos', 150.00, 500500),
  (2, 1, 'torneo mega de asadores', '2018-01-27 19:00:00', '2018-01-27 20:00:00', 'parrilla a estrenar', 750.00, 300300),
  (2, 2, 'primer carrera embolsado', '2018-11-11 18:00:00', '2018-11-11 20:00:00', 'x-box one x', 200.00, 100100),
  (3, 1, 'tercer torneo de asadores arg', '2017-10-01 18:00:00', '2017-12-01 15:00:00', '2 playstation 4', 100.00, 100100),
  (3, 3, 'maraton 6km solidario', '2019-08-27 21:00:00', '2019-08-27 23:00:00', 'tv led 52 plugadas 4k', 350.00, 300300),
  (3, 4, 'carrera en bici por la ciudad 20km', '2019-08-28 02:00:00', '2019-08-28 04:00:00', 'tv led 52 pulgadas 4k', 350.00, 300300),
  (4, 3, 'maraton preparcial', '2018-09-23 13:30:00', '2018-09-23 15:30:00', 'aprobar el preparcial', 1000.00, 500500),
  (4, 5, 'horse games 2019', '2019-09-02 17:00:00', '2019-09-02 19:00:00', 'silla de montar de diamante', 1600.00, 500500),
  (5, 6, 'torneo internacional de ajedrez', '2018-07-02 15:00:00', '2018-07-05 19:00:00', '100.000 pesos', 150.00, 100100),
  (6, 2, 'segunda carrera embolsado', '2018-11-11 18:00:00', '2018-11-11 20:30:00', 'playstation 3 usada', 200.00, 300300),
  (6, 6, 'torneo nacional de ajedrez', '2018-10-05 15:30:00', '2018-10-08 16:00:00', '50.000 pesos', 100.00, 100100);
COMMIT;

# Participante (LIMIT 0,500)
INSERT INTO `comuna`.`participante` (`dni_persona`, `nro_evento`, `codigo_tipo_competencia`, `fecha_hora_inscripcion`, `puesto`) VALUES
  # FK(dni_persona) => persona(dni)
  # FK(nro_evento, codigo_tipo_competencia) => competencia(nro_evento, codigo_tipo_competencia)
  (111111, 1, 1, '2018-07-05 16:00:00', 1),
  (111111, 3, 3, '2018-11-11 12:00:00', 4),
  (111111, 5, 6, '2018-01-01 10:00:00', 1),
  (111111, 6, 6, '2018-01-01 10:00:00', 1),
  (111222, 2, 2, '2018-11-11 14:00:00', 2),
  (111222, 5, 6, '2018-01-01 10:00:00', 2),
  (111222, 6, 6, '2018-01-01 10:00:00', 2),
  (222111, 2, 1, '2017-08-26 15:00:00', 4),
  (222111, 2, 2, '2018-11-11 12:00:00', 1),
  (222111, 5, 6, '2018-01-01 10:00:00', 3),
  (222222, 3, 3, '2019-08-26 10:00:00', 1),
  (222222, 5, 6, '2018-01-01 10:00:00', 4),
  (222222, 6, 6, '2018-01-01 10:00:00', 3),
  (333111, 3, 3, '2019-08-26 11:00:00', 2),
  (333111, 6, 6, '2017-08-26 15:00:00', 1),
  (333222, 3, 3, '2019-08-26 15:00:00', 3);
COMMIT;

# Espectáculo (LIMIT 0,500)
INSERT INTO `comuna`.`espectaculo` (`nro_evento`, `nro_espectaculo`, `nombre`, `fecha_hora_ini`, `fecha_hora_fin`,
`costo_cont`,`cuit_artista`, `codigo_lugar`) VALUES
  # FK(nro_evento) => evento(nro)
  # FK(cuit_artista) => artista(cuit)
  # FK(codigo_lugar) => lugar(codigo)
  (1, 1, 'banda nacional guasones', '2018-12-12 17:00:00', '2018-12-12 20:00:00', 800.00, 640320, 1),
  (1, 2, 'banda nacional guasones', '2018-12-12 21:50:00', '2018-12-12 23:59:59', 900.00, 640320, 2),
  (2, 1, 'show les lutiers', '2019-01-26 19:00:00', '2019-04-26 21:00:00', 600.00, 112233, 2),
  (2, 2, 'show de greta van fleet', '2019-04-26 21:00:00', '2019-04-26 23:59:59', 1400.00, 700006, 2),
  (4, 1, 'payaso piñon fijo', '2019-01-30 13:00:00', '2019-01-30 15:00:00', 400.00, 555555, 3),
  (4, 2, 'show de guns and roses', '2019-09-02 12:00:00', '2019-09-02 23:30:00', 1000.00, NULL, NULL),
  (4, 3, 'show de greta van fleet', '2019-09-03 00:00:15', '2019-09-03 04:00:00', 1900.00, 700006, 3),
  (5, 1, 'comedia musical hans zimmer', '2019-09-15 21:00:00', '2019-09-15 23:00:00', 500.00, 700004, 4),
  (5, 2, 'banda comediante u2', '2019-09-16 02:00:00', '2019-09-16 04:20:00', 900.00, 700003, 4);
COMMIT;


# ############ Código que ya no sirve pero que dejo Comentado  ############
/*
# Modificaciones ya hechas:

ALTER TABLE `comuna`.`eventos` 
CHANGE COLUMN `fecha_hora_ini` `fecha_hora_ini` DATETIME NOT NULL ,
CHANGE COLUMN `fecha_hora_fin` `fecha_hora_fin` DATETIME NULL ;

ALTER TABLE `comuna`.`valores_diarios` 
DROP FOREIGN KEY `valores_diarios_recursos`;
ALTER TABLE `comuna`.`valores_diarios` 
ADD CONSTRAINT `valores_diarios_recursos`
  FOREIGN KEY (`codigo_recurso`)
  REFERENCES `comuna`.`recursos` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE `comuna`.`jurados` 
CHANGE COLUMN `codigo` `dni` INT UNSIGNED NOT NULL ;
# En Jurados es DNI, no CÓDIGO

ALTER TABLE `comuna`.`alquileres` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`codigo_recurso`, `nro_evento`);
;

# CONSTRAINT = RESTRICCIÓN!
*/
