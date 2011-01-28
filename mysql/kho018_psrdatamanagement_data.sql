-- MySQL dump 10.11
--
-- Host: localhost    Database: kho018_psrdatamanagement
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny5-log

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
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,1,5,5,'2011-01-17 06:01:33');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `daemon_statuses`
--

LOCK TABLES `daemon_statuses` WRITE;
/*!40000 ALTER TABLE `daemon_statuses` DISABLE KEYS */;
INSERT INTO `daemon_statuses` VALUES (2,'Parkes-Epping network link',1,'The status of the network link between Parkes and Epping.','2011-01-18 01:14:36'),(3,'DFB3 daemon (at Parkes)',1,'The status of the DFB3 daemon at Parkes.','2011-01-18 01:15:44'),(4,'DFB4 daemon (at Parkes)',1,'The status of the DFB4 daemon at Parkes.','2011-01-19 00:58:35'),(5,'AFB daemon (at Parkes)',1,'The status of the AFB daemon at Parkes.','2011-01-19 00:58:58');
/*!40000 ALTER TABLE `daemon_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `epp_disk_statuses`
--

LOCK TABLES `epp_disk_statuses` WRITE;
/*!40000 ALTER TABLE `epp_disk_statuses` DISABLE KEYS */;
INSERT INTO `epp_disk_statuses` VALUES (1,'$DFB1','/pulsar/archive06/DFB','PSRFITS: Fold Mode','PDFB*',484,606,1100,'2011-01-20 02:30:03'),(2,'$DFB2','/pulsar/archive12/DFB','PSRFITS: Fold Mode','PDFB*',1400,3,1400,'2011-01-20 02:39:26'),(3,'$DFB3','/pulsar/archive14/DFB','PSRFITS: Fold Mode','PDFB*',1200,180,1400,'2011-01-20 02:31:56'),(4,'$DFB4','/pulsar/archive18/DFB','PSRFITS: Fold Mode','PDFB*',3400,638,4100,'2011-01-20 02:39:49'),(5,'$DFB5','/pulsar/archive19/DFB','PSRFITS: Fold Mode','PDFB*',8700,4100,13000,'2011-01-20 02:39:54'),(6,'$APSR1','/pulsar/archive19/APSR','APSR - timer???','APSR',3400,8100,13000,'2011-01-20 02:54:23'),(7,'$AFB1','/pulsar/archive21/AFB','PSRFITS: Search Mode','AFB',1100,12000,13000,'2011-01-20 02:55:59'),(8,'$DFBSRCH1','/pulsar/archive21/DFBSRCH1','PSRFITS: Search Mode','PDFB*',1100,12000,13000,'2011-01-27 05:31:21');
/*!40000 ALTER TABLE `epp_disk_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'admin','admin');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pipeline_statuses`
--

LOCK TABLES `pipeline_statuses` WRITE;
/*!40000 ALTER TABLE `pipeline_statuses` DISABLE KEYS */;
INSERT INTO `pipeline_statuses` VALUES (1,1,'2011-01-25 00:16:46','Initial update from creation.');
/*!40000 ALTER TABLE `pipeline_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pks_disk_statuses`
--

LOCK TABLES `pks_disk_statuses` WRITE;
/*!40000 ALTER TABLE `pks_disk_statuses` DISABLE KEYS */;
INSERT INTO `pks_disk_statuses` VALUES (1,'DFB3',NULL,156,106,276,'/nfs/PKCCC3_1','2011-01-19 05:46:31'),(2,'DFB4',NULL,145,117,276,'/nfs/PKCCC4_1','2011-01-19 05:47:08');
/*!40000 ALTER TABLE `pks_disk_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'The title','This is the post body.','2011-01-17 12:06:48',NULL),(2,'A title once again','And the post body follows.','2011-01-17 12:06:48',NULL),(3,'Title strikes back','This is really exciting! Not.','2011-01-17 12:06:50',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transfers`
--

LOCK TABLES `transfers` WRITE;
/*!40000 ALTER TABLE `transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-28  1:12:49
