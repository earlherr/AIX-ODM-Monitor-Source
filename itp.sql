-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.67-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema itp
--

CREATE DATABASE IF NOT EXISTS itp;
USE itp;

--
-- Definition of table `asset`
--

DROP TABLE IF EXISTS `asset`;
CREATE TABLE `asset` (
  `asset_id` int(11) unsigned NOT NULL auto_increment,
  `asset_name` varchar(128) NOT NULL default '',
  `asset_description` longtext,
  `project_id` int(11) unsigned NOT NULL,
  `asset_cost` double NOT NULL default '0',
  PRIMARY KEY  (`asset_id`),
  KEY `FK_asset_1` (`project_id`),
  CONSTRAINT `FK_asset_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `asset`
--

/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;


--
-- Definition of table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_id` int(11) unsigned NOT NULL auto_increment,
  `company_name` varchar(128) NOT NULL,
  `company_description` longtext,
  `email` varchar(64) default NULL,
  `phone_number` varchar(64) default NULL,
  PRIMARY KEY  (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

/*!40000 ALTER TABLE `company` DISABLE KEYS */;
/*!40000 ALTER TABLE `company` ENABLE KEYS */;


--
-- Definition of table `component`
--

DROP TABLE IF EXISTS `component`;
CREATE TABLE `component` (
  `component_id` int(11) unsigned NOT NULL auto_increment,
  `component_name` varchar(128) default NULL,
  `component_description` longtext,
  `component_lead_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`component_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `component`
--

/*!40000 ALTER TABLE `component` DISABLE KEYS */;
/*!40000 ALTER TABLE `component` ENABLE KEYS */;


--
-- Definition of table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `configuration_key` varchar(128) NOT NULL,
  `configuration_value` varchar(128) default NULL,
  `configuration_description` longtext,
  `configuration_category_id` int(11) NOT NULL,
  PRIMARY KEY  (`configuration_key`),
  UNIQUE KEY `configuration_key` (`configuration_key`),
  KEY `configuration_category_id` (`configuration_category_id`),
  CONSTRAINT `configuration_fk` FOREIGN KEY (`configuration_category_id`) REFERENCES `configuration_category` (`configuration_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `configuration`
--

/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;


--
-- Definition of table `configuration_category`
--

DROP TABLE IF EXISTS `configuration_category`;
CREATE TABLE `configuration_category` (
  `configuration_category_id` int(11) NOT NULL auto_increment,
  `configuration_category_definition` longtext,
  PRIMARY KEY  (`configuration_category_id`),
  UNIQUE KEY `configuration_category_id` (`configuration_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `configuration_category`
--

/*!40000 ALTER TABLE `configuration_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuration_category` ENABLE KEYS */;


--
-- Definition of table `note`
--

DROP TABLE IF EXISTS `note`;
CREATE TABLE `note` (
  `note_id` int(11) unsigned NOT NULL auto_increment,
  `note_summary` varchar(128) default NULL,
  `project_id` int(11) unsigned NOT NULL,
  `component_id` int(11) unsigned NOT NULL,
  `priority_id` int(11) unsigned NOT NULL,
  `due_date` date NOT NULL default '2010-01-01',
  `assignee` varchar(32) NOT NULL,
  `environment` longtext,
  `note_description` longtext NOT NULL,
  `estimated_hours` varchar(45) NOT NULL,
  PRIMARY KEY  (`note_id`),
  KEY `FK_note_1` (`project_id`),
  KEY `FK_note_2` (`component_id`),
  KEY `FK_note_3` (`priority_id`),
  KEY `FK_note_4` (`assignee`),
  CONSTRAINT `FK_note_4` FOREIGN KEY (`assignee`) REFERENCES `user` (`username`),
  CONSTRAINT `FK_note_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`),
  CONSTRAINT `FK_note_2` FOREIGN KEY (`component_id`) REFERENCES `component` (`component_id`),
  CONSTRAINT `FK_note_3` FOREIGN KEY (`priority_id`) REFERENCES `priority` (`priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `note`
--

/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;


--
-- Definition of table `note_type`
--

DROP TABLE IF EXISTS `note_type`;
CREATE TABLE `note_type` (
  `note_type_id` int(11) unsigned NOT NULL auto_increment,
  `note_type_name` varchar(128) default NULL,
  `note_type_description` longtext,
  PRIMARY KEY  (`note_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `note_type`
--

/*!40000 ALTER TABLE `note_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `note_type` ENABLE KEYS */;


--
-- Definition of table `participant`
--

DROP TABLE IF EXISTS `participant`;
CREATE TABLE `participant` (
  `participant_id` int(11) unsigned NOT NULL,
  `username` varchar(32) NOT NULL,
  `project_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`participant_id`),
  KEY `FK_participant_1` (`project_id`),
  KEY `FK_participant_2` (`username`),
  CONSTRAINT `FK_participant_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `FK_participant_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participant`
--

/*!40000 ALTER TABLE `participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `participant` ENABLE KEYS */;


--
-- Definition of table `priority`
--

DROP TABLE IF EXISTS `priority`;
CREATE TABLE `priority` (
  `priority_id` int(11) unsigned NOT NULL auto_increment,
  `priority_name` varchar(128) default NULL,
  `priority_description` longtext NOT NULL,
  PRIMARY KEY  (`priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `priority`
--

/*!40000 ALTER TABLE `priority` DISABLE KEYS */;
/*!40000 ALTER TABLE `priority` ENABLE KEYS */;


--
-- Definition of table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `project_id` int(11) unsigned NOT NULL auto_increment,
  `project_name` varchar(128) default NULL,
  `project_description` longtext,
  `project_lead_id` varchar(32) NOT NULL,
  `status_id` int(11) unsigned NOT NULL,
  `priority_id` int(11) unsigned NOT NULL,
  `start_date` date NOT NULL default '2010-01-01',
  `end_date` date NOT NULL default '2010-01-01',
  `company_id` int(11) unsigned NOT NULL,
  `estimated_hours` int(11) unsigned NOT NULL,
  `budget` double default '0',
  `current_cost` double default '0',
  `asset_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`project_id`),
  KEY `FK_project_1` (`project_lead_id`),
  KEY `FK_project_2` (`status_id`),
  KEY `FK_project_3` (`company_id`),
  CONSTRAINT `FK_project_3` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`),
  CONSTRAINT `FK_project_1` FOREIGN KEY (`project_lead_id`) REFERENCES `user` (`username`),
  CONSTRAINT `FK_project_2` FOREIGN KEY (`status_id`) REFERENCES `project_status` (`project_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


--
-- Definition of table `project_status`
--

DROP TABLE IF EXISTS `project_status`;
CREATE TABLE `project_status` (
  `project_status_id` int(11) unsigned NOT NULL auto_increment,
  `project_status_name` varchar(128) default NULL,
  `project_status_description` longtext,
  PRIMARY KEY  (`project_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_status`
--

/*!40000 ALTER TABLE `project_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_status` ENABLE KEYS */;


--
-- Definition of table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) unsigned NOT NULL auto_increment,
  `role_name` varchar(128) default NULL,
  `role_description` longtext,
  PRIMARY KEY  (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


--
-- Definition of table `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `session_id` int(11) unsigned NOT NULL auto_increment,
  `session_start_time` datetime NOT NULL default '2010-01-01 00:00:00',
  `session_end_time` datetime NOT NULL default '2010-01-01 00:00:00',
  `login_success` tinyint(1) unsigned default '0',
  `session_status` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `session`
--

/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;


--
-- Definition of table `session_status`
--

DROP TABLE IF EXISTS `session_status`;
CREATE TABLE `session_status` (
  `session_status_id` int(11) unsigned NOT NULL auto_increment,
  `session_status_name` varchar(128) NOT NULL,
  `session_status_description` longtext NOT NULL,
  PRIMARY KEY  (`session_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `session_status`
--

/*!40000 ALTER TABLE `session_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_status` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `first_name` varchar(64) default NULL,
  `middle_name` varchar(64) default NULL,
  `last_name` varchar(64) default NULL,
  `email` varchar(64) default NULL,
  `phone_number` varchar(16) default NULL,
  `mobile_number` varchar(16) default NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`username`),
  KEY `FK_user_1` (`role_id`),
  CONSTRAINT `FK_user_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Definition of table `version`
--

DROP TABLE IF EXISTS `version`;
CREATE TABLE `version` (
  `version_id` int(11) unsigned NOT NULL auto_increment,
  `version_name` varchar(128) default NULL,
  `version_description` longtext,
  `version_schedule` varchar(64) default NULL,
  `project_id` int(11) unsigned NOT NULL,
  `release_date` date NOT NULL default '2010-01-01',
  PRIMARY KEY  (`version_id`),
  KEY `FK_version_1` (`project_id`),
  CONSTRAINT `FK_version_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `version`
--

/*!40000 ALTER TABLE `version` DISABLE KEYS */;
/*!40000 ALTER TABLE `version` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
