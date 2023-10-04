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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-03 22:54:26
