-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: comuna
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alquiler`
--

DROP TABLE IF EXISTS `alquiler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alquiler` (
  `nro_evento` int(10) unsigned NOT NULL,
  `codigo_recurso` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nro_evento`,`codigo_recurso`),
  KEY `alquiler_recurso` (`codigo_recurso`),
  CONSTRAINT `alquiler_evento` FOREIGN KEY (`nro_evento`) REFERENCES `evento` (`nro`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `alquiler_recurso` FOREIGN KEY (`codigo_recurso`) REFERENCES `recurso` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `artista`
--

DROP TABLE IF EXISTS `artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artista` (
  `cuit` int(10) unsigned NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `telefono` int(10) unsigned DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `actividad` varchar(45) NOT NULL,
  `nombre_comercial` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `competencia`
--

DROP TABLE IF EXISTS `competencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencia` (
  `nro_evento` int(10) unsigned NOT NULL,
  `codigo_tipo_competencia` int(10) unsigned NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `fecha_hora_ini` datetime NOT NULL,
  `fecha_hora_fin_est` datetime NOT NULL,
  `premios` varchar(200) NOT NULL,
  `costo_inscripcion` decimal(10,2) NOT NULL,
  `dni_jurado` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nro_evento`,`codigo_tipo_competencia`),
  KEY `competencia_tipo_competencia` (`codigo_tipo_competencia`),
  KEY `competencia_jurado` (`dni_jurado`),
  CONSTRAINT `competencia_evento` FOREIGN KEY (`nro_evento`) REFERENCES `evento` (`nro`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `competencia_jurado` FOREIGN KEY (`dni_jurado`) REFERENCES `jurado` (`dni`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `competencia_tipo_competencia` FOREIGN KEY (`codigo_tipo_competencia`) REFERENCES `tipo_competencia` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `espectaculo`
--

DROP TABLE IF EXISTS `espectaculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espectaculo` (
  `nro_evento` int(10) unsigned NOT NULL,
  `nro_espectaculo` int(10) unsigned NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fecha_hora_ini` datetime NOT NULL,
  `fecha_hora_fin` datetime DEFAULT NULL,
  `costo_cont` decimal(10,2) NOT NULL,
  `cuit_artista` int(10) unsigned DEFAULT NULL,
  `codigo_lugar` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`nro_evento`,`nro_espectaculo`),
  KEY `espectaculo_artista` (`cuit_artista`),
  KEY `espectaculo_lugar` (`codigo_lugar`),
  CONSTRAINT `espectaculo_artista` FOREIGN KEY (`cuit_artista`) REFERENCES `artista` (`cuit`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `espectaculo_evento` FOREIGN KEY (`nro_evento`) REFERENCES `evento` (`nro`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `espectaculo_lugar` FOREIGN KEY (`codigo_lugar`) REFERENCES `lugar` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `nro` int(10) unsigned NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `fecha_hora_ini` datetime NOT NULL,
  `fecha_hora_fin` datetime DEFAULT NULL,
  PRIMARY KEY (`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jurado`
--

DROP TABLE IF EXISTS `jurado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jurado` (
  `dni` int(10) unsigned NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `especialidades` varchar(45) NOT NULL,
  `telefono` int(11) DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lugar`
--

DROP TABLE IF EXISTS `lugar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lugar` (
  `codigo` int(10) unsigned NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `url_gps` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizador`
--

DROP TABLE IF EXISTS `organizador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizador` (
  `dni_persona` int(10) unsigned NOT NULL,
  `nro_evento` int(10) unsigned NOT NULL,
  PRIMARY KEY (`dni_persona`,`nro_evento`),
  KEY `organizador_evento` (`nro_evento`),
  CONSTRAINT `organizador_evento` FOREIGN KEY (`nro_evento`) REFERENCES `evento` (`nro`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `organizador_persona` FOREIGN KEY (`dni_persona`) REFERENCES `persona` (`dni`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `participante`
--

DROP TABLE IF EXISTS `participante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participante` (
  `dni_persona` int(10) unsigned NOT NULL,
  `nro_evento` int(10) unsigned NOT NULL,
  `codigo_tipo_competencia` int(10) unsigned NOT NULL,
  `fecha_hora_inscripcion` datetime NOT NULL,
  `puesto` int(11) DEFAULT NULL,
  PRIMARY KEY (`dni_persona`,`nro_evento`,`codigo_tipo_competencia`),
  KEY `participante_competencia` (`nro_evento`,`codigo_tipo_competencia`),
  CONSTRAINT `participante_competencia` FOREIGN KEY (`nro_evento`, `codigo_tipo_competencia`) REFERENCES `competencia` (`nro_evento`, `codigo_tipo_competencia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `participante_persona` FOREIGN KEY (`dni_persona`) REFERENCES `persona` (`dni`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `dni` int(10) unsigned NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `telefono` int(10) unsigned DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `fecha_nac` date NOT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurso`
--

DROP TABLE IF EXISTS `recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso` (
  `codigo` int(10) unsigned NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_competencia`
--

DROP TABLE IF EXISTS `tipo_competencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_competencia` (
  `codigo` int(10) unsigned NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `reglas` varchar(200) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valor_diario`
--

DROP TABLE IF EXISTS `valor_diario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valor_diario` (
  `codigo_recurso` int(10) unsigned NOT NULL,
  `fecha_desde` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigo_recurso`,`fecha_desde`),
  CONSTRAINT `valor_diario_recurso` FOREIGN KEY (`codigo_recurso`) REFERENCES `recurso` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'comuna'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-23 12:10:37
