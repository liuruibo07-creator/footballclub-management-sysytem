-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 192.168.120.174    Database: football-club
-- ------------------------------------------------------
-- Server version	8.0.31

-- Football-club business objects and data (football_* and v_football_*).
-- Safe to run after system_database_full.sql; it does not drop system tables.
CREATE DATABASE IF NOT EXISTS `football-club`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE `football-club`;

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
-- Table structure for table `football_budget`
--

DROP TABLE IF EXISTS `football_budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_budget` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `season` varchar(9) NOT NULL,
  `category` varchar(64) NOT NULL,
  `budget_amount` decimal(15,2) NOT NULL,
  `used_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `create_by` varchar(64) NOT NULL DEFAULT 'system',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) NOT NULL DEFAULT '0',
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_budget_season_category` (`season`,`category`),
  CONSTRAINT `ck_budget_amounts` CHECK (((`budget_amount` >= 0) and (`used_amount` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='赛季预算（内部数据，不预置）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_budget`
--

LOCK TABLES `football_budget` WRITE;
/*!40000 ALTER TABLE `football_budget` DISABLE KEYS */;
INSERT INTO `football_budget` (`id`, `season`, `category`, `budget_amount`, `used_amount`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,'2025-2026','赞助收入',0.00,100000000.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-26 18:24:35','0','合同 HT2026-001'),(2,'2025-2026','会员费',0.00,1800000.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-26 18:26:18','0','已开发票'),(3,'2025-2026','球衣广告',0.00,2400000.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-26 16:50:09','0','已到账'),(4,'2025-2026','赛事奖金',0.00,580000.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:20:12','0','耐克足球'),(5,'2025-2026','球衣收入',0.00,12600.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:18:56','0',NULL),(6,'2025-2026','交通费',1.00,4800.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:20:12','0','飞机、高铁、大巴'),(7,'2025-2026','场地费',1.00,96000.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:19:03','0',NULL),(8,'2025-2026','医疗物资',1.00,2300.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-26 18:27:13','0','队长签字'),(9,'2025-2026','奖金支出',1.00,800000.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:19:05','0',NULL),(10,'2025-2026','聚餐费',1.00,3600.00,'admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:19:06','0',NULL),(11,'2025-2026','球员工资',1.00,60000000.00,'system','2026-08-26 19:23:00',NULL,'2026-08-27 20:19:08','0',NULL);
/*!40000 ALTER TABLE `football_budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_finance_record`
--

DROP TABLE IF EXISTS `football_finance_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_finance_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `season` varchar(9) NOT NULL,
  `record_type` tinyint NOT NULL COMMENT '0=收入,1=支出',
  `category` varchar(64) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `record_date` date NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `create_by` varchar(64) NOT NULL DEFAULT 'system',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) NOT NULL DEFAULT '0',
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_finance_season_type_date` (`season`,`record_type`,`record_date`),
  CONSTRAINT `ck_finance_amount` CHECK ((`amount` > 0)),
  CONSTRAINT `ck_finance_type` CHECK ((`record_type` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='财务收支（内部数据，不预置）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_finance_record`
--

LOCK TABLES `football_finance_record` WRITE;
/*!40000 ALTER TABLE `football_finance_record` DISABLE KEYS */;
INSERT INTO `football_finance_record` (`id`, `season`, `record_type`, `category`, `amount`, `record_date`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,'2025-2026',0,'赞助收入',100000000.00,'2026-03-15','A公司赞助冠名期、回服','admin','2026-08-26 15:11:00',NULL,'2026-08-26 18:24:35','0','合同 HT2026-001'),(2,'2025-2026',0,'会员费',1800000.00,'2026-04-02','2026年度会员会费 36人','admin','2026-08-26 15:11:00',NULL,'2026-08-26 18:26:18','0','已开发票'),(3,'2025-2026',0,'球衣广告',2400000.00,'2026-04-10','球衣胸前后印广告费','admin','2026-08-26 15:11:00',NULL,'2026-08-26 16:50:09','0','已到账'),(4,'2025-2026',0,'赛事奖金',580000.00,'2026-06-22','足协杯亚军奖金','admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:20:12','0','耐克足球'),(5,'2025-2026',0,'球衣收入',12600.00,'2026-03-20','新款主场球衣 42 套','admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:18:56','0',NULL),(6,'2025-2026',1,'交通费',4800.00,'2026-04-05','客场比赛大巴租赁','admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:20:12','0','飞机、高铁、大巴'),(7,'2025-2026',1,'场地费',96000.00,'2026-04-15','训练场使用费 4 日','admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:19:03','0',NULL),(8,'2025-2026',1,'医疗物资',2300.00,'2026-04-25','急救包、运动喷雾采购','admin','2026-08-26 15:11:00',NULL,'2026-08-26 18:27:13','0','队长签字'),(9,'2025-2026',1,'奖金支出',800000.00,'2026-06-22','足协杯决赛二次分配','admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:19:05','0',NULL),(10,'2025-2026',1,'聚餐费',3600.00,'2026-07-10','赛季结束团队聚餐','admin','2026-08-26 15:11:00',NULL,'2026-08-27 20:19:06','0',NULL),(11,'2025-2026',1,'球员工资',60000000.00,'2026-12-15','球员年薪发放','system','2026-08-26 19:23:00',NULL,'2026-08-27 20:19:08','0',NULL);
/*!40000 ALTER TABLE `football_finance_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_injury`
--

DROP TABLE IF EXISTS `football_injury`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_injury` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `player_id` bigint DEFAULT NULL,
  `injury_type` varchar(64) DEFAULT NULL,
  `injury_location` varchar(64) DEFAULT NULL,
  `injury_date` date DEFAULT NULL,
  `expected_return_date` date DEFAULT NULL,
  `actual_return_date` date DEFAULT NULL,
  `recovery_status` tinyint DEFAULT NULL,
  `rehab_plan` text,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_injury`
--

LOCK TABLES `football_injury` WRITE;
/*!40000 ALTER TABLE `football_injury` DISABLE KEYS */;
INSERT INTO `football_injury` (`id`, `player_id`, `injury_type`, `injury_location`, `injury_date`, `expected_return_date`, `actual_return_date`, `recovery_status`, `rehab_plan`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,29,'小腿拉伤','腿','2026-04-04','2026-04-28','2026-04-27',3,'已康复111','system','2026-08-26 21:36:33',NULL,'2026-08-28 11:36:39','0','已康复111'),(2,26,'小腿拉伤','小腿','2026-04-24','2026-05-05','2026-05-07',3,NULL,NULL,'2026-08-28 08:54:35',NULL,'2026-08-28 11:37:20',NULL,NULL),(3,7,'膝盖发炎','膝盖','2026-08-04','2026-09-17',NULL,1,NULL,NULL,'2026-08-27 22:15:52',NULL,'2026-09-02 20:41:30',NULL,NULL),(4,16,'骨裂','脚踝','2026-07-15','2026-10-20',NULL,1,'静养',NULL,'2026-08-27 21:04:46',NULL,'2026-08-30 22:09:07',NULL,NULL),(11,10,'韧带损伤','右膝盖','2026-08-25','2026-08-29','2026-08-28',2,NULL,NULL,'2026-08-28 10:15:54',NULL,'2026-08-28 10:44:18',NULL,NULL),(12,18,'发热',NULL,'2026-08-27','2026-08-28','2026-08-28',3,NULL,NULL,'2026-08-28 10:24:16',NULL,'2026-08-28 10:42:07',NULL,NULL),(13,6,'膝关节韧带损伤','左膝','2026-09-02','2026-10-04',NULL,0,NULL,NULL,'2026-08-28 10:37:20',NULL,'2026-09-04 13:54:38',NULL,NULL),(14,7,'肌肉拉伤','右大腿','2026-09-01','2026-09-05',NULL,3,NULL,NULL,'2026-08-28 10:38:07',NULL,'2026-09-04 14:33:06',NULL,NULL),(15,23,'踝关节扭伤','右踝','2026-07-04','2026-09-03','2026-09-02',3,NULL,NULL,'2026-08-28 10:43:37',NULL,'2026-09-03 21:50:24',NULL,NULL);
/*!40000 ALTER TABLE `football_injury` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_league_team`
--

DROP TABLE IF EXISTS `football_league_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_league_team` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `team_name` varchar(64) NOT NULL COMMENT '球队名称',
  `logo_url` varchar(512) NOT NULL COMMENT '球队logo(OSS完整URL, 必填)',
  `league_name` varchar(64) NOT NULL COMMENT '所属联赛/赛事',
  `division` varchar(32) NOT NULL COMMENT '所属俱乐部分部(一线队/U21/U19/U17/青训梯队)',
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '球队状态(0=停用 1=启用)',
  `dissolve_flag` char(1) NOT NULL DEFAULT '0' COMMENT '解散标记(0=正常 1=已解散)',
  `manager_phone` varchar(20) DEFAULT NULL COMMENT '领队电话',
  `liaison_admin` varchar(64) DEFAULT NULL COMMENT '对接管理员',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志(0=正常 2=已删除)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_team_name` (`team_name`),
  KEY `idx_status` (`status`,`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='联赛球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_league_team`
--

LOCK TABLES `football_league_team` WRITE;
/*!40000 ALTER TABLE `football_league_team` DISABLE KEYS */;
INSERT INTO `football_league_team` (`id`, `team_name`, `logo_url`, `league_name`, `division`, `status`, `dissolve_flag`, `manager_phone`, `liaison_admin`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1,'天津津门虎','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee0113657fb6434f12e1.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(2,'深圳新鹏城','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fdfb13658c98cba5257f.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(3,'云南玉昆','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe1113658c98cba52580.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','','2026-08-31 17:55:07','0'),(4,'北京国安','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe4113658c98cba52581.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(5,'青岛西海岸','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e2.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(6,'浙江俱乐部绿城','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e4.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(7,'上海海港','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe5613658c98cba52582.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(8,'重庆铜梁龙','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe7113658c98cba52583.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(9,'上海申花','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93feb413658c98cba52584.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(10,'青岛海牛','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93febd13658c98cba52585.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(11,'山东泰山','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e3.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(12,'武汉三镇','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fec813658c98cba52586.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(13,'成都蓉城','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fed113658c98cba52587.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(14,'河南俱乐部彩陶坊','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fee013658c98cba52588.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(15,'大连英博海发','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93feef13658c98cba52589.png','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0'),(16,'辽宁铁人楠波湾','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fefc13658c98cba5258a.jpg','中国足球超级联赛','一线队','1','0',NULL,NULL,'2026中超种子数据','admin','2026-08-31 16:57:26','',NULL,'0');
/*!40000 ALTER TABLE `football_league_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_match`
--

DROP TABLE IF EXISTS `football_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_match` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `season` varchar(9) NOT NULL,
  `round_no` int DEFAULT NULL COMMENT '轮次；杯赛可为空',
  `match_date` datetime NOT NULL,
  `home_team` varchar(64) NOT NULL,
  `away_team` varchar(64) NOT NULL,
  `home_score` int DEFAULT NULL,
  `away_score` int DEFAULT NULL,
  `status` tinyint NOT NULL COMMENT '0=已安排,1=已完成,2=已推迟,3=已取消',
  `venue` varchar(128) DEFAULT NULL,
  `competition_type` tinyint NOT NULL COMMENT '0=联赛,1=杯赛,2=友谊赛',
  `competition_name` varchar(64) NOT NULL,
  `source_url` varchar(1000) DEFAULT NULL,
  `source_as_of` date DEFAULT NULL,
  `create_by` varchar(64) NOT NULL DEFAULT 'system',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) NOT NULL DEFAULT '0',
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_match_comp_round_teams` (`season`,`competition_name`,`round_no`,`home_team`,`away_team`),
  KEY `idx_match_season_status_date` (`season`,`status`,`match_date`),
  CONSTRAINT `ck_match_scores` CHECK ((((`status` = 1) and (`home_score` is not null) and (`away_score` is not null)) or ((`status` <> 1) and (`home_score` is null) and (`away_score` is null)))),
  CONSTRAINT `ck_match_status` CHECK ((`status` in (0,1,2,3)))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='比赛';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_match`
--

LOCK TABLES `football_match` WRITE;
/*!40000 ALTER TABLE `football_match` DISABLE KEYS */;
INSERT INTO `football_match` (`id`, `season`, `round_no`, `match_date`, `home_team`, `away_team`, `home_score`, `away_score`, `status`, `venue`, `competition_type`, `competition_name`, `source_url`, `source_as_of`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,'2026',1,'2026-03-07 15:30:00','天津津门虎','重庆铜梁龙',0,0,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(2,'2026',2,'2026-03-14 20:00:00','深圳新鹏城','天津津门虎',1,0,1,'深圳市体育中心体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(4,'2026',4,'2026-04-05 19:35:00','天津津门虎','上海申花',2,3,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(5,'2026',5,'2026-04-12 19:00:00','天津津门虎','青岛海牛',1,1,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(6,'2026',6,'2026-04-17 20:00:00','云南玉昆','天津津门虎',0,3,1,'云南玉溪高原体育运动中心体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(7,'2026',7,'2026-04-21 20:00:00','天津津门虎','山东泰山',1,2,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(8,'2026',8,'2026-04-25 19:35:00','北京国安','天津津门虎',2,4,1,'北京工人体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(9,'2026',9,'2026-05-01 19:35:00','天津津门虎','武汉三镇',2,2,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(10,'2026',10,'2026-05-05 19:00:00','青岛西海岸','天津津门虎',1,1,1,'青岛西海岸大学城体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(11,'2026',11,'2026-05-10 19:35:00','浙江俱乐部绿城','天津津门虎',1,1,1,'黄龙体育中心体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(12,'2026',12,'2026-05-15 19:35:00','天津津门虎','成都蓉城',1,2,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(13,'2026',13,'2026-05-19 19:35:00','天津津门虎','河南俱乐部彩陶坊',1,2,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(14,'2026',14,'2026-05-23 19:00:00','上海海港','天津津门虎',1,1,1,'上汽浦东足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(15,'2026',15,'2026-05-31 19:00:00','天津津门虎','大连英博海发',1,0,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(16,'2026',16,'2026-06-27 20:00:00','重庆铜梁龙','天津津门虎',1,0,1,'重庆龙兴足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(17,'2026',17,'2026-07-04 20:00:00','天津津门虎','深圳新鹏城',3,0,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(18,'2026',18,'2026-09-12 19:00:00','天津津门虎','辽宁铁人楠波湾',NULL,NULL,2,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(19,'2026',19,'2026-07-18 19:35:00','上海申花','天津津门虎',0,2,1,'上海体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(20,'2026',20,'2026-07-25 17:30:00','青岛海牛','天津津门虎',0,2,1,'青岛青春足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(21,'2026',21,'2026-08-01 19:00:00','天津津门虎','云南玉昆',3,2,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(22,'2026',22,'2026-08-09 20:00:00','山东泰山','天津津门虎',2,1,1,'济南奥体中心',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(23,'2026',23,'2026-08-15 19:35:00','天津津门虎','北京国安',2,4,1,'水滴体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 14:31:37','0',NULL),(24,'2026',24,'2026-08-22 19:00:00','武汉三镇','天津津门虎',0,0,1,'武汉体育中心体育场',0,'中国足球超级联赛','https://sports.cctv.com/2026/08/22/ARTIMJRwHuZoOa8OOeJ2Fmhv260822.shtml','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(25,'2026',25,'2026-08-29 19:00:00','天津津门虎','青岛西海岸',1,1,1,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-30 12:49:46','0',NULL),(26,'2026',26,'2026-09-06 20:00:00','天津津门虎','浙江俱乐部绿城',NULL,NULL,0,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(27,'2026',27,'2026-10-10 19:35:00','成都蓉城','天津津门虎',NULL,NULL,0,'五粮液文化体育中心',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(28,'2026',28,'2026-10-16 19:35:00','河南俱乐部彩陶坊','天津津门虎',NULL,NULL,0,'郑州航海体育场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(29,'2026',29,'2026-10-24 15:30:00','天津津门虎','上海海港',NULL,NULL,0,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(30,'2026',30,'2026-11-08 15:30:00','大连英博海发','天津津门虎',NULL,NULL,0,'天津泰达足球场',0,'中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 16:54:41','0',NULL),(31,'2026',4,'2026-06-19 19:30:00','兰州陇原竞技','天津津门虎',1,1,1,'兰州奥体中心玫瑰场',1,'中国足球协会杯','https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','2026-06-19','system','2026-08-26 15:50:36',NULL,NULL,'0','点球大战：兰州陇原竞技5-3天津津门虎；总比分4-6，津门虎出局');
/*!40000 ALTER TABLE `football_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_match_event`
--

DROP TABLE IF EXISTS `football_match_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_match_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `match_id` bigint NOT NULL COMMENT '鍏宠仈姣旇禌ID',
  `minute` int DEFAULT NULL COMMENT '浜嬩欢鍙戠敓鍒嗛挓',
  `event_type` varchar(20) NOT NULL COMMENT '浜嬩欢绫诲瀷: goal/yellow_card/red_card/sub_in/sub_out/own_goal/penalty_goal/penalty_miss',
  `player_id` bigint DEFAULT NULL COMMENT '鐩稿叧鐞冨憳ID',
  `assist_player_id` bigint DEFAULT NULL COMMENT '鍔╂敾鐞冨憳ID(浠単oal)',
  `sub_player_id` bigint DEFAULT NULL COMMENT '琚?崲涓嬬悆鍛業D(浠卻ub)',
  `team_side` varchar(10) DEFAULT NULL COMMENT '涓婚槦/瀹㈤槦: home/away',
  `remark` varchar(200) DEFAULT NULL COMMENT '澶囨敞',
  `create_by` varchar(64) DEFAULT '' COMMENT '鍒涘缓鑰',
  `create_time` datetime DEFAULT NULL COMMENT '鍒涘缓鏃堕棿',
  `update_by` varchar(64) DEFAULT '' COMMENT '鏇存柊鑰',
  `update_time` datetime DEFAULT NULL COMMENT '鏇存柊鏃堕棿',
  `del_flag` char(1) DEFAULT '0' COMMENT '鍒犻櫎鏍囧織',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`),
  KEY `idx_player_id` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='姣旇禌浜嬩欢琛';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_match_event`
--

LOCK TABLES `football_match_event` WRITE;
/*!40000 ALTER TABLE `football_match_event` DISABLE KEYS */;
INSERT INTO `football_match_event` (`id`, `match_id`, `minute`, `event_type`, `player_id`, `assist_player_id`, `sub_player_id`, `team_side`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1,1,12,'yellow_card',5,NULL,NULL,'away','战术犯规','admin','2026-08-31 15:54:43','',NULL,'0'),(2,1,23,'goal',7,10,NULL,'home','头球破门','admin','2026-08-31 15:54:43','',NULL,'0'),(3,1,35,'yellow_card',3,NULL,NULL,'home','拉人犯规','admin','2026-08-31 15:54:43','',NULL,'0'),(4,1,46,'sub_out',10,NULL,NULL,'away',NULL,'admin','2026-08-31 15:54:43','',NULL,'0'),(5,1,46,'sub_in',NULL,NULL,NULL,'away','替补登场','admin','2026-08-31 15:54:43','',NULL,'0'),(6,1,58,'goal',9,7,NULL,'home','远射得分','admin','2026-08-31 15:54:43','',NULL,'0'),(7,1,67,'yellow_card',8,NULL,NULL,'away','铲球犯规','admin','2026-08-31 15:54:43','',NULL,'0'),(8,1,72,'sub_out',7,NULL,NULL,'home',NULL,'admin','2026-08-31 15:54:43','',NULL,'0'),(9,1,72,'sub_in',NULL,NULL,NULL,'home','替补登场','admin','2026-08-31 15:54:43','',NULL,'0'),(10,1,85,'goal',11,9,NULL,'away','反击得分','admin','2026-08-31 15:54:43','',NULL,'0'),(11,2,8,'goal',9,3,NULL,'home','抢点破门','admin','2026-08-31 15:54:43','',NULL,'0'),(12,2,31,'red_card',6,NULL,NULL,'away','恶意犯规','admin','2026-08-31 15:54:43','',NULL,'0'),(13,2,44,'penalty_goal',9,NULL,NULL,'home','点球命中','admin','2026-08-31 15:54:43','',NULL,'0'),(14,2,56,'goal',7,9,NULL,'home','凌空抽射','admin','2026-08-31 15:54:43','',NULL,'0'),(15,2,78,'yellow_card',2,NULL,NULL,'home','拖延时间','admin','2026-08-31 15:54:43','',NULL,'0'),(16,3,15,'goal',11,NULL,NULL,'away','个人突破','admin','2026-08-31 15:54:43','',NULL,'0'),(17,3,33,'goal',7,10,NULL,'home','角球配合','admin','2026-08-31 15:54:43','',NULL,'0'),(18,3,55,'yellow_card',4,NULL,NULL,'home','手球','admin','2026-08-31 15:54:43','',NULL,'0'),(19,3,73,'sub_out',10,NULL,NULL,'home',NULL,'admin','2026-08-31 15:54:43','',NULL,'0'),(20,3,73,'sub_in',NULL,NULL,NULL,'home','替补登场','admin','2026-08-31 15:54:43','',NULL,'0'),(21,3,88,'own_goal',3,NULL,NULL,'home','乌龙球','admin','2026-08-31 15:54:43','',NULL,'0'),(22,4,20,'goal',9,7,NULL,'home','头球攻门','admin','2026-08-31 15:54:43','',NULL,'0'),(23,4,45,'yellow_card',5,NULL,NULL,'away','抗议判罚','admin','2026-08-31 15:54:43','',NULL,'0'),(24,4,60,'goal',7,NULL,NULL,'home','远射世界波','admin','2026-08-31 15:54:43','',NULL,'0'),(25,4,75,'sub_out',9,NULL,NULL,'home',NULL,'admin','2026-08-31 15:54:43','',NULL,'0'),(26,4,75,'sub_in',NULL,NULL,NULL,'home','替补登场','admin','2026-08-31 15:54:43','',NULL,'0'),(27,5,10,'yellow_card',8,NULL,NULL,'home','战术犯规','admin','2026-08-31 15:54:43','',NULL,'0'),(28,5,37,'goal',11,NULL,NULL,'away','单刀赴会','admin','2026-08-31 15:54:43','',NULL,'0'),(29,5,52,'goal',7,3,NULL,'home','任意球直接破门','admin','2026-08-31 15:54:43','',NULL,'0'),(30,5,80,'goal',9,7,NULL,'home','补时绝杀','admin','2026-08-31 15:54:43','',NULL,'0');
/*!40000 ALTER TABLE `football_match_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_match_player`
--

DROP TABLE IF EXISTS `football_match_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_match_player` (
  `id` bigint DEFAULT NULL,
  `match_id` bigint DEFAULT NULL,
  `player_id` bigint DEFAULT NULL,
  `is_starter` tinyint DEFAULT NULL,
  `minutes_played` int DEFAULT NULL,
  `goals` int DEFAULT NULL,
  `assists` int DEFAULT NULL,
  `yellow_cards` int DEFAULT NULL,
  `red_cards` int DEFAULT NULL,
  `source_url` varchar(1000) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_match_player`
--

LOCK TABLES `football_match_player` WRITE;
/*!40000 ALTER TABLE `football_match_player` DISABLE KEYS */;
INSERT INTO `football_match_player` (`id`, `match_id`, `player_id`, `is_starter`, `minutes_played`, `goals`, `assists`, `yellow_cards`, `red_cards`, `source_url`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1,11,2,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(2,11,5,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(3,11,6,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(4,11,8,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(5,11,10,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(6,11,14,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(7,11,15,1,NULL,1,0,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(8,11,17,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(9,11,23,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(10,11,24,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(11,11,27,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(12,11,7,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(13,11,13,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(14,11,19,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(15,11,21,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(16,11,28,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html','system','2026-08-25 18:48:23',NULL,NULL),(17,31,3,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(18,31,12,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(19,31,6,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(20,31,4,1,NULL,1,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(21,31,11,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(22,31,9,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(23,31,20,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(24,31,25,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(25,31,21,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(26,31,18,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(27,31,29,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(28,31,5,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(29,31,7,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(30,31,19,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(31,31,22,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL),(32,31,28,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','system','2026-08-25 18:48:23',NULL,NULL);
/*!40000 ALTER TABLE `football_match_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_player`
--

DROP TABLE IF EXISTS `football_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_player` (
  `id` bigint DEFAULT NULL,
  `jersey_number` int DEFAULT NULL,
  `name_cn` varchar(64) DEFAULT NULL,
  `position` varchar(16) DEFAULT NULL,
  `nationality` varchar(32) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `height` decimal(3,2) DEFAULT NULL,
  `preferred_foot` varchar(8) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `avatar_url` varchar(500) DEFAULT NULL COMMENT '鐞冨憳澶村儚URL',
  `registration_note` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `source_url` varchar(1000) DEFAULT NULL,
  `source_as_of` date DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_player`
--

LOCK TABLES `football_player` WRITE;
/*!40000 ALTER TABLE `football_player` DISABLE KEYS */;
INSERT INTO `football_player` (`id`, `jersey_number`, `name_cn`, `position`, `nationality`, `birth_date`, `height`, `preferred_foot`, `status`, `avatar_url`, `registration_note`, `user_id`, `source_url`, `source_as_of`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,21,'齐雨熙','0','中国','1993-01-20',1.86,'0','活跃',NULL,NULL,NULL,'https://match.sports.sina.com.cn/football/csl/team.php?dpc=1&id=148','2026-08-25','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(2,25,'闫炳良','0','中国','2000-04-03',1.97,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:37:12','0',NULL),(3,26,'张皓然','0','中国','1999-12-17',1.82,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(4,3,'王政豪','1','中国','1993-04-13',1.86,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(5,4,'杨帆','1','中国','1996-03-28',1.82,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:12','0',NULL),(6,6,'王献钧','1','中国','2000-06-01',1.88,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(7,17,'吴兴涵','1','中国','1993-02-24',1.83,'0','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(8,18,'艾托尔·科尔多瓦','1','西班牙','1995-05-21',1.91,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:12','0',NULL),(9,27,'李嗣镕','1','中国','1988-05-08',1.95,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(10,31,'孙铭谦','1','中国香港','1995-03-10',1.83,'0','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:59','0',NULL),(11,38,'李帅琪','1','中国','2008-09-08',1.90,'1','活跃',NULL,NULL,NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(12,39,'蔡承峻','1','中国','2005-01-31',1.83,'1','活跃',NULL,NULL,NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(13,40,'石炎','1','中国','1990-06-24',1.91,'1','活跃',NULL,'公开名单同时也有将其列为前锋的资料；此处按2026-07-24阵容页',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(14,5,'豪梅·格劳','2','西班牙','1997-05-05',1.84,'0','非活跃',NULL,'2026赛季上半程注册，夏窗更新名单中被萨尔瓦多替换',NULL,'https://www.qtx.com/csl/279129.html','2026-08-10','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(15,8,'布鲁诺·哈达斯','2','葡萄牙','1997-12-02',1.79,'0','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(16,10,'克里斯蒂安·萨尔瓦多','2','西班牙','1994-11-20',1.84,'1','活跃',NULL,'冬窗因踝关节韧带手术暂未报名，夏窗回归更新名单',NULL,'https://www.leisu.com/data/zuqiu/player-88945','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:12','0',NULL),(17,14,'黄嘉辉','2','中国','2000-10-07',1.85,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(18,16,'刘帅','2','中国','2004-11-26',1.79,'1','活跃',NULL,NULL,NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(19,20,'季胜攀','2','中国','1999-11-08',1.78,'0','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:12','0',NULL),(20,22,'李永佳','2','中国','1999-02-19',1.85,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(21,24,'陈哲宣','2','中国','2003-09-24',1.81,'0','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(22,28,'郭皓','2','中国','1999-10-19',1.94,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(23,29,'巴顿','2','中国','1995-09-16',1.81,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(24,30,'王秋明','2','中国','1993-01-09',1.73,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:12','0',NULL),(25,33,'乃博宁林','2','中国','2006-03-13',1.86,'1','活跃',NULL,NULL,NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(26,7,'吉列尔梅·谢蒂内','3','巴西','1995-10-10',1.80,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(27,9,'阿尔韦托·基莱斯','3','西班牙','1995-04-27',1.88,'0','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(28,11,'谢维军','3','中国','1997-11-14',1.90,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:39:13','0',NULL),(29,19,'刘俊贤','3','中国','1986-02-25',1.88,'1','活跃',NULL,NULL,NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24','system','2026-08-25 18:48:23',NULL,'2026-08-26 22:43:07','0',NULL),(NULL,99,'ggg','0','xxx','2026-09-08',1.45,'0','活跃',NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-04 14:24:34',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `football_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_player_contract`
--

DROP TABLE IF EXISTS `football_player_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_player_contract` (
  `id` bigint DEFAULT NULL,
  `player_id` bigint DEFAULT NULL,
  `contract_no` varchar(64) DEFAULT NULL,
  `contract_type` varchar(16) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `base_salary` decimal(15,2) DEFAULT NULL,
  `signing_bonus` decimal(15,2) DEFAULT NULL,
  `performance_terms` text,
  `status` varchar(16) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_player_contract`
--

LOCK TABLES `football_player_contract` WRITE;
/*!40000 ALTER TABLE `football_player_contract` DISABLE KEYS */;
INSERT INTO `football_player_contract` (`id`, `player_id`, `contract_no`, `contract_type`, `start_date`, `end_date`, `base_salary`, `signing_bonus`, `performance_terms`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,1,'P-001-2026','1','2026-07-09','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,'2026-08-26 23:02:15','0',NULL),(2,2,'P-002-2026','标准合同','2026-03-18','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(3,3,'P-003-2026','标准合同','2026-04-30','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(4,4,'P-004-2026','标准合同','2026-06-02','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(5,5,'P-005-2026','标准合同','2026-08-06','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(6,6,'P-006-2026','标准合同','2026-03-15','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(7,7,'P-007-2026','标准合同','2026-07-07','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(8,8,'P-008-2026','标准合同','2026-08-09','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(9,9,'P-009-2026','标准合同','2026-06-24','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(10,10,'P-010-2026','标准合同','2026-03-29','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(11,11,'P-011-2026','标准合同','2026-04-27','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(12,12,'P-012-2026','标准合同','2026-06-24','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(13,13,'P-013-2026','标准合同','2026-04-30','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(14,15,'P-015-2026','标准合同','2026-07-09','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(15,16,'P-016-2026','标准合同','2026-07-13','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(16,17,'P-017-2026','标准合同','2026-07-06','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(17,18,'P-018-2026','标准合同','2026-07-29','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(18,19,'P-019-2026','标准合同','2026-06-01','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(19,20,'P-020-2026','标准合同','2026-04-29','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(20,21,'P-021-2026','标准合同','2026-07-05','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(21,22,'P-022-2026','标准合同','2026-05-08','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(22,23,'P-023-2026','标准合同','2026-08-23','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(23,24,'P-024-2026','标准合同','2026-03-19','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(24,25,'P-025-2026','标准合同','2026-04-21','2027-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(25,14,'P-014-2026','标准合同','2026-06-14','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(26,26,'P-026-2026','标准合同','2026-06-19','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(27,27,'P-027-2026','标准合同','2026-05-18','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(28,28,'P-028-2026','标准合同','2026-07-17','2028-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL),(29,29,'P-029-2026','标准合同','2026-07-19','2029-08-26',NULL,NULL,NULL,'已签署','system','2026-08-26 23:01:14',NULL,NULL,'0',NULL);
/*!40000 ALTER TABLE `football_player_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_player_season_stat`
--

DROP TABLE IF EXISTS `football_player_season_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_player_season_stat` (
  `id` bigint DEFAULT NULL,
  `player_id` bigint DEFAULT NULL,
  `season` varchar(9) DEFAULT NULL,
  `competition` varchar(64) DEFAULT NULL,
  `appearances` int DEFAULT NULL,
  `starts` int DEFAULT NULL,
  `minutes_played` int DEFAULT NULL,
  `goals` int DEFAULT NULL,
  `assists` int DEFAULT NULL,
  `yellow_cards` int DEFAULT NULL,
  `red_cards` int DEFAULT NULL,
  `stat_as_of` date DEFAULT NULL,
  `source_url` varchar(1000) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_player_season_stat`
--

LOCK TABLES `football_player_season_stat` WRITE;
/*!40000 ALTER TABLE `football_player_season_stat` DISABLE KEYS */;
INSERT INTO `football_player_season_stat` (`id`, `player_id`, `season`, `competition`, `appearances`, `starts`, `minutes_played`, `goals`, `assists`, `yellow_cards`, `red_cards`, `stat_as_of`, `source_url`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1,27,'2026','中国足球超级联赛',22,17,1866,10,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(2,15,'2026','中国足球超级联赛',22,19,1878,7,6,2,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(3,26,'2026','中国足球超级联赛',16,11,1179,6,2,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(4,19,'2026','中国足球超级联赛',5,3,350,3,1,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(5,8,'2026','中国足球超级联赛',18,15,1415,1,1,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(6,17,'2026','中国足球超级联赛',17,12,1305,1,1,4,1,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(7,6,'2026','中国足球超级联赛',13,11,974,1,0,4,1,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(8,16,'2026','中国足球超级联赛',5,3,361,1,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(9,23,'2026','中国足球超级联赛',20,17,1598,0,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(10,2,'2026','中国足球超级联赛',19,19,1575,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(11,5,'2026','中国足球超级联赛',18,16,1479,0,1,6,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(12,14,'2026','中国足球超级联赛',17,13,1280,0,0,4,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(13,10,'2026','中国足球超级联赛',14,13,1080,0,1,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(14,24,'2026','中国足球超级联赛',15,13,1057,0,0,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(15,28,'2026','中国足球超级联赛',11,9,801,0,0,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(16,7,'2026','中国足球超级联赛',9,8,714,0,0,4,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(17,4,'2026','中国足球超级联赛',9,8,667,0,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(18,21,'2026','中国足球超级联赛',6,3,470,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(19,1,'2026','中国足球超级联赛',4,3,315,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(20,22,'2026','中国足球超级联赛',4,2,277,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(21,13,'2026','中国足球超级联赛',2,1,135,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(22,29,'2026','中国足球超级联赛',1,0,23,0,1,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(23,20,'2026','中国足球超级联赛',1,0,8,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-25 18:48:23',NULL,NULL,NULL),(24,3,'2026','中国足球超级联赛',1,1,90,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-28 20:51:56',NULL,NULL,NULL),(25,9,'2026','中国足球超级联赛',4,3,299,0,1,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-28 20:51:56',NULL,NULL,NULL),(26,11,'2026','中国足球超级联赛',4,2,192,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-28 20:51:56',NULL,NULL,NULL),(27,12,'2026','中国足球超级联赛',4,2,228,0,1,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-28 20:51:56',NULL,NULL,NULL),(28,18,'2026','中国足球超级联赛',5,3,243,0,2,2,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-28 20:51:56',NULL,NULL,NULL),(29,25,'2026','中国足球超级联赛',4,2,190,0,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','system','2026-08-28 20:51:56',NULL,NULL,NULL);
/*!40000 ALTER TABLE `football_player_season_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_salary_cap`
--

DROP TABLE IF EXISTS `football_salary_cap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_salary_cap` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `season` varchar(9) NOT NULL,
  `salary_cap_limit` decimal(15,2) NOT NULL,
  `policy_reference` varchar(1000) DEFAULT NULL,
  `create_by` varchar(64) NOT NULL DEFAULT 'system',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_salary_cap_season` (`season`),
  CONSTRAINT `ck_salary_cap_limit` CHECK ((`salary_cap_limit` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工资帽政策；具体限额需按正式政策录入';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_salary_cap`
--

LOCK TABLES `football_salary_cap` WRITE;
/*!40000 ALTER TABLE `football_salary_cap` DISABLE KEYS */;
/*!40000 ALTER TABLE `football_salary_cap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_schedule_event`
--

DROP TABLE IF EXISTS `football_schedule_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_schedule_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `match_id` bigint DEFAULT NULL COMMENT '比赛日程关联比赛，可空',
  `training_id` bigint DEFAULT NULL COMMENT '训练日程关联训练，可空',
  `title` varchar(128) NOT NULL,
  `event_type` tinyint NOT NULL COMMENT '0=比赛,1=训练,2=会议',
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `location` varchar(128) DEFAULT NULL,
  `description` text,
  `status` tinyint NOT NULL COMMENT '0=已安排,1=已完成,2=已取消,3=已推迟',
  `create_by` varchar(64) NOT NULL DEFAULT 'system',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) NOT NULL DEFAULT '0',
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_schedule_match` (`match_id`),
  UNIQUE KEY `uk_schedule_training` (`training_id`),
  KEY `idx_schedule_type_time` (`event_type`,`start_time`),
  CONSTRAINT `fk_schedule_match` FOREIGN KEY (`match_id`) REFERENCES `football_match` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_schedule_training` FOREIGN KEY (`training_id`) REFERENCES `football_training` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_schedule_status` CHECK ((`status` in (0,1,2,3))),
  CONSTRAINT `ck_schedule_time` CHECK ((`end_time` > `start_time`)),
  CONSTRAINT `ck_schedule_type` CHECK ((`event_type` in (0,1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='统一球队日程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_schedule_event`
--

LOCK TABLES `football_schedule_event` WRITE;
/*!40000 ALTER TABLE `football_schedule_event` DISABLE KEYS */;
INSERT INTO `football_schedule_event` (`id`, `match_id`, `training_id`, `title`, `event_type`, `start_time`, `end_time`, `location`, `description`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,1,NULL,'2026中超第1轮：天津津门虎 vs 重庆铜梁龙',0,'2026-03-07 15:30:00','2026-03-07 17:30:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(2,2,NULL,'2026中超第2轮：深圳新鹏城 vs 天津津门虎',0,'2026-03-14 20:00:00','2026-03-14 22:00:00','深圳市体育中心体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:44:21','0',NULL),(4,4,NULL,'2026中超第4轮：天津津门虎 vs 上海申花',0,'2026-04-05 19:35:00','2026-04-05 21:35:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(5,5,NULL,'2026中超第5轮：天津津门虎 vs 青岛海牛',0,'2026-04-12 19:00:00','2026-04-12 21:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(6,6,NULL,'2026中超第6轮：云南玉昆 vs 天津津门虎',0,'2026-04-17 20:00:00','2026-04-17 22:00:00','云南玉溪高原体育运动中心体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:44:21','0',NULL),(7,7,NULL,'2026中超第7轮：天津津门虎 vs 山东泰山',0,'2026-04-21 20:00:00','2026-04-21 22:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(8,8,NULL,'2026中超第8轮：北京国安 vs 天津津门虎',0,'2026-04-25 19:35:00','2026-04-25 21:35:00','北京工人体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(9,9,NULL,'2026中超第9轮：天津津门虎 vs 武汉三镇',0,'2026-05-01 19:35:00','2026-05-01 21:35:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(10,10,NULL,'2026中超第10轮：青岛西海岸 vs 天津津门虎',0,'2026-05-05 19:00:00','2026-05-05 21:00:00','青岛西海岸大学城体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:44:21','0',NULL),(11,11,NULL,'2026中超第11轮：浙江俱乐部绿城 vs 天津津门虎',0,'2026-05-10 19:35:00','2026-05-10 21:35:00','黄龙体育中心体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:44:21','0',NULL),(12,12,NULL,'2026中超第12轮：天津津门虎 vs 成都蓉城',0,'2026-05-15 19:35:00','2026-05-15 21:35:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(13,13,NULL,'2026中超第13轮：天津津门虎 vs 河南俱乐部彩陶坊',0,'2026-05-19 19:35:00','2026-05-19 21:35:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(14,14,NULL,'2026中超第14轮：上海海港 vs 天津津门虎',0,'2026-05-23 19:00:00','2026-05-23 21:00:00','上汽浦东足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:44:21','0',NULL),(15,15,NULL,'2026中超第15轮：天津津门虎 vs 大连英博海发',0,'2026-05-31 19:00:00','2026-05-31 21:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(16,16,NULL,'2026中超第16轮：重庆铜梁龙 vs 天津津门虎',0,'2026-06-27 20:00:00','2026-06-27 22:00:00','重庆龙兴足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(17,17,NULL,'2026中超第17轮：天津津门虎 vs 深圳新鹏城',0,'2026-07-04 20:00:00','2026-07-04 22:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(18,18,NULL,'2026中超第18轮：天津津门虎 vs 辽宁铁人楠波湾',0,'2026-09-12 19:00:00','2026-09-12 21:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',3,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(19,19,NULL,'2026中超第19轮：上海申花 vs 天津津门虎',0,'2026-07-18 19:35:00','2026-07-18 21:35:00','上海体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(20,20,NULL,'2026中超第20轮：青岛海牛 vs 天津津门虎',0,'2026-07-25 17:30:00','2026-07-25 19:30:00','青岛青春足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(21,21,NULL,'2026中超第21轮：天津津门虎 vs 云南玉昆',0,'2026-08-01 19:00:00','2026-08-01 21:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(22,22,NULL,'2026中超第22轮：山东泰山 vs 天津津门虎',0,'2026-08-09 20:00:00','2026-08-09 22:00:00','济南奥体中心','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(23,23,NULL,'2026中超第23轮：天津津门虎 vs 北京国安',0,'2026-08-15 19:35:00','2026-08-15 21:35:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(24,24,NULL,'2026中超第24轮：武汉三镇 vs 天津津门虎',0,'2026-08-22 19:00:00','2026-08-22 21:00:00','武汉体育中心体育场','公开赛程同步；数据源：https://sports.cctv.com/2026/08/22/ARTIMJRwHuZoOa8OOeJ2Fmhv260822.shtml',1,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(25,25,NULL,'2026中超第25轮：天津津门虎 vs 青岛西海岸',0,'2026-08-29 19:00:00','2026-08-29 21:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',1,'system','2026-08-26 15:50:36',NULL,'2026-08-30 12:48:27','0',NULL),(26,26,NULL,'2026中超第26轮：天津津门虎 vs 浙江俱乐部绿城',0,'2026-09-06 20:00:00','2026-09-06 22:00:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',0,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(27,27,NULL,'2026中超第27轮：成都蓉城 vs 天津津门虎',0,'2026-10-10 19:35:00','2026-10-10 21:35:00','五粮液文化体育中心','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',0,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(28,28,NULL,'2026中超第28轮：河南俱乐部彩陶坊 vs 天津津门虎',0,'2026-10-16 19:35:00','2026-10-16 21:35:00','郑州航海体育场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',0,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(29,29,NULL,'2026中超第29轮：天津津门虎 vs 上海海港',0,'2026-10-24 15:30:00','2026-10-24 17:30:00','天津泰达足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',0,'system','2026-08-26 15:50:36',NULL,NULL,'0',NULL),(30,30,NULL,'2026中超第30轮：大连英博海发 vs 天津津门虎',0,'2026-11-08 15:30:00','2026-11-08 17:30:00','大连梭鱼湾足球场','公开赛程同步；数据源：https://www.tianjinfc.com/fixtures.html',0,'system','2026-08-26 15:50:36',NULL,'2026-08-28 23:47:57','0',NULL),(35,NULL,NULL,'赛前准备会议',2,'2026-09-11 10:00:00','2026-09-11 12:00:00','会议室',NULL,0,'system','2026-08-28 10:30:23',NULL,'2026-08-28 10:43:13','0',NULL),(36,NULL,NULL,'赛季壮行会',2,'2026-03-01 19:00:00','2026-03-01 21:00:00','天津市体育局',NULL,1,'system','2026-08-28 13:32:11',NULL,NULL,'0',NULL),(37,NULL,NULL,'2026中超第1轮：天津津门虎 vs 重庆铜梁龙 赛前新闻发布会',2,'2026-03-06 15:30:00','2026-03-06 17:30:00','天津泰达足球场','为2026中超第1轮：天津津门虎 vs 重庆铜梁龙召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(38,NULL,NULL,'2026中超第2轮：深圳新鹏城 vs 天津津门虎 赛前新闻发布会',2,'2026-03-13 20:00:00','2026-03-13 22:00:00','深圳市体育中心体育场','为2026中超第2轮：深圳新鹏城 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(39,NULL,NULL,'2026中超第4轮：天津津门虎 vs 上海申花 赛前新闻发布会',2,'2026-04-04 19:35:00','2026-04-04 21:35:00','天津泰达足球场','为2026中超第4轮：天津津门虎 vs 上海申花召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(40,NULL,NULL,'2026中超第5轮：天津津门虎 vs 青岛海牛 赛前新闻发布会',2,'2026-04-11 19:00:00','2026-04-11 21:00:00','天津泰达足球场','为2026中超第5轮：天津津门虎 vs 青岛海牛召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(41,NULL,NULL,'2026中超第6轮：云南玉昆 vs 天津津门虎 赛前新闻发布会',2,'2026-04-16 20:00:00','2026-04-16 22:00:00','云南玉溪高原体育运动中心体育场','为2026中超第6轮：云南玉昆 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(42,NULL,NULL,'2026中超第7轮：天津津门虎 vs 山东泰山 赛前新闻发布会',2,'2026-04-20 20:00:00','2026-04-20 22:00:00','天津泰达足球场','为2026中超第7轮：天津津门虎 vs 山东泰山召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(43,NULL,NULL,'2026中超第8轮：北京国安 vs 天津津门虎 赛前新闻发布会',2,'2026-04-24 19:35:00','2026-04-24 21:35:00','北京工人体育场','为2026中超第8轮：北京国安 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(44,NULL,NULL,'2026中超第9轮：天津津门虎 vs 武汉三镇 赛前新闻发布会',2,'2026-04-30 19:35:00','2026-04-30 21:35:00','天津泰达足球场','为2026中超第9轮：天津津门虎 vs 武汉三镇召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(45,NULL,NULL,'2026中超第10轮：青岛西海岸 vs 天津津门虎 赛前新闻发布会',2,'2026-05-04 19:00:00','2026-05-04 21:00:00','青岛西海岸大学城体育场','为2026中超第10轮：青岛西海岸 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(46,NULL,NULL,'2026中超第11轮：浙江俱乐部绿城 vs 天津津门虎 赛前新闻发布会',2,'2026-05-09 19:35:00','2026-05-09 21:35:00','黄龙体育中心体育场','为2026中超第11轮：浙江俱乐部绿城 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(47,NULL,NULL,'2026中超第12轮：天津津门虎 vs 成都蓉城 赛前新闻发布会',2,'2026-05-14 19:35:00','2026-05-14 21:35:00','天津泰达足球场','为2026中超第12轮：天津津门虎 vs 成都蓉城召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(48,NULL,NULL,'2026中超第13轮：天津津门虎 vs 河南俱乐部彩陶坊 赛前新闻发布会',2,'2026-05-18 19:35:00','2026-05-18 21:35:00','天津泰达足球场','为2026中超第13轮：天津津门虎 vs 河南俱乐部彩陶坊召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(49,NULL,NULL,'2026中超第14轮：上海海港 vs 天津津门虎 赛前新闻发布会',2,'2026-05-22 19:00:00','2026-05-22 21:00:00','上汽浦东足球场','为2026中超第14轮：上海海港 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(50,NULL,NULL,'2026中超第15轮：天津津门虎 vs 大连英博海发 赛前新闻发布会',2,'2026-05-30 19:00:00','2026-05-30 21:00:00','天津泰达足球场','为2026中超第15轮：天津津门虎 vs 大连英博海发召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(51,NULL,NULL,'2026中超第16轮：重庆铜梁龙 vs 天津津门虎 赛前新闻发布会',2,'2026-06-26 20:00:00','2026-06-26 22:00:00','重庆龙兴足球场','为2026中超第16轮：重庆铜梁龙 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(52,NULL,NULL,'2026中超第17轮：天津津门虎 vs 深圳新鹏城 赛前新闻发布会',2,'2026-07-03 20:00:00','2026-07-03 22:00:00','天津泰达足球场','为2026中超第17轮：天津津门虎 vs 深圳新鹏城召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(53,NULL,NULL,'2026中超第19轮：上海申花 vs 天津津门虎 赛前新闻发布会',2,'2026-07-17 19:35:00','2026-07-17 21:35:00','上海体育场','为2026中超第19轮：上海申花 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(54,NULL,NULL,'2026中超第20轮：青岛海牛 vs 天津津门虎 赛前新闻发布会',2,'2026-07-24 17:30:00','2026-07-24 19:30:00','青岛青春足球场','为2026中超第20轮：青岛海牛 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(55,NULL,NULL,'2026中超第21轮：天津津门虎 vs 云南玉昆 赛前新闻发布会',2,'2026-07-31 19:00:00','2026-07-31 21:00:00','天津泰达足球场','为2026中超第21轮：天津津门虎 vs 云南玉昆召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(56,NULL,NULL,'2026中超第22轮：山东泰山 vs 天津津门虎 赛前新闻发布会',2,'2026-08-08 20:00:00','2026-08-08 22:00:00','济南奥体中心','为2026中超第22轮：山东泰山 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(57,NULL,NULL,'2026中超第23轮：天津津门虎 vs 北京国安 赛前新闻发布会',2,'2026-08-14 19:35:00','2026-08-14 21:35:00','天津泰达足球场','为2026中超第23轮：天津津门虎 vs 北京国安召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(58,NULL,NULL,'2026中超第24轮：武汉三镇 vs 天津津门虎 赛前新闻发布会',2,'2026-08-21 19:00:00','2026-08-21 21:00:00','武汉体育中心体育场','为2026中超第24轮：武汉三镇 vs 天津津门虎召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(59,NULL,NULL,'2026中超第25轮：天津津门虎 vs 青岛西海岸 赛前新闻发布会',2,'2026-08-28 19:00:00','2026-08-28 21:00:00','天津泰达足球场','为2026中超第25轮：天津津门虎 vs 青岛西海岸召开的赛前准备会议',1,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(60,NULL,NULL,'2026中超第26轮：天津津门虎 vs 浙江俱乐部绿城 赛前新闻发布会',2,'2026-09-05 20:00:00','2026-09-05 22:00:00','天津泰达足球场','为2026中超第26轮：天津津门虎 vs 浙江俱乐部绿城召开的赛前准备会议',0,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(61,NULL,NULL,'2026中超第27轮：成都蓉城 vs 天津津门虎 赛前新闻发布会',2,'2026-10-09 19:35:00','2026-10-09 21:35:00','五粮液文化体育中心','为2026中超第27轮：成都蓉城 vs 天津津门虎召开的赛前准备会议',0,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(62,NULL,NULL,'2026中超第28轮：河南俱乐部彩陶坊 vs 天津津门虎 赛前新闻发布会',2,'2026-10-15 19:35:00','2026-10-15 21:35:00','郑州航海体育场','为2026中超第28轮：河南俱乐部彩陶坊 vs 天津津门虎召开的赛前准备会议',0,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(63,NULL,NULL,'2026中超第29轮：天津津门虎 vs 上海海港 赛前新闻发布会',2,'2026-10-23 15:30:00','2026-10-23 17:30:00','天津泰达足球场','为2026中超第29轮：天津津门虎 vs 上海海港召开的赛前准备会议',0,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(64,NULL,NULL,'2026中超第30轮：大连英博海发 vs 天津津门虎 赛前新闻发布会',2,'2026-11-07 15:30:00','2026-11-07 17:30:00','大连梭鱼湾足球场','为2026中超第30轮：大连英博海发 vs 天津津门虎召开的赛前准备会议',0,'system','2026-08-28 23:58:56',NULL,'2026-08-29 00:01:44','0',NULL),(68,NULL,1,'赛前体能储备训练',1,'2026-02-24 09:00:00','2026-02-24 11:00:00','训练基地1号场','训练类型：体能',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(69,NULL,2,'赛前战术演练',1,'2026-03-05 15:00:00','2026-03-05 17:00:00','训练基地1号场','训练类型：战术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(70,NULL,3,'赛后恢复训练',1,'2026-03-08 10:00:00','2026-03-08 12:00:00','训练基地健身房','训练类型：恢复',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(71,NULL,4,'定位球专项训练',1,'2026-03-12 09:30:00','2026-03-12 11:30:00','训练基地2号场','训练类型：技术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(72,NULL,5,'赛前热身准备',1,'2026-03-14 17:00:00','2026-03-14 19:00:00','深圳宝安体育中心','训练类型：热身',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(73,NULL,6,'体能恢复训练',1,'2026-04-07 09:00:00','2026-04-07 11:00:00','训练基地健身房','训练类型：体能',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(74,NULL,7,'防守战术训练',1,'2026-04-19 15:00:00','2026-04-19 17:00:00','训练基地1号场','训练类型：战术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(75,NULL,8,'进攻配合训练',1,'2026-05-03 09:00:00','2026-05-03 11:00:00','训练基地1号场','训练类型：技术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(76,NULL,9,'赛后恢复训练',1,'2026-05-06 10:00:00','2026-05-06 12:00:00','训练基地健身房','训练类型：恢复',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(77,NULL,10,'定位球专项训练',1,'2026-05-13 14:00:00','2026-05-13 16:00:00','训练基地2号场','训练类型：技术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(78,NULL,11,'体能储备训练',1,'2026-06-29 09:00:00','2026-06-29 11:00:00','训练基地1号场','训练类型：体能',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(79,NULL,12,'战术对抗训练',1,'2026-07-02 15:00:00','2026-07-02 17:00:00','训练基地1号场','训练类型：战术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(80,NULL,13,'赛前热身准备',1,'2026-07-18 17:00:00','2026-07-18 19:00:00','上海体育场','训练类型：热身',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(81,NULL,14,'赛后恢复训练',1,'2026-08-10 10:00:00','2026-08-10 12:00:00','训练基地健身房','训练类型：恢复',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(82,NULL,15,'赛前战术演练',1,'2026-08-28 09:00:00','2026-08-28 11:00:00','训练基地1号场','训练类型：战术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(83,NULL,16,'体能恢复训练',1,'2026-08-26 15:00:00','2026-08-26 17:00:00','训练基地健身房','训练类型：体能',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(84,NULL,17,'定位球专项训练',1,'2026-08-25 09:30:00','2026-08-25 11:30:00','训练基地2号场','训练类型：技术',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(85,NULL,18,'赛后恢复训练',1,'2026-08-23 10:00:00','2026-08-23 12:00:00','训练基地','训练类型：恢复',1,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(86,NULL,19,'热身赛准备',1,'2026-08-27 16:00:00','2026-08-27 18:00:00','天津泰达足球场','训练类型：热身',2,'system','2026-08-29 00:06:30',NULL,NULL,'0',NULL),(99,NULL,32,'赛后体能恢复',1,'2026-08-30 10:00:00','2026-08-30 12:00:00','水滴外场','体能恢复',1,'system','2026-08-30 13:45:29',NULL,'2026-09-04 09:21:20','0',NULL),(100,NULL,24,'赛前踩场训练',1,'2026-08-29 00:24:40','2026-08-29 01:24:32','1','1',1,'system','2026-08-29 00:25:00',NULL,'2026-08-31 09:21:01','0',NULL),(101,NULL,33,'战术演练',1,'2026-09-02 10:00:00','2026-09-02 12:00:00','水滴内场',NULL,1,'system','2026-08-31 19:10:03',NULL,'2026-09-04 11:01:38','0',NULL);
/*!40000 ALTER TABLE `football_schedule_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_schedule_player`
--

DROP TABLE IF EXISTS `football_schedule_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_schedule_player` (
  `id` bigint DEFAULT NULL,
  `event_id` bigint DEFAULT NULL,
  `player_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_schedule_player`
--

LOCK TABLES `football_schedule_player` WRITE;
/*!40000 ALTER TABLE `football_schedule_player` DISABLE KEYS */;
/*!40000 ALTER TABLE `football_schedule_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_season`
--

DROP TABLE IF EXISTS `football_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_season` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `season` varchar(9) NOT NULL COMMENT '赛季标识',
  `competition` varchar(64) NOT NULL COMMENT '赛事名称',
  `points_deduction` int NOT NULL DEFAULT '0' COMMENT '纪律扣分（正数表示扣除）',
  `league_rank` int DEFAULT NULL COMMENT '官方联赛排名快照',
  `team_count` int DEFAULT NULL COMMENT '联赛球队总数快照',
  `deduction_reason` varchar(500) DEFAULT NULL COMMENT '扣分原因',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '0=未开始,1=进行中,2=已结束',
  `source_url` varchar(1000) DEFAULT NULL,
  `source_as_of` date DEFAULT NULL,
  `create_by` varchar(64) NOT NULL DEFAULT 'system',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_season_competition` (`season`,`competition`),
  CONSTRAINT `ck_season_status` CHECK ((`status` in (0,1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='赛季/赛事';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_season`
--

LOCK TABLES `football_season` WRITE;
/*!40000 ALTER TABLE `football_season` DISABLE KEYS */;
INSERT INTO `football_season` (`id`, `season`, `competition`, `points_deduction`, `league_rank`, `team_count`, `deduction_reason`, `start_date`, `end_date`, `status`, `source_url`, `source_as_of`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1,'2026','中国足球超级联赛',10,14,16,'2026赛季开赛前纪律处罚，联赛积分扣10分','2026-03-07','2026-11-08',1,'https://www.tianjinfc.com/fixtures.html','2026-08-25','system','2026-08-26 15:50:36',NULL,'2026-08-28 19:08:06','比赛所得积分与积分榜积分应扣除10分后展示'),(2,'2026','中国足球协会杯',0,NULL,NULL,NULL,'2026-06-19','2026-06-19',2,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','2026-06-19','system','2026-08-26 15:50:36',NULL,NULL,'津门虎第4轮点球大战3-5负，总比分4-6出局');
/*!40000 ALTER TABLE `football_season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_team_logo`
--

DROP TABLE IF EXISTS `football_team_logo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_team_logo` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `team_name` varchar(64) NOT NULL COMMENT '球队名称(与football_match.home_team/away_team保持一致)',
  `logo_url` varchar(512) DEFAULT NULL COMMENT '队徽图片OSS完整URL(为空时前端显示"队名前两字"圆形兜底)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志(0=正常 2=已删除)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_team_name` (`team_name`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='球队队徽OSS映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_team_logo`
--

LOCK TABLES `football_team_logo` WRITE;
/*!40000 ALTER TABLE `football_team_logo` DISABLE KEYS */;
INSERT INTO `football_team_logo` (`id`, `team_name`, `logo_url`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1,'兰州陇原竞技','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a9400a013658c98cba5258b.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(2,'天津津门虎','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee0113657fb6434f12e1.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(3,'深圳新鹏城','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fdfb13658c98cba5257f.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(4,'云南玉昆','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe1113658c98cba52580.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(5,'北京国安','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe4113658c98cba52581.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(6,'青岛西海岸','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e2.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(7,'浙江俱乐部绿城','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e4.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(8,'上海海港','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe5613658c98cba52582.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(9,'重庆铜梁龙','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe7113658c98cba52583.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(10,'上海申花','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93feb413658c98cba52584.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(11,'青岛海牛','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93febd13658c98cba52585.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(12,'山东泰山','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e3.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(13,'武汉三镇','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fec813658c98cba52586.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(14,'成都蓉城','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fed113658c98cba52587.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(15,'河南俱乐部彩陶坊','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fee013658c98cba52588.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(16,'大连英博海发','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93feef13658c98cba52589.png',NULL,'',NULL,'','2026-08-30 21:12:13','0'),(17,'辽宁铁人楠波湾','https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fefc13658c98cba5258a.jpg',NULL,'',NULL,'','2026-08-30 21:12:13','0');
/*!40000 ALTER TABLE `football_team_logo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_training`
--

DROP TABLE IF EXISTS `football_training`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_training` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '训练ID',
  `season` varchar(50) DEFAULT NULL,
  `title` varchar(128) NOT NULL COMMENT '训练标题',
  `training_type` tinyint NOT NULL COMMENT '训练类型:0体能/1战术/2技术/3恢复/4热身',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `venue` varchar(128) DEFAULT NULL COMMENT '训练场地',
  `description` text COMMENT '训练描述',
  `training_goal` text COMMENT '训练目标',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态:0已计划/1已完成/2已取消',
  `create_by` varchar(64) NOT NULL DEFAULT 'system' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_training_time_status` (`start_time`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='训练计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_training`
--

LOCK TABLES `football_training` WRITE;
/*!40000 ALTER TABLE `football_training` DISABLE KEYS */;
INSERT INTO `football_training` (`id`, `season`, `title`, `training_type`, `start_time`, `end_time`, `venue`, `description`, `training_goal`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `remark`) VALUES (1,'2026','赛前体能储备训练',0,'2026-02-24 09:00:00','2026-02-24 11:30:00','训练基地1号场','赛季前体能储备，重点提升有氧耐力和核心力量','为2026赛季打好体能基础，确保球员达到比赛体能要求',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(2,'2026','赛前战术演练',1,'2026-03-05 15:00:00','2026-03-05 17:00:00','训练基地1号场','针对首轮对手重庆铜梁龙的战术部署，演练4-2-3-1阵型','熟悉首发阵容配合，明确各位置防守职责',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(3,'2026','赛后恢复训练',3,'2026-03-08 10:00:00','2026-03-08 11:30:00','训练基地健身房','首轮0-0平局后恢复性训练，重点放松肌肉','缓解比赛疲劳，预防伤病',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(4,'2026','定位球专项训练',2,'2026-03-12 09:30:00','2026-03-12 11:30:00','训练基地2号场','角球、任意球攻防演练，谢蒂内主罚练习','提高定位球得分效率，目标每场至少1次定位球威胁',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(5,'2026','赛前热身准备',4,'2026-03-14 17:00:00','2026-03-14 18:30:00','深圳宝安体育中心','客场对阵深圳新鹏城赛前热身','激活身体状态，适应客场场地',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(6,'2026','体能恢复训练',0,'2026-04-07 09:00:00','2026-04-07 11:00:00','训练基地健身房','第4轮2-3负申花后体能调整，加强下肢力量','恢复体能状态，为密集赛程做准备',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(7,'2026','防守战术训练',1,'2026-04-19 15:00:00','2026-04-19 17:30:00','训练基地1号场','针对山东泰山的防守部署，演练低位防守反击','强化防守组织，减少失球',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(8,'2026','进攻配合训练',2,'2026-05-03 09:00:00','2026-05-03 11:30:00','训练基地1号场','边路传中与中路包抄配合，基莱斯和谢维军锋线组合','提升进攻端配合默契度',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(9,'2026','赛后恢复训练',3,'2026-05-06 10:00:00','2026-05-06 11:30:00','训练基地健身房','客场1-1平青岛西海岸后恢复','放松肌肉，冰浴恢复',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(10,'2026','定位球专项训练',2,'2026-05-13 14:00:00','2026-05-13 16:00:00','训练基地2号场','任意球直接射门和战术角球演练','丰富定位球战术套路',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(11,'2026','体能储备训练',0,'2026-06-29 09:00:00','2026-06-29 11:30:00','训练基地1号场','间歇期后体能恢复训练，为下半赛季做准备','恢复赛季前体能水平',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(12,'2026','战术对抗训练',1,'2026-07-02 15:00:00','2026-07-02 17:30:00','训练基地1号场','分组对抗赛，演练新援萨尔瓦多的战术融入','帮助新援融入球队战术体系',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(13,'2026','赛前热身准备',4,'2026-07-18 17:00:00','2026-07-18 18:30:00','上海体育场','客场对阵上海申花赛前热身','适应客场氛围，调整比赛状态',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(14,'2026','赛后恢复训练',3,'2026-08-10 10:00:00','2026-08-10 11:30:00','训练基地健身房','客场1-2负山东泰山后恢复性训练','缓解比赛疲劳，处理轻微伤病',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(15,'2026','赛前战术演练',1,'2026-08-28 09:00:00','2026-08-28 11:00:00','训练基地1号场','针对青岛西海岸的战术部署','制定比赛策略，明确攻防要点',1,'system','2026-08-28 11:56:54',NULL,'2026-08-28 23:34:39','0',NULL),(16,'2026','体能恢复训练',0,'2026-08-26 15:00:00','2026-08-26 17:00:00','训练基地健身房','第22轮赛后体能恢复','恢复体能，为下一轮备战',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(17,'2026','定位球专项训练',2,'2026-08-25 09:30:00','2026-08-25 11:00:00','训练基地2号场','角球和任意球攻防演练','提高定位球转化率',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(18,'2026','赛后恢复训练',3,'2026-08-23 10:00:00','2026-08-23 11:30:00','训练基地','第23轮2-4负国安后恢复训练','放松身心，总结比赛',1,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(19,'2026','热身赛准备',4,'2026-08-27 16:00:00','2026-08-27 18:00:00','天津泰达足球场','与预备队热身赛准备','保持比赛感觉，考察年轻球员',2,'system','2026-08-28 11:56:54',NULL,NULL,'0',NULL),(24,NULL,'赛前踩场训练',4,'2026-08-29 00:24:40','2026-08-29 01:24:32','1','1','1',1,'system','2026-08-29 00:25:00',NULL,'2026-08-31 09:21:01','0',NULL),(32,NULL,'赛后体能恢复',0,'2026-08-30 10:00:00','2026-08-30 12:00:00','水滴外场','体能恢复',NULL,1,'system','2026-08-30 13:45:29',NULL,'2026-09-04 09:21:20','0',NULL),(33,NULL,'战术演练',1,'2026-09-02 10:00:00','2026-09-02 12:00:00','水滴内场',NULL,NULL,1,'system','2026-08-31 19:10:03',NULL,'2026-09-04 11:01:38','0',NULL);
/*!40000 ALTER TABLE `football_training` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_training_player`
--

DROP TABLE IF EXISTS `football_training_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_training_player` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `training_id` bigint NOT NULL COMMENT '训练ID',
  `player_id` bigint NOT NULL COMMENT '球员ID',
  `attendance_status` tinyint NOT NULL DEFAULT '0' COMMENT '出勤状态:0待确认/1已出勤/2缺勤/3请假',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_training_player` (`training_id`,`player_id`),
  KEY `idx_training_player_player` (`player_id`),
  CONSTRAINT `fk_training_player_training` FOREIGN KEY (`training_id`) REFERENCES `football_training` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1021 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='训练参与及出勤';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_training_player`
--

LOCK TABLES `football_training_player` WRITE;
/*!40000 ALTER TABLE `football_training_player` DISABLE KEYS */;
INSERT INTO `football_training_player` (`id`, `training_id`, `player_id`, `attendance_status`, `create_time`) VALUES (1,1,1,1,'2026-08-28 11:56:54'),(2,1,2,1,'2026-08-28 11:56:54'),(3,1,3,1,'2026-08-28 11:56:54'),(4,1,4,1,'2026-08-28 11:56:54'),(5,1,5,1,'2026-08-28 11:56:54'),(6,1,6,1,'2026-08-28 11:56:54'),(7,1,7,1,'2026-08-28 11:56:54'),(8,1,8,1,'2026-08-28 11:56:54'),(9,1,9,1,'2026-08-28 11:56:54'),(10,1,10,1,'2026-08-28 11:56:54'),(11,1,11,1,'2026-08-28 11:56:54'),(12,1,12,1,'2026-08-28 11:56:54'),(13,1,13,1,'2026-08-28 11:56:54'),(14,1,14,1,'2026-08-28 11:56:54'),(15,1,15,1,'2026-08-28 11:56:54'),(16,1,16,3,'2026-08-28 11:56:54'),(17,1,17,1,'2026-08-28 11:56:54'),(18,1,18,1,'2026-08-28 11:56:54'),(19,1,19,1,'2026-08-28 11:56:54'),(20,1,20,1,'2026-08-28 11:56:54'),(21,1,21,1,'2026-08-28 11:56:54'),(22,1,22,1,'2026-08-28 11:56:54'),(23,1,23,1,'2026-08-28 11:56:54'),(24,1,24,1,'2026-08-28 11:56:54'),(25,1,25,1,'2026-08-28 11:56:54'),(26,1,26,1,'2026-08-28 11:56:54'),(27,1,27,1,'2026-08-28 11:56:54'),(28,1,28,2,'2026-08-28 11:56:54'),(29,1,29,1,'2026-08-28 11:56:54'),(30,2,1,1,'2026-08-28 11:56:54'),(31,2,2,1,'2026-08-28 11:56:54'),(32,2,3,3,'2026-08-28 11:56:54'),(33,2,4,1,'2026-08-28 11:56:54'),(34,2,5,1,'2026-08-28 11:56:54'),(35,2,6,1,'2026-08-28 11:56:54'),(36,2,7,1,'2026-08-28 11:56:54'),(37,2,8,1,'2026-08-28 11:56:54'),(38,2,9,1,'2026-08-28 11:56:54'),(39,2,10,1,'2026-08-28 11:56:54'),(40,2,11,1,'2026-08-28 11:56:54'),(41,2,12,1,'2026-08-28 11:56:54'),(42,2,13,1,'2026-08-28 11:56:54'),(43,2,14,1,'2026-08-28 11:56:54'),(44,2,15,1,'2026-08-28 11:56:54'),(45,2,16,1,'2026-08-28 11:56:54'),(46,2,17,1,'2026-08-28 11:56:54'),(47,2,18,1,'2026-08-28 11:56:54'),(48,2,19,1,'2026-08-28 11:56:54'),(49,2,20,1,'2026-08-28 11:56:54'),(50,2,21,1,'2026-08-28 11:56:54'),(51,2,22,1,'2026-08-28 11:56:54'),(52,2,23,1,'2026-08-28 11:56:54'),(53,2,24,1,'2026-08-28 11:56:54'),(54,2,25,1,'2026-08-28 11:56:54'),(55,2,26,1,'2026-08-28 11:56:54'),(56,2,27,1,'2026-08-28 11:56:54'),(57,2,28,1,'2026-08-28 11:56:54'),(58,2,29,2,'2026-08-28 11:56:54'),(59,3,1,1,'2026-08-28 11:56:54'),(60,3,2,1,'2026-08-28 11:56:54'),(61,3,3,1,'2026-08-28 11:56:54'),(62,3,4,1,'2026-08-28 11:56:54'),(63,3,5,1,'2026-08-28 11:56:54'),(64,3,6,1,'2026-08-28 11:56:54'),(65,3,7,1,'2026-08-28 11:56:54'),(66,3,8,1,'2026-08-28 11:56:54'),(67,3,9,3,'2026-08-28 11:56:54'),(68,3,10,1,'2026-08-28 11:56:54'),(69,3,11,1,'2026-08-28 11:56:54'),(70,3,12,1,'2026-08-28 11:56:54'),(71,3,13,2,'2026-08-28 11:56:54'),(72,3,14,1,'2026-08-28 11:56:54'),(73,3,15,1,'2026-08-28 11:56:54'),(74,3,16,1,'2026-08-28 11:56:54'),(75,3,17,1,'2026-08-28 11:56:54'),(76,3,18,1,'2026-08-28 11:56:54'),(77,3,19,3,'2026-08-28 11:56:54'),(78,3,20,1,'2026-08-28 11:56:54'),(79,3,21,1,'2026-08-28 11:56:54'),(80,3,22,1,'2026-08-28 11:56:54'),(81,3,23,1,'2026-08-28 11:56:54'),(82,3,24,1,'2026-08-28 11:56:54'),(83,3,25,1,'2026-08-28 11:56:54'),(84,3,26,1,'2026-08-28 11:56:54'),(85,3,27,1,'2026-08-28 11:56:54'),(86,3,28,1,'2026-08-28 11:56:54'),(87,3,29,1,'2026-08-28 11:56:54'),(88,4,1,2,'2026-08-28 11:56:54'),(89,4,2,2,'2026-08-28 11:56:54'),(90,4,3,2,'2026-08-28 11:56:54'),(91,4,4,1,'2026-08-28 11:56:54'),(92,4,5,1,'2026-08-28 11:56:54'),(93,4,6,1,'2026-08-28 11:56:54'),(94,4,7,1,'2026-08-28 11:56:54'),(95,4,8,1,'2026-08-28 11:56:54'),(96,4,9,1,'2026-08-28 11:56:54'),(97,4,10,1,'2026-08-28 11:56:54'),(98,4,11,1,'2026-08-28 11:56:54'),(99,4,12,1,'2026-08-28 11:56:54'),(100,4,13,1,'2026-08-28 11:56:54'),(101,4,14,1,'2026-08-28 11:56:54'),(102,4,15,1,'2026-08-28 11:56:54'),(103,4,16,1,'2026-08-28 11:56:54'),(104,4,17,1,'2026-08-28 11:56:54'),(105,4,18,1,'2026-08-28 11:56:54'),(106,4,19,1,'2026-08-28 11:56:54'),(107,4,20,1,'2026-08-28 11:56:54'),(108,4,21,1,'2026-08-28 11:56:54'),(109,4,22,1,'2026-08-28 11:56:54'),(110,4,23,1,'2026-08-28 11:56:54'),(111,4,24,1,'2026-08-28 11:56:54'),(112,4,25,1,'2026-08-28 11:56:54'),(113,4,26,1,'2026-08-28 11:56:54'),(114,4,27,1,'2026-08-28 11:56:54'),(115,4,28,3,'2026-08-28 11:56:54'),(116,4,29,1,'2026-08-28 11:56:54'),(117,5,1,1,'2026-08-28 11:56:54'),(118,5,2,1,'2026-08-28 11:56:54'),(119,5,3,1,'2026-08-28 11:56:54'),(120,5,4,1,'2026-08-28 11:56:54'),(121,5,5,1,'2026-08-28 11:56:54'),(122,5,6,1,'2026-08-28 11:56:54'),(123,5,7,1,'2026-08-28 11:56:54'),(124,5,8,1,'2026-08-28 11:56:54'),(125,5,9,1,'2026-08-28 11:56:54'),(126,5,10,1,'2026-08-28 11:56:54'),(127,5,11,1,'2026-08-28 11:56:54'),(128,5,12,1,'2026-08-28 11:56:54'),(129,5,13,1,'2026-08-28 11:56:54'),(130,5,14,1,'2026-08-28 11:56:54'),(131,5,15,1,'2026-08-28 11:56:54'),(132,5,16,1,'2026-08-28 11:56:54'),(133,5,17,1,'2026-08-28 11:56:54'),(134,5,18,1,'2026-08-28 11:56:54'),(135,5,19,1,'2026-08-28 11:56:54'),(136,5,20,1,'2026-08-28 11:56:54'),(137,5,21,1,'2026-08-28 11:56:54'),(138,5,22,1,'2026-08-28 11:56:54'),(139,5,23,1,'2026-08-28 11:56:54'),(140,5,24,1,'2026-08-28 11:56:54'),(141,5,25,1,'2026-08-28 11:56:54'),(142,5,26,1,'2026-08-28 11:56:54'),(143,5,27,1,'2026-08-28 11:56:54'),(144,5,28,1,'2026-08-28 11:56:54'),(145,5,29,3,'2026-08-28 11:56:54'),(146,6,1,1,'2026-08-28 11:56:54'),(147,6,2,1,'2026-08-28 11:56:54'),(148,6,3,1,'2026-08-28 11:56:54'),(149,6,4,1,'2026-08-28 11:56:54'),(150,6,5,1,'2026-08-28 11:56:54'),(151,6,6,1,'2026-08-28 11:56:54'),(152,6,7,1,'2026-08-28 11:56:54'),(153,6,8,1,'2026-08-28 11:56:54'),(154,6,9,1,'2026-08-28 11:56:54'),(155,6,10,3,'2026-08-28 11:56:54'),(156,6,11,1,'2026-08-28 11:56:54'),(157,6,12,1,'2026-08-28 11:56:54'),(158,6,13,1,'2026-08-28 11:56:54'),(159,6,14,1,'2026-08-28 11:56:54'),(160,6,15,1,'2026-08-28 11:56:54'),(161,6,16,1,'2026-08-28 11:56:54'),(162,6,17,1,'2026-08-28 11:56:54'),(163,6,18,1,'2026-08-28 11:56:54'),(164,6,19,1,'2026-08-28 11:56:54'),(165,6,20,1,'2026-08-28 11:56:54'),(166,6,21,1,'2026-08-28 11:56:54'),(167,6,22,2,'2026-08-28 11:56:54'),(168,6,23,1,'2026-08-28 11:56:54'),(169,6,24,1,'2026-08-28 11:56:54'),(170,6,25,1,'2026-08-28 11:56:54'),(171,6,26,1,'2026-08-28 11:56:54'),(172,6,27,1,'2026-08-28 11:56:54'),(173,6,28,1,'2026-08-28 11:56:54'),(174,6,29,1,'2026-08-28 11:56:54'),(175,7,1,1,'2026-08-28 11:56:54'),(176,7,2,1,'2026-08-28 11:56:54'),(177,7,3,1,'2026-08-28 11:56:54'),(178,7,4,1,'2026-08-28 11:56:54'),(179,7,5,1,'2026-08-28 11:56:54'),(180,7,6,1,'2026-08-28 11:56:54'),(181,7,7,1,'2026-08-28 11:56:54'),(182,7,8,1,'2026-08-28 11:56:54'),(183,7,9,1,'2026-08-28 11:56:54'),(184,7,10,1,'2026-08-28 11:56:54'),(185,7,11,1,'2026-08-28 11:56:54'),(186,7,12,1,'2026-08-28 11:56:54'),(187,7,13,1,'2026-08-28 11:56:54'),(188,7,14,1,'2026-08-28 11:56:54'),(189,7,15,1,'2026-08-28 11:56:54'),(190,7,16,1,'2026-08-28 11:56:54'),(191,7,17,1,'2026-08-28 11:56:54'),(192,7,18,3,'2026-08-28 11:56:54'),(193,7,19,1,'2026-08-28 11:56:54'),(194,7,20,1,'2026-08-28 11:56:54'),(195,7,21,1,'2026-08-28 11:56:54'),(196,7,22,1,'2026-08-28 11:56:54'),(197,7,23,1,'2026-08-28 11:56:54'),(198,7,24,1,'2026-08-28 11:56:54'),(199,7,25,1,'2026-08-28 11:56:54'),(200,7,26,1,'2026-08-28 11:56:54'),(201,7,27,1,'2026-08-28 11:56:54'),(202,7,28,1,'2026-08-28 11:56:54'),(203,7,29,2,'2026-08-28 11:56:54'),(204,8,1,2,'2026-08-28 11:56:54'),(205,8,2,2,'2026-08-28 11:56:54'),(206,8,3,2,'2026-08-28 11:56:54'),(207,8,4,1,'2026-08-28 11:56:54'),(208,8,5,1,'2026-08-28 11:56:54'),(209,8,6,1,'2026-08-28 11:56:54'),(210,8,7,1,'2026-08-28 11:56:54'),(211,8,8,1,'2026-08-28 11:56:54'),(212,8,9,1,'2026-08-28 11:56:54'),(213,8,10,1,'2026-08-28 11:56:54'),(214,8,11,1,'2026-08-28 11:56:54'),(215,8,12,1,'2026-08-28 11:56:54'),(216,8,13,1,'2026-08-28 11:56:54'),(217,8,14,1,'2026-08-28 11:56:54'),(218,8,15,1,'2026-08-28 11:56:54'),(219,8,16,1,'2026-08-28 11:56:54'),(220,8,17,1,'2026-08-28 11:56:54'),(221,8,18,1,'2026-08-28 11:56:54'),(222,8,19,1,'2026-08-28 11:56:54'),(223,8,20,1,'2026-08-28 11:56:54'),(224,8,21,1,'2026-08-28 11:56:54'),(225,8,22,1,'2026-08-28 11:56:54'),(226,8,23,1,'2026-08-28 11:56:54'),(227,8,24,1,'2026-08-28 11:56:54'),(228,8,25,3,'2026-08-28 11:56:54'),(229,8,26,1,'2026-08-28 11:56:54'),(230,8,27,1,'2026-08-28 11:56:54'),(231,8,28,1,'2026-08-28 11:56:54'),(232,8,29,1,'2026-08-28 11:56:54'),(233,9,1,1,'2026-08-28 11:56:54'),(234,9,2,1,'2026-08-28 11:56:54'),(235,9,3,1,'2026-08-28 11:56:54'),(236,9,4,1,'2026-08-28 11:56:54'),(237,9,5,1,'2026-08-28 11:56:54'),(238,9,6,1,'2026-08-28 11:56:54'),(239,9,7,1,'2026-08-28 11:56:54'),(240,9,8,1,'2026-08-28 11:56:54'),(241,9,9,1,'2026-08-28 11:56:54'),(242,9,10,1,'2026-08-28 11:56:54'),(243,9,11,3,'2026-08-28 11:56:54'),(244,9,12,1,'2026-08-28 11:56:54'),(245,9,13,1,'2026-08-28 11:56:54'),(246,9,14,1,'2026-08-28 11:56:54'),(247,9,15,1,'2026-08-28 11:56:54'),(248,9,16,1,'2026-08-28 11:56:54'),(249,9,17,1,'2026-08-28 11:56:54'),(250,9,18,1,'2026-08-28 11:56:54'),(251,9,19,2,'2026-08-28 11:56:54'),(252,9,20,1,'2026-08-28 11:56:54'),(253,9,21,1,'2026-08-28 11:56:54'),(254,9,22,1,'2026-08-28 11:56:54'),(255,9,23,1,'2026-08-28 11:56:54'),(256,9,24,1,'2026-08-28 11:56:54'),(257,9,25,1,'2026-08-28 11:56:54'),(258,9,26,1,'2026-08-28 11:56:54'),(259,9,27,1,'2026-08-28 11:56:54'),(260,9,28,1,'2026-08-28 11:56:54'),(261,9,29,3,'2026-08-28 11:56:54'),(262,10,1,2,'2026-08-28 11:56:54'),(263,10,2,2,'2026-08-28 11:56:54'),(264,10,3,2,'2026-08-28 11:56:54'),(265,10,4,1,'2026-08-28 11:56:54'),(266,10,5,1,'2026-08-28 11:56:54'),(267,10,6,1,'2026-08-28 11:56:54'),(268,10,7,1,'2026-08-28 11:56:54'),(269,10,8,1,'2026-08-28 11:56:54'),(270,10,9,1,'2026-08-28 11:56:54'),(271,10,10,1,'2026-08-28 11:56:54'),(272,10,11,1,'2026-08-28 11:56:54'),(273,10,12,1,'2026-08-28 11:56:54'),(274,10,13,1,'2026-08-28 11:56:54'),(275,10,14,1,'2026-08-28 11:56:54'),(276,10,15,1,'2026-08-28 11:56:54'),(277,10,16,1,'2026-08-28 11:56:54'),(278,10,17,1,'2026-08-28 11:56:54'),(279,10,18,1,'2026-08-28 11:56:54'),(280,10,19,1,'2026-08-28 11:56:54'),(281,10,20,1,'2026-08-28 11:56:54'),(282,10,21,1,'2026-08-28 11:56:54'),(283,10,22,1,'2026-08-28 11:56:54'),(284,10,23,1,'2026-08-28 11:56:54'),(285,10,24,1,'2026-08-28 11:56:54'),(286,10,25,1,'2026-08-28 11:56:54'),(287,10,26,1,'2026-08-28 11:56:54'),(288,10,27,1,'2026-08-28 11:56:54'),(289,10,28,1,'2026-08-28 11:56:54'),(290,10,29,1,'2026-08-28 11:56:54'),(291,11,1,1,'2026-08-28 11:56:54'),(292,11,2,1,'2026-08-28 11:56:54'),(293,11,3,1,'2026-08-28 11:56:54'),(294,11,4,1,'2026-08-28 11:56:54'),(295,11,5,1,'2026-08-28 11:56:54'),(296,11,6,1,'2026-08-28 11:56:54'),(297,11,7,1,'2026-08-28 11:56:54'),(298,11,8,1,'2026-08-28 11:56:54'),(299,11,9,1,'2026-08-28 11:56:54'),(300,11,10,1,'2026-08-28 11:56:54'),(301,11,11,1,'2026-08-28 11:56:54'),(302,11,12,1,'2026-08-28 11:56:54'),(303,11,13,1,'2026-08-28 11:56:54'),(304,11,14,1,'2026-08-28 11:56:54'),(305,11,15,1,'2026-08-28 11:56:54'),(306,11,16,1,'2026-08-28 11:56:54'),(307,11,17,1,'2026-08-28 11:56:54'),(308,11,18,1,'2026-08-28 11:56:54'),(309,11,19,1,'2026-08-28 11:56:54'),(310,11,20,1,'2026-08-28 11:56:54'),(311,11,21,1,'2026-08-28 11:56:54'),(312,11,22,1,'2026-08-28 11:56:54'),(313,11,23,1,'2026-08-28 11:56:54'),(314,11,24,1,'2026-08-28 11:56:54'),(315,11,25,1,'2026-08-28 11:56:54'),(316,11,26,1,'2026-08-28 11:56:54'),(317,11,27,1,'2026-08-28 11:56:54'),(318,11,28,3,'2026-08-28 11:56:54'),(319,11,29,1,'2026-08-28 11:56:54'),(320,12,1,1,'2026-08-28 11:56:54'),(321,12,2,1,'2026-08-28 11:56:54'),(322,12,3,1,'2026-08-28 11:56:54'),(323,12,4,1,'2026-08-28 11:56:54'),(324,12,5,1,'2026-08-28 11:56:54'),(325,12,6,1,'2026-08-28 11:56:54'),(326,12,7,1,'2026-08-28 11:56:54'),(327,12,8,1,'2026-08-28 11:56:54'),(328,12,9,1,'2026-08-28 11:56:54'),(329,12,10,1,'2026-08-28 11:56:54'),(330,12,11,1,'2026-08-28 11:56:54'),(331,12,12,1,'2026-08-28 11:56:54'),(332,12,13,1,'2026-08-28 11:56:54'),(333,12,14,1,'2026-08-28 11:56:54'),(334,12,15,1,'2026-08-28 11:56:54'),(335,12,16,1,'2026-08-28 11:56:54'),(336,12,17,1,'2026-08-28 11:56:54'),(337,12,18,1,'2026-08-28 11:56:54'),(338,12,19,1,'2026-08-28 11:56:54'),(339,12,20,1,'2026-08-28 11:56:54'),(340,12,21,1,'2026-08-28 11:56:54'),(341,12,22,1,'2026-08-28 11:56:54'),(342,12,23,1,'2026-08-28 11:56:54'),(343,12,24,1,'2026-08-28 11:56:54'),(344,12,25,1,'2026-08-28 11:56:54'),(345,12,26,1,'2026-08-28 11:56:54'),(346,12,27,1,'2026-08-28 11:56:54'),(347,12,28,2,'2026-08-28 11:56:54'),(348,12,29,1,'2026-08-28 11:56:54'),(349,13,1,1,'2026-08-28 11:56:54'),(350,13,2,1,'2026-08-28 11:56:54'),(351,13,3,1,'2026-08-28 11:56:54'),(352,13,4,1,'2026-08-28 11:56:54'),(353,13,5,1,'2026-08-28 11:56:54'),(354,13,6,1,'2026-08-28 11:56:54'),(355,13,7,1,'2026-08-28 11:56:54'),(356,13,8,1,'2026-08-28 11:56:54'),(357,13,9,1,'2026-08-28 11:56:54'),(358,13,10,1,'2026-08-28 11:56:54'),(359,13,11,1,'2026-08-28 11:56:54'),(360,13,12,1,'2026-08-28 11:56:54'),(361,13,13,1,'2026-08-28 11:56:54'),(362,13,14,1,'2026-08-28 11:56:54'),(363,13,15,1,'2026-08-28 11:56:54'),(364,13,16,1,'2026-08-28 11:56:54'),(365,13,17,1,'2026-08-28 11:56:54'),(366,13,18,1,'2026-08-28 11:56:54'),(367,13,19,1,'2026-08-28 11:56:54'),(368,13,20,1,'2026-08-28 11:56:54'),(369,13,21,1,'2026-08-28 11:56:54'),(370,13,22,1,'2026-08-28 11:56:54'),(371,13,23,1,'2026-08-28 11:56:54'),(372,13,24,1,'2026-08-28 11:56:54'),(373,13,25,1,'2026-08-28 11:56:54'),(374,13,26,1,'2026-08-28 11:56:54'),(375,13,27,1,'2026-08-28 11:56:54'),(376,13,28,1,'2026-08-28 11:56:54'),(377,13,29,1,'2026-08-28 11:56:54'),(378,14,1,1,'2026-08-28 11:56:54'),(379,14,2,1,'2026-08-28 11:56:54'),(380,14,3,1,'2026-08-28 11:56:54'),(381,14,4,1,'2026-08-28 11:56:54'),(382,14,5,1,'2026-08-28 11:56:54'),(383,14,6,1,'2026-08-28 11:56:54'),(384,14,7,1,'2026-08-28 11:56:54'),(385,14,8,1,'2026-08-28 11:56:54'),(386,14,9,3,'2026-08-28 11:56:54'),(387,14,10,1,'2026-08-28 11:56:54'),(388,14,11,1,'2026-08-28 11:56:54'),(389,14,12,1,'2026-08-28 11:56:54'),(390,14,13,1,'2026-08-28 11:56:54'),(391,14,14,1,'2026-08-28 11:56:54'),(392,14,15,1,'2026-08-28 11:56:54'),(393,14,16,1,'2026-08-28 11:56:54'),(394,14,17,1,'2026-08-28 11:56:54'),(395,14,18,1,'2026-08-28 11:56:54'),(396,14,19,1,'2026-08-28 11:56:54'),(397,14,20,1,'2026-08-28 11:56:54'),(398,14,21,1,'2026-08-28 11:56:54'),(399,14,22,1,'2026-08-28 11:56:54'),(400,14,23,2,'2026-08-28 11:56:54'),(401,14,24,1,'2026-08-28 11:56:54'),(402,14,25,1,'2026-08-28 11:56:54'),(403,14,26,1,'2026-08-28 11:56:54'),(404,14,27,1,'2026-08-28 11:56:54'),(405,14,28,1,'2026-08-28 11:56:54'),(406,14,29,3,'2026-08-28 11:56:54'),(436,16,1,1,'2026-08-28 11:56:54'),(437,16,2,1,'2026-08-28 11:56:54'),(438,16,3,1,'2026-08-28 11:56:54'),(439,16,4,1,'2026-08-28 11:56:54'),(440,16,5,1,'2026-08-28 11:56:54'),(441,16,6,1,'2026-08-28 11:56:54'),(442,16,7,1,'2026-08-28 11:56:54'),(443,16,8,1,'2026-08-28 11:56:54'),(444,16,9,1,'2026-08-28 11:56:54'),(445,16,10,1,'2026-08-28 11:56:54'),(446,16,11,1,'2026-08-28 11:56:54'),(447,16,12,1,'2026-08-28 11:56:54'),(448,16,13,1,'2026-08-28 11:56:54'),(449,16,14,1,'2026-08-28 11:56:54'),(450,16,15,1,'2026-08-28 11:56:54'),(451,16,16,1,'2026-08-28 11:56:54'),(452,16,17,1,'2026-08-28 11:56:54'),(453,16,18,1,'2026-08-28 11:56:54'),(454,16,19,1,'2026-08-28 11:56:54'),(455,16,20,1,'2026-08-28 11:56:54'),(456,16,21,1,'2026-08-28 11:56:54'),(457,16,22,1,'2026-08-28 11:56:54'),(458,16,23,1,'2026-08-28 11:56:54'),(459,16,24,1,'2026-08-28 11:56:54'),(460,16,25,1,'2026-08-28 11:56:54'),(461,16,26,1,'2026-08-28 11:56:54'),(462,16,27,1,'2026-08-28 11:56:54'),(463,16,28,2,'2026-08-28 11:56:54'),(464,16,29,3,'2026-08-28 11:56:54'),(465,17,1,2,'2026-08-28 11:56:54'),(466,17,2,2,'2026-08-28 11:56:54'),(467,17,3,2,'2026-08-28 11:56:54'),(468,17,4,1,'2026-08-28 11:56:54'),(469,17,5,1,'2026-08-28 11:56:54'),(470,17,6,1,'2026-08-28 11:56:54'),(471,17,7,1,'2026-08-28 11:56:54'),(472,17,8,1,'2026-08-28 11:56:54'),(473,17,9,1,'2026-08-28 11:56:54'),(474,17,10,1,'2026-08-28 11:56:54'),(475,17,11,1,'2026-08-28 11:56:54'),(476,17,12,1,'2026-08-28 11:56:54'),(477,17,13,1,'2026-08-28 11:56:54'),(478,17,14,1,'2026-08-28 11:56:54'),(479,17,15,1,'2026-08-28 11:56:54'),(480,17,16,1,'2026-08-28 11:56:54'),(481,17,17,1,'2026-08-28 11:56:54'),(482,17,18,1,'2026-08-28 11:56:54'),(483,17,19,1,'2026-08-28 11:56:54'),(484,17,20,1,'2026-08-28 11:56:54'),(485,17,21,1,'2026-08-28 11:56:54'),(486,17,22,1,'2026-08-28 11:56:54'),(487,17,23,1,'2026-08-28 11:56:54'),(488,17,24,1,'2026-08-28 11:56:54'),(489,17,25,1,'2026-08-28 11:56:54'),(490,17,26,1,'2026-08-28 11:56:54'),(491,17,27,1,'2026-08-28 11:56:54'),(492,17,28,1,'2026-08-28 11:56:54'),(493,17,29,1,'2026-08-28 11:56:54'),(494,18,1,1,'2026-08-28 11:56:54'),(495,18,2,1,'2026-08-28 11:56:54'),(496,18,3,1,'2026-08-28 11:56:54'),(497,18,4,1,'2026-08-28 11:56:54'),(498,18,5,1,'2026-08-28 11:56:54'),(499,18,6,1,'2026-08-28 11:56:54'),(500,18,7,1,'2026-08-28 11:56:54'),(501,18,8,1,'2026-08-28 11:56:54'),(502,18,9,1,'2026-08-28 11:56:54'),(503,18,10,1,'2026-08-28 11:56:54'),(504,18,11,1,'2026-08-28 11:56:54'),(505,18,12,1,'2026-08-28 11:56:54'),(506,18,13,1,'2026-08-28 11:56:54'),(507,18,14,1,'2026-08-28 11:56:54'),(508,18,15,1,'2026-08-28 11:56:54'),(509,18,16,3,'2026-08-28 11:56:54'),(510,18,17,1,'2026-08-28 11:56:54'),(511,18,18,1,'2026-08-28 11:56:54'),(512,18,19,1,'2026-08-28 11:56:54'),(513,18,20,1,'2026-08-28 11:56:54'),(514,18,21,1,'2026-08-28 11:56:54'),(515,18,22,1,'2026-08-28 11:56:54'),(516,18,23,1,'2026-08-28 11:56:54'),(517,18,24,1,'2026-08-28 11:56:54'),(518,18,25,1,'2026-08-28 11:56:54'),(519,18,26,1,'2026-08-28 11:56:54'),(520,18,27,1,'2026-08-28 11:56:54'),(521,18,28,2,'2026-08-28 11:56:54'),(522,18,29,2,'2026-08-28 11:56:54'),(916,15,1,1,'2026-08-28 23:34:39'),(917,15,2,1,'2026-08-28 23:34:39'),(918,15,3,1,'2026-08-28 23:34:39'),(919,15,4,0,'2026-08-28 23:34:39'),(920,15,5,0,'2026-08-28 23:34:39'),(921,15,6,0,'2026-08-28 23:34:39'),(922,15,7,0,'2026-08-28 23:34:39'),(923,15,8,0,'2026-08-28 23:34:39'),(924,15,9,0,'2026-08-28 23:34:39'),(925,15,10,0,'2026-08-28 23:34:39'),(926,15,11,0,'2026-08-28 23:34:39'),(927,15,12,0,'2026-08-28 23:34:39'),(928,15,13,0,'2026-08-28 23:34:39'),(929,15,14,0,'2026-08-28 23:34:39'),(930,15,15,0,'2026-08-28 23:34:39'),(931,15,16,0,'2026-08-28 23:34:39'),(932,15,17,0,'2026-08-28 23:34:39'),(933,15,18,0,'2026-08-28 23:34:39'),(934,15,19,0,'2026-08-28 23:34:39'),(935,15,20,0,'2026-08-28 23:34:39'),(936,15,21,0,'2026-08-28 23:34:39'),(937,15,22,0,'2026-08-28 23:34:39'),(938,15,23,0,'2026-08-28 23:34:39'),(939,15,24,0,'2026-08-28 23:34:39'),(940,15,25,0,'2026-08-28 23:34:39'),(941,15,26,0,'2026-08-28 23:34:39'),(942,15,27,0,'2026-08-28 23:34:39'),(943,15,28,0,'2026-08-28 23:34:39'),(944,15,29,0,'2026-08-28 23:34:39');
/*!40000 ALTER TABLE `football_training_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_football_finance_summary`
--

DROP TABLE IF EXISTS `v_football_finance_summary`;
/*!50001 DROP VIEW IF EXISTS `v_football_finance_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_football_finance_summary` AS SELECT 
 1 AS `season`,
 1 AS `total_income`,
 1 AS `total_expense`,
 1 AS `net_profit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_football_next_match`
--

DROP TABLE IF EXISTS `v_football_next_match`;
/*!50001 DROP VIEW IF EXISTS `v_football_next_match`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_football_next_match` AS SELECT 
 1 AS `id`,
 1 AS `season`,
 1 AS `round_no`,
 1 AS `match_date`,
 1 AS `home_team`,
 1 AS `away_team`,
 1 AS `home_score`,
 1 AS `away_score`,
 1 AS `status`,
 1 AS `venue`,
 1 AS `competition_type`,
 1 AS `competition_name`,
 1 AS `source_url`,
 1 AS `source_as_of`,
 1 AS `create_by`,
 1 AS `create_time`,
 1 AS `update_by`,
 1 AS `update_time`,
 1 AS `del_flag`,
 1 AS `remark`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_football_season_snapshot`
--

DROP TABLE IF EXISTS `v_football_season_snapshot`;
/*!50001 DROP VIEW IF EXISTS `v_football_season_snapshot`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_football_season_snapshot` AS SELECT 
 1 AS `season`,
 1 AS `matches_played`,
 1 AS `wins`,
 1 AS `draws`,
 1 AS `losses`,
 1 AS `goals_for`,
 1 AS `goals_against`,
 1 AS `points_earned`,
 1 AS `table_points`,
 1 AS `points_deduction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_football_training_attendance`
--

DROP TABLE IF EXISTS `v_football_training_attendance`;
/*!50001 DROP VIEW IF EXISTS `v_football_training_attendance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_football_training_attendance` AS SELECT 
 1 AS `player_id`,
 1 AS `name_cn`,
 1 AS `planned_count`,
 1 AS `attended_count`,
 1 AS `attendance_rate`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_football_finance_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_football_finance_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_football_finance_summary` AS select `football_finance_record`.`season` AS `season`,sum((case when (`football_finance_record`.`record_type` = 0) then `football_finance_record`.`amount` else 0 end)) AS `total_income`,sum((case when (`football_finance_record`.`record_type` = 1) then `football_finance_record`.`amount` else 0 end)) AS `total_expense`,sum((case when (`football_finance_record`.`record_type` = 0) then `football_finance_record`.`amount` else -(`football_finance_record`.`amount`) end)) AS `net_profit` from `football_finance_record` where (`football_finance_record`.`del_flag` = '0') group by `football_finance_record`.`season` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_football_next_match`
--

/*!50001 DROP VIEW IF EXISTS `v_football_next_match`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_football_next_match` AS select `m`.`id` AS `id`,`m`.`season` AS `season`,`m`.`round_no` AS `round_no`,`m`.`match_date` AS `match_date`,`m`.`home_team` AS `home_team`,`m`.`away_team` AS `away_team`,`m`.`home_score` AS `home_score`,`m`.`away_score` AS `away_score`,`m`.`status` AS `status`,`m`.`venue` AS `venue`,`m`.`competition_type` AS `competition_type`,`m`.`competition_name` AS `competition_name`,`m`.`source_url` AS `source_url`,`m`.`source_as_of` AS `source_as_of`,`m`.`create_by` AS `create_by`,`m`.`create_time` AS `create_time`,`m`.`update_by` AS `update_by`,`m`.`update_time` AS `update_time`,`m`.`del_flag` AS `del_flag`,`m`.`remark` AS `remark` from `football_match` `m` where ((`m`.`status` in (0,2)) and (`m`.`del_flag` = '0') and (`m`.`match_date` >= now()) and (`m`.`match_date` = (select min(`m2`.`match_date`) from `football_match` `m2` where ((`m2`.`status` in (0,2)) and (`m2`.`del_flag` = '0') and (`m2`.`match_date` >= now()))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_football_season_snapshot`
--

/*!50001 DROP VIEW IF EXISTS `v_football_season_snapshot`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_football_season_snapshot` AS select `m`.`season` AS `season`,count(0) AS `matches_played`,sum((case when (((`m`.`home_team` = '天津津门虎') and (`m`.`home_score` > `m`.`away_score`)) or ((`m`.`away_team` = '天津津门虎') and (`m`.`away_score` > `m`.`home_score`))) then 1 else 0 end)) AS `wins`,sum((case when (`m`.`home_score` = `m`.`away_score`) then 1 else 0 end)) AS `draws`,sum((case when (((`m`.`home_team` = '天津津门虎') and (`m`.`home_score` < `m`.`away_score`)) or ((`m`.`away_team` = '天津津门虎') and (`m`.`away_score` > `m`.`home_score`))) then 1 else 0 end)) AS `losses`,sum((case when (`m`.`home_team` = '天津津门虎') then `m`.`home_score` else `m`.`away_score` end)) AS `goals_for`,sum((case when (`m`.`home_team` = '天津津门虎') then `m`.`away_score` else `m`.`home_score` end)) AS `goals_against`,sum((case when (((`m`.`home_team` = '天津津门虎') and (`m`.`home_score` > `m`.`away_score`)) or ((`m`.`away_team` = '天津津门虎') and (`m`.`away_score` > `m`.`home_score`))) then 3 when (`m`.`home_score` = `m`.`away_score`) then 1 else 0 end)) AS `points_earned`,(sum((case when (((`m`.`home_team` = '天津津门虎') and (`m`.`home_score` > `m`.`away_score`)) or ((`m`.`away_team` = '天津津门虎') and (`m`.`away_score` > `m`.`home_score`))) then 3 when (`m`.`home_score` = `m`.`away_score`) then 1 else 0 end)) - coalesce(`s`.`points_deduction`,0)) AS `table_points`,coalesce(`s`.`points_deduction`,0) AS `points_deduction` from (`football_match` `m` left join `football_season` `s` on(((`s`.`season` = `m`.`season`) and (`s`.`competition` = `m`.`competition_name`)))) where ((`m`.`status` = 1) and (`m`.`competition_name` = '中国足球超级联赛') and (`m`.`del_flag` = '0')) group by `m`.`season`,`s`.`points_deduction` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_football_training_attendance`
--

/*!50001 DROP VIEW IF EXISTS `v_football_training_attendance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_football_training_attendance` AS select `tp`.`player_id` AS `player_id`,`p`.`name_cn` AS `name_cn`,count(0) AS `planned_count`,sum((`tp`.`attendance_status` = 1)) AS `attended_count`,round(((100.0 * sum((`tp`.`attendance_status` = 1))) / nullif(count(0),0)),2) AS `attendance_rate` from ((`football_training_player` `tp` join `football_player` `p` on((`p`.`id` = `tp`.`player_id`))) join `football_training` `t` on(((`t`.`id` = `tp`.`training_id`) and (`t`.`del_flag` = '0')))) group by `tp`.`player_id`,`p`.`name_cn` */;
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

-- Dump completed on 2026-09-08 19:02:20
