CREATE DATABASE  IF NOT EXISTS `company` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `company`;
-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: company
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.16.04.1

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
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `Dname` varchar(25) DEFAULT NULL,
  `Dnumber` int(5) NOT NULL,
  `Mgr_ssn` int(9) NOT NULL,
  `Mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  KEY `Mgr_ssn` (`Mgr_ssn`),
  CONSTRAINT `Department_ibfk_1` FOREIGN KEY (`Mgr_ssn`) REFERENCES `Employee` (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES ('Headquarters',1,888665555,'1981-06-19'),('Development',2,123456789,'1996-05-05'),('Testing',3,999887777,'1988-07-01'),('Administration',4,987654321,'1995-01-01'),('Research',5,333445555,'1988-05-22'),('Pubic Relations',6,666884444,'1990-04-03');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dependent`
--

DROP TABLE IF EXISTS `Dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dependent` (
  `Essn` int(9) NOT NULL,
  `Dependent_name` varchar(25) NOT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Bdate` date DEFAULT NULL,
  `Relationship` varchar(10) DEFAULT NULL,
  KEY `Essn` (`Essn`),
  CONSTRAINT `Dependent_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `Employee` (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dependent`
--

LOCK TABLES `Dependent` WRITE;
/*!40000 ALTER TABLE `Dependent` DISABLE KEYS */;
INSERT INTO `Dependent` VALUES (333445555,'Alice','F','1986-04-05','Daughter'),(333445555,'Theodore','M','1983-10-25','Son'),(333445555,'Joy','F','1958-05-03','Spouse'),(987654321,'Abnar','M','1942-02-28','Spouse'),(123456789,'Michael','M','1988-01-04','Son'),(123456789,'Alice','F','1988-12-30','Daughter');
/*!40000 ALTER TABLE `Dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dept_locations`
--

DROP TABLE IF EXISTS `Dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dept_locations` (
  `DNumber` int(5) NOT NULL,
  `DLocation` varchar(25) NOT NULL,
  KEY `DNumber` (`DNumber`),
  CONSTRAINT `Dept_locations_ibfk_1` FOREIGN KEY (`DNumber`) REFERENCES `Department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dept_locations`
--

LOCK TABLES `Dept_locations` WRITE;
/*!40000 ALTER TABLE `Dept_locations` DISABLE KEYS */;
INSERT INTO `Dept_locations` VALUES (1,'Houston'),(4,'Stafford'),(5,'Bellaire'),(5,'Sugarland'),(5,'Houston'),(2,'Dallas'),(3,'Humble'),(6,'Rice');
/*!40000 ALTER TABLE `Dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employee` (
  `Fname` varchar(25) DEFAULT NULL,
  `Minit` varchar(1) DEFAULT NULL,
  `Lname` varchar(25) DEFAULT NULL,
  `Ssn` int(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Salary` int(5) DEFAULT NULL,
  `Super_ssn` int(9) DEFAULT NULL,
  `Dno` int(5) DEFAULT NULL,
  PRIMARY KEY (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES ('John','B','Smith',123456789,'1965-01-09','731 Fondren, Houston, TX','M',30000,333445555,5),('Franklin','T','Wong',333445555,'1955-12-08','638 Voss, Houston, TX','M',40000,888665555,5),('Joyce','A','English',453453453,'1972-07-31','5631 Rice, Houston, TX','F',25000,333445555,5),('Ramesh','K','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble, TX','M',38000,333445555,5),('James','E','Borg',888665555,'1937-11-10','450 Stone, Houston, TX','M',55000,NULL,1),('Jennifer','S','Wallace',987654321,'1941-06-20','291 Borry, Bellaire, TX','F',43000,888665555,4),('Alicia','J','Zelaya',999887777,'1968-01-19','3321 Castle, Spring, TX','M',25000,987654321,4);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Project`
--

DROP TABLE IF EXISTS `Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project` (
  `Pname` varchar(25) DEFAULT NULL,
  `Pnumber` int(5) NOT NULL,
  `Plocation` varchar(25) DEFAULT NULL,
  `Dnum` int(5) DEFAULT NULL,
  PRIMARY KEY (`Pnumber`),
  KEY `Dnum` (`Dnum`),
  CONSTRAINT `Project_ibfk_1` FOREIGN KEY (`Dnum`) REFERENCES `Department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Project`
--

LOCK TABLES `Project` WRITE;
/*!40000 ALTER TABLE `Project` DISABLE KEYS */;
INSERT INTO `Project` VALUES ('ProductX',1,'Bellaire',5),('ProductY',2,'Sugarland',5),('ProductZ',3,'Houston',5),('Computerization',10,'Stafford',4),('Reorganization',20,'Houston',1),('Newbenefits',30,'Stafford',4);
/*!40000 ALTER TABLE `Project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Works_on`
--

DROP TABLE IF EXISTS `Works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Works_on` (
  `Essn` int(9) NOT NULL,
  `Pno` int(5) NOT NULL,
  `Hours` decimal(3,1) DEFAULT NULL,
  KEY `Essn` (`Essn`),
  KEY `Pno` (`Pno`),
  CONSTRAINT `Works_on_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `Employee` (`Ssn`),
  CONSTRAINT `Works_on_ibfk_2` FOREIGN KEY (`Pno`) REFERENCES `Project` (`Pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Works_on`
--

LOCK TABLES `Works_on` WRITE;
/*!40000 ALTER TABLE `Works_on` DISABLE KEYS */;
INSERT INTO `Works_on` VALUES (123456789,1,32.5),(123456789,2,7.5),(666884444,3,40.0),(453453453,1,20.0),(453453453,2,20.0),(333445555,2,10.0);
/*!40000 ALTER TABLE `Works_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-27 14:43:08
