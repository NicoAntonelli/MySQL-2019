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
-- Dumping data for table `alquiler`
--

LOCK TABLES `alquiler` WRITE;
/*!40000 ALTER TABLE `alquiler` DISABLE KEYS */;
INSERT INTO `alquiler` VALUES (1,1,10),(1,2,4),(1,3,1),(2,1,12),(2,2,6),(2,3,2),(3,1,8),(3,2,5),(3,3,1),(9,1,5),(9,2,3),(9,3,3),(9,4,4);
/*!40000 ALTER TABLE `alquiler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `artista`
--

LOCK TABLES `artista` WRITE;
/*!40000 ALTER TABLE `artista` DISABLE KEYS */;
INSERT INTO `artista` VALUES (112233,'show les luthiers',1110111,'lesluthiers@ticketek.com','comedia','les luthiers',NULL,NULL),(272727,'artista grunge curco vein',2700000,'elcurco@vein.com','musical',NULL,'curco','vein'),(310013,'banda nacional sodastereo',1300013,'sodastereo@sonymusic.com','musical','sodastereo',NULL,NULL),(445566,'celebridad marito baracus',4455660,'maritobaracus@gmail.com','stand up',NULL,'marito','baracus'),(555555,'payaso piñon fijo',9701212,'pfshowparachicos@yahoo.com','show infantil',NULL,'piñon','fijo'),(640320,'banda nacional guasones',1882019,'guasones@sonymusic.com','musical','guasones',NULL,NULL),(700001,'banda internacional megadeth',309345506,'contact@megadeth.com','musical','megadeth',NULL,NULL),(700002,'banda internacional iron maiden',568570617,'contact@ironmaiden.com','musical','iron maiden',NULL,NULL),(700003,'banda comediante u2',252213139,'contact@u2.com','comedia','u2',NULL,NULL),(700004,'comedia musical hans zimmer',70208212,'contact@hanszimmer.com','stand up',NULL,'hans','zimmer'),(700005,'diversion con roger waters',70208212,'contact@rwaters.com','comedia infantil',NULL,'roger','waters'),(700006,'banda internacional greta van fleet',568570617,'contact@gretavanfleet.com','musical','greta van fleet',NULL,NULL);
/*!40000 ALTER TABLE `artista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `competencia`
--

LOCK TABLES `competencia` WRITE;
/*!40000 ALTER TABLE `competencia` DISABLE KEYS */;
INSERT INTO `competencia` VALUES (1,1,'cuarto torneo de asadores arg','2018-10-01 18:00:00','2018-12-01 14:00:00','playstation 4 pro',200.00,100100),(1,2,'super carrera de embolsados','2018-10-01 18:00:00','2018-10-01 19:00:00','playstation 3',300.00,300300),(1,3,'maraton 60 km SN-Ros','2017-10-05 15:20:00','2017-10-05 22:20:00','tv led 52 pulgadas 4k',200.00,100100),(1,4,'carrera en bici por las sierras 15km','2017-09-02 14:00:00','2017-09-02 18:00:00','20.000 pesos',150.00,500500),(2,1,'torneo mega de asadores','2018-01-27 19:00:00','2018-01-27 20:00:00','parrilla a estrenar',750.00,300300),(2,2,'primer carrera embolsado','2018-11-11 18:00:00','2018-11-11 20:00:00','x-box one x',200.00,100100),(3,1,'tercer torneo de asadores arg','2017-10-01 18:00:00','2017-12-01 15:00:00','2 playstation 4',100.00,100100),(3,3,'maraton 6km solidario','2019-08-27 21:00:00','2019-08-27 23:00:00','tv led 52 plugadas 4k',350.00,300300),(3,4,'carrera en bici por la ciudad 20km','2019-08-28 02:00:00','2019-08-28 04:00:00','tv led 52 pulgadas 4k',350.00,300300),(4,5,'horse games 2019','2019-09-02 17:00:00','2019-09-02 19:00:00','silla de montar de diamante',1600.00,500500),(5,6,'torneo internacional de ajedrez','2018-07-02 15:00:00','2018-07-05 19:00:00','100.000 pesos',150.00,100100),(6,2,'segunda carrera embolsado','2018-11-11 18:00:00','2018-11-11 20:30:00','playstation 3 usada',200.00,300300),(6,6,'torneo nacional de ajedrez','2018-10-05 15:30:00','2018-10-08 16:00:00','50.000 pesos',100.00,100100);
/*!40000 ALTER TABLE `competencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `espectaculo`
--

LOCK TABLES `espectaculo` WRITE;
/*!40000 ALTER TABLE `espectaculo` DISABLE KEYS */;
INSERT INTO `espectaculo` VALUES (1,1,'banda nacional guasones','2018-12-12 17:00:00','2018-12-12 20:00:00',800.00,640320,1),(1,2,'banda nacional guasones','2018-12-12 21:50:00','2018-12-12 23:59:59',900.00,640320,2),(2,1,'show les lutiers','2019-01-26 19:00:00','2019-04-26 21:00:00',600.00,112233,2),(2,2,'show de greta van fleet','2019-04-26 21:00:00','2019-04-26 23:59:59',1400.00,700006,2),(4,1,'payaso piñon fijo','2019-01-30 13:00:00','2019-01-30 15:00:00',400.00,555555,3),(4,2,'show de guns and roses','2019-09-02 12:00:00','2019-09-02 23:30:00',1000.00,NULL,NULL),(4,3,'show de greta van fleet','2019-09-03 00:00:15','2019-09-03 04:00:00',1900.00,700006,3),(5,1,'comedia musical hans zimmer','2019-09-15 21:00:00','2019-09-15 23:00:00',500.00,700004,4),(5,2,'banda comediante u2','2019-09-16 02:00:00','2019-09-16 04:20:00',900.00,700003,4);
/*!40000 ALTER TABLE `espectaculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'torneo asado y show de guasones','2018-10-01 18:00:00','2018-12-12 20:00:00'),(2,'torneo embolsados y show de les lutiers','2018-01-27 18:00:00','2018-01-28 21:00:00'),(3,'torneos ciclismo y running','2019-08-27 21:00:00','2019-08-28 22:30:00'),(4,'torneo a caballo y show piñon fijo','2019-09-02 17:00:00','2019-09-02 23:30:00'),(5,'show hans zimmer y show u2','2019-09-15 21:00:00','2019-09-16 04:20:00'),(6,'evento ajedrecistico','2019-10-01 16:00:00','2019-10-03 22:00:00'),(7,'evento globant','2019-10-13 14:00:00','2019-10-16 20:00:00'),(8,'evento agile','2019-11-27 21:30:00','2019-11-28 23:15:00'),(9,'feria del arte','2019-12-02 10:00:00','2019-12-02 22:00:00'),(10,'feria just do it','2018-01-10 21:00:00','2018-01-11 06:00:00'),(11,'evento deep learning','2020-01-05 12:00:00','2020-01-06 12:00:00'),(12,'machine learning anniversary','2020-05-07 12:00:00','2020-05-09 16:00:00');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `jurado`
--

LOCK TABLES `jurado` WRITE;
/*!40000 ALTER TABLE `jurado` DISABLE KEYS */;
INSERT INTO `jurado` VALUES (100100,'pepe','argento','asado profesional y embolsado',4305510),(300300,'marcelo','polino','ciclismo y running',4108844),(500500,'john','johnson','equitacion',2044901),(555555,'nunca fui','jurado','no ser jurado',4455415);
/*!40000 ALTER TABLE `jurado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lugar`
--

LOCK TABLES `lugar` WRITE;
/*!40000 ALTER TABLE `lugar` DISABLE KEYS */;
INSERT INTO `lugar` VALUES (1,'rosario','zeballos 1341','www.rosario.com/gps'),(2,'buenos aires','san martin 1212','www.bsas.com/gps'),(3,'cordoba','sana fe 1111','www.cordoba.com/gps'),(4,'la plata','parana 9090','www.laplata.com/gps'),(5,'miami','2464 rinehart road','www.miami.com/gps'),(6,'new york','4239 veltri drive','www.nyc.com/gps'),(7,'chicago','834 oak lane','www.chicago.com/gps');
/*!40000 ALTER TABLE `lugar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organizador`
--

LOCK TABLES `organizador` WRITE;
/*!40000 ALTER TABLE `organizador` DISABLE KEYS */;
INSERT INTO `organizador` VALUES (111111,1),(222111,1),(444111,2),(111111,3),(333222,3),(111111,4),(444111,4);
/*!40000 ALTER TABLE `organizador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `participante`
--

LOCK TABLES `participante` WRITE;
/*!40000 ALTER TABLE `participante` DISABLE KEYS */;
INSERT INTO `participante` VALUES (111111,1,1,'2018-07-05 16:00:00',1),(111111,3,3,'2018-11-11 12:00:00',4),(111111,5,6,'2018-01-01 10:00:00',1),(111111,6,6,'2018-01-01 10:00:00',1),(111222,2,2,'2018-11-11 14:00:00',2),(111222,5,6,'2018-01-01 10:00:00',2),(111222,6,6,'2018-01-01 10:00:00',2),(222111,2,1,'2017-08-26 15:00:00',4),(222111,2,2,'2018-11-11 12:00:00',1),(222111,5,6,'2018-01-01 10:00:00',3),(222222,3,3,'2019-08-26 10:00:00',1),(222222,5,6,'2018-01-01 10:00:00',4),(222222,6,6,'2018-01-01 10:00:00',3),(333111,3,3,'2019-08-26 11:00:00',2),(333111,6,6,'2017-08-26 15:00:00',1),(333222,3,3,'2019-08-26 15:00:00',3);
/*!40000 ALTER TABLE `participante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (111111,'Joshua','Acciari',153657365,'joshynob@gmail.com','1998-07-02'),(111222,'Gaston','Amengual',158268440,'gastonamengual@icloud.com','1999-04-03'),(222111,'Nicolas','Antonelli',154983756,'niconelli2@gmail.com','1997-12-12'),(222222,'Dolores','Biondo',154764583,'db@gmail.com','1998-11-21'),(333111,'Patricio','Carestia',156723659,'pc@gmail.com','1999-04-26'),(333222,'Barbara','De Leon',150100200,'bdl@gmail.com','1998-10-09'),(444111,'Eliseo','Gamba',156489365,'eg@gmail.com','1998-03-05'),(444222,'Franco','Giannassi',150130120,'fg@gmail.com','1998-12-31'),(555111,'Federico','Katzaroff',156831483,'fk@gmail.com','1996-01-01'),(555222,'Hernan','Listorti',156831483,'hl@gmail.com','1998-02-02'),(666111,'Lara','Mateo',150210201,'lm@gmail.com','1998-03-14'),(666222,'Aldana','Muñoz',151234567,'am@gmail.com','1998-10-10'),(777111,'Martin','Oliva',153687415,'mo@gmail.com','1997-09-21'),(777222,'Alejandro','Recalde',157932145,'ar@gmail.com','1998-10-13'),(888111,'Vittorio','Retrivi',156831483,'vr@gmail.com','1999-02-14');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `recurso`
--

LOCK TABLES `recurso` WRITE;
/*!40000 ALTER TABLE `recurso` DISABLE KEYS */;
INSERT INTO `recurso` VALUES (1,'luces pack'),(2,'camara pack'),(3,'accion pack'),(4,'scenarie pack'),(5,'Escenario movil');
/*!40000 ALTER TABLE `recurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipo_competencia`
--

LOCK TABLES `tipo_competencia` WRITE;
/*!40000 ALTER TABLE `tipo_competencia` DISABLE KEYS */;
INSERT INTO `tipo_competencia` VALUES (1,'competencia de asadores','prohibido comer el asado de otro participante'),(2,'carrera de embolsados','prohibido tirar a otro participante'),(3,'carrera de bicicletas','prohibido robar la bicicleta de otro participante'),(4,'maraton','prohibido caminar'),(5,'monta','prohibido robar el caballo de otro participante'),(6,'torneo de ajedrez','prohibido abandonar');
/*!40000 ALTER TABLE `tipo_competencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `valor_diario`
--

LOCK TABLES `valor_diario` WRITE;
/*!40000 ALTER TABLE `valor_diario` DISABLE KEYS */;
INSERT INTO `valor_diario` VALUES (1,'2018-06-01',200.00),(1,'2019-01-01',300.00),(1,'2019-06-01',400.00),(2,'2018-05-01',700.00),(2,'2019-01-10',1000.00),(2,'2019-08-12',1200.00),(3,'2018-09-01',1000.00),(3,'2019-04-30',2000.00),(3,'2019-07-02',1500.00),(4,'2019-03-02',750.00),(5,'2019-09-19',2500.00);
/*!40000 ALTER TABLE `valor_diario` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2019-09-23 12:10:13
