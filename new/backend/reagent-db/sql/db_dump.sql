mysqldump: [Warning] Using a password on the command line interface can be insecure.
-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: localhost    Database: reagentdb
-- ------------------------------------------------------
-- Server version	5.7.32

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
mysqldump: Error: 'Access denied; you need (at least one of) the PROCESS privilege(s) for this operation' when trying to dump tablespaces

--
-- Table structure for table `reagent_admin`
--

DROP TABLE IF EXISTS `reagent_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_admin` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `username` varchar(64) DEFAULT NULL,
                                 `password` varchar(64) DEFAULT NULL,
                                 `icon` varchar(500) DEFAULT NULL COMMENT '头像',
                                 `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
                                 `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
                                 `note` varchar(500) DEFAULT NULL COMMENT '备注信息',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
                                 `status` int(1) DEFAULT '1' COMMENT '帐号启用状态：0->禁用；1->启用',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_admin`
--

LOCK TABLES `reagent_admin` WRITE;
/*!40000 ALTER TABLE `reagent_admin` DISABLE KEYS */;
INSERT INTO `reagent_admin` VALUES (8,'test11111','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','','test@qq.com','测试账号','111111','2018-09-29 13:55:30','2018-09-29 13:55:39',1),(9,'admin','$2a$10$oPur9/vFF0u/SzpVQ1KUNeKf5vfUHee44xvYziwoM1VPh6l7FX4MC','','admin@163.com','系统管理员','系统管理员','2018-10-08 13:32:47','2019-04-20 12:45:16',1),(10,'macro','$2a$10$Bx4jZPR7GhEpIQfefDQtVeS58GfT5n6mxs/b4nLLK65eMFa16topa','string','macro@qq.com','macro','macro专用','2019-10-06 15:53:51','2020-02-03 14:55:55',1);
/*!40000 ALTER TABLE `reagent_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_admin_login_log`
--

DROP TABLE IF EXISTS `reagent_admin_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_admin_login_log` (
                                           `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                           `admin_id` bigint(20) DEFAULT NULL,
                                           `create_time` datetime DEFAULT NULL,
                                           `ip` varchar(64) DEFAULT NULL,
                                           `address` varchar(100) DEFAULT NULL,
                                           `user_agent` varchar(100) DEFAULT NULL COMMENT '浏览器登录类型',
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户登录日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_admin_login_log`
--

LOCK TABLES `reagent_admin_login_log` WRITE;
/*!40000 ALTER TABLE `reagent_admin_login_log` DISABLE KEYS */;
INSERT INTO `reagent_admin_login_log` VALUES (237,3,'2018-12-23 14:27:00','0:0:0:0:0:0:0:1',NULL,NULL),(238,3,'2019-04-07 16:04:39','0:0:0:0:0:0:0:1',NULL,NULL),(239,3,'2019-04-08 21:47:52','0:0:0:0:0:0:0:1',NULL,NULL),(240,3,'2019-04-08 21:48:18','0:0:0:0:0:0:0:1',NULL,NULL),(241,3,'2019-04-18 22:18:40','0:0:0:0:0:0:0:1',NULL,NULL),(242,3,'2019-04-20 12:45:16','0:0:0:0:0:0:0:1',NULL,NULL),(243,3,'2019-05-19 14:52:12','0:0:0:0:0:0:0:1',NULL,NULL),(244,3,'2019-05-25 15:00:17','0:0:0:0:0:0:0:1',NULL,NULL),(245,3,'2019-06-19 20:11:42','0:0:0:0:0:0:0:1',NULL,NULL),(246,3,'2019-06-30 10:33:48','0:0:0:0:0:0:0:1',NULL,NULL),(247,3,'2019-06-30 10:34:31','0:0:0:0:0:0:0:1',NULL,NULL),(248,3,'2019-06-30 10:35:34','0:0:0:0:0:0:0:1',NULL,NULL),(249,3,'2019-07-27 17:11:01','0:0:0:0:0:0:0:1',NULL,NULL),(250,3,'2019-07-27 17:13:18','0:0:0:0:0:0:0:1',NULL,NULL),(251,3,'2019-07-27 17:15:35','0:0:0:0:0:0:0:1',NULL,NULL),(252,3,'2019-07-27 17:17:11','0:0:0:0:0:0:0:1',NULL,NULL),(253,3,'2019-07-27 17:18:34','0:0:0:0:0:0:0:1',NULL,NULL),(254,3,'2019-07-27 21:21:52','0:0:0:0:0:0:0:1',NULL,NULL),(255,3,'2019-07-27 21:34:29','0:0:0:0:0:0:0:1',NULL,NULL),(256,3,'2019-07-27 21:35:17','0:0:0:0:0:0:0:1',NULL,NULL),(257,3,'2019-07-27 21:35:48','0:0:0:0:0:0:0:1',NULL,NULL),(258,3,'2019-07-27 21:40:33','0:0:0:0:0:0:0:1',NULL,NULL),(259,3,'2019-08-18 16:00:38','0:0:0:0:0:0:0:1',NULL,NULL),(260,3,'2019-08-18 16:01:06','0:0:0:0:0:0:0:1',NULL,NULL),(261,3,'2019-08-18 16:47:01','0:0:0:0:0:0:0:1',NULL,NULL),(262,3,'2019-10-06 15:54:23','0:0:0:0:0:0:0:1',NULL,NULL),(263,3,'2019-10-06 16:03:28','0:0:0:0:0:0:0:1',NULL,NULL),(264,3,'2019-10-06 16:04:51','0:0:0:0:0:0:0:1',NULL,NULL),(265,3,'2019-10-06 16:06:44','0:0:0:0:0:0:0:1',NULL,NULL),(266,3,'2019-10-06 16:14:51','0:0:0:0:0:0:0:1',NULL,NULL),(267,1,'2019-10-06 16:15:09','0:0:0:0:0:0:0:1',NULL,NULL),(268,1,'2019-10-06 16:16:14','0:0:0:0:0:0:0:1',NULL,NULL),(269,3,'2019-10-06 16:16:35','0:0:0:0:0:0:0:1',NULL,NULL),(270,3,'2019-10-06 16:16:42','0:0:0:0:0:0:0:1',NULL,NULL),(271,3,'2019-10-07 15:20:48','0:0:0:0:0:0:0:1',NULL,NULL),(272,3,'2019-10-07 15:40:07','0:0:0:0:0:0:0:1',NULL,NULL),(273,3,'2019-10-07 16:34:15','0:0:0:0:0:0:0:1',NULL,NULL),(274,3,'2019-10-09 21:19:08','0:0:0:0:0:0:0:1',NULL,NULL),(275,4,'2019-10-09 21:30:35','0:0:0:0:0:0:0:1',NULL,NULL),(276,4,'2019-10-09 21:31:30','0:0:0:0:0:0:0:1',NULL,NULL),(277,4,'2019-10-09 21:32:39','0:0:0:0:0:0:0:1',NULL,NULL),(278,4,'2019-10-09 21:33:27','0:0:0:0:0:0:0:1',NULL,NULL),(279,4,'2019-10-09 21:33:50','0:0:0:0:0:0:0:1',NULL,NULL),(280,3,'2019-10-20 16:02:53','0:0:0:0:0:0:0:1',NULL,NULL),(281,3,'2019-10-23 21:20:55','0:0:0:0:0:0:0:1',NULL,NULL),(282,3,'2019-10-27 21:41:45','0:0:0:0:0:0:0:1',NULL,NULL),(283,3,'2019-11-09 16:44:57','0:0:0:0:0:0:0:1',NULL,NULL),(284,3,'2019-11-09 16:46:56','0:0:0:0:0:0:0:1',NULL,NULL),(285,3,'2019-11-09 16:49:55','0:0:0:0:0:0:0:1',NULL,NULL),(286,3,'2019-11-23 14:17:16','0:0:0:0:0:0:0:1',NULL,NULL),(287,6,'2019-11-23 14:52:30','0:0:0:0:0:0:0:1',NULL,NULL),(288,3,'2019-11-23 15:07:24','0:0:0:0:0:0:0:1',NULL,NULL),(289,3,'2019-11-30 21:25:30','192.168.3.185',NULL,NULL),(290,3,'2019-11-30 21:27:54','192.168.3.185',NULL,NULL),(291,3,'2019-12-28 15:23:01','0:0:0:0:0:0:0:1',NULL,NULL),(292,3,'2020-01-01 15:21:46','0:0:0:0:0:0:0:1',NULL,NULL),(293,3,'2020-01-04 16:00:54','192.168.3.185',NULL,NULL),(294,3,'2020-02-01 15:05:19','0:0:0:0:0:0:0:1',NULL,NULL),(295,3,'2020-02-01 15:36:05','0:0:0:0:0:0:0:1',NULL,NULL),(296,3,'2020-02-01 15:36:36','0:0:0:0:0:0:0:1',NULL,NULL),(297,3,'2020-02-01 15:37:30','0:0:0:0:0:0:0:1',NULL,NULL),(298,3,'2020-02-01 15:37:46','0:0:0:0:0:0:0:1',NULL,NULL),(299,3,'2020-02-01 15:38:20','0:0:0:0:0:0:0:1',NULL,NULL),(300,3,'2020-02-01 15:38:33','0:0:0:0:0:0:0:1',NULL,NULL),(301,3,'2020-02-01 15:39:06','0:0:0:0:0:0:0:1',NULL,NULL),(302,3,'2020-02-01 15:41:31','0:0:0:0:0:0:0:1',NULL,NULL),(303,3,'2020-02-01 15:43:17','0:0:0:0:0:0:0:1',NULL,NULL),(304,3,'2020-02-01 15:44:34','0:0:0:0:0:0:0:1',NULL,NULL),(305,3,'2020-02-01 15:45:10','0:0:0:0:0:0:0:1',NULL,NULL),(306,3,'2020-02-01 15:46:04','0:0:0:0:0:0:0:1',NULL,NULL),(307,3,'2020-02-01 15:48:33','0:0:0:0:0:0:0:1',NULL,NULL),(308,3,'2020-02-01 16:00:07','0:0:0:0:0:0:0:1',NULL,NULL),(309,3,'2020-02-01 16:07:25','0:0:0:0:0:0:0:1',NULL,NULL),(310,3,'2020-02-01 16:08:22','0:0:0:0:0:0:0:1',NULL,NULL),(311,3,'2020-02-02 15:28:13','0:0:0:0:0:0:0:1',NULL,NULL),(312,3,'2020-02-02 15:44:37','0:0:0:0:0:0:0:1',NULL,NULL),(313,3,'2020-02-02 15:45:25','0:0:0:0:0:0:0:1',NULL,NULL),(314,3,'2020-02-02 15:52:32','0:0:0:0:0:0:0:1',NULL,NULL),(315,3,'2020-02-02 15:53:44','0:0:0:0:0:0:0:1',NULL,NULL),(316,3,'2020-02-02 15:54:36','0:0:0:0:0:0:0:1',NULL,NULL),(317,3,'2020-02-02 16:01:00','0:0:0:0:0:0:0:1',NULL,NULL),(318,3,'2020-02-02 16:05:19','0:0:0:0:0:0:0:1',NULL,NULL),(319,3,'2020-02-02 16:06:31','0:0:0:0:0:0:0:1',NULL,NULL),(320,3,'2020-02-02 16:17:26','0:0:0:0:0:0:0:1',NULL,NULL),(321,3,'2020-02-02 16:18:45','0:0:0:0:0:0:0:1',NULL,NULL),(322,3,'2020-02-02 16:19:05','0:0:0:0:0:0:0:1',NULL,NULL),(323,3,'2020-02-02 16:19:23','0:0:0:0:0:0:0:1',NULL,NULL),(324,3,'2020-02-02 16:22:27','0:0:0:0:0:0:0:1',NULL,NULL),(325,3,'2020-02-02 16:23:30','0:0:0:0:0:0:0:1',NULL,NULL),(326,3,'2020-02-02 16:23:48','0:0:0:0:0:0:0:1',NULL,NULL),(327,3,'2020-02-02 16:24:38','0:0:0:0:0:0:0:1',NULL,NULL),(328,3,'2020-02-02 16:25:22','0:0:0:0:0:0:0:1',NULL,NULL),(329,3,'2020-02-02 16:26:19','0:0:0:0:0:0:0:1',NULL,NULL),(330,3,'2020-02-02 16:26:31','0:0:0:0:0:0:0:1',NULL,NULL),(331,3,'2020-02-02 16:27:08','0:0:0:0:0:0:0:1',NULL,NULL),(332,3,'2020-02-02 16:31:02','0:0:0:0:0:0:0:1',NULL,NULL),(333,3,'2020-02-02 16:31:08','0:0:0:0:0:0:0:1',NULL,NULL),(334,3,'2020-02-02 16:31:25','0:0:0:0:0:0:0:1',NULL,NULL),(335,3,'2020-02-02 16:31:50','0:0:0:0:0:0:0:1',NULL,NULL),(336,3,'2020-02-02 16:33:22','0:0:0:0:0:0:0:1',NULL,NULL),(337,3,'2020-02-02 16:33:41','0:0:0:0:0:0:0:1',NULL,NULL),(338,3,'2020-02-02 16:34:58','0:0:0:0:0:0:0:1',NULL,NULL),(339,3,'2020-02-02 16:38:42','0:0:0:0:0:0:0:1',NULL,NULL),(340,3,'2020-02-02 16:39:41','0:0:0:0:0:0:0:1',NULL,NULL),(341,3,'2020-02-02 16:42:22','0:0:0:0:0:0:0:1',NULL,NULL),(342,3,'2020-02-02 16:46:21','0:0:0:0:0:0:0:1',NULL,NULL),(343,3,'2020-02-02 16:50:23','0:0:0:0:0:0:0:1',NULL,NULL),(344,3,'2020-02-02 16:51:11','0:0:0:0:0:0:0:1',NULL,NULL),(345,3,'2020-02-02 16:51:22','0:0:0:0:0:0:0:1',NULL,NULL),(346,3,'2020-02-02 16:52:00','0:0:0:0:0:0:0:1',NULL,NULL),(347,3,'2020-02-02 17:01:05','0:0:0:0:0:0:0:1',NULL,NULL),(348,3,'2020-02-03 10:43:22','0:0:0:0:0:0:0:1',NULL,NULL),(349,3,'2020-02-03 10:45:29','0:0:0:0:0:0:0:1',NULL,NULL),(350,3,'2020-02-03 10:46:33','0:0:0:0:0:0:0:1',NULL,NULL),(351,3,'2020-02-03 10:54:33','0:0:0:0:0:0:0:1',NULL,NULL),(352,3,'2020-02-03 14:24:47','0:0:0:0:0:0:0:1',NULL,NULL),(353,3,'2020-02-03 14:25:38','0:0:0:0:0:0:0:1',NULL,NULL),(354,5,'2020-02-03 15:22:28','0:0:0:0:0:0:0:1',NULL,NULL),(355,5,'2020-02-03 15:23:00','0:0:0:0:0:0:0:1',NULL,NULL),(356,5,'2020-02-03 15:24:29','0:0:0:0:0:0:0:1',NULL,NULL),(357,3,'2020-02-03 15:24:50','0:0:0:0:0:0:0:1',NULL,NULL),(358,5,'2020-02-03 15:27:18','0:0:0:0:0:0:0:1',NULL,NULL),(359,3,'2020-02-03 15:27:33','0:0:0:0:0:0:0:1',NULL,NULL),(360,3,'2020-02-03 15:29:06','0:0:0:0:0:0:0:1',NULL,NULL),(361,5,'2020-02-03 15:33:25','0:0:0:0:0:0:0:1',NULL,NULL),(362,3,'2020-02-03 15:33:51','0:0:0:0:0:0:0:1',NULL,NULL),(363,1,'2020-02-03 15:34:35','0:0:0:0:0:0:0:1',NULL,NULL),(364,3,'2020-02-03 15:34:47','0:0:0:0:0:0:0:1',NULL,NULL),(365,3,'2020-02-04 14:14:46','0:0:0:0:0:0:0:1',NULL,NULL),(366,3,'2020-02-05 10:33:35','0:0:0:0:0:0:0:1',NULL,NULL),(367,3,'2020-02-05 10:36:21','0:0:0:0:0:0:0:1',NULL,NULL),(368,3,'2020-02-05 16:34:37','0:0:0:0:0:0:0:1',NULL,NULL),(369,4,'2020-02-05 16:58:37','0:0:0:0:0:0:0:1',NULL,NULL),(370,3,'2020-02-05 16:59:03','0:0:0:0:0:0:0:1',NULL,NULL),(371,3,'2020-02-06 10:25:02','0:0:0:0:0:0:0:1',NULL,NULL),(372,3,'2020-02-07 14:34:34','0:0:0:0:0:0:0:1',NULL,NULL),(373,3,'2020-02-07 14:36:20','0:0:0:0:0:0:0:1',NULL,NULL),(374,1,'2020-02-07 14:43:34','0:0:0:0:0:0:0:1',NULL,NULL),(375,3,'2020-02-07 15:18:06','0:0:0:0:0:0:0:1',NULL,NULL),(376,3,'2020-02-07 15:20:07','0:0:0:0:0:0:0:1',NULL,NULL),(377,3,'2020-02-07 15:22:20','0:0:0:0:0:0:0:1',NULL,NULL),(378,3,'2020-02-07 15:22:28','0:0:0:0:0:0:0:1',NULL,NULL),(379,3,'2020-02-07 15:55:11','0:0:0:0:0:0:0:1',NULL,NULL),(380,3,'2020-02-07 15:56:04','0:0:0:0:0:0:0:1',NULL,NULL),(381,3,'2020-02-07 15:58:49','0:0:0:0:0:0:0:1',NULL,NULL),(382,6,'2020-02-07 16:16:21','0:0:0:0:0:0:0:1',NULL,NULL),(383,7,'2020-02-07 16:16:37','0:0:0:0:0:0:0:1',NULL,NULL),(384,3,'2020-02-07 16:18:39','0:0:0:0:0:0:0:1',NULL,NULL),(385,7,'2020-02-07 16:20:06','0:0:0:0:0:0:0:1',NULL,NULL),(386,3,'2020-02-07 16:20:44','0:0:0:0:0:0:0:1',NULL,NULL),(387,3,'2020-02-07 16:32:31','0:0:0:0:0:0:0:1',NULL,NULL),(388,3,'2020-02-07 19:32:34','0:0:0:0:0:0:0:1',NULL,NULL),(389,3,'2020-02-07 19:32:48','0:0:0:0:0:0:0:1',NULL,NULL),(390,3,'2020-02-07 19:33:01','0:0:0:0:0:0:0:1',NULL,NULL),(391,3,'2020-02-07 19:33:06','0:0:0:0:0:0:0:1',NULL,NULL),(392,3,'2020-02-07 19:33:21','0:0:0:0:0:0:0:1',NULL,NULL),(393,3,'2020-02-07 19:35:33','0:0:0:0:0:0:0:1',NULL,NULL),(394,3,'2020-02-07 19:37:10','0:0:0:0:0:0:0:1',NULL,NULL),(395,3,'2020-02-07 19:37:14','0:0:0:0:0:0:0:1',NULL,NULL),(396,3,'2020-02-07 19:37:25','0:0:0:0:0:0:0:1',NULL,NULL),(397,3,'2020-02-07 19:45:41','0:0:0:0:0:0:0:1',NULL,NULL),(398,3,'2020-02-07 19:47:45','0:0:0:0:0:0:0:1',NULL,NULL),(399,3,'2020-02-07 20:02:25','0:0:0:0:0:0:0:1',NULL,NULL),(400,6,'2020-02-07 20:10:55','0:0:0:0:0:0:0:1',NULL,NULL),(401,6,'2020-02-07 20:11:02','0:0:0:0:0:0:0:1',NULL,NULL),(402,6,'2020-02-07 20:13:44','0:0:0:0:0:0:0:1',NULL,NULL),(403,6,'2020-02-07 20:17:14','0:0:0:0:0:0:0:1',NULL,NULL),(404,3,'2020-02-07 20:17:44','0:0:0:0:0:0:0:1',NULL,NULL),(405,6,'2020-02-07 20:18:13','0:0:0:0:0:0:0:1',NULL,NULL),(406,3,'2020-02-10 10:28:14','0:0:0:0:0:0:0:1',NULL,NULL),(407,3,'2020-02-10 10:45:15','0:0:0:0:0:0:0:1',NULL,NULL),(408,3,'2020-02-10 10:57:46','0:0:0:0:0:0:0:1',NULL,NULL),(409,3,'2020-02-10 10:59:06','0:0:0:0:0:0:0:1',NULL,NULL),(410,3,'2020-02-10 11:04:19','0:0:0:0:0:0:0:1',NULL,NULL),(411,3,'2020-02-10 11:05:55','0:0:0:0:0:0:0:1',NULL,NULL),(412,3,'2020-02-10 11:06:45','0:0:0:0:0:0:0:1',NULL,NULL),(413,3,'2020-02-10 11:07:41','0:0:0:0:0:0:0:1',NULL,NULL),(414,3,'2020-02-10 11:08:13','0:0:0:0:0:0:0:1',NULL,NULL),(415,3,'2020-02-10 11:10:02','0:0:0:0:0:0:0:1',NULL,NULL),(416,6,'2020-02-10 14:25:17','0:0:0:0:0:0:0:1',NULL,NULL),(417,6,'2020-02-10 14:29:14','0:0:0:0:0:0:0:1',NULL,NULL),(418,3,'2020-02-10 16:09:16','0:0:0:0:0:0:0:1',NULL,NULL),(419,3,'2020-02-20 14:39:19','0:0:0:0:0:0:0:1',NULL,NULL),(420,8,'2020-02-20 17:14:58','0:0:0:0:0:0:0:1',NULL,NULL),(421,8,'2020-02-20 17:17:04','0:0:0:0:0:0:0:1',NULL,NULL),(422,8,'2020-02-20 17:17:42','0:0:0:0:0:0:0:1',NULL,NULL),(423,8,'2020-02-21 10:26:56','0:0:0:0:0:0:0:1',NULL,NULL),(424,8,'2020-02-21 10:28:54','0:0:0:0:0:0:0:1',NULL,NULL),(425,8,'2020-02-21 10:32:25','0:0:0:0:0:0:0:1',NULL,NULL),(426,8,'2020-02-21 10:33:41','0:0:0:0:0:0:0:1',NULL,NULL),(427,8,'2020-02-21 10:35:58','0:0:0:0:0:0:0:1',NULL,NULL),(428,8,'2020-02-21 10:36:49','0:0:0:0:0:0:0:1',NULL,NULL),(429,3,'2020-02-21 11:10:11','0:0:0:0:0:0:0:1',NULL,NULL),(430,3,'2020-02-25 16:11:13','0:0:0:0:0:0:0:1',NULL,NULL),(431,3,'2020-02-25 16:46:29','0:0:0:0:0:0:0:1',NULL,NULL),(432,3,'2020-12-06 15:57:54','192.168.3.19',NULL,NULL),(433,3,'2020-12-06 15:58:07','192.168.3.19',NULL,NULL),(434,3,'2020-12-06 15:58:11','192.168.3.19',NULL,NULL),(435,3,'2020-12-06 15:59:17','192.168.3.19',NULL,NULL),(436,3,'2020-12-06 16:00:07','192.168.3.19',NULL,NULL),(437,3,'2020-12-06 16:01:09','192.168.3.19',NULL,NULL),(438,3,'2020-12-06 16:04:32','192.168.3.19',NULL,NULL),(439,3,'2020-12-06 16:04:43','192.168.3.19',NULL,NULL),(440,3,'2020-12-06 16:06:29','192.168.3.19',NULL,NULL),(441,3,'2020-12-06 16:08:03','192.168.3.19',NULL,NULL),(442,3,'2020-12-06 16:10:42','192.168.3.19',NULL,NULL),(443,3,'2020-12-06 16:11:11','192.168.3.19',NULL,NULL),(444,3,'2020-12-06 16:11:35','192.168.3.19',NULL,NULL),(445,3,'2020-12-06 16:11:55','192.168.3.19',NULL,NULL),(446,3,'2020-12-06 16:12:59','192.168.3.19',NULL,NULL),(447,3,'2020-12-06 16:13:26','192.168.3.19',NULL,NULL),(448,3,'2020-12-06 16:14:38','192.168.3.19',NULL,NULL),(449,3,'2020-12-06 16:18:08','192.168.3.19',NULL,NULL),(450,3,'2020-12-06 16:18:54','192.168.3.19',NULL,NULL),(451,3,'2020-12-06 16:50:38','192.168.3.19',NULL,NULL),(452,3,'2020-12-06 19:07:57','192.168.3.19',NULL,NULL),(453,3,'2020-12-06 19:11:59','192.168.3.19',NULL,NULL),(454,3,'2020-12-06 19:49:26','192.168.3.19',NULL,NULL),(455,3,'2020-12-06 19:52:05','192.168.3.19',NULL,NULL),(456,3,'2020-12-06 20:02:28','192.168.3.19',NULL,NULL),(457,3,'2020-12-06 20:03:08','192.168.3.19',NULL,NULL),(458,3,'2020-12-06 20:03:23','192.168.3.19',NULL,NULL),(459,3,'2020-12-06 20:15:07','192.168.3.19',NULL,NULL),(460,3,'2020-12-06 20:20:18','192.168.3.19',NULL,NULL),(461,3,'2020-12-06 20:22:49','192.168.3.19',NULL,NULL),(462,3,'2020-12-06 20:27:44','192.168.3.19',NULL,NULL),(463,3,'2020-12-06 20:44:46','192.168.3.19',NULL,NULL),(464,3,'2020-12-06 20:53:16','192.168.3.19',NULL,NULL),(465,3,'2020-12-06 20:55:14','192.168.3.19',NULL,NULL),(466,3,'2020-12-06 20:55:44','192.168.3.19',NULL,NULL),(467,3,'2020-12-06 20:58:48','192.168.3.19',NULL,NULL),(468,3,'2020-12-06 21:05:28','192.168.3.19',NULL,NULL),(469,3,'2020-12-06 21:07:36','192.168.3.19',NULL,NULL),(470,3,'2021-01-10 22:39:46','192.168.3.21',NULL,NULL),(471,3,'2021-01-12 20:28:44','192.168.3.21',NULL,NULL),(472,3,'2021-01-18 22:01:53','192.168.3.21',NULL,NULL),(473,9,'2021-01-24 20:13:23','192.168.3.21',NULL,NULL),(474,9,'2021-01-24 20:33:30','192.168.3.21',NULL,NULL),(475,9,'2021-01-24 20:51:20','192.168.3.21',NULL,NULL),(476,9,'2021-01-24 22:36:44','192.168.3.21',NULL,NULL),(477,9,'2021-02-07 09:14:45','192.168.3.21',NULL,NULL),(478,9,'2021-02-21 09:38:30','127.0.0.1',NULL,NULL),(479,9,'2021-02-21 09:44:15','127.0.0.1',NULL,NULL),(480,9,'2021-02-21 12:51:39','192.168.0.110',NULL,NULL),(481,9,'2021-02-25 16:19:18','192.168.0.110',NULL,NULL),(482,9,'2021-02-28 18:47:15','10.160.163.237',NULL,NULL),(483,9,'2021-02-28 19:40:09','10.160.163.237',NULL,NULL),(484,9,'2021-03-01 20:57:07','10.160.163.98',NULL,NULL),(485,9,'2021-03-02 10:15:14','10.160.163.98',NULL,NULL),(486,9,'2021-03-02 10:15:20','10.160.163.98',NULL,NULL),(487,9,'2021-03-03 22:18:02','10.160.163.98',NULL,NULL),(488,9,'2021-03-04 17:01:03','10.160.163.98',NULL,NULL),(489,9,'2021-03-05 16:16:36','10.160.163.98',NULL,NULL),(490,9,'2021-03-08 10:36:26','10.160.163.237',NULL,NULL),(491,9,'2021-03-08 11:01:12','10.160.163.237',NULL,NULL),(492,9,'2021-03-08 19:29:52','10.160.163.237',NULL,NULL),(493,9,'2021-03-09 10:16:08','10.160.163.98',NULL,NULL),(494,9,'2021-03-09 10:38:44','10.160.163.237',NULL,NULL),(495,9,'2021-03-11 22:01:25','10.160.163.98',NULL,NULL),(496,9,'2021-03-15 20:49:24','10.160.163.98',NULL,NULL),(497,9,'2021-03-16 22:06:59','10.160.163.98',NULL,NULL),(498,9,'2021-03-19 17:31:17','10.160.163.98',NULL,NULL),(499,9,'2021-03-19 21:46:34','10.160.163.98',NULL,NULL),(500,9,'2021-03-20 17:36:11','10.160.163.98',NULL,NULL),(501,9,'2021-03-22 18:49:34','10.177.20.47',NULL,NULL),(502,9,'2021-03-22 20:43:13','10.177.20.47',NULL,NULL),(503,9,'2021-03-23 20:18:51','10.160.163.98',NULL,NULL),(504,9,'2021-03-25 17:18:23','10.160.165.252',NULL,NULL),(505,9,'2021-04-02 20:49:03','192.168.3.29',NULL,NULL),(506,9,'2021-04-12 12:27:20','192.168.3.21',NULL,NULL),(507,9,'2021-04-29 18:25:06','192.168.10.110',NULL,NULL),(508,9,'2021-04-29 18:29:47','192.168.10.110',NULL,NULL),(509,9,'2021-04-29 18:49:01','192.168.10.114',NULL,NULL),(510,9,'2021-04-30 21:25:31','192.168.10.114',NULL,NULL),(511,9,'2021-04-30 21:26:17','192.168.10.114',NULL,NULL),(512,9,'2021-04-30 21:27:16','192.168.10.114',NULL,NULL),(513,9,'2021-04-30 21:30:40','192.168.10.114',NULL,NULL),(514,9,'2021-04-30 21:30:54','192.168.10.114',NULL,NULL),(515,9,'2021-04-30 21:31:01','192.168.10.114',NULL,NULL),(516,9,'2021-04-30 21:35:09','192.168.10.114',NULL,NULL),(517,9,'2021-04-30 21:36:12','192.168.10.114',NULL,NULL),(518,9,'2021-04-30 21:41:18','192.168.10.114',NULL,NULL),(519,9,'2021-04-30 21:45:18','192.168.10.114',NULL,NULL),(520,9,'2021-04-30 21:46:15','192.168.10.114',NULL,NULL),(521,9,'2021-04-30 21:55:43','192.168.10.114',NULL,NULL),(522,9,'2021-05-01 14:18:38','192.168.10.114',NULL,NULL),(523,9,'2021-05-01 14:23:02','192.168.10.114',NULL,NULL),(524,9,'2021-05-01 14:25:47','192.168.10.114',NULL,NULL),(525,9,'2021-05-01 14:28:25','192.168.10.114',NULL,NULL),(526,9,'2021-05-01 14:55:25','192.168.10.114',NULL,NULL),(527,9,'2021-05-01 14:59:53','192.168.10.114',NULL,NULL),(528,9,'2021-05-01 15:45:01','192.168.10.114',NULL,NULL),(529,9,'2021-05-01 15:46:08','192.168.10.114',NULL,NULL),(530,9,'2021-05-01 15:47:40','192.168.10.114',NULL,NULL),(531,9,'2021-05-03 23:05:02','192.168.10.114',NULL,NULL),(532,9,'2021-05-03 23:06:33','192.168.10.114',NULL,NULL),(533,9,'2021-05-03 23:13:55','192.168.10.114',NULL,NULL),(534,9,'2021-05-03 23:23:44','192.168.10.114',NULL,NULL),(535,9,'2021-05-03 23:33:39','192.168.10.114',NULL,NULL),(536,9,'2021-05-03 23:41:36','192.168.10.114',NULL,NULL),(537,9,'2021-05-04 00:08:35','192.168.10.114',NULL,NULL),(538,9,'2021-05-04 00:11:04','192.168.10.114',NULL,NULL),(539,9,'2021-05-05 10:51:24','192.168.10.114',NULL,NULL),(540,9,'2021-05-05 10:56:17','192.168.10.114',NULL,NULL),(541,9,'2021-05-05 10:57:53','192.168.10.114',NULL,NULL),(542,9,'2021-05-05 11:00:47','192.168.10.114',NULL,NULL),(543,9,'2021-05-05 11:05:51','192.168.10.114',NULL,NULL),(544,9,'2021-05-05 11:11:48','192.168.10.114',NULL,NULL),(545,9,'2021-05-05 11:13:56','192.168.10.114',NULL,NULL),(546,9,'2021-05-05 11:34:15','192.168.10.114',NULL,NULL),(547,9,'2021-05-05 11:41:50','192.168.10.114',NULL,NULL),(548,9,'2021-05-05 16:10:07','192.168.10.114',NULL,NULL),(549,9,'2021-05-05 16:39:41','192.168.10.114',NULL,NULL),(550,9,'2021-05-05 17:01:49','192.168.10.114',NULL,NULL),(551,9,'2021-05-05 17:05:59','192.168.10.114',NULL,NULL),(552,9,'2021-05-05 17:08:42','192.168.10.114',NULL,NULL),(553,9,'2021-05-05 17:16:31','192.168.10.114',NULL,NULL),(554,9,'2021-05-05 17:41:00','192.168.10.114',NULL,NULL),(555,9,'2021-05-05 17:42:09','192.168.10.114',NULL,NULL),(556,9,'2021-05-05 17:43:34','192.168.10.114',NULL,NULL),(557,9,'2021-05-05 19:45:43','192.168.10.114',NULL,NULL),(558,9,'2021-05-05 19:57:50','192.168.10.114',NULL,NULL),(559,9,'2021-05-05 19:58:29','192.168.10.114',NULL,NULL),(560,9,'2021-05-05 19:58:45','192.168.10.114',NULL,NULL),(561,9,'2021-05-05 19:59:12','192.168.10.114',NULL,NULL),(562,9,'2021-05-05 19:59:45','192.168.10.114',NULL,NULL),(563,9,'2021-05-05 20:05:07','192.168.10.114',NULL,NULL),(564,9,'2021-05-05 20:12:53','192.168.10.114',NULL,NULL),(565,9,'2021-05-05 20:18:05','192.168.10.114',NULL,NULL),(566,9,'2021-05-05 20:20:45','192.168.10.114',NULL,NULL),(567,9,'2021-05-05 20:22:23','192.168.10.114',NULL,NULL);
/*!40000 ALTER TABLE `reagent_admin_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_admin_permission_relation`
--

DROP TABLE IF EXISTS `reagent_admin_permission_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_admin_permission_relation` (
                                                     `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                     `admin_id` bigint(20) DEFAULT NULL,
                                                     `permission_id` bigint(20) DEFAULT NULL,
                                                     `type` int(1) DEFAULT NULL,
                                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户和权限关系表(除角色中定义的权限以外的加减权限)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_admin_permission_relation`
--

LOCK TABLES `reagent_admin_permission_relation` WRITE;
/*!40000 ALTER TABLE `reagent_admin_permission_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_admin_permission_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_admin_role_relation`
--

DROP TABLE IF EXISTS `reagent_admin_role_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_admin_role_relation` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                               `admin_id` bigint(20) DEFAULT NULL,
                                               `role_id` bigint(20) DEFAULT NULL,
                                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户和角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_admin_role_relation`
--

LOCK TABLES `reagent_admin_role_relation` WRITE;
/*!40000 ALTER TABLE `reagent_admin_role_relation` DISABLE KEYS */;
INSERT INTO `reagent_admin_role_relation` VALUES (31,9,1);
/*!40000 ALTER TABLE `reagent_admin_role_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_base_info`
--

DROP TABLE IF EXISTS `reagent_base_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_base_info` (
                                     `id` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
                                     `code` varchar(32) NOT NULL COMMENT '试剂耗材编号',
                                     `name` varchar(50) NOT NULL COMMENT '试剂名称',
                                     `unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                     `specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                     `manufacturer_name` varchar(255) DEFAULT NULL COMMENT '生产厂家',
                                     `registration_no` varchar(30) DEFAULT NULL COMMENT '注册证号',
                                     `supplier_id` bigint(20) DEFAULT NULL COMMENT '供货商 ID',
                                     `supplier_short_name` varchar(20) DEFAULT NULL COMMENT '供货商名',
                                     `price` double(16,2) DEFAULT NULL COMMENT '单价',
  `stock_type` varchar(20) DEFAULT NULL COMMENT '储存温度: 常温，冷藏，冷冻',
  `expiration_limit` int(11) DEFAULT NULL COMMENT '过期预警时间阈值',
  `stock_limit` int(11) DEFAULT NULL COMMENT '低库存预警阈值',
  `use_day_limit` int(11) DEFAULT NULL COMMENT '开启有效期限',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(20) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime DEFAULT NULL,
  `delete_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='试剂基础情报';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_base_info`
--

LOCK TABLES `reagent_base_info` WRITE;
/*!40000 ALTER TABLE `reagent_base_info` DISABLE KEYS */;
INSERT INTO `reagent_base_info` VALUES (00000000000000000001,'123456','健胃消食片','盒','12片','哈药集团','2324',23423,'哈药',11.00,'常温',33,33,33,'2021-03-04 20:00:23',NULL,'2021-03-04 20:00:28',NULL,0,NULL,NULL),(00000000000000000002,'3211234','阿司匹林','盒','24粒','哈药集团','1213',23423,'哈药集团',22.00,'常温',212,122,1234,'2021-03-04 11:12:14',NULL,'2021-03-04 20:00:31',NULL,NULL,NULL,NULL),(00000000000000000003,'233','口服液','瓶','12瓶/盒','第三方','23423',32432,'济南',33.00,'冷藏',1111,2222,3333,'2021-03-04 17:03:24',NULL,'2021-03-04 20:00:34',NULL,NULL,NULL,NULL),(00000000000000000004,'326','西瓜霜','盒','两板/盒','济南','34123',342142,'济南',44.00,'常温',23,234,234,'2021-03-10 21:08:11',NULL,NULL,NULL,NULL,NULL,NULL),(00000000000000000005,'325','当归','盒','一两/盒','济南','234',3242,'济南',55.00,'冷藏',234,324,235,'2021-03-10 21:08:58',NULL,NULL,NULL,NULL,NULL,NULL),(00000000000000000006,'324','西瓜霜','盒','12片','山西医药','234123',42523,'山医',6.00,'冷冻',344,344,344,'2021-03-16 10:57:59',NULL,NULL,NULL,NULL,NULL,NULL),(00000000000000000007,'327','可口可乐','盒','50粒','菏泽医药','1234',666,'菏泽医药',7.00,'常温',1,1,1,'2021-03-17 11:06:24',NULL,NULL,NULL,0,NULL,NULL),(00000000000000000008,'328','盖中盖','盒','30粒','菏泽医药','12345',666,'菏泽医药',8.00,'冷冻',2,2,2,'2021-03-17 11:06:24',NULL,NULL,NULL,0,NULL,NULL),(00000000000000000009,'329','人参','盒','30粒','菏泽医药','12346',666,'菏泽医药',9.00,'冷藏',3,3,3,'2021-03-17 11:06:24',NULL,NULL,NULL,0,NULL,NULL),(00000000000000000010,'340','晕车药','盒','3板','济南医药','342',112,'济南医药',19.80,'常温',2,2,2,'2021-03-22 22:18:56',NULL,NULL,NULL,NULL,NULL,NULL),(00000000000000000011,'341','可口可乐','瓶','500ML','山东医药','2021324',999,'admin',3.50,'冷藏',15,15,15,'2021-03-24 10:27:56',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_base_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_branch`
--

DROP TABLE IF EXISTS `reagent_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_branch` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `branch_code` varchar(20) DEFAULT NULL COMMENT '科室号',
                                  `branch_name` varchar(32) DEFAULT NULL COMMENT '科室名',
                                  `tel` varchar(15) DEFAULT NULL COMMENT '电话',
                                  `head` varchar(16) DEFAULT NULL COMMENT '负责人',
                                  `create_time` datetime DEFAULT NULL COMMENT '从这五个非空',
                                  `create_by` varchar(20) DEFAULT NULL,
                                  `update_time` datetime DEFAULT NULL,
                                  `update_by` varchar(20) DEFAULT NULL,
                                  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                  `delete_time` datetime DEFAULT NULL,
                                  `delete_by` varchar(20) DEFAULT NULL,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='科室';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_branch`
--

LOCK TABLES `reagent_branch` WRITE;
/*!40000 ALTER TABLE `reagent_branch` DISABLE KEYS */;
INSERT INTO `reagent_branch` VALUES (1,'222','内科','110','admin','2021-02-25 22:05:42','1','2021-02-25 22:05:54','1',0,NULL,NULL),(2,'234','消化科','120110','admin','2021-02-25 22:09:57','1','2021-02-25 22:10:16','1',0,NULL,NULL),(4,'555','心电科','987','admin','2021-02-25 22:51:23',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_growth_change_history`
--

DROP TABLE IF EXISTS `reagent_growth_change_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_growth_change_history` (
                                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                 `member_id` bigint(20) DEFAULT NULL,
                                                 `create_time` datetime DEFAULT NULL,
                                                 `change_type` int(1) DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
                                                 `change_count` int(11) DEFAULT NULL COMMENT '积分改变数量',
                                                 `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人员',
                                                 `operate_note` varchar(200) DEFAULT NULL COMMENT '操作备注',
                                                 `source_type` int(1) DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
                                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='成长值变化历史记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_growth_change_history`
--

LOCK TABLES `reagent_growth_change_history` WRITE;
/*!40000 ALTER TABLE `reagent_growth_change_history` DISABLE KEYS */;
INSERT INTO `reagent_growth_change_history` VALUES (2,1,'2018-08-29 17:16:35',0,1000,'test','测试使用',1);
/*!40000 ALTER TABLE `reagent_growth_change_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_in_bill`
--

DROP TABLE IF EXISTS `reagent_in_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_in_bill` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                   `code` varchar(32) NOT NULL COMMENT '入库单编号',
                                   `bill_type` varchar(1) NOT NULL COMMENT '入库单种类：1 预入库单， 2 入库单',
                                   `suppiler_id` bigint(20) NOT NULL COMMENT '供货商ID',
                                   `suppiler_short_name` varchar(20) NOT NULL COMMENT '供货商名',
                                   `bill_date` date NOT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为入库日期）',
                                   `bill_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '单据状态：0-草稿，1-已入库 ',
                                   `bill_creator` varchar(20) NOT NULL COMMENT '制单人',
                                   `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                   `create_time` datetime NOT NULL,
                                   `create_by` varchar(20) NOT NULL,
                                   `update_time` datetime NOT NULL,
                                   `update_by` varchar(20) NOT NULL,
                                   `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                   `delete_time` datetime DEFAULT NULL,
                                   `delete_by` varchar(20) DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材入库申请单（接收单）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_in_bill`
--

LOCK TABLES `reagent_in_bill` WRITE;
/*!40000 ALTER TABLE `reagent_in_bill` DISABLE KEYS */;
INSERT INTO `reagent_in_bill` VALUES (1,'IN-001','1',1,'供应商','2021-01-01',1,'zhao','','2021-01-01 00:00:00','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(2,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:42:35','zhao',0,NULL,NULL),(3,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:44:00','zhao',0,NULL,NULL),(4,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:44:39','zhao',0,NULL,NULL),(5,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:46:16','zhao',0,NULL,NULL),(6,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:46:31','zhao',0,NULL,NULL),(7,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:47:10','zhao',0,NULL,NULL),(8,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:49:07','zhao',0,NULL,NULL),(9,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:50:50','zhao',0,NULL,NULL),(10,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:53:04','zhao',0,NULL,NULL),(11,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:54:11','zhao',0,NULL,NULL),(12,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:55:31','zhao',0,NULL,NULL),(13,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:56:47','zhao',0,NULL,NULL),(14,'IN-001','2',1,'供应商','2021-05-03',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-03 23:57:37','zhao',0,NULL,NULL),(15,'IN-001','2',1,'供应商','2021-05-04',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-04 00:09:03','zhao',0,NULL,NULL),(16,'IN-001','2',1,'供应商','2021-05-04',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-04 00:11:22','zhao',0,NULL,NULL),(17,'IN-001','2',1,'供应商','2021-05-05',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-05 10:51:54','zhao',0,NULL,NULL),(18,'IN-001','2',1,'供应商','2021-05-05',1,'admin','','2021-01-01 00:00:00','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_in_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_in_detail`
--

DROP TABLE IF EXISTS `reagent_in_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_in_detail` (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `in_bill_id` bigint(20) NOT NULL COMMENT '入库单ID',
                                     `reagent_id` bigint(20) NOT NULL COMMENT '试剂ID',
                                     `reagent_name` varchar(50) NOT NULL COMMENT '试剂名称',
                                     `reagent_unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                     `reagent_specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                     `price` bigint(20) DEFAULT NULL COMMENT '价格',
                                     `quantity` bigint(20) DEFAULT NULL COMMENT '数量',
                                     `total` bigint(20) DEFAULT NULL COMMENT '金额',
                                     `batch_no` varchar(16) DEFAULT NULL COMMENT '批号',
                                     `expire_date` date NOT NULL COMMENT '保质期',
                                     `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                     `create_time` datetime NOT NULL,
                                     `create_by` varchar(20) NOT NULL,
                                     `update_time` datetime NOT NULL,
                                     `update_by` varchar(20) NOT NULL,
                                     `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                     `delete_time` datetime DEFAULT NULL,
                                     `delete_by` varchar(20) DEFAULT NULL,
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材入库申请单详细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_in_detail`
--

LOCK TABLES `reagent_in_detail` WRITE;
/*!40000 ALTER TABLE `reagent_in_detail` DISABLE KEYS */;
INSERT INTO `reagent_in_detail` VALUES (1,1,1,'试剂1','盒','规格',100,5,500,'20210321','2022-01-01','','2021-01-01 00:00:00','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(2,1,2,'试剂1','盒','规格',100,5,500,'20210322','2022-01-01','','2021-01-01 00:00:00','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(3,1,1,'试剂1','盒','规格',100,5,500,'20210321','2022-01-01','','2021-05-03 23:44:39','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(4,1,1,'试剂1','盒','规格',100,5,500,'20210321','2022-01-01','','2021-05-03 23:46:16','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(5,1,1,'试剂1','盒','规格',100,5,500,'20210321','2022-01-01','','2021-05-03 23:46:31','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(6,1,1,'试剂1','盒','规格',100,5,500,'20210321','2022-01-01','','2021-05-03 23:47:10','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(7,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:49:07','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(8,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:50:50','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(9,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:53:04','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(10,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:54:11','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(11,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:55:31','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(12,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:56:47','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(13,1,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-03 23:57:37','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(14,1,1,'试剂1','盒','规格',100,2,500,'20210321','2022-01-01','','2021-05-04 00:09:03','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(15,1,1,'试剂1','盒','规格',100,1,500,'20210322','2022-01-01','','2021-05-04 00:11:22','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(16,1,1,'试剂1','盒','规格',100,2,500,'20210321','2022-01-01','','2021-05-04 00:11:22','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(17,17,1,'试剂1','盒','规格',100,1,500,'20210321','2022-01-01','','2021-05-05 10:51:54','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(18,17,2,'试剂1','盒','规格',100,1,500,'20210322','2022-01-01','','2021-05-05 10:51:54','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(19,18,1,'试剂1','盒','规格',100,2,500,'20210321','2022-01-01','','2021-05-05 11:20:25','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(20,18,2,'试剂1','盒','规格',100,1,500,'20210322','2022-01-01','','2021-05-05 11:20:25','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_in_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_in_detail_item`
--

DROP TABLE IF EXISTS `reagent_in_detail_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_in_detail_item` (
                                          `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                          `in_detail_id` bigint(20) NOT NULL COMMENT '入库单详细ID',
                                          `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                          `status` varchar(1) NOT NULL COMMENT '状态',
                                          `create_time` datetime NOT NULL,
                                          `create_by` varchar(20) NOT NULL,
                                          `update_time` datetime NOT NULL,
                                          `update_by` varchar(20) NOT NULL,
                                          `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                          `delete_time` datetime DEFAULT NULL,
                                          `delete_by` varchar(20) DEFAULT NULL,
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材入库申请单个体';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_in_detail_item`
--

LOCK TABLES `reagent_in_detail_item` WRITE;
/*!40000 ALTER TABLE `reagent_in_detail_item` DISABLE KEYS */;
INSERT INTO `reagent_in_detail_item` VALUES (1,1,'20210301-01','1','2021-01-01 00:00:00','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(2,1,'20210301-02','1','2021-01-01 00:00:00','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(3,2,'20210302-01','1','2021-01-01 00:00:00','zhao','2021-01-01 00:00:00','zhao',0,NULL,NULL),(4,1,'20210301-01','1','2021-05-03 23:57:39','admin','2021-05-03 23:57:39','admin',0,NULL,NULL),(5,1,'20210301-01','1','2021-05-04 00:09:11','admin','2021-05-04 00:09:11','admin',0,NULL,NULL),(6,1,'20210301-02','1','2021-05-04 00:09:11','admin','2021-05-04 00:09:11','admin',0,NULL,NULL),(7,1,'20210302-01','1','2021-05-04 00:11:22','admin','2021-05-04 00:11:22','admin',0,NULL,NULL),(8,1,'20210301-01','1','2021-05-04 00:11:22','admin','2021-05-04 00:11:22','admin',0,NULL,NULL),(9,1,'20210301-02','1','2021-05-04 00:11:22','admin','2021-05-04 00:11:22','admin',0,NULL,NULL),(10,17,'20210301-01','1','2021-05-05 10:51:54','admin','2021-05-05 10:51:54','admin',0,NULL,NULL),(11,18,'20210302-01','1','2021-05-05 10:51:54','admin','2021-05-05 10:51:54','admin',0,NULL,NULL),(12,19,'20210301-01','1','2021-05-05 11:20:25','admin','2021-05-05 11:20:25','admin',0,NULL,NULL),(13,19,'20210301-02','1','2021-05-05 11:20:25','admin','2021-05-05 11:20:25','admin',0,NULL,NULL),(14,20,'20210302-01','1','2021-05-05 11:20:25','admin','2021-05-05 11:20:25','admin',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_in_detail_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_integration_change_history`
--

DROP TABLE IF EXISTS `reagent_integration_change_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_integration_change_history` (
                                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                      `member_id` bigint(20) DEFAULT NULL,
                                                      `create_time` datetime DEFAULT NULL,
                                                      `change_type` int(1) DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
                                                      `change_count` int(11) DEFAULT NULL COMMENT '积分改变数量',
                                                      `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人员',
                                                      `operate_note` varchar(200) DEFAULT NULL COMMENT '操作备注',
                                                      `source_type` int(1) DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
                                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分变化历史记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_integration_change_history`
--

LOCK TABLES `reagent_integration_change_history` WRITE;
/*!40000 ALTER TABLE `reagent_integration_change_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_integration_change_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_integration_consume_setting`
--

DROP TABLE IF EXISTS `reagent_integration_consume_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_integration_consume_setting` (
                                                       `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                       `deduction_per_amount` int(11) DEFAULT NULL COMMENT '每一元需要抵扣的积分数量',
                                                       `max_percent_per_order` int(11) DEFAULT NULL COMMENT '每笔订单最高抵用百分比',
                                                       `use_unit` int(11) DEFAULT NULL COMMENT '每次使用积分最小单位100',
                                                       `coupon_status` int(1) DEFAULT NULL COMMENT '是否可以和优惠券同用；0->不可以；1->可以',
                                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分消费设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_integration_consume_setting`
--

LOCK TABLES `reagent_integration_consume_setting` WRITE;
/*!40000 ALTER TABLE `reagent_integration_consume_setting` DISABLE KEYS */;
INSERT INTO `reagent_integration_consume_setting` VALUES (2,100,50,100,1);
/*!40000 ALTER TABLE `reagent_integration_consume_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member`
--

DROP TABLE IF EXISTS `reagent_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `member_level_id` bigint(20) DEFAULT NULL,
                                  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
                                  `password` varchar(64) DEFAULT NULL COMMENT '密码',
                                  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
                                  `phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
                                  `status` int(1) DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
                                  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
                                  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
                                  `gender` int(1) DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
                                  `birthday` date DEFAULT NULL COMMENT '生日',
                                  `city` varchar(64) DEFAULT NULL COMMENT '所做城市',
                                  `job` varchar(100) DEFAULT NULL COMMENT '职业',
                                  `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
                                  `source_type` int(1) DEFAULT NULL COMMENT '用户来源',
                                  `integration` int(11) DEFAULT NULL COMMENT '积分',
                                  `growth` int(11) DEFAULT NULL COMMENT '成长值',
                                  `luckey_count` int(11) DEFAULT NULL COMMENT '剩余抽奖次数',
                                  `history_integration` int(11) DEFAULT NULL COMMENT '历史积分数量',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE KEY `idx_username` (`username`) USING BTREE,
                                  UNIQUE KEY `idx_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member`
--

LOCK TABLES `reagent_member` WRITE;
/*!40000 ALTER TABLE `reagent_member` DISABLE KEYS */;
INSERT INTO `reagent_member` VALUES (10,4,'test','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','windir','18061581849',1,'2018-08-02 10:35:44',NULL,1,'2009-06-01','上海','学生','test',NULL,5000,NULL,NULL,NULL),(11,4,'windy','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','windy','18061581848',1,'2018-08-03 16:46:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,4,'zhengsan','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','zhengsan','18061581847',1,'2018-11-12 14:12:04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,4,'lisi','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','lisi','18061581841',1,'2018-11-12 14:12:38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,4,'wangwu','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','wangwu','18061581842',1,'2018-11-12 14:13:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,4,'lion','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','lion','18061581845',1,'2018-11-12 14:21:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,4,'shari','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','shari','18061581844',1,'2018-11-12 14:22:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,4,'aewen','$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG','aewen','18061581843',1,'2018-11-12 14:22:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_level`
--

DROP TABLE IF EXISTS `reagent_member_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_level` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                        `name` varchar(100) DEFAULT NULL,
                                        `growth_point` int(11) DEFAULT NULL,
                                        `default_status` int(1) DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
                                        `free_freight_point` decimal(10,2) DEFAULT NULL COMMENT '免运费标准',
                                        `comment_growth_point` int(11) DEFAULT NULL COMMENT '每次评价获取的成长值',
                                        `priviledge_free_freight` int(1) DEFAULT NULL COMMENT '是否有免邮特权',
                                        `priviledge_sign_in` int(1) DEFAULT NULL COMMENT '是否有签到特权',
                                        `priviledge_comment` int(1) DEFAULT NULL COMMENT '是否有评论获奖励特权',
                                        `priviledge_promotion` int(1) DEFAULT NULL COMMENT '是否有专享活动特权',
                                        `priviledge_member_price` int(1) DEFAULT NULL COMMENT '是否有会员价格特权',
                                        `priviledge_birthday` int(1) DEFAULT NULL COMMENT '是否有生日特权',
                                        `note` varchar(200) DEFAULT NULL,
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员等级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_level`
--

LOCK TABLES `reagent_member_level` WRITE;
/*!40000 ALTER TABLE `reagent_member_level` DISABLE KEYS */;
INSERT INTO `reagent_member_level` VALUES (5,'黄金会员',1000,0,199.00,5,1,1,1,1,1,1,NULL),(6,'白金会员',5000,0,99.00,10,1,1,1,1,1,1,NULL),(7,'钻石会员',15000,0,69.00,15,1,1,1,1,1,1,NULL),(8,'普通会员',1,1,199.00,20,1,1,1,1,0,0,NULL);
/*!40000 ALTER TABLE `reagent_member_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_login_log`
--

DROP TABLE IF EXISTS `reagent_member_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_login_log` (
                                            `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                            `member_id` bigint(20) DEFAULT NULL,
                                            `create_time` datetime DEFAULT NULL,
                                            `ip` varchar(64) DEFAULT NULL,
                                            `city` varchar(64) DEFAULT NULL,
                                            `login_type` int(1) DEFAULT NULL COMMENT '登录类型：0->PC；1->android;2->ios;3->小程序',
                                            `province` varchar(64) DEFAULT NULL,
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员登录记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_login_log`
--

LOCK TABLES `reagent_member_login_log` WRITE;
/*!40000 ALTER TABLE `reagent_member_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_member_tag_relation`
--

DROP TABLE IF EXISTS `reagent_member_member_tag_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_member_tag_relation` (
                                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                      `member_id` bigint(20) DEFAULT NULL,
                                                      `tag_id` bigint(20) DEFAULT NULL,
                                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户和标签关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_member_tag_relation`
--

LOCK TABLES `reagent_member_member_tag_relation` WRITE;
/*!40000 ALTER TABLE `reagent_member_member_tag_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_member_tag_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_product_category_relation`
--

DROP TABLE IF EXISTS `reagent_member_product_category_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_product_category_relation` (
                                                            `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                            `member_id` bigint(20) DEFAULT NULL,
                                                            `product_category_id` bigint(20) DEFAULT NULL,
                                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员与产品分类关系表（用户喜欢的分类）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_product_category_relation`
--

LOCK TABLES `reagent_member_product_category_relation` WRITE;
/*!40000 ALTER TABLE `reagent_member_product_category_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_product_category_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_receive_address`
--

DROP TABLE IF EXISTS `reagent_member_receive_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_receive_address` (
                                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                  `member_id` bigint(20) DEFAULT NULL,
                                                  `name` varchar(100) DEFAULT NULL COMMENT '收货人名称',
                                                  `phone_number` varchar(64) DEFAULT NULL,
                                                  `default_status` int(1) DEFAULT NULL COMMENT '是否为默认',
                                                  `post_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
                                                  `province` varchar(100) DEFAULT NULL COMMENT '省份/直辖市',
                                                  `city` varchar(100) DEFAULT NULL COMMENT '城市',
                                                  `region` varchar(100) DEFAULT NULL COMMENT '区',
                                                  `detail_address` varchar(128) DEFAULT NULL COMMENT '详细地址(街道)',
                                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员收货地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_receive_address`
--

LOCK TABLES `reagent_member_receive_address` WRITE;
/*!40000 ALTER TABLE `reagent_member_receive_address` DISABLE KEYS */;
INSERT INTO `reagent_member_receive_address` VALUES (5,1,'大梨','18033441849',0,'518000','广东省','深圳市','南山区','科兴科学园'),(6,1,'大梨','18033441849',0,'518000','广东省','深圳市','福田区','清水河街道'),(7,1,'大梨','18033441849',1,'518000','广东省','深圳市','福田区','东晓街道');
/*!40000 ALTER TABLE `reagent_member_receive_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_rule_setting`
--

DROP TABLE IF EXISTS `reagent_member_rule_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_rule_setting` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                               `continue_sign_day` int(11) DEFAULT NULL COMMENT '连续签到天数',
                                               `continue_sign_point` int(11) DEFAULT NULL COMMENT '连续签到赠送数量',
                                               `consume_per_point` decimal(10,2) DEFAULT NULL COMMENT '每消费多少元获取1个点',
                                               `low_order_amount` decimal(10,2) DEFAULT NULL COMMENT '最低获取点数的订单金额',
                                               `max_point_per_order` int(11) DEFAULT NULL COMMENT '每笔订单最高获取点数',
                                               `type` int(1) DEFAULT NULL COMMENT '类型：0->积分规则；1->成长值规则',
                                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员积分成长规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_rule_setting`
--

LOCK TABLES `reagent_member_rule_setting` WRITE;
/*!40000 ALTER TABLE `reagent_member_rule_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_rule_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_statistics_info`
--

DROP TABLE IF EXISTS `reagent_member_statistics_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_statistics_info` (
                                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                  `member_id` bigint(20) DEFAULT NULL,
                                                  `consume_amount` decimal(10,2) DEFAULT NULL COMMENT '累计消费金额',
                                                  `order_count` int(11) DEFAULT NULL COMMENT '订单数量',
                                                  `coupon_count` int(11) DEFAULT NULL COMMENT '优惠券数量',
                                                  `comment_count` int(11) DEFAULT NULL COMMENT '评价数',
                                                  `return_order_count` int(11) DEFAULT NULL COMMENT '退货数量',
                                                  `login_count` int(11) DEFAULT NULL COMMENT '登录次数',
                                                  `attend_count` int(11) DEFAULT NULL COMMENT '关注数量',
                                                  `fans_count` int(11) DEFAULT NULL COMMENT '粉丝数量',
                                                  `collect_product_count` int(11) DEFAULT NULL,
                                                  `collect_subject_count` int(11) DEFAULT NULL,
                                                  `collect_topic_count` int(11) DEFAULT NULL,
                                                  `collect_comment_count` int(11) DEFAULT NULL,
                                                  `invite_friend_count` int(11) DEFAULT NULL,
                                                  `recent_order_time` datetime DEFAULT NULL COMMENT '最后一次下订单时间',
                                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员统计信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_statistics_info`
--

LOCK TABLES `reagent_member_statistics_info` WRITE;
/*!40000 ALTER TABLE `reagent_member_statistics_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_statistics_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_tag`
--

DROP TABLE IF EXISTS `reagent_member_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_tag` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                      `name` varchar(100) DEFAULT NULL,
                                      `finish_order_count` int(11) DEFAULT NULL COMMENT '自动打标签完成订单数量',
                                      `finish_order_amount` decimal(10,2) DEFAULT NULL COMMENT '自动打标签完成订单金额',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_tag`
--

LOCK TABLES `reagent_member_tag` WRITE;
/*!40000 ALTER TABLE `reagent_member_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_member_task`
--

DROP TABLE IF EXISTS `reagent_member_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_member_task` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                       `name` varchar(100) DEFAULT NULL,
                                       `growth` int(11) DEFAULT NULL COMMENT '赠送成长值',
                                       `intergration` int(11) DEFAULT NULL COMMENT '赠送积分',
                                       `type` int(1) DEFAULT NULL COMMENT '任务类型：0->新手任务；1->日常任务',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_member_task`
--

LOCK TABLES `reagent_member_task` WRITE;
/*!40000 ALTER TABLE `reagent_member_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_member_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_menu`
--

DROP TABLE IF EXISTS `reagent_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_menu` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                `title` varchar(100) DEFAULT NULL COMMENT '菜单名称',
                                `level` int(4) DEFAULT NULL COMMENT '菜单级数',
                                `sort` int(4) DEFAULT NULL COMMENT '菜单排序',
                                `name` varchar(100) DEFAULT NULL COMMENT '前端名称',
                                `icon` varchar(200) DEFAULT NULL COMMENT '前端图标',
                                `hidden` int(1) DEFAULT NULL COMMENT '前端隐藏',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_menu`
--

LOCK TABLES `reagent_menu` WRITE;
/*!40000 ALTER TABLE `reagent_menu` DISABLE KEYS */;
INSERT INTO `reagent_menu` VALUES (1,0,'2020-02-02 14:50:36','入库',0,0,'ims','product',0),(2,1,'2020-02-02 14:51:50','入库列表',1,0,'incident','product-list',0),(3,0,'2020-02-07 16:29:13','系统管理',0,0,'ums','ums',0),(4,3,'2020-02-07 16:29:51','用户列表',1,0,'admin','ums-admin',0),(5,3,'2020-02-07 16:30:13','角色列表',1,0,'role','ums-role',0),(6,3,'2020-02-07 16:30:53','菜单列表',1,0,'menu','ums-menu',0),(7,3,'2020-02-07 16:31:13','资源列表',1,0,'resource','ums-resource',0),(8,3,'2021-02-25 17:37:05','科室列表',1,0,'branch','ums-branch',0),(9,3,'2021-02-28 19:40:42','供应商列表',1,0,'supplier','ums-supplier',0),(10,3,'2021-03-03 17:15:51','试剂基础信息',1,0,'baseInfo','ums-baseInfo',0),(11,0,'2021-03-05 09:28:23','订单管理',0,0,'oms','order',0),(12,11,'2021-03-05 09:43:57','订单列表',1,0,'order','product-list',0),(13,11,'2021-03-05 09:50:45','订单设置',1,0,'orderSetting','order-setting',0),(14,0,'2021-03-05 20:55:27','库存管理',0,0,'tms','tms',0),(15,14,'2021-03-05 20:53:19','中心库存列表',1,0,'stockCentre','tms-stockCentre',0),(16,14,'2021-03-05 21:19:20','库损列表',1,0,'stockItem','tms-stockItem',0),(17,14,'2021-03-09 20:49:34','科室库存列表',1,0,'stockBranch','tms-stockBranch',0),(18,11,'2021-03-09 20:57:59','试剂下单',1,0,'placeOrder','place-order',0),(19,11,'2021-03-11 22:02:43','预入库单列表',1,0,'preInBill','oms-preInBill',0),(20,0,'2021-03-22 19:00:09','出库管理',0,0,'dms','dms',0),(21,20,'2021-03-22 19:00:39','中心库出库',1,0,'centreOut','dms-centreOut',0),(22,20,'2021-03-22 19:01:15','科室库出库',1,0,'branchOut','dms-branchOut',0),(23,11,'2021-03-23 20:36:27','预入库单新增',1,0,'preInBillAdd','oms-preInBillAdd',0),(28,1,'2020-02-02 14:52:44','添加事件',1,0,'addIncident','product-add',0),(29,1,'2020-02-02 14:53:51','事件分类',1,0,'productCate','product-cate',0),(30,1,'2021-03-27 17:07:03','搜索',1,1,'search','tms-search',0);
/*!40000 ALTER TABLE `reagent_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_operation_log`
--

DROP TABLE IF EXISTS `reagent_operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_operation_log` (
                                         `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                         `function` varchar(20) DEFAULT NULL COMMENT '功能区分',
                                         `opera_log` varchar(100) DEFAULT NULL COMMENT '操作内容',
                                         `user_id` bigint(20) DEFAULT NULL COMMENT '操作用户ID',
                                         `user_name` varchar(20) DEFAULT NULL COMMENT '操作用户名',
                                         `create_time` datetime DEFAULT NULL,
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_operation_log`
--

LOCK TABLES `reagent_operation_log` WRITE;
/*!40000 ALTER TABLE `reagent_operation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_operation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_order`
--

DROP TABLE IF EXISTS `reagent_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_order` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `order_no` varchar(32) DEFAULT NULL COMMENT '订单号',
                                 `order_day` varchar(50) DEFAULT NULL COMMENT '下单日',
                                 `supplier_id` bigint(16) DEFAULT NULL COMMENT '供货商ID',
                                 `supplier_short_name` varchar(20) DEFAULT NULL COMMENT '供货商名',
                                 `order_price` double(20,2) DEFAULT NULL COMMENT '总价',
  `order_status` tinyint(2) DEFAULT NULL COMMENT '订单状态 0 ：草稿，1：已提交',
  `order_describe` varchar(1000) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(20) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime DEFAULT NULL,
  `delete_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_order`
--

LOCK TABLES `reagent_order` WRITE;
/*!40000 ALTER TABLE `reagent_order` DISABLE KEYS */;
INSERT INTO `reagent_order` VALUES (141,'11616419411923','2021-3-22',42523,'山医',30.00,0,'测试级联删除','admin','2021-03-22 21:23:32',NULL,NULL,NULL,NULL,NULL),(142,'21616422667109','2021-3-22',666,'菏泽医药',59.00,0,NULL,'admin','2021-03-22 22:17:47',NULL,NULL,NULL,NULL,NULL),(143,'91616422754049','2021-3-22',112,'济南医药',39.60,0,NULL,'admin','2021-03-22 22:19:14',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_order_detail`
--

DROP TABLE IF EXISTS `reagent_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_order_detail` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                        `order_no` varchar(32) DEFAULT NULL COMMENT '订单号',
                                        `reagent_code` varchar(255) DEFAULT NULL COMMENT '试剂编号',
                                        `reagent_name` varchar(30) DEFAULT NULL COMMENT '试剂名',
                                        `reagent_number` bigint(20) DEFAULT NULL COMMENT '订货数量',
                                        `unit` varchar(16) DEFAULT NULL COMMENT '订货单位',
                                        `price` double(16,2) DEFAULT NULL COMMENT '单价',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(20) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime DEFAULT NULL,
  `delete_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_order_detail`
--

LOCK TABLES `reagent_order_detail` WRITE;
/*!40000 ALTER TABLE `reagent_order_detail` DISABLE KEYS */;
INSERT INTO `reagent_order_detail` VALUES (172,'11616419411923','324','西瓜霜',2,'盒',6.00,'2021-03-22 21:23:32',NULL,NULL,NULL,NULL,NULL,NULL),(173,'21616422667109','328','盖中盖',4,'盒',8.00,'2021-03-22 22:17:47',NULL,NULL,NULL,NULL,NULL,NULL),(174,'21616422667109','329','人参',3,'盒',9.00,'2021-03-22 22:17:47',NULL,NULL,NULL,NULL,NULL,NULL),(175,'91616422754049','340','晕车药',2,'盒',19.80,'2021-03-22 22:19:14',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_out_bill`
--

DROP TABLE IF EXISTS `reagent_out_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_out_bill` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `code` varchar(32) DEFAULT NULL COMMENT '出库单编号',
                                    `bill_type` varchar(1) DEFAULT NULL COMMENT '出库单种类：1 出库申请单， 2 中心库出库单，2 2级库出库单，',
                                    `bill_date` date DEFAULT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为做成日期）',
                                    `bill_status` tinyint(1) DEFAULT '0' COMMENT '单据状态：0-草稿，1-已完结 ',
                                    `bill_creator` varchar(20) DEFAULT NULL COMMENT '制单人',
                                    `remark` varchar(255) DEFAULT '' COMMENT '备注',
                                    `branch_id` bigint(20) DEFAULT NULL COMMENT '申请科室ID',
                                    `branch_name` varchar(20) DEFAULT NULL COMMENT '申请科室名',
                                    `stock_day` date DEFAULT NULL COMMENT '出库预定日',
                                    `application_date` date DEFAULT NULL COMMENT '申请日',
                                    `application_user` varchar(20) DEFAULT NULL COMMENT '申请人',
                                    `consumer_id` bigint(20) DEFAULT NULL COMMENT '使用者',
                                    `create_time` datetime DEFAULT NULL,
                                    `create_by` varchar(20) DEFAULT NULL,
                                    `update_time` datetime DEFAULT NULL,
                                    `update_by` varchar(20) DEFAULT NULL,
                                    `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                    `delete_time` datetime DEFAULT NULL,
                                    `delete_by` varchar(20) DEFAULT NULL,
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='出库单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_out_bill`
--

LOCK TABLES `reagent_out_bill` WRITE;
/*!40000 ALTER TABLE `reagent_out_bill` DISABLE KEYS */;
INSERT INTO `reagent_out_bill` VALUES (1,'1','1','2021-03-16',0,'季','3',123,NULL,'2021-03-16','2021-03-16','1',NULL,'2021-03-16 15:40:29',NULL,NULL,NULL,0,NULL,NULL),(2,'2','2','2021-03-16',0,'季','3',123,NULL,'2021-03-16','2021-03-16','1',NULL,'2021-03-16 15:40:29',NULL,NULL,NULL,0,NULL,NULL),(3,'3','1','2021-03-16',0,'季','3',123,NULL,'2021-03-16','2021-03-16','1',NULL,'2021-03-16 15:40:29',NULL,NULL,NULL,0,NULL,NULL),(12,'AAAA','2','2021-05-05',1,'admin',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-05 11:42:10',NULL,NULL,NULL,NULL),(13,'AAAA','2','2021-05-05',1,'admin',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-05 11:50:41',NULL,NULL,NULL,NULL),(14,'AAAA','2','2021-05-05',1,'admin',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-05 11:53:44',NULL,NULL,NULL,NULL),(15,'AAAA','2','2021-05-05',1,'admin',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-05 14:46:41',NULL,NULL,NULL,NULL),(16,'AAAA','2','2021-05-05',1,'admin',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-05 14:50:59',NULL,NULL,NULL,NULL),(17,'AAAA','2','2021-05-05',1,'admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-05 16:10:52',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_out_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_out_detail`
--

DROP TABLE IF EXISTS `reagent_out_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_out_detail` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                      `out_bill_id` bigint(20) NOT NULL COMMENT '出库单ID',
                                      `reagent_id` bigint(20) NOT NULL COMMENT '试剂ID',
                                      `reagent_name` varchar(50) DEFAULT NULL COMMENT '试剂名称',
                                      `reagent_unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                      `reagent_specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                      `quantity` bigint(20) DEFAULT NULL COMMENT '数量',
                                      `batch_no` varchar(16) DEFAULT NULL COMMENT '批号',
                                      `expire_date` date DEFAULT NULL COMMENT '保质期',
                                      `remark` varchar(255) DEFAULT '' COMMENT '备注',
                                      `create_time` datetime NOT NULL,
                                      `create_by` varchar(20) NOT NULL,
                                      `update_time` datetime DEFAULT NULL,
                                      `update_by` varchar(20) DEFAULT NULL,
                                      `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                      `delete_time` datetime DEFAULT NULL,
                                      `delete_by` varchar(20) DEFAULT NULL,
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='出库单详细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_out_detail`
--

LOCK TABLES `reagent_out_detail` WRITE;
/*!40000 ALTER TABLE `reagent_out_detail` DISABLE KEYS */;
INSERT INTO `reagent_out_detail` VALUES (1,1,111,'aaa','xxx','xxx',100,'111','2021-03-22','1','2021-03-22 20:28:14','1','2021-03-22 20:28:21','1',0,'2021-03-22 20:28:24','1'),(2,2,111,'aaa','xxx','xxx',100,'111','2021-03-22','1','2021-03-22 20:28:14','1','2021-03-22 20:28:21','1',0,'2021-03-22 20:28:24','1'),(3,3,111,'aaa','xxx','xxx',100,'111','2021-03-22','1','2021-03-22 20:28:14','1','2021-03-22 20:28:21','1',0,'2021-03-22 20:28:24','1'),(7,12,2,NULL,NULL,NULL,1,'20210322','2022-01-01',NULL,'2021-05-05 11:42:13','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL),(8,13,1,NULL,NULL,NULL,2,'20210321','2022-01-01',NULL,'2021-05-05 11:50:53','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL),(9,14,1,NULL,NULL,NULL,2,'20210321','2022-01-01',NULL,'2021-05-05 11:53:44','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL),(10,15,1,NULL,NULL,NULL,2,'20210321','2022-01-01',NULL,'2021-05-05 14:46:41','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL),(11,16,2,NULL,NULL,NULL,1,'20210322','2022-01-01',NULL,'2021-05-05 14:50:59','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL),(12,17,2,NULL,NULL,NULL,1,'20210322','2022-01-01',NULL,'2021-05-05 16:10:52','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_out_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_out_detail_item`
--

DROP TABLE IF EXISTS `reagent_out_detail_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_out_detail_item` (
                                           `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                           `out_detail_id` bigint(20) NOT NULL COMMENT '试剂详细ID',
                                           `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                           `status` varchar(1) NOT NULL COMMENT '状态',
                                           `create_time` datetime NOT NULL,
                                           `create_by` varchar(20) NOT NULL,
                                           `update_time` datetime NOT NULL,
                                           `update_by` varchar(20) NOT NULL,
                                           `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                           `delete_time` datetime DEFAULT NULL,
                                           `delete_by` varchar(20) DEFAULT NULL,
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材出库单个体';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_out_detail_item`
--

LOCK TABLES `reagent_out_detail_item` WRITE;
/*!40000 ALTER TABLE `reagent_out_detail_item` DISABLE KEYS */;
INSERT INTO `reagent_out_detail_item` VALUES (1,7,'20210302-01','1','2021-05-05 11:42:14','admin','2021-05-05 11:42:14','admin',0,NULL,NULL),(2,8,'20210301-01','1','2021-05-05 11:51:06','admin','2021-05-05 11:51:06','admin',0,NULL,NULL),(3,8,'20210301-02','1','2021-05-05 11:51:14','admin','2021-05-05 11:51:14','admin',0,NULL,NULL),(4,9,'20210301-01','1','2021-05-05 11:53:44','admin','2021-05-05 11:53:44','admin',0,NULL,NULL),(5,9,'20210301-02','1','2021-05-05 11:55:13','admin','2021-05-05 11:55:14','admin',0,NULL,NULL),(6,10,'20210301-01','1','2021-05-05 14:46:41','admin','2021-05-05 14:46:41','admin',0,NULL,NULL),(7,10,'20210301-02','1','2021-05-05 14:46:52','admin','2021-05-05 14:46:52','admin',0,NULL,NULL),(8,11,'20210302-01','1','2021-05-05 14:50:59','admin','2021-05-05 14:50:59','admin',0,NULL,NULL),(9,12,'20210302-01','1','2021-05-05 16:10:52','admin','2021-05-05 16:10:52','admin',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_out_detail_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_permission`
--

DROP TABLE IF EXISTS `reagent_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_permission` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                      `pid` bigint(20) DEFAULT NULL COMMENT '父级权限id',
                                      `name` varchar(100) DEFAULT NULL COMMENT '名称',
                                      `value` varchar(200) DEFAULT NULL COMMENT '权限值',
                                      `icon` varchar(500) DEFAULT NULL COMMENT '图标',
                                      `type` int(1) DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
                                      `uri` varchar(200) DEFAULT NULL COMMENT '前端资源路径',
                                      `status` int(1) DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
                                      `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                      `sort` int(11) DEFAULT NULL COMMENT '排序',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_permission`
--

LOCK TABLES `reagent_permission` WRITE;
/*!40000 ALTER TABLE `reagent_permission` DISABLE KEYS */;
INSERT INTO `reagent_permission` VALUES (24,0,'商品',NULL,NULL,0,NULL,1,'2018-09-29 16:15:14',0),(25,1,'商品列表','pms:product:read',NULL,1,'/pms/product/index',1,'2018-09-29 16:17:01',0),(26,1,'添加商品','pms:product:create',NULL,1,'/pms/product/add',1,'2018-09-29 16:18:51',0),(27,1,'商品分类','pms:productCategory:read',NULL,1,'/pms/productCate/index',1,'2018-09-29 16:23:07',0),(28,1,'商品类型','pms:productAttribute:read',NULL,1,'/pms/productAttr/index',1,'2018-09-29 16:24:43',0),(29,1,'品牌管理','pms:brand:read',NULL,1,'/pms/brand/index',1,'2018-09-29 16:25:45',0),(30,2,'编辑商品','pms:product:update',NULL,2,'/pms/product/updateProduct',1,'2018-09-29 16:34:23',0),(31,2,'删除商品','pms:product:delete',NULL,2,'/pms/product/delete',1,'2018-09-29 16:38:33',0),(32,4,'添加商品分类','pms:productCategory:create',NULL,2,'/pms/productCate/create',1,'2018-09-29 16:43:23',0),(33,4,'修改商品分类','pms:productCategory:update',NULL,2,'/pms/productCate/update',1,'2018-09-29 16:43:55',0),(34,4,'删除商品分类','pms:productCategory:delete',NULL,2,'/pms/productAttr/delete',1,'2018-09-29 16:44:38',0),(35,5,'添加商品类型','pms:productAttribute:create',NULL,2,'/pms/productAttr/create',1,'2018-09-29 16:45:25',0),(36,5,'修改商品类型','pms:productAttribute:update',NULL,2,'/pms/productAttr/update',1,'2018-09-29 16:48:08',0),(37,5,'删除商品类型','pms:productAttribute:delete',NULL,2,'/pms/productAttr/delete',1,'2018-09-29 16:48:44',0),(38,6,'添加品牌','pms:brand:create',NULL,2,'/pms/brand/add',1,'2018-09-29 16:49:34',0),(39,6,'修改品牌','pms:brand:update',NULL,2,'/pms/brand/update',1,'2018-09-29 16:50:55',0),(40,6,'删除品牌','pms:brand:delete',NULL,2,'/pms/brand/delete',1,'2018-09-29 16:50:59',0),(41,0,'首页',NULL,NULL,0,NULL,1,'2018-09-29 16:51:57',0),(42,1,'事件列表','ims:incident:read','',1,'/ims/incident/index',1,'2018-09-29 16:17:01',0),(43,1,'添加事件','ims:incident:create','',1,'/ims/incident/add',1,'2018-09-29 16:18:51',0),(44,2,'编辑事件','ims:incident:update','',2,'/ims/incident/update',1,'2018-09-29 16:34:23',0),(45,2,'删除事件','ims:incident:delete','',2,'/ims/incident/delete',1,'2018-09-29 16:38:33',0);
/*!40000 ALTER TABLE `reagent_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_pre_in_bill`
--

DROP TABLE IF EXISTS `reagent_pre_in_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_pre_in_bill` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                       `code` varchar(32) NOT NULL COMMENT '入库单编号',
                                       `bill_type` varchar(1) DEFAULT NULL COMMENT '入库单种类：1 预入库单， 2 入库单',
                                       `suppiler_id` bigint(20) NOT NULL COMMENT '供货商ID',
                                       `suppiler_short_name` varchar(20) NOT NULL COMMENT '供货商名',
                                       `bill_date` date NOT NULL COMMENT '单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为入库日期）',
                                       `bill_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '单据状态：0-草稿，1-已入库 ',
                                       `bill_creator` varchar(20) NOT NULL COMMENT '制单人',
                                       `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                       `create_time` datetime DEFAULT NULL,
                                       `create_by` varchar(20) DEFAULT NULL,
                                       `update_time` datetime DEFAULT NULL,
                                       `update_by` varchar(20) DEFAULT NULL,
                                       `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                       `delete_time` datetime DEFAULT NULL,
                                       `delete_by` varchar(20) DEFAULT NULL,
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材入库申请单（接收单）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_pre_in_bill`
--

LOCK TABLES `reagent_pre_in_bill` WRITE;
/*!40000 ALTER TABLE `reagent_pre_in_bill` DISABLE KEYS */;
INSERT INTO `reagent_pre_in_bill` VALUES (3,'71616637904944','1',999,'admin','2021-03-25',0,'admin','第一次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'61616638046078','1',999,'admin','2021-03-25',0,'admin','第二次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'61616638545179','1',999,'admin','2021-03-25',0,'admin','第三次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'11616638760384','1',999,'admin','2021-03-25',0,'admin','第四次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'91616639801831','1',999,'admin','2021-03-25',0,'admin','第五次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_pre_in_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_pre_in_detail`
--

DROP TABLE IF EXISTS `reagent_pre_in_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_pre_in_detail` (
                                         `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                         `in_bill_id` varchar(20) NOT NULL COMMENT '入库单ID',
                                         `reagent_id` varchar(20) NOT NULL COMMENT '试剂ID',
                                         `reagent_name` varchar(50) NOT NULL COMMENT '试剂名称',
                                         `reagent_unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                         `reagent_specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                         `price` double(20,2) DEFAULT NULL COMMENT '价格',
  `quantity` bigint(20) DEFAULT NULL COMMENT '数量',
  `total` double(20,2) DEFAULT NULL COMMENT '金额',
  `batch_no` varchar(16) DEFAULT NULL COMMENT '批号',
  `expire_date` date DEFAULT NULL COMMENT '保质期',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(20) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
  `delete_time` datetime DEFAULT NULL,
  `delete_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材入库申请单详细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_pre_in_detail`
--

LOCK TABLES `reagent_pre_in_detail` WRITE;
/*!40000 ALTER TABLE `reagent_pre_in_detail` DISABLE KEYS */;
INSERT INTO `reagent_pre_in_detail` VALUES (1,'61616638046078','341','可口可乐','瓶','500ML',NULL,1,3.00,NULL,NULL,'第二次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'61616638545179','341','可口可乐','瓶','500ML',3.00,6,21.00,'2021325','1970-01-01','第三次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'11616638760384','341','可口可乐','瓶','500ML',3.20,3,10.50,'2021325','1970-01-01','第四次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'91616639801831','341','可口可乐','瓶','500ML',3.20,3,9.60,'2021325','1970-01-01','第五次测试',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_pre_in_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_pre_in_detail_item`
--

DROP TABLE IF EXISTS `reagent_pre_in_detail_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_pre_in_detail_item` (
                                              `id` bigint(20) NOT NULL COMMENT 'id',
                                              `in_detail_id` varchar(20) NOT NULL COMMENT '入库单详细ID',
                                              `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                              `status` varchar(1) NOT NULL COMMENT '状态',
                                              `create_time` datetime NOT NULL,
                                              `create_by` varchar(20) NOT NULL,
                                              `update_time` datetime NOT NULL,
                                              `update_by` varchar(20) NOT NULL,
                                              `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                              `delete_time` datetime DEFAULT NULL,
                                              `delete_by` varchar(20) DEFAULT NULL,
                                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材入库申请单个体';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_pre_in_detail_item`
--

LOCK TABLES `reagent_pre_in_detail_item` WRITE;
/*!40000 ALTER TABLE `reagent_pre_in_detail_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_pre_in_detail_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_refund_detail`
--

DROP TABLE IF EXISTS `reagent_refund_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_refund_detail` (
                                         `id` bigint(20) NOT NULL COMMENT 'id',
                                         `in_bill_id` bigint(20) NOT NULL COMMENT '入库单ID',
                                         `reagent_id` bigint(20) NOT NULL COMMENT '试剂ID',
                                         `reagent_name` varchar(50) NOT NULL COMMENT '试剂名称',
                                         `reagent_unit` varchar(16) DEFAULT NULL COMMENT '单位',
                                         `reagent_specification` varchar(32) DEFAULT NULL COMMENT '规格型号',
                                         `price` bigint(20) DEFAULT NULL COMMENT '价格',
                                         `quantity` bigint(20) DEFAULT NULL COMMENT '数量',
                                         `total` bigint(20) DEFAULT NULL COMMENT '金额',
                                         `batch_no` varchar(16) DEFAULT NULL COMMENT '批号',
                                         `expire_date` date NOT NULL COMMENT '保质期',
                                         `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                         `create_time` datetime NOT NULL,
                                         `create_by` varchar(20) NOT NULL,
                                         `update_time` datetime NOT NULL,
                                         `update_by` varchar(20) NOT NULL,
                                         `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                         `delete_time` datetime DEFAULT NULL,
                                         `delete_by` varchar(20) DEFAULT NULL,
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='退货单详细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_refund_detail`
--

LOCK TABLES `reagent_refund_detail` WRITE;
/*!40000 ALTER TABLE `reagent_refund_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_refund_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_refund_detail_item`
--

DROP TABLE IF EXISTS `reagent_refund_detail_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_refund_detail_item` (
                                              `id` bigint(20) NOT NULL COMMENT 'id',
                                              `in_detail_id` bigint(20) NOT NULL COMMENT '入库单详细ID',
                                              `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                              `status` varchar(1) NOT NULL COMMENT '状态',
                                              `create_time` datetime NOT NULL,
                                              `create_by` varchar(20) NOT NULL,
                                              `update_time` datetime NOT NULL,
                                              `update_by` varchar(20) NOT NULL,
                                              `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                              `delete_time` datetime DEFAULT NULL,
                                              `delete_by` varchar(20) DEFAULT NULL,
                                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='退货单个体';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_refund_detail_item`
--

LOCK TABLES `reagent_refund_detail_item` WRITE;
/*!40000 ALTER TABLE `reagent_refund_detail_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `reagent_refund_detail_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_resource`
--

DROP TABLE IF EXISTS `reagent_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_resource` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    `name` varchar(200) DEFAULT NULL COMMENT '资源名称',
                                    `url` varchar(200) DEFAULT NULL COMMENT '资源URL',
                                    `description` varchar(500) DEFAULT NULL COMMENT '描述',
                                    `category_id` bigint(20) DEFAULT NULL COMMENT '资源分类ID',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_resource`
--

LOCK TABLES `reagent_resource` WRITE;
/*!40000 ALTER TABLE `reagent_resource` DISABLE KEYS */;
INSERT INTO `reagent_resource` VALUES (31,'2020-02-04 17:04:55','商品品牌管理','/brand/**',NULL,1),(32,'2020-02-04 17:05:35','商品属性分类管理','/productAttribute/**',NULL,1),(33,'2020-02-04 17:06:13','商品属性管理','/productAttribute/**',NULL,1),(34,'2020-02-04 17:07:15','商品分类管理','/productCategory/**',NULL,1),(35,'2020-02-04 17:09:16','商品管理','/product/**',NULL,1),(36,'2020-02-04 17:09:53','商品库存管理','/sku/**',NULL,1),(37,'2020-02-05 14:43:37','订单管理','/order/**','',2),(38,'2020-02-05 14:44:22',' 订单退货申请管理','/returnApply/**','',2),(39,'2020-02-05 14:45:08','退货原因管理','/returnReason/**','',2),(40,'2020-02-05 14:45:43','订单设置管理','/orderSetting/**','',2),(41,'2020-02-05 14:46:23','收货地址管理','/companyAddress/**','',2),(42,'2020-02-07 16:37:22','优惠券管理','/coupon/**','',3),(43,'2020-02-07 16:37:59','优惠券领取记录管理','/couponHistory/**','',3),(44,'2020-02-07 16:38:28','限时购活动管理','/flash/**','',3),(45,'2020-02-07 16:38:59','限时购商品关系管理','/flashProductRelation/**','',3),(46,'2020-02-07 16:39:22','限时购场次管理','/flashSession/**','',3),(47,'2020-02-07 16:40:07','首页轮播广告管理','/home/advertise/**','',3),(48,'2020-02-07 16:40:34','首页品牌管理','/home/brand/**','',3),(49,'2020-02-07 16:41:06','首页新品管理','/home/newProduct/**','',3),(50,'2020-02-07 16:42:16','首页人气推荐管理','/home/recommendProduct/**','',3),(51,'2020-02-07 16:42:48','首页专题推荐管理','/home/recommendSubject/**','',3),(52,'2020-02-07 16:44:56',' 商品优选管理','/prefrenceArea/**','',5),(53,'2020-02-07 16:45:39','商品专题管理','/subject/**','',5),(54,'2020-02-07 16:47:34','后台用户管理','/admin/**','',4),(55,'2020-02-07 16:48:24','后台用户角色管理','/role/**','',4),(56,'2020-02-07 16:48:48','后台菜单管理','/menu/**','',4),(57,'2020-02-07 16:49:18','后台资源分类管理','/resourceCategory/**','',4),(58,'2020-02-07 16:49:45','后台资源管理','/resource/**','',4),(59,'2020-02-04 17:09:16','事件管理','/incident/**','',1);
/*!40000 ALTER TABLE `reagent_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_resource_category`
--

DROP TABLE IF EXISTS `reagent_resource_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_resource_category` (
                                             `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                             `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
                                             `sort` int(4) DEFAULT NULL COMMENT '排序',
                                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='资源分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_resource_category`
--

LOCK TABLES `reagent_resource_category` WRITE;
/*!40000 ALTER TABLE `reagent_resource_category` DISABLE KEYS */;
INSERT INTO `reagent_resource_category` VALUES (7,'2020-02-05 10:21:44','商品模块',0),(8,'2020-02-05 10:22:34','订单模块',0),(9,'2020-02-05 10:22:48','营销模块',0),(10,'2020-02-05 10:23:04','权限模块',0),(11,'2020-02-07 16:34:27','内容模块',0),(12,'2020-02-07 16:35:49','其他模块',0);
/*!40000 ALTER TABLE `reagent_resource_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_role`
--

DROP TABLE IF EXISTS `reagent_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_role` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                `name` varchar(100) DEFAULT NULL COMMENT '名称',
                                `description` varchar(500) DEFAULT NULL COMMENT '描述',
                                `admin_count` int(11) DEFAULT NULL COMMENT '后台用户数量',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                `status` int(1) DEFAULT '1' COMMENT '启用状态：0->禁用；1->启用',
                                `sort` int(11) DEFAULT '0',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_role`
--

LOCK TABLES `reagent_role` WRITE;
/*!40000 ALTER TABLE `reagent_role` DISABLE KEYS */;
INSERT INTO `reagent_role` VALUES (1,'系统管理员','系统维护',0,NULL,1,0),(2,'中心库管理员','一级库管理',0,NULL,1,0),(3,'科室管理员','2级库管理',0,NULL,1,0),(4,'试剂操作员','试剂使用',0,NULL,1,0),(5,'供货商','进货',0,NULL,1,0);
/*!40000 ALTER TABLE `reagent_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_role_menu_relation`
--

DROP TABLE IF EXISTS `reagent_role_menu_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_role_menu_relation` (
                                              `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                              `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
                                              `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
                                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色菜单关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_role_menu_relation`
--

LOCK TABLES `reagent_role_menu_relation` WRITE;
/*!40000 ALTER TABLE `reagent_role_menu_relation` DISABLE KEYS */;
INSERT INTO `reagent_role_menu_relation` VALUES (96,1,1),(97,1,2),(98,1,3),(99,1,4),(100,1,5),(101,1,6),(102,1,8),(103,1,9),(104,1,10),(105,1,11),(106,1,12),(107,1,13),(108,1,14),(109,1,15),(110,1,16),(111,1,17),(112,1,18),(113,1,19),(114,1,20),(115,1,21),(116,1,22),(117,1,23),(118,1,30);
/*!40000 ALTER TABLE `reagent_role_menu_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_role_permission_relation`
--

DROP TABLE IF EXISTS `reagent_role_permission_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_role_permission_relation` (
                                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                    `role_id` bigint(20) DEFAULT NULL,
                                                    `permission_id` bigint(20) DEFAULT NULL,
                                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户角色和权限关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_role_permission_relation`
--

LOCK TABLES `reagent_role_permission_relation` WRITE;
/*!40000 ALTER TABLE `reagent_role_permission_relation` DISABLE KEYS */;
INSERT INTO `reagent_role_permission_relation` VALUES (18,1,1),(19,1,2),(20,1,3),(21,1,7),(22,1,8),(23,2,4),(24,2,9),(25,2,10),(26,2,11),(27,3,5),(28,3,12),(29,3,13),(30,3,14),(31,4,6),(32,4,15),(33,4,16),(34,4,17);
/*!40000 ALTER TABLE `reagent_role_permission_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_role_resource_relation`
--

DROP TABLE IF EXISTS `reagent_role_resource_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_role_resource_relation` (
                                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
                                                  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
                                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色资源关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_role_resource_relation`
--

LOCK TABLES `reagent_role_resource_relation` WRITE;
/*!40000 ALTER TABLE `reagent_role_resource_relation` DISABLE KEYS */;
INSERT INTO `reagent_role_resource_relation` VALUES (178,2,8),(179,2,9),(180,2,10),(181,2,11),(182,2,12),(183,5,1),(184,5,2),(185,5,3),(186,5,4),(187,5,5),(188,5,6),(189,5,8),(190,5,9),(191,5,10),(192,5,11),(193,5,12),(194,5,13),(195,5,14),(196,5,15),(197,5,16),(198,5,17),(199,5,18),(200,5,19),(201,5,20),(202,5,21),(203,5,22),(204,5,23),(205,5,24),(206,5,25),(207,5,26),(208,5,27),(209,5,28),(210,5,29),(211,1,1),(212,1,2),(213,1,3),(214,1,4),(215,1,5),(216,1,54),(217,1,55),(218,1,56);
/*!40000 ALTER TABLE `reagent_role_resource_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_search`
--

DROP TABLE IF EXISTS `reagent_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_search` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `groupname` varchar(20) DEFAULT NULL COMMENT '角色ID',
                                  `kind` varchar(20) DEFAULT NULL COMMENT '菜单ID',
                                  `placename` varchar(255) DEFAULT NULL,
                                  `detail` varchar(255) DEFAULT NULL,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色菜单关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_search`
--

LOCK TABLES `reagent_search` WRITE;
/*!40000 ALTER TABLE `reagent_search` DISABLE KEYS */;
INSERT INTO `reagent_search` VALUES (1,'00001','0','asas','sasas'),(2,'00001','0','sdfsdf','sdfd'),(3,'00001','0','sdfs','sdfs'),(4,'00002','1','sadfs','sdf'),(5,'00002','1','asdfs','sdf'),(6,'11113','1','sdfg','sgf'),(7,'11113','444','sdfs','sf');
/*!40000 ALTER TABLE `reagent_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_stock`
--

DROP TABLE IF EXISTS `reagent_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_stock` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                 `branch_id` bigint(20) DEFAULT NULL COMMENT '科室ID ',
                                 `reagent_id` bigint(20) NOT NULL COMMENT '试剂耗材ID',
                                 `batch_no` varchar(32) NOT NULL COMMENT '系统批号',
                                 `expire_date` date NOT NULL COMMENT '到期日期',
                                 `quantity` bigint(20) NOT NULL COMMENT '库存数量',
                                 `create_time` datetime NOT NULL,
                                 `create_by` varchar(20) NOT NULL,
                                 `update_time` datetime NOT NULL,
                                 `update_by` varchar(20) NOT NULL,
                                 `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                 `delete_time` datetime DEFAULT NULL,
                                 `delete_by` varchar(20) DEFAULT NULL,
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_stock`
--

LOCK TABLES `reagent_stock` WRITE;
/*!40000 ALTER TABLE `reagent_stock` DISABLE KEYS */;
INSERT INTO `reagent_stock` VALUES (10,0,1,'20210321','2022-01-01',2,'2021-05-05 11:20:25','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL),(11,0,2,'20210322','2022-01-01',1,'2021-05-05 11:20:25','zhao','2021-05-05 11:20:25','zhao',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_stock_branch`
--

DROP TABLE IF EXISTS `reagent_stock_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_stock_branch` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                        `stock_no` varchar(20) DEFAULT NULL COMMENT '库存编号',
                                        `reagent_id` varchar(20) NOT NULL COMMENT '试剂耗材ID',
                                        `quantity` decimal(20,4) NOT NULL COMMENT '库存数量',
                                        `create_time` datetime NOT NULL,
                                        `create_by` varchar(20) NOT NULL,
                                        `update_time` datetime NOT NULL,
                                        `update_by` varchar(20) NOT NULL,
                                        `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                        `delete_time` datetime DEFAULT NULL,
                                        `delete_by` varchar(20) DEFAULT NULL,
                                        `reagent_name` varchar(20) DEFAULT NULL COMMENT '试剂名称',
                                        `reagent_type` varchar(20) DEFAULT NULL COMMENT '型号规格',
                                        `factory` varchar(20) DEFAULT NULL COMMENT '生产厂家',
                                        `supplier_name` varchar(20) DEFAULT NULL COMMENT '供货商',
                                        `reagent_status` varchar(20) DEFAULT NULL COMMENT '状态',
                                        `reagent_unit` varchar(20) DEFAULT NULL COMMENT '单位',
                                        `reagent_temp` varchar(20) DEFAULT NULL COMMENT '存储温度',
                                        `overdue` bigint(20) DEFAULT NULL COMMENT '过期预警',
                                        `low_stock` bigint(20) DEFAULT NULL COMMENT '低库存预警',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_stock_branch`
--

LOCK TABLES `reagent_stock_branch` WRITE;
/*!40000 ALTER TABLE `reagent_stock_branch` DISABLE KEYS */;
INSERT INTO `reagent_stock_branch` VALUES (1,'11111','22222',100.0000,'2021-03-15 19:18:33','1','2021-03-15 19:18:36','1',0,'2021-03-15 19:18:40','1','aaa','1','bbb','ccc','ddd','eee','fff',1,1),(2,'11112','22223',100.0000,'2021-03-15 19:18:33','1','2021-03-15 19:18:36','1',0,'2021-03-15 19:18:40','1','aaa','1','bbd','ccc','dda','eee','fff',1,1),(3,'11113','22224',100.0000,'2021-03-15 19:18:33','1','2021-03-15 19:18:36','1',0,'2021-03-15 19:18:40','1','aab','1','bbb','ccf','ddd','eev','ffg',1,1),(4,'11111','22222',100.0000,'2021-03-15 19:18:33','1','2021-03-15 19:18:36','1',0,'2021-03-15 19:18:40','1','aaa','1','bbb','ccc','ddd','eee','fff',1,1);
/*!40000 ALTER TABLE `reagent_stock_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_stock_branch_detail`
--

DROP TABLE IF EXISTS `reagent_stock_branch_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_stock_branch_detail` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                               `stock_no` varchar(20) DEFAULT NULL,
                                               `reagent_name` varchar(20) DEFAULT NULL COMMENT '试剂名称',
                                               `reagent_id` bigint(20) DEFAULT NULL COMMENT '试剂耗材ID',
                                               `reagent_no` varchar(32) DEFAULT NULL COMMENT '产品批号',
                                               `expire_date` varchar(32) DEFAULT NULL COMMENT '库存有效期',
                                               `quantity` decimal(20,4) DEFAULT NULL COMMENT '库存数量',
                                               `create_time` datetime DEFAULT NULL,
                                               `create_by` varchar(20) DEFAULT NULL,
                                               `update_time` datetime DEFAULT NULL,
                                               `update_by` varchar(20) DEFAULT NULL,
                                               `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                               `overdue` bigint(20) DEFAULT NULL COMMENT '过期预警',
                                               `enter_time` datetime DEFAULT NULL COMMENT '入库时间',
                                               `enter_no` bigint(20) DEFAULT NULL COMMENT '入库单号',
                                               `enter_man` varchar(20) DEFAULT NULL COMMENT '入库人',
                                               `out_time` datetime DEFAULT NULL COMMENT '出库时间',
                                               `out_no` bigint(20) DEFAULT NULL COMMENT '出库单号',
                                               `out_man` varchar(20) DEFAULT NULL COMMENT '出库人',
                                               `apply_man` varchar(20) DEFAULT NULL COMMENT '申领人',
                                               `open_period` varchar(32) DEFAULT NULL COMMENT '开启有效期',
                                               `reagent_price` decimal(10,2) DEFAULT NULL COMMENT '单价',
                                               `delete_time` datetime DEFAULT NULL,
                                               `delete_by` varchar(20) DEFAULT NULL,
                                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_stock_branch_detail`
--

LOCK TABLES `reagent_stock_branch_detail` WRITE;
/*!40000 ALTER TABLE `reagent_stock_branch_detail` DISABLE KEYS */;
INSERT INTO `reagent_stock_branch_detail` VALUES (1,'1','1',1,'1','1',1.0000,'2021-03-08 20:11:49','1','2021-03-08 20:11:52','1',0,1,'2021-03-08 20:11:56',1,'1','2021-03-08 20:12:19',1,'1','1','1',1.00,'2021-03-08 20:12:07','1');
/*!40000 ALTER TABLE `reagent_stock_branch_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_stock_centre`
--

DROP TABLE IF EXISTS `reagent_stock_centre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_stock_centre` (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                        `stock_no` varchar(20) DEFAULT NULL COMMENT '库存编号',
                                        `reagent_id` varchar(20) NOT NULL COMMENT '试剂耗材ID',
                                        `quantity` decimal(20,4) NOT NULL COMMENT '库存数量',
                                        `create_time` datetime DEFAULT NULL,
                                        `create_by` varchar(20) DEFAULT NULL,
                                        `update_time` datetime DEFAULT NULL,
                                        `update_by` varchar(20) DEFAULT NULL,
                                        `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                        `delete_time` datetime DEFAULT NULL,
                                        `delete_by` varchar(20) DEFAULT NULL,
                                        `reagent_name` varchar(20) DEFAULT NULL COMMENT '试剂名称',
                                        `reagent_type` varchar(20) DEFAULT NULL COMMENT '型号规格',
                                        `factory` varchar(20) DEFAULT NULL COMMENT '生产厂家',
                                        `supplier_name` varchar(20) DEFAULT NULL COMMENT '供货商',
                                        `reagent_status` varchar(20) DEFAULT NULL COMMENT '状态',
                                        `reagent_unit` varchar(20) DEFAULT NULL COMMENT '单位',
                                        `reagent_temp` varchar(20) DEFAULT NULL COMMENT '存储温度',
                                        `overdue` bigint(20) DEFAULT NULL COMMENT '过期预警',
                                        `low_stock` bigint(20) DEFAULT NULL COMMENT '低库存预警',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_stock_centre`
--

LOCK TABLES `reagent_stock_centre` WRITE;
/*!40000 ALTER TABLE `reagent_stock_centre` DISABLE KEYS */;
INSERT INTO `reagent_stock_centre` VALUES (1,'1222','122',1.0000,'2021-03-08 19:38:46','1','2021-03-08 19:39:06','1',1,'2021-03-08 19:39:09','1','1','1','1','1','1','1','1',1,1),(2,'2','2',2.0000,'2021-03-08 21:05:50','2','2021-03-08 21:05:53','2',0,'2021-03-08 21:06:01','2','2','2','2','2','2','2','2',2,2),(3,'23','234',232.0000,'2021-03-15 21:15:28',NULL,NULL,NULL,NULL,NULL,NULL,'大师傅','大师傅sd','士大夫','大师傅asd','3','的所发生的','324',53455,3425),(4,'2345','2345',323.0000,'2021-03-15 21:23:14',NULL,NULL,NULL,NULL,NULL,NULL,'3245','345','45325','34252','435','453','常温',2314,3242),(5,'423','234432',34234.0000,'2021-03-15 21:44:57',NULL,NULL,NULL,NULL,NULL,NULL,'423','3242','4324','2342','2423','42342','23423',423423,423),(6,'4535','4352',43.0000,'2021-03-15 21:57:02',NULL,NULL,NULL,NULL,NULL,NULL,'435','345','2345','43534','543','452','543',53425,23),(7,'33','333',3.0000,'2021-03-15 21:57:28',NULL,NULL,NULL,NULL,NULL,NULL,'3','3','3','3','3','3','3',3,3);
/*!40000 ALTER TABLE `reagent_stock_centre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_stock_centre_detail`
--

DROP TABLE IF EXISTS `reagent_stock_centre_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_stock_centre_detail` (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                               `stock_no` varchar(20) DEFAULT NULL,
                                               `reagent_name` varchar(20) DEFAULT NULL COMMENT '试剂名称',
                                               `reagent_id` bigint(20) DEFAULT NULL COMMENT '试剂耗材ID',
                                               `reagent_no` varchar(32) DEFAULT NULL COMMENT '产品批号',
                                               `expire_date` varchar(32) DEFAULT NULL COMMENT '库存有效期',
                                               `quantity` bigint(20) DEFAULT NULL COMMENT '库存数量',
                                               `create_time` datetime DEFAULT NULL,
                                               `create_by` varchar(20) DEFAULT NULL,
                                               `update_by` varchar(20) DEFAULT NULL,
                                               `update_time` datetime DEFAULT NULL,
                                               `overdue` bigint(20) DEFAULT NULL COMMENT '过期预警',
                                               `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                               `enter_time` datetime DEFAULT NULL COMMENT '入库时间',
                                               `enter_no` bigint(20) DEFAULT NULL COMMENT '入库单号',
                                               `enter_man` varchar(20) DEFAULT NULL COMMENT '入库人',
                                               `out_time` datetime DEFAULT NULL COMMENT '出库时间',
                                               `out_no` bigint(20) DEFAULT NULL COMMENT '出库单号',
                                               `out_man` varchar(20) DEFAULT NULL COMMENT '出库人',
                                               `apply_man` varchar(20) DEFAULT NULL COMMENT '申领人',
                                               `open_period` varchar(32) DEFAULT NULL COMMENT '开启有效期',
                                               `reagent_price` decimal(10,2) DEFAULT NULL COMMENT '单价',
                                               `delete_time` datetime DEFAULT NULL,
                                               `delete_by` varchar(20) DEFAULT NULL,
                                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='试剂耗材库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_stock_centre_detail`
--

LOCK TABLES `reagent_stock_centre_detail` WRITE;
/*!40000 ALTER TABLE `reagent_stock_centre_detail` DISABLE KEYS */;
INSERT INTO `reagent_stock_centre_detail` VALUES (1,'1','1',1,'1','1',1,'2021-03-08 20:11:49','1','1','2021-03-08 20:11:52',1,0,'2021-03-08 20:11:56',1,'1','2021-03-08 20:12:19',1,'1','1','1',1.00,'2021-03-08 20:12:07','1'),(2,'2','2',2,'2','2',2,'2021-03-08 20:59:20','2','2','2021-03-08 20:59:25',2,0,'2021-03-08 20:59:34',2,'2','2021-03-08 20:59:40',2,'2','2','2',2.00,'2021-03-08 20:59:50','2');
/*!40000 ALTER TABLE `reagent_stock_centre_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_stock_item`
--

DROP TABLE IF EXISTS `reagent_stock_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_stock_item` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                      `stock_id` bigint(20) NOT NULL COMMENT '库存ID',
                                      `qr_code` varchar(50) NOT NULL COMMENT '二维码',
                                      `status` varchar(2) NOT NULL COMMENT '状态',
                                      `use_date` date DEFAULT NULL COMMENT '开瓶日',
                                      `use_expire` date DEFAULT NULL COMMENT '开瓶有效期',
                                      `create_time` datetime NOT NULL,
                                      `branch_id` bigint(20) DEFAULT NULL COMMENT '科室ID ',
                                      `consumer_id` bigint(20) DEFAULT NULL COMMENT '使用者ID',
                                      `create_by` varchar(20) NOT NULL,
                                      `update_time` datetime NOT NULL,
                                      `update_by` varchar(20) NOT NULL,
                                      `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                      `delete_time` datetime DEFAULT NULL,
                                      `delete_by` varchar(20) DEFAULT NULL,
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='试剂耗材库存个体';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_stock_item`
--

LOCK TABLES `reagent_stock_item` WRITE;
/*!40000 ALTER TABLE `reagent_stock_item` DISABLE KEYS */;
INSERT INTO `reagent_stock_item` VALUES (9,10,'20210301-01','01',NULL,NULL,'2021-05-05 11:20:25',1000,NULL,'admin','2021-05-05 14:46:48','admin',0,NULL,NULL),(10,10,'20210301-02','01',NULL,NULL,'2021-05-05 11:20:25',NULL,NULL,'admin','2021-05-05 14:47:01','admin',0,NULL,NULL),(11,11,'20210302-01','03',NULL,NULL,'2021-05-05 11:20:25',1000,100,'admin','2021-05-05 19:45:57','admin',0,NULL,NULL);
/*!40000 ALTER TABLE `reagent_stock_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reagent_supplier`
--

DROP TABLE IF EXISTS `reagent_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent_supplier` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                    `supplier_code` varchar(20) DEFAULT NULL COMMENT '供货商ID',
                                    `supplier_name` varchar(100) DEFAULT NULL COMMENT '供货商正式名',
                                    `supplier_short_name` varchar(20) DEFAULT NULL COMMENT '供货商简名',
                                    `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
                                    `contacts_tel` varchar(15) DEFAULT NULL COMMENT '联系人电话',
                                    `contacts_phone` varchar(15) DEFAULT NULL COMMENT '联系人手机',
                                    `contacts_wechat` varchar(30) DEFAULT NULL COMMENT '联系人微信',
                                    `supplier_address` varchar(150) DEFAULT NULL COMMENT '公司地址',
                                    `status` int(1) DEFAULT NULL COMMENT '公司状态',
                                    `create_time` datetime DEFAULT NULL,
                                    `create_by` varchar(20) DEFAULT NULL,
                                    `update_time` datetime DEFAULT NULL,
                                    `update_by` varchar(20) DEFAULT NULL,
                                    `delete_flag` tinyint(4) DEFAULT '0' COMMENT '软删除标志: 0, 未删除, 1: 已删除',
                                    `delete_time` datetime DEFAULT NULL,
                                    `delete_by` varchar(20) DEFAULT NULL,
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应商';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagent_supplier`
--

LOCK TABLES `reagent_supplier` WRITE;
/*!40000 ALTER TABLE `reagent_supplier` DISABLE KEYS */;
INSERT INTO `reagent_supplier` VALUES (1,'11122','哈药六厂','哈','2143234','234234','234234','2342342','423434',1,'2021-02-28 19:37:14','1','2021-02-28 19:37:17','2',0,'2021-02-28 19:37:22','2'),(4,'19989','福建制药','福制','季厚望','1214',NULL,'3423','浙江省杭州市',0,'2021-03-03 17:00:54',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reagent_supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-05 12:26:51
