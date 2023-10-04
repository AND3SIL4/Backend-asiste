CREATE DATABASE  IF NOT EXISTS `asiste_v4` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `asiste_v4`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: asiste_v4
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `asistencia_aprendiz`
--

DROP TABLE IF EXISTS `asistencia_aprendiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_aprendiz` (
  `documento_aprendiz` int NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `nombres_aprendiz` varchar(45) NOT NULL,
  `apellidos_aprendiz` varchar(45) NOT NULL,
  `email_personal_aprendiz` varchar(45) NOT NULL,
  `email_institucional_aprendiz` varchar(45) NOT NULL,
  `numero_celular` int NOT NULL,
  `genero_aprendiz` varchar(10) NOT NULL,
  `ficha_aprendiz_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`documento_aprendiz`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `asistencia_aprendiz_ficha_aprendiz_id_1aefdd6e_fk_asistenci` (`ficha_aprendiz_id`),
  CONSTRAINT `asistencia_aprendiz_ficha_aprendiz_id_1aefdd6e_fk_asistenci` FOREIGN KEY (`ficha_aprendiz_id`) REFERENCES `asistencia_ficha` (`id_ficha`),
  CONSTRAINT `asistencia_aprendiz_user_id_fd8e854d_fk_users_user_document` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`document`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_aprendiz`
--

LOCK TABLES `asistencia_aprendiz` WRITE;
/*!40000 ALTER TABLE `asistencia_aprendiz` DISABLE KEYS */;
INSERT INTO `asistencia_aprendiz` VALUES (333,'CC','Aprendiz','sena','anndres@gmail.com','af@misena.edu.co',333,'Masculino',1,333),(999,'CC','Aprendiz 2','2','anndres@gmail.com','af@misena.edu.co',333,'Masculino',1,555);
/*!40000 ALTER TABLE `asistencia_aprendiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_asistencia`
--

DROP TABLE IF EXISTS `asistencia_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_asistencia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_asistencia` date NOT NULL,
  `presente` varchar(45) NOT NULL,
  `aprendiz_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `asistencia_asistenci_aprendiz_id_d2ad6ef1_fk_asistenci` (`aprendiz_id`),
  CONSTRAINT `asistencia_asistenci_aprendiz_id_d2ad6ef1_fk_asistenci` FOREIGN KEY (`aprendiz_id`) REFERENCES `asistencia_aprendiz` (`documento_aprendiz`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_asistencia`
--

LOCK TABLES `asistencia_asistencia` WRITE;
/*!40000 ALTER TABLE `asistencia_asistencia` DISABLE KEYS */;
INSERT INTO `asistencia_asistencia` VALUES (15,'2023-08-01','Novedad',333);
/*!40000 ALTER TABLE `asistencia_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_coordinacion`
--

DROP TABLE IF EXISTS `asistencia_coordinacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_coordinacion` (
  `id_coordinacion` int NOT NULL,
  `nombre_coordinacion` varchar(45) NOT NULL,
  PRIMARY KEY (`id_coordinacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_coordinacion`
--

LOCK TABLES `asistencia_coordinacion` WRITE;
/*!40000 ALTER TABLE `asistencia_coordinacion` DISABLE KEYS */;
INSERT INTO `asistencia_coordinacion` VALUES (1,'TELEINFORMATICA');
/*!40000 ALTER TABLE `asistencia_coordinacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_ficha`
--

DROP TABLE IF EXISTS `asistencia_ficha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_ficha` (
  `id_ficha` int NOT NULL,
  `nivel_formacion` varchar(20) NOT NULL,
  `programa_ficha_id` int NOT NULL,
  PRIMARY KEY (`id_ficha`),
  KEY `asistencia_ficha_programa_ficha_id_3a39b313_fk_asistenci` (`programa_ficha_id`),
  CONSTRAINT `asistencia_ficha_programa_ficha_id_3a39b313_fk_asistenci` FOREIGN KEY (`programa_ficha_id`) REFERENCES `asistencia_programa` (`id_programa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_ficha`
--

LOCK TABLES `asistencia_ficha` WRITE;
/*!40000 ALTER TABLE `asistencia_ficha` DISABLE KEYS */;
INSERT INTO `asistencia_ficha` VALUES (1,'TECNICO',1);
/*!40000 ALTER TABLE `asistencia_ficha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_ficha_horario_ficha`
--

DROP TABLE IF EXISTS `asistencia_ficha_horario_ficha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_ficha_horario_ficha` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ficha_id` int NOT NULL,
  `horario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asistencia_ficha_horario_ficha_ficha_id_horario_id_1fee0d74_uniq` (`ficha_id`,`horario_id`),
  KEY `asistencia_ficha_hor_horario_id_8f17c7d4_fk_asistenci` (`horario_id`),
  CONSTRAINT `asistencia_ficha_hor_ficha_id_3a402004_fk_asistenci` FOREIGN KEY (`ficha_id`) REFERENCES `asistencia_ficha` (`id_ficha`),
  CONSTRAINT `asistencia_ficha_hor_horario_id_8f17c7d4_fk_asistenci` FOREIGN KEY (`horario_id`) REFERENCES `asistencia_horario` (`horario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_ficha_horario_ficha`
--

LOCK TABLES `asistencia_ficha_horario_ficha` WRITE;
/*!40000 ALTER TABLE `asistencia_ficha_horario_ficha` DISABLE KEYS */;
INSERT INTO `asistencia_ficha_horario_ficha` VALUES (1,1,3);
/*!40000 ALTER TABLE `asistencia_ficha_horario_ficha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_ficha_instructores`
--

DROP TABLE IF EXISTS `asistencia_ficha_instructores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_ficha_instructores` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ficha_id` int NOT NULL,
  `instructor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asistencia_ficha_instruc_ficha_id_instructor_id_5ed6d8d8_uniq` (`ficha_id`,`instructor_id`),
  KEY `asistencia_ficha_ins_instructor_id_9ce7fb38_fk_asistenci` (`instructor_id`),
  CONSTRAINT `asistencia_ficha_ins_ficha_id_75a5c0c7_fk_asistenci` FOREIGN KEY (`ficha_id`) REFERENCES `asistencia_ficha` (`id_ficha`),
  CONSTRAINT `asistencia_ficha_ins_instructor_id_9ce7fb38_fk_asistenci` FOREIGN KEY (`instructor_id`) REFERENCES `asistencia_instructor` (`documento`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_ficha_instructores`
--

LOCK TABLES `asistencia_ficha_instructores` WRITE;
/*!40000 ALTER TABLE `asistencia_ficha_instructores` DISABLE KEYS */;
INSERT INTO `asistencia_ficha_instructores` VALUES (1,1,222);
/*!40000 ALTER TABLE `asistencia_ficha_instructores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_horario`
--

DROP TABLE IF EXISTS `asistencia_horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_horario` (
  `horario_id` int NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrada` time(6) NOT NULL,
  `hora_salida` time(6) NOT NULL,
  `salon` int NOT NULL,
  `jornada` varchar(10) NOT NULL,
  `asignatura` varchar(45) NOT NULL,
  PRIMARY KEY (`horario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_horario`
--

LOCK TABLES `asistencia_horario` WRITE;
/*!40000 ALTER TABLE `asistencia_horario` DISABLE KEYS */;
INSERT INTO `asistencia_horario` VALUES (3,'2023-08-01','01:49:03.000000','01:49:03.000000',2,'DIURNA','Futter');
/*!40000 ALTER TABLE `asistencia_horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_instructor`
--

DROP TABLE IF EXISTS `asistencia_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_instructor` (
  `documento` int NOT NULL,
  `nombres_instructor` varchar(45) NOT NULL,
  `apellidos_instructor` varchar(45) NOT NULL,
  `email_institucional` varchar(50) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`documento`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `asistencia_instructor_user_id_ca33cf01_fk_users_user_document` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`document`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_instructor`
--

LOCK TABLES `asistencia_instructor` WRITE;
/*!40000 ALTER TABLE `asistencia_instructor` DISABLE KEYS */;
INSERT INTO `asistencia_instructor` VALUES (222,'Nuevo Nombre','Nuevo Apellido','nuevo_email@example.com',222);
/*!40000 ALTER TABLE `asistencia_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_instructor_registro_asistencia`
--

DROP TABLE IF EXISTS `asistencia_instructor_registro_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_instructor_registro_asistencia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `instructor_id` int NOT NULL,
  `asistencia_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asistencia_instructor_re_instructor_id_asistencia_68fa517a_uniq` (`instructor_id`,`asistencia_id`),
  KEY `asistencia_instructo_asistencia_id_7ddea6cb_fk_asistenci` (`asistencia_id`),
  CONSTRAINT `asistencia_instructo_asistencia_id_7ddea6cb_fk_asistenci` FOREIGN KEY (`asistencia_id`) REFERENCES `asistencia_asistencia` (`id`),
  CONSTRAINT `asistencia_instructo_instructor_id_2d33d1b3_fk_asistenci` FOREIGN KEY (`instructor_id`) REFERENCES `asistencia_instructor` (`documento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_instructor_registro_asistencia`
--

LOCK TABLES `asistencia_instructor_registro_asistencia` WRITE;
/*!40000 ALTER TABLE `asistencia_instructor_registro_asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencia_instructor_registro_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_novedad`
--

DROP TABLE IF EXISTS `asistencia_novedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_novedad` (
  `id_novedad` int NOT NULL AUTO_INCREMENT,
  `tipo_novedad` varchar(10) NOT NULL,
  `observaciones` longtext NOT NULL,
  `archivo_adjunto` varchar(100) NOT NULL,
  `estado_novedad` tinyint(1) NOT NULL,
  `aprendiz_id` int NOT NULL,
  `asistencia_id` bigint NOT NULL,
  PRIMARY KEY (`id_novedad`),
  KEY `asistencia_novedad_aprendiz_id_628896dd_fk_asistenci` (`aprendiz_id`),
  KEY `asistencia_novedad_asistencia_id_b4c33d52_fk_asistenci` (`asistencia_id`),
  CONSTRAINT `asistencia_novedad_aprendiz_id_628896dd_fk_asistenci` FOREIGN KEY (`aprendiz_id`) REFERENCES `asistencia_aprendiz` (`documento_aprendiz`),
  CONSTRAINT `asistencia_novedad_asistencia_id_b4c33d52_fk_asistenci` FOREIGN KEY (`asistencia_id`) REFERENCES `asistencia_asistencia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_novedad`
--

LOCK TABLES `asistencia_novedad` WRITE;
/*!40000 ALTER TABLE `asistencia_novedad` DISABLE KEYS */;
INSERT INTO `asistencia_novedad` VALUES (2,'Calamidad','aa','pdfs/Logo_full.png',1,333,15),(3,'Calamidad','s','pdfs/English_dot_work_4.pdf',1,999,15);
/*!40000 ALTER TABLE `asistencia_novedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia_programa`
--

DROP TABLE IF EXISTS `asistencia_programa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_programa` (
  `id_programa` int NOT NULL,
  `nombre_programa` varchar(45) NOT NULL,
  `coordinacion_programa_id` int NOT NULL,
  PRIMARY KEY (`id_programa`),
  KEY `asistencia_programa_coordinacion_program_d2db48f6_fk_asistenci` (`coordinacion_programa_id`),
  CONSTRAINT `asistencia_programa_coordinacion_program_d2db48f6_fk_asistenci` FOREIGN KEY (`coordinacion_programa_id`) REFERENCES `asistencia_coordinacion` (`id_coordinacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_programa`
--

LOCK TABLES `asistencia_programa` WRITE;
/*!40000 ALTER TABLE `asistencia_programa` DISABLE KEYS */;
INSERT INTO `asistencia_programa` VALUES (1,'ADSO',1);
/*!40000 ALTER TABLE `asistencia_programa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Token',6,'add_token'),(22,'Can change Token',6,'change_token'),(23,'Can delete Token',6,'delete_token'),(24,'Can view Token',6,'view_token'),(25,'Can add token',7,'add_tokenproxy'),(26,'Can change token',7,'change_tokenproxy'),(27,'Can delete token',7,'delete_tokenproxy'),(28,'Can view token',7,'view_tokenproxy'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add Aprendiz',9,'add_aprendiz'),(34,'Can change Aprendiz',9,'change_aprendiz'),(35,'Can delete Aprendiz',9,'delete_aprendiz'),(36,'Can view Aprendiz',9,'view_aprendiz'),(37,'Can add Asistencia',10,'add_asistencia'),(38,'Can change Asistencia',10,'change_asistencia'),(39,'Can delete Asistencia',10,'delete_asistencia'),(40,'Can view Asistencia',10,'view_asistencia'),(41,'Can add Coordinacion',11,'add_coordinacion'),(42,'Can change Coordinacion',11,'change_coordinacion'),(43,'Can delete Coordinacion',11,'delete_coordinacion'),(44,'Can view Coordinacion',11,'view_coordinacion'),(45,'Can add Ficha',12,'add_ficha'),(46,'Can change Ficha',12,'change_ficha'),(47,'Can delete Ficha',12,'delete_ficha'),(48,'Can view Ficha',12,'view_ficha'),(49,'Can add Horario',13,'add_horario'),(50,'Can change Horario',13,'change_horario'),(51,'Can delete Horario',13,'delete_horario'),(52,'Can view Horario',13,'view_horario'),(53,'Can add Instructor',14,'add_instructor'),(54,'Can change Instructor',14,'change_instructor'),(55,'Can delete Instructor',14,'delete_instructor'),(56,'Can view Instructor',14,'view_instructor'),(57,'Can add Programa',15,'add_programa'),(58,'Can change Programa',15,'change_programa'),(59,'Can delete Programa',15,'delete_programa'),(60,'Can view Programa',15,'view_programa'),(61,'Can add Novedad',16,'add_novedad'),(62,'Can change Novedad',16,'change_novedad'),(63,'Can delete Novedad',16,'delete_novedad'),(64,'Can view Novedad',16,'view_novedad');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_user_document` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`document`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('24b0d768726813b1e9d4e05509fc2ddefbc9ed4d','2023-08-01 01:47:40.892755',222),('382c5b25e655d21cb082ccc5a1002af6903d4534','2023-08-01 06:08:18.179372',555),('e5982e9c4b710064b69c9c79e6594123eaa026e6','2023-08-01 02:58:17.946543',333),('f38f9229ddaab2d1f613d1efd08724bf78b7af40','2023-08-01 06:06:53.254831',444);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_user_document` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_document` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`document`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-08-01 01:47:34.905472','222','INSTRUCTOR',1,'[{\"added\": {}}]',8,111),(2,'2023-08-01 01:47:40.893765','222','24b0d768726813b1e9d4e05509fc2ddefbc9ed4d',1,'[{\"added\": {}}]',7,111),(3,'2023-08-01 01:47:56.334397','222','Instructor Ramos',1,'[{\"added\": {}}]',14,111),(4,'2023-08-01 01:49:09.593499','3','2023-08-01 - DIURNA - 2',1,'[{\"added\": {}}]',13,111),(5,'2023-08-01 02:55:18.857000','1','TELEINFORMATICA',1,'[{\"added\": {}}]',11,111),(6,'2023-08-01 02:55:26.571778','1','ADSO',1,'[{\"added\": {}}]',15,111),(7,'2023-08-01 02:56:16.169468','2222','Instructor Ramos',1,'[{\"added\": {}}]',14,111),(8,'2023-08-01 02:56:25.651506','2222','Instructor Ramos',3,'',14,111),(9,'2023-08-01 02:56:28.521900','222','Instructor Ramos',2,'[]',14,111),(10,'2023-08-01 02:56:43.526068','1','1',1,'[{\"added\": {}}]',12,111),(11,'2023-08-01 02:57:25.432982','333','APRENDIZ',1,'[{\"added\": {}}]',8,111),(12,'2023-08-01 02:57:42.156997','333','Aprendiz sena',1,'[{\"added\": {}}]',9,111),(13,'2023-08-01 02:57:48.442514','1','2023-07-31 - Aprendiz',1,'[{\"added\": {}}]',10,111),(14,'2023-08-01 02:58:12.447129','1','Calamidad 1',1,'[{\"added\": {}}]',16,111),(15,'2023-08-01 02:58:17.948545','333','e5982e9c4b710064b69c9c79e6594123eaa026e6',1,'[{\"added\": {}}]',7,111),(16,'2023-08-01 03:12:20.943289','1','2023-07-31 - Aprendiz',2,'[{\"changed\": {\"fields\": [\"Presente\"]}}]',10,111),(17,'2023-08-01 03:12:33.066915','1','2023-07-31 - Aprendiz',2,'[{\"changed\": {\"fields\": [\"Presente\"]}}]',10,111),(18,'2023-08-01 03:13:18.982533','1','2023-07-31 - Aprendiz',2,'[]',10,111),(19,'2023-08-01 03:37:47.757711','333','Aprendiz sena',2,'[]',9,111),(20,'2023-08-01 04:39:27.446087','333','Aprendiz sena',2,'[]',9,111),(21,'2023-08-01 04:52:14.955146','4','2023-07-31 - Aprendiz',3,'',10,111),(22,'2023-08-01 04:52:14.970168','3','2023-07-31 - Aprendiz',3,'',10,111),(23,'2023-08-01 04:52:14.982199','2','2023-07-31 - Aprendiz',3,'',10,111),(24,'2023-08-01 04:52:14.994170','1','2023-07-31 - Aprendiz',3,'',10,111),(25,'2023-08-01 04:58:51.168138','5','2023-07-31 - Aprendiz',3,'',10,111),(26,'2023-08-01 05:15:37.060013','14','2023-08-01 - Aprendiz',3,'',10,111),(27,'2023-08-01 05:15:37.071067','13','2023-08-01 - Aprendiz',3,'',10,111),(28,'2023-08-01 05:15:37.083430','12','2023-08-01 - Aprendiz',3,'',10,111),(29,'2023-08-01 05:15:37.096750','11','2023-08-01 - Aprendiz',3,'',10,111),(30,'2023-08-01 05:15:37.110353','10','2023-08-01 - Aprendiz',3,'',10,111),(31,'2023-08-01 05:15:37.123390','9','2023-08-01 - Aprendiz',3,'',10,111),(32,'2023-08-01 05:15:37.134963','8','2023-08-01 - Aprendiz',3,'',10,111),(33,'2023-08-01 05:15:37.149202','7','2023-08-01 - Aprendiz',3,'',10,111),(34,'2023-08-01 05:15:37.163402','6','2023-08-01 - Aprendiz',3,'',10,111),(35,'2023-08-01 06:06:44.429047','444','BIENESTAR',1,'[{\"added\": {}}]',8,111),(36,'2023-08-01 06:06:53.257822','444','f38f9229ddaab2d1f613d1efd08724bf78b7af40',1,'[{\"added\": {}}]',7,111),(37,'2023-08-01 06:07:07.360877','15','2023-08-01 - Aprendiz',1,'[{\"added\": {}}]',10,111),(38,'2023-08-01 06:07:24.454269','2','Calamidad 2',1,'[{\"added\": {}}]',16,111),(39,'2023-08-01 06:15:04.720284','999','Aprendiz 2 2',1,'[{\"added\": {}}]',9,111),(40,'2023-08-01 06:29:03.935267','3','Calamidad 3',1,'[{\"added\": {}}]',16,111),(41,'2023-08-01 06:32:43.002496','888','Instructor 2 Ramos',1,'[{\"added\": {}}]',14,111),(42,'2023-08-01 06:43:42.359960','5544','PUT INSTRUCTOR APELLIDOS',3,'',14,111),(43,'2023-08-01 06:43:42.372270','5454','PUT INSTRUCTOR APELLIDOS',3,'',14,111),(44,'2023-08-01 06:43:42.384844','888','Instructor 2 Ramos',3,'',14,111),(45,'2023-08-01 06:47:06.038208','5454','PUT INSTRUCTOR APELLIDOS',3,'',14,111),(46,'2023-08-01 06:53:57.135512','20','2023-08-01 - Aprendiz',3,'',10,111),(47,'2023-08-01 06:53:57.148536','19','2023-08-01 - Aprendiz',3,'',10,111),(48,'2023-08-01 06:53:57.161537','18','2023-08-01 - Aprendiz',3,'',10,111),(49,'2023-08-01 06:53:57.175093','17','2023-08-01 - Aprendiz',3,'',10,111),(50,'2023-08-01 06:53:57.188150','16','2023-08-01 - Aprendiz',3,'',10,111);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(9,'asistencia','aprendiz'),(10,'asistencia','asistencia'),(11,'asistencia','coordinacion'),(12,'asistencia','ficha'),(13,'asistencia','horario'),(14,'asistencia','instructor'),(16,'asistencia','novedad'),(15,'asistencia','programa'),(3,'auth','group'),(2,'auth','permission'),(6,'authtoken','token'),(7,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(8,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-08-01 01:46:35.093649'),(2,'contenttypes','0002_remove_content_type_name','2023-08-01 01:46:35.264390'),(3,'auth','0001_initial','2023-08-01 01:46:35.909896'),(4,'auth','0002_alter_permission_name_max_length','2023-08-01 01:46:36.102894'),(5,'auth','0003_alter_user_email_max_length','2023-08-01 01:46:36.132890'),(6,'auth','0004_alter_user_username_opts','2023-08-01 01:46:36.171892'),(7,'auth','0005_alter_user_last_login_null','2023-08-01 01:46:36.204890'),(8,'auth','0006_require_contenttypes_0002','2023-08-01 01:46:36.224890'),(9,'auth','0007_alter_validators_add_error_messages','2023-08-01 01:46:36.243885'),(10,'auth','0008_alter_user_username_max_length','2023-08-01 01:46:36.262887'),(11,'auth','0009_alter_user_last_name_max_length','2023-08-01 01:46:36.286885'),(12,'auth','0010_alter_group_name_max_length','2023-08-01 01:46:36.337904'),(13,'auth','0011_update_proxy_permissions','2023-08-01 01:46:36.358888'),(14,'auth','0012_alter_user_first_name_max_length','2023-08-01 01:46:36.380393'),(15,'users','0001_initial','2023-08-01 01:46:37.169554'),(16,'admin','0001_initial','2023-08-01 01:46:37.490881'),(17,'admin','0002_logentry_remove_auto_add','2023-08-01 01:46:37.517666'),(18,'admin','0003_logentry_add_action_flag_choices','2023-08-01 01:46:37.545567'),(19,'asistencia','0001_initial','2023-08-01 01:46:38.387071'),(20,'asistencia','0002_initial','2023-08-01 01:46:40.328127'),(21,'authtoken','0001_initial','2023-08-01 01:46:40.513351'),(22,'authtoken','0002_auto_20160226_1747','2023-08-01 01:46:40.575497'),(23,'authtoken','0003_tokenproxy','2023-08-01 01:46:40.588982'),(24,'sessions','0001_initial','2023-08-01 01:46:40.698030'),(25,'asistencia','0003_remove_asistencia_horario_id_and_more','2023-08-01 02:30:59.249810');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('m3lhelwqddv3bh7ug9ch8jqd2v98w5vp','.eJxVjEEOwiAQRe_C2hAKtFCX7nsGMswMUjWQlHZlvLtt0oVu_3vvv0WAbc1ha7yEmcRVdF0nLr9rBHxyORA9oNyrxFrWZY7yUORJm5wq8et2un8HGVreazY0WnCWvEuEvUojG4uokexoBgfsQRlMxmsYotb9LvZaaR4YmTmi-HwBQ-Q5Kg:1qnqNl:PxD5iBk4D9ISim3w5HiZ7NSHOgNsTM2lh1VajD3cDYk','2023-10-18 01:08:57.949887'),('vyak51od5a4n70idsqiwufw653bine8y','.eJxVjEEOwiAQRe_C2hAKtFCX7nsGMswMUjWQlHZlvLtt0oVu_3vvv0WAbc1ha7yEmcRVdF0nLr9rBHxyORA9oNyrxFrWZY7yUORJm5wq8et2un8HGVreazY0WnCWvEuEvUojG4uokexoBgfsQRlMxmsYotb9LvZaaR4YmTmi-HwBQ-Q5Kg:1qQeTl:1sTLrmpZ4YBMaiEry1rmvVpSVu0qomfXMzZ_28P0GGk','2023-08-15 01:47:17.646645');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `document` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_type` varchar(45) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`document`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES ('pbkdf2_sha256$600000$nvwCyvyOzRTg6H4DVpNVXl$rUnbM4lIBdxoKCiLt2hPyaA+vCjZ9bEPY5vj/aXL0IM=','2023-10-04 01:08:57.919887',1,'','','2023-08-01 01:47:05.273729',111,'ADMINISTRADOR','111@111.com','SUPERUSER',1,1),('password',NULL,0,'','','2023-08-01 01:47:21.000000',222,'INSTRUCTOR','222@222.com','INSTRUCTOR',0,1),('password',NULL,0,'','','2023-08-01 02:57:10.000000',333,'APRENDIZ','333@333.com','APRENDIZ',0,1),('password',NULL,0,'','','2023-08-01 06:06:23.000000',444,'BIENESTAR','444@444.com','BIENESTAR',0,1),('pbkdf2_sha256$600000$r2psCgaCSR7eRJHxFQPSzn$Sb911YNcg3Slb1IiN8S+fD/Ew16Jl/ozbBqFXT3q8Qg=',NULL,0,'','','2023-08-01 06:08:09.130572',555,'Prueba2','prueba2@prueba2.com','APRENDIZ',0,1),('pbkdf2_sha256$600000$02G5BH8SB28v5N2PWwyDqw$jfvNPRLFZiRgF3Fo6fvJpdW3Bsv9P6B3xlb2IaQuxio=',NULL,0,'','','2023-08-01 02:57:10.000000',999,'put','put@put.com','INSTRUCTOR',0,1);
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_groups`
--

DROP TABLE IF EXISTS `users_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_document` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`document`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_groups`
--

LOCK TABLES `users_user_groups` WRITE;
/*!40000 ALTER TABLE `users_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_user_permissions`
--

DROP TABLE IF EXISTS `users_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_user_perm_user_id_20aca447_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`document`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_user_permissions`
--

LOCK TABLES `users_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-03 22:47:10
