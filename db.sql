CREATE DATABASE  IF NOT EXISTS `integrador` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `integrador`;
-- MySQL dump 10.13  Distrib 8.0.14, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: integrador
-- ------------------------------------------------------
-- Server version	8.0.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
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
 SET character_set_client = utf8mb4 ;
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
  `AR_ArchivoSubido_Anonimo` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivos`
--

LOCK TABLES `archivos` WRITE;
/*!40000 ALTER TABLE `archivos` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos`
--

DROP TABLE IF EXISTS `contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contactos` (
  `CO_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CO_Nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `CO_Email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `status` (
  `ST_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ST_Nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuario_anonimo` (
  `UA_Direccion_IP` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
/*!40000 ALTER TABLE `usuario_anonimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_registrado`
--

DROP TABLE IF EXISTS `usuario_registrado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuario_registrado` (
  `UR_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UR_Nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `UR_Email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `UR_Password` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `UR_Status` int(10) unsigned NOT NULL,
  `UR_CodigoActivacion` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
INSERT INTO `usuario_registrado` VALUES (9,'Ubaldo Torres Juárez','ubaldojuarez1@gmail.com','3983',1,'f9d7e2d48b705c17ebbdc1e13ac8bcb1');
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

-- Dump completed on 2019-02-15  0:18:11
