-- MySQL dump 10.16  Distrib 10.1.23-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: base
-- ------------------------------------------------------
-- Server version	10.1.23-MariaDB

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
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogs` (
  `id_catalog` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id_catalog`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `name2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Материнские платы'),(3,'Видеоадаптеры'),(5,'Оперативная память'),(10,'Жёсткие диски');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL DEFAULT '0',
  `ordertime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `number` int(11) NOT NULL DEFAULT '0',
  `id_product` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_order`),
  KEY `id_product` (`id_product`),
  KEY `id_user` (`id_user`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,3,'2005-01-04 10:39:38',1,8),(2,6,'2005-02-10 09:40:29',2,10),(3,1,'2005-02-18 13:41:05',4,20),(4,3,'2005-03-10 18:20:00',1,20),(5,3,'2005-03-17 19:15:36',1,20);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `price` decimal(7,2) DEFAULT '0.00',
  `count` int(11) DEFAULT '0',
  `mark` float(4,1) NOT NULL DEFAULT '0.0',
  `description` mediumtext,
  `id_catalog` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_product`),
  KEY `id_catalog` (`id_catalog`),
  FULLTEXT KEY `search` (`name`,`description`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_catalog`) REFERENCES `catalogs` (`id_catalog`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Celeron 1.8',1595.00,10,3.6,'Процессор Celeron® 1.8GHz, 128kb, 478-PGA, 400Mhz, OEM 0.18',1),(2,'Celeron 2.0GHz',1969.00,2,3.7,'Процессор Celeron® 2.0GHz, 128KB, 478-PGA, 400MHz, OEM ',1),(3,'Celeron 2.4GHz',2109.00,4,3.9,'Процессор Celeron® 2.4GHz, 128kb, 478-PGA, 400Mhz, OEM ',1),(4,'Celeron D 320 2.4GHz',1962.00,1,4.1,'Процессор Celeron® D 320 2.4GHz, 256kb, 478-PGA, 533Mhz, OEM',1),(5,'Celeron D 325 2.53GHz',2747.00,6,4.1,'Процессор Celeron® D 325 2.53GHz, 256kb, 478-PGA, 533Mhz, OEM ',1),(6,'Celeron D 315 2.26GHz',1880.00,6,4.1,'Процессор Celeron® D 315 2.26GHz, 256kb, 478-PGA, 533Mhz, OEM ',1),(7,'Intel Pentium 4 3.2GHz',7259.00,5,4.5,'Процессор Intel® Pentium®4 3.2GHz, 1Mb, 478-PGA, 800Mhz, Hyper-Threading, OEM ',1),(8,'Intel Pentium 4 3.0GHz',6147.00,1,4.6,'Процессор Intel® Pentium®4 3.0GHz, 512Kb, 478-PGA, 800Mhz, Hyper-Threading, OEM ',1),(9,'Intel Pentium 4 3.0GHz',5673.00,12,4.5,'Процессор Intel® Pentium®4 3.0GHz, 1Mb, 478-PGA, 800Mhz, Hyper-Treading, OEM ',1),(10,'Gigabyte GA-8I848P-RS',1896.00,4,3.9,'Материнская плата SOCKET-478 Gigabyte GA-8I848P-RS i848, (800Mhz), DDR, AGP 8x, ATA100, SATA , Sound 6ch, USB2.0, ATX',2),(11,'Gigabyte GA-8IG1000',2420.00,2,3.8,'Материнская плата SOCKET-478 Gigabyte GA-8IG1000 i865g,FSB800/533/400,2chDDR400/333/266(4слота),Video,AGP,5PCI,ATA-100,S-ATA',2),(12,'Gigabyte GA-8IPE1000G',2289.00,6,3.7,'Материнская плата Socket-478 Gigabyte GA-8IPE1000G i865PE(800/533/400Mhz),2ch400/333/266DDR,PCI/AGP,U-100,AC`97,Lan(1Gb),S-ATA,USB 2.0, ATX',2),(13,'Asustek P4C800-E Delux',5395.00,4,4.1,'Материнская плата Socket-478 Asustek P4C800-E Delux i875P,FSB800/533Mhz,2chDDR400/333,AGP,6PCI,iEEE1394, Raid, U-133,S-ATA, AC`97, Lan(1000), ATX',2),(14,'Asustek P4P800-VM\\L i865G',2518.00,6,4.0,'Материнская плата Socket-478 Asustek P4P800-VM\\L i865G FSB800/533/400, 2chDDR400/333/266(4слота),AGP,video,3PCI,ATA-100,S-ATA,lan ,M-ATX',2),(15,'Epox EP-4PDA3I',2289.00,5,4.0,'Материнская плата Socket-478 Epox EP-4PDA3I i865PE(800Mhz), 2chDDR, PCI/AGP, SATA, Lan, U-100, RAID, AC`97, LAN, ATX',2),(16,'ASUSTEK A9600XT/TD',5156.00,2,4.7,'Видеоадаптер ASUSTEK A9600XT/TD 128Mb DDR SDRAM, 2x400MHz DAC, AGP8x, ATI Radeon 9600XT, DVI, TV- out, BOX ',3),(17,'ASUSTEK V9520X',1602.00,6,4.0,'Видеоадаптер ASUSTEK V9520X 128Mb DDR SDRAM, 400MHz DAC, AGP 8x, GeForce FX 5200, TV- out, BOX ',3),(18,'SAPPHIRE 256MB RADEON 9550',2730.00,3,3.8,'ВИДЕОКАРТА SAPPHIRE 256MB RADEON 9550, TV-out, DVI, OEM ',3),(19,'GIGABYTE AGP GV-N59X128D',5886.00,6,3.6,'ВИДЕОКАРТА GIGABYTE AGP GV-N59X128D FX5900XT OEM ',3),(20,'Maxtor 6Y120P0',2456.00,6,4.5,'Винчестер 120 GB Maxtor 6Y120P0, UDMA-133, 7200rpm, 8MB ',10),(21,'Maxtor 6B200P0',3589.00,4,4.0,'Винчестер 200 GB Maxtor 6B200P0, UDMA-133, 7200rpm, 8Mb ',10),(22,'Samsung SP0812C',2093.00,5,4.0,'Винчестер 80 GB Samsung SP0812C, SATA, 7200rpm SpinPoint P80 SerialATA Буферная кэш-память 8 MB  7200об/мин  Интерфейс Serial ATA 1.0',10),(23,'Seagate Barracuda ST3160023A',3139.00,3,4.1,'Винчестер 160 GB Seagate Barracuda ST3160023A, UDMA-100, 7200rpm, 8Mb ',10),(24,'Seagate ST3120026A',2468.00,8,4.2,'Винчестер 120 GB Seagate ST3120026A, UDMA-100, 7200rpm, 8MB ',10),(25,'DDR-400 256MB Kingston',1085.00,20,4.8,'Оперативная память DDR-400 256MB Kingston ',5),(26,'DDR-400 256MB Hynix Original ',1179.00,15,4.6,'Оперативная память DDR-400 256MB Hynix Original ',5),(27,'DDR-400 256MB PQI',899.00,10,4.2,'Оперативная память DDR-400 256MB PQI ',5),(28,'DDR-400 512MB Kingston',1932.00,20,4.8,'Оперативная память DDR-400 512MB Kingston ',5),(29,'DDR-400 512MB PQI',1690.00,12,4.2,'Оперативная память DDR-400 512MB PQI ',5),(30,'DDR-400 512MB Hynix',1717.00,8,4.5,'Оперативная память DDR-400 512MB Hynix ',5);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products2`
--

DROP TABLE IF EXISTS `products2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products2` (
  `id_product` int(11) NOT NULL DEFAULT '0',
  `name` text CHARACTER SET utf8 NOT NULL,
  `price` decimal(7,2) DEFAULT '0.00',
  `count` int(11) DEFAULT '0',
  `mark` float(4,1) NOT NULL DEFAULT '0.0',
  `id_catalog` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products2`
--

LOCK TABLES `products2` WRITE;
/*!40000 ALTER TABLE `products2` DISABLE KEYS */;
INSERT INTO `products2` VALUES (1,'Celeron 1.8',1595.00,10,3.6,1),(2,'Celeron 2.0GHz',1969.00,2,3.7,1),(3,'Celeron 2.4GHz',2109.00,4,3.9,1),(4,'Celeron D 320 2.4GHz',1962.00,1,4.1,1),(5,'Celeron D 325 2.53GHz',2747.00,6,4.1,1),(6,'Celeron D 315 2.26GHz',1880.00,6,4.1,1),(7,'Intel Pentium 4 3.2GHz',7259.00,5,4.5,1),(8,'Intel Pentium 4 3.0GHz',6147.00,1,4.6,1),(9,'Intel Pentium 4 3.0GHz',5673.00,12,4.5,1),(10,'Gigabyte GA-8I848P-RS',1896.00,4,3.9,2),(11,'Gigabyte GA-8IG1000',2420.00,2,3.8,2),(12,'Gigabyte GA-8IPE1000G',2289.00,6,3.7,2),(13,'Asustek P4C800-E Delux',5395.00,4,4.1,2),(14,'Asustek P4P800-VM\\L i865G',2518.00,6,4.0,2),(15,'Epox EP-4PDA3I',2289.00,5,4.0,2),(16,'ASUSTEK A9600XT/TD',5156.00,2,4.7,3),(17,'ASUSTEK V9520X',1602.00,6,4.0,3),(18,'SAPPHIRE 256MB RADEON 9550',2730.00,3,3.8,3),(19,'GIGABYTE AGP GV-N59X128D',5886.00,6,3.6,3),(20,'Maxtor 6Y120P0',2456.00,6,4.5,4),(21,'Maxtor 6B200P0',3589.00,4,4.0,4),(22,'Samsung SP0812C',2093.00,5,4.0,4),(23,'Seagate Barracuda ST3160023A',3139.00,3,4.1,4),(24,'Seagate ST3120026A',2468.00,8,4.2,4),(25,'DDR-400 256MB Kingston',1085.00,20,4.8,5),(26,'DDR-400 256MB Hynix Original ',1179.00,15,4.6,5),(27,'DDR-400 256MB PQI',899.00,10,4.2,5),(28,'DDR-400 512MB Kingston',1932.00,20,4.8,5),(29,'DDR-400 512MB PQI',1690.00,12,4.2,5),(30,'DDR-400 512MB Hynix',1717.00,8,4.5,5);
/*!40000 ALTER TABLE `products2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `surname` tinytext,
  `patronymic` tinytext,
  `name` tinytext,
  `phone` varchar(12) DEFAULT NULL,
  `email` tinytext,
  `url` tinytext,
  `status` enum('active','passive','lock','gold') DEFAULT 'active',
  PRIMARY KEY (`id_user`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Иванов','Валерьевич','Александр','58-98-78','ivanov@email.ru',NULL,'active'),(2,'Лосев','Иванович','Сергей','9057777777','losev@email.ru',NULL,'passive'),(3,'Симдянов','Вячеславович','Игорь','9056666100','simdyanov@softtime.ru','http://www.softtime.ru/','active'),(4,'Кузнецов','Валерьевич','Максим',NULL,'kuznetsov@softtime.ru','http://www.softtime.ru','active'),(5,'Нехорошев','Юрьевич','Анатолий',NULL,NULL,NULL,'lock'),(6,'Корнеев','Александрович','Александр','89-78-36','korneev@domen.ru',NULL,'gold');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-16  1:12:08
