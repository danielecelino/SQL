CREATE DATABASE  IF NOT EXISTS `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `pais` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Isabel Allende','Chile'),(2,'Arturo Perez-Reverte','España'),(3,'Haruki Murakami','Japón'),(4,'Ursula K. Le Guin','EEUU'),(5,'Stephen King','EEUU'),(6,'Carlos Ruiz Zafon','España'),(7,'Jorge Luis Borges','Argentina');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escribe`
--

DROP TABLE IF EXISTS `escribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `escribe` (
  `autor_id` int NOT NULL,
  `libro_id` int NOT NULL,
  PRIMARY KEY (`autor_id`,`libro_id`),
  KEY `libro_id` (`libro_id`),
  CONSTRAINT `escribe_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `autor` (`id`),
  CONSTRAINT `escribe_ibfk_2` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escribe`
--

LOCK TABLES `escribe` WRITE;
/*!40000 ALTER TABLE `escribe` DISABLE KEYS */;
INSERT INTO `escribe` VALUES (1,1),(7,1),(2,2),(3,3),(4,4),(5,5),(1,6),(2,6),(6,6),(3,7),(7,7);
/*!40000 ALTER TABLE `escribe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `genero` varchar(40) NOT NULL,
  `anio_publicacion` int NOT NULL,
  `codigo_libro` varchar(20) NOT NULL,
  `editorial` varchar(60) DEFAULT NULL,
  `idioma` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_libro` (`codigo_libro`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (1,'La casa de los espiritus','Novela',1982,'L-001',NULL,NULL),(2,'El capitan Alatriste','Novela',1996,'L-002',NULL,NULL),(3,'Kafka en la orilla','Novela',2002,'L-003',NULL,NULL),(4,'Los desposeidos','Ciencia ficcion',1974,'L-004',NULL,NULL),(5,'It','Terror',1986,'L-005',NULL,NULL),(6,'La sombra del viento','Novela',2001,'L-006',NULL,NULL),(7,'Cuentos completos','Relatos',2010,'L-007',NULL,NULL),(8,'Historia del tiempo','Ensayo',1988,'L-008',NULL,NULL);
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multa`
--

DROP TABLE IF EXISTS `multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prestamo_id` int NOT NULL,
  `importe` decimal(7,2) NOT NULL,
  `motivo` varchar(120) NOT NULL,
  `fecha` date NOT NULL,
  `pagada` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_pago` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prestamo_id` (`prestamo_id`),
  CONSTRAINT `multa_ibfk_1` FOREIGN KEY (`prestamo_id`) REFERENCES `prestamo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multa`
--

LOCK TABLES `multa` WRITE;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` VALUES (1,2,5.00,'Retraso en devolucion','2024-06-10',0,NULL),(2,4,7.50,'Libro dañado','2024-06-05',0,NULL),(3,8,3.00,'Retraso en devolucion','2024-03-10',0,NULL),(4,10,4.50,'Retraso en devolucion','2024-06-20',0,NULL),(5,12,6.00,'Retraso en devolucion','2024-05-25',0,NULL),(6,6,4.00,'Retraso en devolucion','2024-06-20',0,NULL),(7,7,6.50,'Libro dañado','2024-06-22',0,NULL);
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `socio_id` int NOT NULL,
  `libro_id` int NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `socio_id` (`socio_id`),
  KEY `libro_id` (`libro_id`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`socio_id`) REFERENCES `socio` (`id`),
  CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`libro_id`) REFERENCES `libro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,1,1,'2024-05-03','2024-05-20',NULL),(2,2,2,'2024-05-10',NULL,NULL),(3,3,3,'2024-04-15','2024-04-28',NULL),(4,4,4,'2024-05-25',NULL,NULL),(5,5,5,'2024-03-02','2024-03-18',NULL),(6,1,3,'2024-06-01',NULL,NULL),(7,6,6,'2024-05-12','2024-05-19',NULL),(8,2,5,'2024-02-20','2024-03-05',NULL),(9,5,2,'2023-11-10','2023-11-25',NULL),(10,7,7,'2024-06-15',NULL,NULL),(11,8,1,'2024-05-02','2024-05-04',NULL),(12,2,1,'2023-05-10','2023-05-20',NULL),(13,3,5,'2024-05-01',NULL,NULL),(14,1,5,'2024-06-10',NULL,NULL),(15,1,2,'2024-06-15',NULL,NULL);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio`
--

DROP TABLE IF EXISTS `socio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `email` varchar(120) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_alta` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socio`
--

LOCK TABLES `socio` WRITE;
/*!40000 ALTER TABLE `socio` DISABLE KEYS */;
INSERT INTO `socio` VALUES (1,'Ana Ruiz','ana@correo.com','555-0101','2023-01-10'),(2,'Luis Soto','luis@gmail.com','555-0202','2023-03-05'),(3,'Marta Lopez','marta@correo.com',NULL,'2023-06-20'),(4,'Pablo Diaz','pablo@gmail.com','600-1111','2024-02-12'),(5,'Elena Romero','elena@correo.com','555-0303','2024-04-01'),(6,'Sergio Ferrer','sergio@correo.com',NULL,'2024-05-18'),(7,'Nuria Gil','nuria@correo.com','555-0404','2024-06-10'),(8,'Ivan Mora','ivan@gmail.com',NULL,'2024-06-11');
/*!40000 ALTER TABLE `socio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-30 12:39:59
