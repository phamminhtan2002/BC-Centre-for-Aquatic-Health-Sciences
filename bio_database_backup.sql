-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: bio_database
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `bio_database`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bio_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bio_database`;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `site_name` varchar(45) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sample_data`
--

DROP TABLE IF EXISTS `sample_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample_data` (
  `name` varchar(45) NOT NULL,
  `taxonomy_id` int NOT NULL,
  `taxonomy_lvl` varchar(2) NOT NULL,
  `kraken_assigned_reads` int DEFAULT NULL,
  `added_reads` int DEFAULT NULL,
  `new_est_reads` int DEFAULT NULL,
  `fraction_total_reads` float DEFAULT NULL,
  `Sample ID` varchar(45) NOT NULL,
  PRIMARY KEY (`taxonomy_id`,`Sample ID`),
  KEY `sample_info_Sample_ID_idx` (`Sample ID`),
  CONSTRAINT `sample_info_Sample_ID_idx` FOREIGN KEY (`Sample ID`) REFERENCES `sample_info` (`Sample ID`),
  CONSTRAINT `species_taxonomy_ID` FOREIGN KEY (`taxonomy_id`) REFERENCES `species` (`taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_data`
--

LOCK TABLES `sample_data` WRITE;
/*!40000 ALTER TABLE `sample_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `sample_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `species_exist` BEFORE INSERT ON `sample_data` FOR EACH ROW INSERT IGNORE INTO `bio_database`.`species` (`taxonomy_id`, `name`, `taxonomy_lvl`) VALUES (new.`taxonomy_id`, new.`name`, new.`taxonomy_lvl`) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `sample_data_view`
--

DROP TABLE IF EXISTS `sample_data_view`;
/*!50001 DROP VIEW IF EXISTS `sample_data_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sample_data_view` AS SELECT 
 1 AS `Sample ID`,
 1 AS `Date Collected`,
 1 AS `Location`,
 1 AS `CAHS Submission Number`,
 1 AS `Water Temperature (c)`,
 1 AS `Oxygen (mg/L)`,
 1 AS `Saturation (%)`,
 1 AS `Sample Type`,
 1 AS `Sample location`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sample_info`
--

DROP TABLE IF EXISTS `sample_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample_info` (
  `Sample ID` varchar(45) NOT NULL,
  `CAHS Submission Number` varchar(45) NOT NULL,
  `Sample Type` varchar(45) NOT NULL,
  `Sample location` varchar(45) NOT NULL,
  `Fish Weight (g)` float DEFAULT NULL,
  `Fish Length (mm)` float DEFAULT NULL,
  `Material Swabbed for Biofilm` varchar(200) DEFAULT NULL,
  `Date Filtered` datetime DEFAULT NULL,
  `Volume Filtered (mL)` float DEFAULT NULL,
  `Time to Filter (h:mm:ss)` time DEFAULT NULL,
  PRIMARY KEY (`Sample ID`),
  KEY `submission_data_id_idx` (`CAHS Submission Number`),
  CONSTRAINT `submission_data_CAHS Submmission Number` FOREIGN KEY (`CAHS Submission Number`) REFERENCES `submission_data` (`CAHS Submission Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_info`
--

LOCK TABLES `sample_info` WRITE;
/*!40000 ALTER TABLE `sample_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `sample_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `species` (
  `taxonomy_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `taxonomy_lvl` varchar(2) NOT NULL,
  PRIMARY KEY (`taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species`
--

LOCK TABLES `species` WRITE;
/*!40000 ALTER TABLE `species` DISABLE KEYS */;
/*!40000 ALTER TABLE `species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_data`
--

DROP TABLE IF EXISTS `submission_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_data` (
  `CAHS Submission Number` varchar(45) NOT NULL,
  `Samplers` varchar(150) DEFAULT NULL,
  `Water Temperature (c)` float DEFAULT NULL,
  `Oxygen (mg/L)` float DEFAULT NULL,
  `Saturation (%)` float DEFAULT NULL,
  `# Fish Swabs` float NOT NULL,
  `# Biofilm Swabs` float NOT NULL,
  `# Water Samples Collected` float NOT NULL,
  `Vol Water collected (mL)` float NOT NULL,
  `location_id` int NOT NULL,
  `Date Collected` datetime NOT NULL,
  PRIMARY KEY (`CAHS Submission Number`),
  KEY `location_location_id_idx` (`location_id`),
  CONSTRAINT `location_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_data`
--

LOCK TABLES `submission_data` WRITE;
/*!40000 ALTER TABLE `submission_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `bio_database`
--

USE `bio_database`;

--
-- Final view structure for view `sample_data_view`
--

/*!50001 DROP VIEW IF EXISTS `sample_data_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sample_data_view` AS select `sample_info`.`Sample ID` AS `Sample ID`,`submission_data`.`Date Collected` AS `Date Collected`,`location`.`site_name` AS `Location`,`sample_info`.`CAHS Submission Number` AS `CAHS Submission Number`,`submission_data`.`Water Temperature (c)` AS `Water Temperature (c)`,`submission_data`.`Oxygen (mg/L)` AS `Oxygen (mg/L)`,`submission_data`.`Saturation (%)` AS `Saturation (%)`,`sample_info`.`Sample Type` AS `Sample Type`,`sample_info`.`Sample location` AS `Sample location` from ((`sample_info` join `submission_data` on((`sample_info`.`CAHS Submission Number` = `submission_data`.`CAHS Submission Number`))) join `location` on((`submission_data`.`location_id` = `location`.`location_id`))) order by `submission_data`.`Date Collected` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-07 18:15:50
