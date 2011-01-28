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
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `config` (
  `id` int(11) NOT NULL auto_increment,
  `pipeline_status` tinyint(1) default NULL,
  `check_for_observations_time` int(3) default NULL,
  `observation_complete_time` int(3) default NULL,
  `last_updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `daemon_statuses`
--

DROP TABLE IF EXISTS `daemon_statuses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `daemon_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `status` tinyint(1) default NULL,
  `description` varchar(200) default NULL,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `epp_disk_statuses`
--

DROP TABLE IF EXISTS `epp_disk_statuses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `epp_disk_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `env_variable` varchar(20) default NULL,
  `access_path` varchar(50) default NULL,
  `data_format` varchar(50) default NULL,
  `backend_name` varchar(50) default NULL,
  `disk_used` int(11) default NULL,
  `disk_free` int(11) default NULL,
  `disk_capacity` int(11) default NULL,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `files` (
  `id` int(11) NOT NULL auto_increment,
  `filename` varchar(100) default NULL,
  `filepath` varchar(200) default NULL,
  `status` int(3) default NULL,
  `backend` varchar(30) default NULL,
  `filesize` int(4) default NULL,
  `project_id` varchar(5) default NULL,
  `last_updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `source_name` varchar(30) default NULL,
  `file_last_modified` int(10) unsigned default NULL,
  `frontend` varchar(30) default NULL,
  `frequency` decimal(6,2) default NULL,
  `obs_length` decimal(6,2) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `members` (
  `id` int(4) NOT NULL auto_increment,
  `username` varchar(65) NOT NULL default '',
  `password` varchar(65) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pipeline_statuses`
--

DROP TABLE IF EXISTS `pipeline_statuses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pipeline_statuses` (
  `id` int(10) NOT NULL auto_increment,
  `status` tinyint(1) default NULL,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `comment` varchar(200) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pks_disk_statuses`
--

DROP TABLE IF EXISTS `pks_disk_statuses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pks_disk_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `backend_name` varchar(20) default NULL,
  `description` varchar(200) default NULL,
  `disk_used` int(11) default NULL,
  `disk_free` int(11) default NULL,
  `disk_capacity` int(11) default NULL,
  `access_path` varchar(50) default NULL,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(50) default NULL,
  `body` text,
  `created` datetime default NULL,
  `modified` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `transfers` (
  `id` int(11) NOT NULL auto_increment,
  `backend` varchar(30) default NULL,
  `success` tinyint(1) default NULL,
  `time_of_transfer` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-28  1:12:49
