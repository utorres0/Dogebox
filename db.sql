CREATE DATABASE  IF NOT EXISTS `integrador` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `integrador`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: integrador
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `archivos`
--

DROP TABLE IF EXISTS `archivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivos` (
  `AR_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AR_Nombre` varchar(100) NOT NULL,
  `AR_Tamano` varchar(10) NOT NULL,
  `AR_Tipo` varchar(10) NOT NULL,
  `AR_Accesos_totales` smallint(6) NOT NULL,
  `AR_Descarga_totales` smallint(6) NOT NULL,
  `AR_Hora_subida` time NOT NULL,
  `AR_Fecha_subida` date NOT NULL,
  `AR_Hora_Expiracion` time NOT NULL,
  `AR_Fecha_Expiracion` date NOT NULL,
  `AR_Status` int(10) unsigned NOT NULL,
  `AR_ArchivoSubido_Anonimo` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `AR_ArchivoSubido_Registrado` int(10) unsigned DEFAULT NULL,
  `AR_URL` text NOT NULL,
  `AR_Zelda` text NOT NULL,
  `AR_ZeldaCorto` text NOT NULL,
  `AR_Password` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`AR_ID`),
  KEY `fk_status` (`AR_Status`),
  KEY `fk_ArchivoSubido_Anonimo` (`AR_ArchivoSubido_Anonimo`),
  KEY `fk_ArchivoSubido_Registrado` (`AR_ArchivoSubido_Registrado`),
  CONSTRAINT `fk_ArchivoSubido_Anonimo` FOREIGN KEY (`AR_ArchivoSubido_Anonimo`) REFERENCES `usuario_anonimo` (`UA_Direccion_IP`),
  CONSTRAINT `fk_ArchivoSubido_Registrado` FOREIGN KEY (`AR_ArchivoSubido_Registrado`) REFERENCES `usuario_registrado` (`UR_ID`),
  CONSTRAINT `fk_status` FOREIGN KEY (`AR_Status`) REFERENCES `status` (`ST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivos`
--

LOCK TABLES `archivos` WRITE;
/*!40000 ALTER TABLE `archivos` DISABLE KEYS */;
INSERT INTO `archivos` VALUES (2,'received_1381453838561942.jpeg','11','jpeg',0,2,'09:52:12','2016-11-28','09:52:12','2016-11-30',1,'66.102.7.169',NULL,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/66.102.7.169/received_1381453838561942.jpeg','33bcb60aa197f29771b20d4e189e2d7d','https://goo.gl/8eZxvL',''),(3,'FB_IMG_1480253568737.jpg','30','jpg',0,0,'09:55:04','2016-11-28','09:55:04','2016-11-30',1,'66.102.7.163',NULL,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/66.102.7.163/FB_IMG_1480253568737.jpg','06246bf4dbc84d831d03bfd184543de4','https://goo.gl/2aWP5D',''),(4,'image.jpg','936','jpg',0,1,'10:03:33','2016-11-28','10:03:33','2016-11-30',1,'187.216.136.26',NULL,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/187.216.136.26/image.jpg','d71372527d69615b1f8c960f4a2ec58a','https://goo.gl/Y1HLSv',''),(5,'received_1378830018824324.jpeg','15','jpeg',0,2,'10:12:21','2016-11-28','10:12:21','2016-11-30',1,'148.213.191.174',NULL,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/148.213.191.174/received_1378830018824324.jpeg','11525896ea64e455521c9fadc80d9762','https://goo.gl/a4DGI4',''),(8,'asdff.txt','0','txt',5,1,'11:34:49','2016-11-28','14:04:42','2016-12-05',1,NULL,5,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/almarcianita@gmail.com/asdff.txt','376a69d5c4330d87e43a438bd6a23d31','https://goo.gl/TzXyFB','1'),(9,'copia deasdff.txt','0','txt',0,0,'12:48:37','2016-11-28','12:48:37','2016-12-05',1,NULL,5,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/almarcianita@gmail.com/asdff.txt','376a69d5c4330d87e43a438bd6a23d31','https://goo.gl/TzXyFB',''),(10,'diagramaEI_PI.png','57','png',1,1,'12:58:48','2016-11-28','12:58:48','2016-12-05',1,NULL,5,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/almarcianita@gmail.com/diagramaEI_PI.png','e02731d6bb93f59bdebc8f5623b63583','https://goo.gl/2an8Gc','hola'),(12,'diagramaEI_PI.png','57','png',0,1,'13:08:51','2016-11-28','13:10:02','2016-12-05',1,NULL,6,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/ivanxx.2708@gmail.com/diagramaEI_PI.png','079c827c17ad25677c9caafe401378f8','https://goo.gl/CPQQzz',''),(15,'20150428_151327.jpg','2346','jpg',0,1,'13:28:15','2016-11-28','13:28:15','2016-11-30',1,'148.213.180.118',NULL,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/148.213.180.118/20150428_151327.jpg','3aea398d9d8b3e305abde6acaedcc536','https://goo.gl/nmTA1P',''),(16,'IMG_4760.JPG','1152','JPG',1,0,'13:32:59','2016-11-28','13:34:09','2016-12-05',1,NULL,8,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/rigc88@gmail.com/IMG_4760.JPG','9f120020051a56d42fb9850c856edc98','https://goo.gl/Dlnm5t',''),(17,'20150428_145010.jpg','1966','jpg',0,0,'13:44:30','2016-11-28','13:44:30','2016-12-05',1,NULL,5,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/almarcianita@gmail.com/20150428_145010.jpg','0a7e999ecc13bbe066b3a603f981b232','https://goo.gl/BSyXR3',''),(18,'20150428_145004.jpg','2885','jpg',0,0,'13:51:06','2016-11-28','13:51:06','2016-12-05',1,NULL,5,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/almarcianita@gmail.com/20150428_145004.jpg','f4113909589115c57a2c28255d8c9c64','https://goo.gl/Jo0ysY',''),(19,'20150428_092647.jpg','2885','jpg',0,0,'14:02:35','2016-11-28','14:02:35','2016-11-30',1,'148.213.180.118',NULL,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/148.213.180.118/20150428_092647.jpg','3258c20290d8941b79aefd9757b1627f','https://goo.gl/X7HPQ9',''),(20,'20150428_092647.jpg','2885','jpg',0,0,'14:03:24','2016-11-28','14:03:24','2016-12-05',1,NULL,5,'C:/Users/oneee/Desktop/dogebox/build/web/archivos/almarcianita@gmail.com/20150428_092647.jpg','4fd8409b5f124f1206370f7551d02d5d','https://goo.gl/rjK11E','');
/*!40000 ALTER TABLE `archivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos`
--

DROP TABLE IF EXISTS `contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactos` (
  `CO_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CO_Nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `CO_Email` varchar(100) CHARACTER SET latin1 NOT NULL,
  `CO_ID_usuario` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`CO_ID`),
  KEY `fk_usuario_contacto` (`CO_ID_usuario`),
  CONSTRAINT `fk_usuario_contacto` FOREIGN KEY (`CO_ID_usuario`) REFERENCES `usuario_registrado` (`UR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
INSERT INTO `contactos` VALUES (1,'Ubaldo Torres Juárez','ubaldojuarez1@gmail.com',5),(2,'Gustrapo','gurbina0@ucol.mx',9);
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `ST_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ST_Nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`ST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'activo'),(2,'Sin verificar'),(3,'Inactivo');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_anonimo`
--

DROP TABLE IF EXISTS `usuario_anonimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_anonimo` (
  `UA_Direccion_IP` varchar(40) CHARACTER SET latin1 NOT NULL,
  `UA_Archivos_activos` tinyint(4) NOT NULL,
  `UA_Limite_Subida` tinyint(4) NOT NULL,
  PRIMARY KEY (`UA_Direccion_IP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_anonimo`
--

LOCK TABLES `usuario_anonimo` WRITE;
/*!40000 ALTER TABLE `usuario_anonimo` DISABLE KEYS */;
INSERT INTO `usuario_anonimo` VALUES ('148.213.180.118',2,4),('148.213.191.174',1,4),('187.216.136.26',1,4),('66.102.7.163',1,4),('66.102.7.167',0,4),('66.102.7.169',1,4);
/*!40000 ALTER TABLE `usuario_anonimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_registrado`
--

DROP TABLE IF EXISTS `usuario_registrado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_registrado` (
  `UR_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UR_Nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `UR_Email` varchar(100) CHARACTER SET latin1 NOT NULL,
  `UR_Password` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `UR_Status` int(10) unsigned NOT NULL,
  `UR_CodigoActivacion` varchar(35) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`UR_ID`),
  KEY `fk_registrado_status` (`UR_Status`),
  CONSTRAINT `fk_registrado_status` FOREIGN KEY (`UR_Status`) REFERENCES `status` (`ST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_registrado`
--

LOCK TABLES `usuario_registrado` WRITE;
/*!40000 ALTER TABLE `usuario_registrado` DISABLE KEYS */;
INSERT INTO `usuario_registrado` VALUES (2,'GUstavo','gurbina0@ucol.com','1',2,'958bf851fb8af9cd0bc816ce735fdcc4'),(4,'gustavo puto','gurbina0@ucol.mx','a',1,'2a052da6d41323e3443f86e5d5aec962'),(5,'Alma','almarcianita@gmail.com','hehe',1,'87b2d773d87d2b042e959858fe89122a'),(6,'ivan guerrero','ivanxx.2708@gmail.com','cucharas',1,'c442a66ed2f3d65e5ee6d9b2905ae004'),(8,'christian rincon','rigc88@gmail.com','colima2016',1,'7ce0e798b7e5727133ca6bfed4cea94c'),(9,'Ubaldo Torres Juárez','ubaldojuarez1@gmail.com','3983',1,'f9d7e2d48b705c17ebbdc1e13ac8bcb1');
/*!40000 ALTER TABLE `usuario_registrado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'integrador'
--

--
-- Dumping routines for database 'integrador'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-09 13:25:51
