-- 天津津门虎足球俱乐部管理系统（MySQL 8.0+）
-- 生成日期：2026-08-25（Asia/Shanghai）
-- 依据：需求分析文档(4).md、接口设计文档(2).md
--
-- 数据真实性原则：
-- 1. 球员名单采用 2026 赛季报名名单及 2026-07-24 更新名单；夏窗前后注册变化均保留。
-- 2. 中超赛程/比分更新至 2026-08-22。未赛、延期比赛的比分为 NULL。
-- 3. 球员累计技术统计采用 2026-08-10 数据快照，不与之后赛果混算。
-- 4. 合同薪资、俱乐部财务、训练及医疗档案属于非公开信息，因此仅建表，不编造初始化数据。
-- 5. source_url/source_as_of 用于记录公开数据出处与数据截止日期。

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;



-- ============================================================
-- 一、核心业务表
-- ============================================================

CREATE TABLE IF NOT EXISTS `football_season` (
  `id`              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  `season`          VARCHAR(9)   NOT NULL COMMENT '赛季标识',
  `competition`     VARCHAR(64)  NOT NULL COMMENT '赛事名称',
  `points_deduction` INT         NOT NULL DEFAULT 0 COMMENT '纪律扣分（正数表示扣除）',
  `deduction_reason` VARCHAR(500) DEFAULT NULL COMMENT '扣分原因',
  `start_date`      DATE         DEFAULT NULL,
  `end_date`        DATE         DEFAULT NULL,
  `status`          VARCHAR(16)  NOT NULL DEFAULT '进行中' COMMENT '未开始/进行中/已结束',
  `source_url`      VARCHAR(1000) DEFAULT NULL,
  `source_as_of`    DATE         DEFAULT NULL,
  `create_by`       VARCHAR(64)  NOT NULL DEFAULT 'system',
  `create_time`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`       VARCHAR(64)  DEFAULT NULL,
  `update_time`     DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark`          VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_season_competition` (`season`, `competition`)
) ENGINE=InnoDB COMMENT='赛季/赛事';

CREATE TABLE IF NOT EXISTS `football_player` (
  `id`              BIGINT       NOT NULL AUTO_INCREMENT,
  `jersey_number`   INT          NOT NULL,
  `name_cn`         VARCHAR(64)  NOT NULL,
  `name_en`         VARCHAR(128) DEFAULT NULL,
  `position`        VARCHAR(16)  NOT NULL COMMENT '守门员/后卫/中场/前锋',
  `nationality`     VARCHAR(32)  NOT NULL,
  `birth_date`      DATE         DEFAULT NULL,
  `height`          DECIMAL(3,2) DEFAULT NULL COMMENT '身高（米）',
  `preferred_foot`  VARCHAR(8)   DEFAULT NULL COMMENT '左脚/右脚/双脚',
  `status`          VARCHAR(16)  NOT NULL DEFAULT '活跃' COMMENT '活跃/非活跃',
  `registration_note` VARCHAR(255) DEFAULT NULL COMMENT '2026赛季报名变化说明',
  `user_id`         BIGINT       DEFAULT NULL COMMENT '若依 sys_user.user_id；跨库部署时不设外键',
  `source_url`      VARCHAR(1000) DEFAULT NULL,
  `source_as_of`    DATE         DEFAULT NULL,
  `create_by`       VARCHAR(64)  NOT NULL DEFAULT 'system',
  `create_time`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`       VARCHAR(64)  DEFAULT NULL,
  `update_time`     DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`        CHAR(1)      NOT NULL DEFAULT '0' COMMENT '0正常 2删除',
  `remark`          VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_player_name_birth` (`name_cn`, `birth_date`),
  KEY `idx_player_position_status` (`position`, `status`),
  KEY `idx_player_user` (`user_id`),
  CONSTRAINT `ck_player_position` CHECK (`position` IN ('守门员','后卫','中场','前锋')),
  CONSTRAINT `ck_player_status` CHECK (`status` IN ('活跃','非活跃')),
  CONSTRAINT `ck_player_height` CHECK (`height` IS NULL OR (`height` >= 1.40 AND `height` <= 2.20))
) ENGINE=InnoDB COMMENT='球员档案';

CREATE TABLE IF NOT EXISTS `football_player_contract` (
  `id`                BIGINT        NOT NULL AUTO_INCREMENT,
  `player_id`         BIGINT        NOT NULL,
  `contract_no`       VARCHAR(64)   NOT NULL,
  `contract_type`     VARCHAR(16)   NOT NULL COMMENT '标准合同/青年合同/短期合同',
  `start_date`        DATE          NOT NULL,
  `end_date`          DATE          NOT NULL,
  `base_salary`       DECIMAL(15,2) DEFAULT NULL COMMENT '非公开数据，不提供演示值',
  `signing_bonus`     DECIMAL(15,2) DEFAULT NULL,
  `performance_terms` TEXT          DEFAULT NULL,
  `status`            VARCHAR(16)   NOT NULL COMMENT '草拟中/已签署/已到期/已终止',
  `create_by`         VARCHAR(64)   NOT NULL DEFAULT 'system',
  `create_time`       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`         VARCHAR(64)   DEFAULT NULL,
  `update_time`       DATETIME      DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`          CHAR(1)       NOT NULL DEFAULT '0',
  `remark`            VARCHAR(500)  DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_contract_no` (`contract_no`),
  UNIQUE KEY `uk_contract_current_player` (`player_id`),
  CONSTRAINT `fk_contract_player` FOREIGN KEY (`player_id`) REFERENCES `football_player` (`id`),
  CONSTRAINT `ck_contract_dates` CHECK (`end_date` >= `start_date`),
  CONSTRAINT `ck_contract_status` CHECK (`status` IN ('草拟中','已签署','已到期','已终止'))
) ENGINE=InnoDB COMMENT='球员当前合同（公开资料不足，不预置敏感数据）';

CREATE TABLE IF NOT EXISTS `football_player_season_stat` (
  `id`              BIGINT      NOT NULL AUTO_INCREMENT,
  `player_id`       BIGINT      NOT NULL,
  `season`          VARCHAR(9)  NOT NULL,
  `competition`     VARCHAR(64) NOT NULL DEFAULT '中国足球超级联赛',
  `appearances`     INT         DEFAULT NULL COMMENT '来源未明确时保持NULL',
  `starts`          INT         DEFAULT NULL,
  `minutes_played`  INT         DEFAULT NULL,
  `goals`           INT         NOT NULL DEFAULT 0,
  `assists`         INT         NOT NULL DEFAULT 0,
  `yellow_cards`    INT         NOT NULL DEFAULT 0,
  `red_cards`       INT         NOT NULL DEFAULT 0,
  `stat_as_of`      DATE        NOT NULL COMMENT '统计快照截止日',
  `source_url`      VARCHAR(1000) DEFAULT NULL,
  `create_by`       VARCHAR(64) NOT NULL DEFAULT 'system',
  `create_time`     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`       VARCHAR(64) DEFAULT NULL,
  `update_time`     DATETIME    DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark`          VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_player_season_competition` (`player_id`, `season`, `competition`),
  KEY `idx_stat_season` (`season`, `competition`),
  CONSTRAINT `fk_stat_player` FOREIGN KEY (`player_id`) REFERENCES `football_player` (`id`),
  CONSTRAINT `ck_stat_nonnegative` CHECK (
    (`appearances` IS NULL OR `appearances` >= 0) AND
    (`starts` IS NULL OR `starts` >= 0) AND
    (`minutes_played` IS NULL OR `minutes_played` >= 0) AND
    `goals` >= 0 AND `assists` >= 0 AND `yellow_cards` >= 0 AND `red_cards` >= 0
  )
) ENGINE=InnoDB COMMENT='球员赛季统计快照';

CREATE TABLE IF NOT EXISTS `football_match` (
  `id`               BIGINT       NOT NULL AUTO_INCREMENT,
  `season`           VARCHAR(9)   NOT NULL,
  `round_no`         INT          DEFAULT NULL COMMENT '轮次；杯赛可为空',
  `match_date`       DATETIME     NOT NULL,
  `home_team`        VARCHAR(64)  NOT NULL,
  `away_team`        VARCHAR(64)  NOT NULL,
  `home_score`       INT          DEFAULT NULL,
  `away_score`       INT          DEFAULT NULL,
  `status`           VARCHAR(16)  NOT NULL COMMENT '已安排/已完成/已推迟/已取消',
  `venue`            VARCHAR(128) DEFAULT NULL,
  `competition_type` VARCHAR(16)  NOT NULL COMMENT '联赛/杯赛/友谊赛',
  `competition_name` VARCHAR(64)  NOT NULL,
  `source_url`       VARCHAR(1000) DEFAULT NULL,
  `source_as_of`     DATE         DEFAULT NULL,
  `create_by`        VARCHAR(64)  NOT NULL DEFAULT 'system',
  `create_time`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`        VARCHAR(64)  DEFAULT NULL,
  `update_time`      DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`         CHAR(1)      NOT NULL DEFAULT '0',
  `remark`           VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_match_comp_round_teams` (`season`, `competition_name`, `round_no`, `home_team`, `away_team`),
  KEY `idx_match_season_status_date` (`season`, `status`, `match_date`),
  CONSTRAINT `ck_match_status` CHECK (`status` IN ('已安排','已完成','已推迟','已取消')),
  CONSTRAINT `ck_match_scores` CHECK (
    (`status` = '已完成' AND `home_score` IS NOT NULL AND `away_score` IS NOT NULL) OR
    (`status` <> '已完成' AND `home_score` IS NULL AND `away_score` IS NULL)
  )
) ENGINE=InnoDB COMMENT='比赛';

CREATE TABLE IF NOT EXISTS `football_match_player` (
  `id`              BIGINT      NOT NULL AUTO_INCREMENT,
  `match_id`        BIGINT      NOT NULL,
  `player_id`       BIGINT      NOT NULL,
  `is_starter`      TINYINT(1)  NOT NULL DEFAULT 0,
  `minutes_played`  INT         DEFAULT NULL COMMENT '公开来源未提供准确值时保持NULL',
  `goals`           INT         DEFAULT NULL,
  `assists`         INT         DEFAULT NULL,
  `yellow_cards`    INT         DEFAULT NULL,
  `red_cards`       INT         DEFAULT NULL,
  `source_url`      VARCHAR(1000) DEFAULT NULL,
  `create_by`       VARCHAR(64) NOT NULL DEFAULT 'system',
  `create_time`     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`       VARCHAR(64) DEFAULT NULL,
  `update_time`     DATETIME    DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_match_player` (`match_id`, `player_id`),
  KEY `idx_match_player_player` (`player_id`),
  CONSTRAINT `fk_match_player_match` FOREIGN KEY (`match_id`) REFERENCES `football_match` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_match_player_player` FOREIGN KEY (`player_id`) REFERENCES `football_player` (`id`),
  CONSTRAINT `ck_match_player_minutes` CHECK (`minutes_played` IS NULL OR (`minutes_played` >= 0 AND `minutes_played` <= 130))
) ENGINE=InnoDB COMMENT='单场球员表现';

CREATE TABLE IF NOT EXISTS `football_training` (
  `id`              BIGINT       NOT NULL AUTO_INCREMENT,
  `season`          VARCHAR(9)   NOT NULL,
  `title`           VARCHAR(128) NOT NULL,
  `training_type`   VARCHAR(16)  NOT NULL COMMENT '体能/战术/技术/恢复/热身',
  `start_time`      DATETIME     NOT NULL,
  `end_time`        DATETIME     NOT NULL,
  `venue`           VARCHAR(128) DEFAULT NULL,
  `description`     TEXT         DEFAULT NULL,
  `training_goal`   TEXT         DEFAULT NULL,
  `status`           VARCHAR(16)  NOT NULL COMMENT '已计划/已完成/已取消',
  `create_by`        VARCHAR(64)  NOT NULL DEFAULT 'system',
  `create_time`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`        VARCHAR(64)  DEFAULT NULL,
  `update_time`      DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`         CHAR(1)      NOT NULL DEFAULT '0',
  `remark`           VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_training_time_status` (`start_time`, `status`),
  CONSTRAINT `ck_training_time` CHECK (`end_time` > `start_time`),
  CONSTRAINT `ck_training_type` CHECK (`training_type` IN ('体能','战术','技术','恢复','热身')),
  CONSTRAINT `ck_training_status` CHECK (`status` IN ('已计划','已完成','已取消'))
) ENGINE=InnoDB COMMENT='训练计划';

CREATE TABLE IF NOT EXISTS `football_training_player` (
  `id`                BIGINT      NOT NULL AUTO_INCREMENT,
  `training_id`       BIGINT      NOT NULL,
  `player_id`         BIGINT      NOT NULL,
  `attendance_status` VARCHAR(16) NOT NULL DEFAULT '待确认' COMMENT '待确认/已出勤/缺勤/请假',
  `create_time`       DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_training_player` (`training_id`, `player_id`),
  KEY `idx_training_player_player` (`player_id`),
  CONSTRAINT `fk_training_player_training` FOREIGN KEY (`training_id`) REFERENCES `football_training` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_training_player_player` FOREIGN KEY (`player_id`) REFERENCES `football_player` (`id`)
) ENGINE=InnoDB COMMENT='训练参与及出勤';

CREATE TABLE IF NOT EXISTS `football_schedule_event` (
  `id`              BIGINT       NOT NULL AUTO_INCREMENT,
  `match_id`        BIGINT       DEFAULT NULL COMMENT '比赛日程关联比赛，可空',
  `training_id`     BIGINT       DEFAULT NULL COMMENT '训练日程关联训练，可空',
  `title`           VARCHAR(128) NOT NULL,
  `event_type`      VARCHAR(16)  NOT NULL COMMENT '比赛/训练/会议',
  `start_time`      DATETIME     NOT NULL,
  `end_time`        DATETIME     NOT NULL,
  `location`        VARCHAR(128) DEFAULT NULL,
  `description`     TEXT         DEFAULT NULL,
  `status`          VARCHAR(16)  NOT NULL COMMENT '已安排/已完成/已取消/已推迟',
  `create_by`       VARCHAR(64)  NOT NULL DEFAULT 'system',
  `create_time`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`       VARCHAR(64)  DEFAULT NULL,
  `update_time`     DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`        CHAR(1)      NOT NULL DEFAULT '0',
  `remark`          VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_schedule_match` (`match_id`),
  UNIQUE KEY `uk_schedule_training` (`training_id`),
  KEY `idx_schedule_type_time` (`event_type`, `start_time`),
  CONSTRAINT `fk_schedule_match` FOREIGN KEY (`match_id`) REFERENCES `football_match` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_schedule_training` FOREIGN KEY (`training_id`) REFERENCES `football_training` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_schedule_time` CHECK (`end_time` > `start_time`),
  CONSTRAINT `ck_schedule_type` CHECK (`event_type` IN ('比赛','训练','会议'))
) ENGINE=InnoDB COMMENT='统一球队日程';

CREATE TABLE IF NOT EXISTS `football_schedule_player` (
  `id`          BIGINT   NOT NULL AUTO_INCREMENT,
  `event_id`    BIGINT   NOT NULL,
  `player_id`   BIGINT   NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_schedule_player` (`event_id`, `player_id`),
  KEY `idx_schedule_player_player` (`player_id`),
  CONSTRAINT `fk_schedule_player_event` FOREIGN KEY (`event_id`) REFERENCES `football_schedule_event` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_schedule_player_player` FOREIGN KEY (`player_id`) REFERENCES `football_player` (`id`)
) ENGINE=InnoDB COMMENT='日程参与人';

CREATE TABLE IF NOT EXISTS `football_injury` (
  `id`                   BIGINT       NOT NULL AUTO_INCREMENT,
  `player_id`            BIGINT       NOT NULL,
  `injury_type`          VARCHAR(64)  NOT NULL,
  `injury_location`      VARCHAR(64)  DEFAULT NULL,
  `injury_date`          DATE         NOT NULL,
  `expected_return_date` DATE         DEFAULT NULL,
  `actual_return_date`   DATE         DEFAULT NULL,
  `recovery_status`      VARCHAR(16)  NOT NULL COMMENT '未知/治疗中/康复中/已康复',
  `rehab_plan`           TEXT         DEFAULT NULL,
  `create_by`            VARCHAR(64)  NOT NULL DEFAULT 'system',
  `create_time`          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`            VARCHAR(64)  DEFAULT NULL,
  `update_time`          DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`             CHAR(1)      NOT NULL DEFAULT '0',
  `remark`               VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_injury_player_date` (`player_id`, `injury_date`),
  KEY `idx_injury_status` (`recovery_status`),
  CONSTRAINT `fk_injury_player` FOREIGN KEY (`player_id`) REFERENCES `football_player` (`id`),
  CONSTRAINT `ck_injury_status` CHECK (`recovery_status` IN ('未知','治疗中','康复中','已康复'))
) ENGINE=InnoDB COMMENT='伤病康复记录（敏感医疗数据，不预置）';

CREATE TABLE IF NOT EXISTS `football_finance_record` (
  `id`          BIGINT        NOT NULL AUTO_INCREMENT,
  `season`      VARCHAR(9)    NOT NULL,
  `record_type` VARCHAR(16)   NOT NULL COMMENT '收入/支出',
  `category`    VARCHAR(64)   NOT NULL,
  `amount`      DECIMAL(15,2) NOT NULL,
  `record_date` DATE          NOT NULL,
  `description` VARCHAR(500)  DEFAULT NULL,
  `create_by`   VARCHAR(64)   NOT NULL DEFAULT 'system',
  `create_time` DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`   VARCHAR(64)   DEFAULT NULL,
  `update_time` DATETIME      DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`    CHAR(1)       NOT NULL DEFAULT '0',
  `remark`      VARCHAR(500)  DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_finance_season_type_date` (`season`, `record_type`, `record_date`),
  CONSTRAINT `ck_finance_type` CHECK (`record_type` IN ('收入','支出')),
  CONSTRAINT `ck_finance_amount` CHECK (`amount` > 0)
) ENGINE=InnoDB COMMENT='财务收支（内部数据，不预置）';

CREATE TABLE IF NOT EXISTS `football_budget` (
  `id`            BIGINT        NOT NULL AUTO_INCREMENT,
  `season`        VARCHAR(9)    NOT NULL,
  `category`      VARCHAR(64)   NOT NULL,
  `budget_amount` DECIMAL(15,2) NOT NULL,
  `used_amount`   DECIMAL(15,2) NOT NULL DEFAULT 0,
  `create_by`     VARCHAR(64)   NOT NULL DEFAULT 'system',
  `create_time`   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by`     VARCHAR(64)   DEFAULT NULL,
  `update_time`   DATETIME      DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag`      CHAR(1)       NOT NULL DEFAULT '0',
  `remark`        VARCHAR(500)  DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_budget_season_category` (`season`, `category`),
  CONSTRAINT `ck_budget_amounts` CHECK (`budget_amount` >= 0 AND `used_amount` >= 0)
) ENGINE=InnoDB COMMENT='赛季预算（内部数据，不预置）';

CREATE TABLE IF NOT EXISTS `football_salary_cap` (
  `id`               BIGINT        NOT NULL AUTO_INCREMENT,
  `season`           VARCHAR(9)    NOT NULL,
  `salary_cap_limit` DECIMAL(15,2) NOT NULL,
  `policy_reference` VARCHAR(1000) DEFAULT NULL,
  `create_by`        VARCHAR(64)   NOT NULL DEFAULT 'system',
  `create_time`      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`      DATETIME      DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_salary_cap_season` (`season`),
  CONSTRAINT `ck_salary_cap_limit` CHECK (`salary_cap_limit` >= 0)
) ENGINE=InnoDB COMMENT='工资帽政策；具体限额需按正式政策录入';

-- ============================================================
-- 二、2026 赛季真实公开数据
-- ============================================================

INSERT INTO `football_season`
(`id`,`season`,`competition`,`points_deduction`,`deduction_reason`,`start_date`,`end_date`,`status`,`source_url`,`source_as_of`,`remark`)
VALUES
(1,'2026','中国足球超级联赛',10,'2026赛季开赛前纪律处罚，联赛积分扣10分','2026-03-07','2026-11-08','进行中',
 'https://www.tianjinfc.com/fixtures.html','2026-08-25','比赛所得积分与积分榜积分应扣除10分后展示'),
(2,'2026','中国足球协会杯',0,NULL,'2026-06-19','2026-06-19','已结束',
 'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','2026-06-19','津门虎第4轮点球大战3-5负，总比分4-6出局')
ON DUPLICATE KEY UPDATE
`points_deduction`=VALUES(`points_deduction`),`deduction_reason`=VALUES(`deduction_reason`),
`start_date`=VALUES(`start_date`),`end_date`=VALUES(`end_date`),`status`=VALUES(`status`),
`source_url`=VALUES(`source_url`),`source_as_of`=VALUES(`source_as_of`),`remark`=VALUES(`remark`);

-- 2026赛季球员：夏窗前后共出现29名注册球员；格劳为夏窗前球员，萨尔瓦多为更新名单球员。
INSERT INTO `football_player`
(`id`,`jersey_number`,`name_cn`,`name_en`,`position`,`nationality`,`birth_date`,`height`,`preferred_foot`,`status`,`registration_note`,`source_url`,`source_as_of`)
VALUES
(1,21,'齐雨熙','Qi Yuxi','守门员','中国','2006-07-18',NULL,NULL,'活跃',NULL,'https://match.sports.sina.com.cn/football/csl/team.php?dpc=1&id=148','2026-08-25'),
(2,25,'闫炳良','Yan Bingliang','守门员','中国','2000-04-03',1.97,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(3,26,'张皓然','Zhang Haoran','守门员','中国',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(4,3,'王政豪','Wang Zhenghao','后卫','中国',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(5,4,'杨帆','Yang Fan','后卫','中国','1996-03-28',1.82,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(6,6,'王献钧','Wang Xianjun','后卫','中国','2000-06-01',1.88,'左脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(7,17,'吴兴涵','Wu Xinghan','后卫','中国','1993-02-24',1.83,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(8,18,'艾托尔·科尔多瓦','Aitor Cordoba','后卫','西班牙','1995-05-21',1.91,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(9,27,'李嗣镕','Li Silong','后卫','中国',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(10,31,'孙铭谦','Sun Minghim','后卫','中国香港',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(11,38,'李帅琪','Li Shuaiqi','后卫','中国','2008-09-08',1.90,'右脚','活跃',NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28'),
(12,39,'蔡承峻','Cai Chengjun','后卫','中国','2005-01-31',1.83,'右脚','活跃',NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28'),
(13,40,'石炎','Shi Yan','后卫','中国',NULL,NULL,NULL,'活跃','公开名单同时也有将其列为前锋的资料；此处按2026-07-24阵容页','https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(14,5,'豪梅·格劳','Jaume Grau','中场','西班牙','1997-05-05',1.84,'左脚','非活跃','2026赛季上半程注册，夏窗更新名单中被萨尔瓦多替换','https://www.qtx.com/csl/279129.html','2026-08-10'),
(15,8,'布鲁诺·哈达斯','Bruno Xadas','中场','葡萄牙','1997-12-02',1.79,'左脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(16,10,'克里斯蒂安·萨尔瓦多','Cristian Salvador','中场','西班牙','1994-11-20',1.84,NULL,'活跃','冬窗因踝关节韧带手术暂未报名，夏窗回归更新名单','https://www.leisu.com/data/zuqiu/player-88945','2026-07-24'),
(17,14,'黄嘉辉','Huang Jiahui','中场','中国','2000-10-07',1.85,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(18,16,'刘帅','Liu Shuai','中场','中国','2004-11-26',1.79,'右脚','活跃',NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28'),
(19,20,'季胜攀','Ji Shengpan','中场','中国','1999-11-08',1.78,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(20,22,'李永佳','Li Yongjia','中场','中国',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(21,24,'陈哲宣','Chen Zhexuan','中场','中国','2003-09-24',1.81,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(22,28,'郭皓','Guo Hao','中场','中国',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(23,29,'巴顿','Ba Dun','中场','中国','1995-09-16',1.81,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(24,30,'王秋明','Wang Qiuming','中场','中国','1993-01-09',1.73,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(25,33,'乃博宁林','Naiboninglin','中场','中国','2006-03-13',1.86,'右脚','活跃',NULL,'https://m.zhibo8.cc/news/web/zuqiu/2026-02-28/69a2d65033a76native.htm','2026-02-28'),
(26,7,'吉列尔梅·谢蒂内','Guilherme Schettine','前锋','巴西','1995-10-10',1.80,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(27,9,'阿尔韦托·基莱斯','Alberto Quiles','前锋','西班牙','1995-04-27',1.88,'左脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(28,11,'谢维军','Xie Weijun','前锋','中国','1997-11-14',1.90,'右脚','活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24'),
(29,19,'刘俊贤','Liu Junxian','前锋','中国',NULL,NULL,NULL,'活跃',NULL,'https://www.qiumiwu.com/team/tianjinjinmenhu/roster','2026-07-24')
ON DUPLICATE KEY UPDATE
`jersey_number`=VALUES(`jersey_number`),`name_en`=VALUES(`name_en`),`position`=VALUES(`position`),
`nationality`=VALUES(`nationality`),`birth_date`=VALUES(`birth_date`),`height`=VALUES(`height`),
`preferred_foot`=VALUES(`preferred_foot`),`status`=VALUES(`status`),
`registration_note`=VALUES(`registration_note`),`source_url`=VALUES(`source_url`),`source_as_of`=VALUES(`source_as_of`);

-- 中超累计统计快照（截至2026-08-10；公开页面未明确出场/首发次数，故保持NULL）
INSERT INTO `football_player_season_stat`
(`player_id`,`season`,`competition`,`appearances`,`starts`,`minutes_played`,`goals`,`assists`,`yellow_cards`,`red_cards`,`stat_as_of`,`source_url`)
VALUES
(27,'2026','中国足球超级联赛',NULL,NULL,1866,10,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(15,'2026','中国足球超级联赛',NULL,NULL,1878,7,6,2,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(26,'2026','中国足球超级联赛',NULL,NULL,1179,6,2,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(19,'2026','中国足球超级联赛',NULL,NULL,350,3,1,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(8,'2026','中国足球超级联赛',NULL,NULL,1415,1,1,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(17,'2026','中国足球超级联赛',NULL,NULL,1305,1,1,4,1,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(6,'2026','中国足球超级联赛',NULL,NULL,974,1,0,4,1,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(16,'2026','中国足球超级联赛',NULL,NULL,361,1,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(23,'2026','中国足球超级联赛',NULL,NULL,1598,0,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(2,'2026','中国足球超级联赛',NULL,NULL,1575,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(5,'2026','中国足球超级联赛',NULL,NULL,1479,0,1,6,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(14,'2026','中国足球超级联赛',NULL,NULL,1280,0,0,4,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(10,'2026','中国足球超级联赛',NULL,NULL,1080,0,1,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(24,'2026','中国足球超级联赛',NULL,NULL,1057,0,0,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(28,'2026','中国足球超级联赛',NULL,NULL,801,0,0,3,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(7,'2026','中国足球超级联赛',NULL,NULL,714,0,0,4,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(4,'2026','中国足球超级联赛',NULL,NULL,667,0,2,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(21,'2026','中国足球超级联赛',NULL,NULL,470,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(1,'2026','中国足球超级联赛',NULL,NULL,315,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(22,'2026','中国足球超级联赛',NULL,NULL,277,0,0,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(13,'2026','中国足球超级联赛',NULL,NULL,135,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(29,'2026','中国足球超级联赛',NULL,NULL,23,0,1,0,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster'),
(20,'2026','中国足球超级联赛',NULL,NULL,8,0,0,1,0,'2026-08-10','https://www.qiumiwu.com/team/tianjinjinmenhu/roster')
ON DUPLICATE KEY UPDATE
`appearances`=VALUES(`appearances`),`starts`=VALUES(`starts`),`minutes_played`=VALUES(`minutes_played`),
`goals`=VALUES(`goals`),`assists`=VALUES(`assists`),`yellow_cards`=VALUES(`yellow_cards`),
`red_cards`=VALUES(`red_cards`),`stat_as_of`=VALUES(`stat_as_of`),`source_url`=VALUES(`source_url`);

-- 2026中超完整30轮赛程。第18轮延期至9月12日；截至8月22日的完赛比分已填入。
INSERT INTO `football_match`
(`id`,`season`,`round_no`,`match_date`,`home_team`,`away_team`,`home_score`,`away_score`,`status`,`venue`,`competition_type`,`competition_name`,`source_url`,`source_as_of`)
VALUES
(1,'2026',1,'2026-03-07 15:30:00','天津津门虎','重庆铜梁龙',0,0,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(2,'2026',2,'2026-03-14 20:00:00','深圳新鹏城','天津津门虎',1,0,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(3,'2026',3,'2026-03-21 15:30:00','辽宁铁人楠波湾','天津津门虎',3,0,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(4,'2026',4,'2026-04-05 19:35:00','天津津门虎','上海申花',2,3,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(5,'2026',5,'2026-04-12 19:00:00','天津津门虎','青岛海牛',1,1,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(6,'2026',6,'2026-04-17 20:00:00','云南玉昆','天津津门虎',0,3,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(7,'2026',7,'2026-04-21 20:00:00','天津津门虎','山东泰山',1,2,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(8,'2026',8,'2026-04-25 19:35:00','北京国安','天津津门虎',2,4,'已完成','北京工人体育场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(9,'2026',9,'2026-05-01 19:35:00','天津津门虎','武汉三镇',2,2,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(10,'2026',10,'2026-05-05 19:00:00','青岛西海岸','天津津门虎',1,1,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(11,'2026',11,'2026-05-10 19:35:00','浙江俱乐部绿城','天津津门虎',1,1,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(12,'2026',12,'2026-05-15 19:35:00','天津津门虎','成都蓉城',1,2,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(13,'2026',13,'2026-05-19 19:35:00','天津津门虎','河南俱乐部彩陶坊',1,2,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(14,'2026',14,'2026-05-23 19:00:00','上海海港','天津津门虎',1,1,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(15,'2026',15,'2026-05-31 19:00:00','天津津门虎','大连英博海发',1,0,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(16,'2026',16,'2026-06-27 20:00:00','重庆铜梁龙','天津津门虎',1,0,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(17,'2026',17,'2026-07-04 20:00:00','天津津门虎','深圳新鹏城',3,0,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(18,'2026',18,'2026-09-12 19:00:00','天津津门虎','辽宁铁人楠波湾',NULL,NULL,'已推迟','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(19,'2026',19,'2026-07-18 19:35:00','上海申花','天津津门虎',0,2,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(20,'2026',20,'2026-07-25 17:30:00','青岛海牛','天津津门虎',0,2,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(21,'2026',21,'2026-08-01 19:00:00','天津津门虎','云南玉昆',3,2,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(22,'2026',22,'2026-08-09 20:00:00','山东泰山','天津津门虎',2,1,'已完成',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(23,'2026',23,'2026-08-15 19:35:00','天津津门虎','北京国安',2,4,'已完成','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(24,'2026',24,'2026-08-22 19:00:00','武汉三镇','天津津门虎',0,0,'已完成','武汉体育中心体育场','联赛','中国足球超级联赛','https://sports.cctv.com/2026/08/22/ARTIMJRwHuZoOa8OOeJ2Fmhv260822.shtml','2026-08-25'),
(25,'2026',25,'2026-08-29 19:00:00','天津津门虎','青岛西海岸',NULL,NULL,'已安排','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(26,'2026',26,'2026-09-06 20:00:00','天津津门虎','浙江俱乐部绿城',NULL,NULL,'已安排','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(27,'2026',27,'2026-10-10 19:35:00','成都蓉城','天津津门虎',NULL,NULL,'已安排',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(28,'2026',28,'2026-10-16 19:35:00','河南俱乐部彩陶坊','天津津门虎',NULL,NULL,'已安排',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(29,'2026',29,'2026-10-24 15:30:00','天津津门虎','上海海港',NULL,NULL,'已安排','天津泰达足球场','联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25'),
(30,'2026',30,'2026-11-08 15:30:00','大连英博海发','天津津门虎',NULL,NULL,'已安排',NULL,'联赛','中国足球超级联赛','https://www.tianjinfc.com/fixtures.html','2026-08-25')
ON DUPLICATE KEY UPDATE
`match_date`=VALUES(`match_date`),`home_score`=VALUES(`home_score`),`away_score`=VALUES(`away_score`),
`status`=VALUES(`status`),`venue`=VALUES(`venue`),`source_url`=VALUES(`source_url`),`source_as_of`=VALUES(`source_as_of`);

-- 2026中国足协杯第4轮：常规时间1-1，津门虎点球大战3-5负（总比分4-6）。
INSERT INTO `football_match`
(`id`,`season`,`round_no`,`match_date`,`home_team`,`away_team`,`home_score`,`away_score`,`status`,`venue`,`competition_type`,`competition_name`,`source_url`,`source_as_of`,`remark`)
VALUES
(31,'2026',4,'2026-06-19 19:30:00','兰州陇原竞技','天津津门虎',1,1,'已完成','兰州奥体中心玫瑰场','杯赛','中国足球协会杯',
 'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm','2026-06-19','点球大战：兰州陇原竞技5-3天津津门虎；总比分4-6，津门虎出局')
ON DUPLICATE KEY UPDATE
`match_date`=VALUES(`match_date`),`home_score`=VALUES(`home_score`),`away_score`=VALUES(`away_score`),
`status`=VALUES(`status`),`venue`=VALUES(`venue`),`source_url`=VALUES(`source_url`),
`source_as_of`=VALUES(`source_as_of`),`remark`=VALUES(`remark`);

-- 第11轮浙江1-1津门虎：公开报道给出的真实出场名单。
-- 技术统计中仅确认哈达斯点球破门；未由来源明确的分钟/助攻/牌数保持NULL。
INSERT INTO `football_match_player`
(`match_id`,`player_id`,`is_starter`,`minutes_played`,`goals`,`assists`,`yellow_cards`,`red_cards`,`source_url`)
VALUES
(11,2,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,5,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,6,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,8,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,10,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,14,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,15,1,NULL,1,0,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,17,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,23,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,24,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,27,1,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,7,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,13,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,19,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,21,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html'),
(11,28,0,NULL,0,NULL,NULL,NULL,'https://www.ttplus.cn/publish/app/data/2026/05/10/583210/os_news.html')
ON DUPLICATE KEY UPDATE
`is_starter`=VALUES(`is_starter`),`minutes_played`=VALUES(`minutes_played`),`goals`=VALUES(`goals`),
`assists`=VALUES(`assists`),`yellow_cards`=VALUES(`yellow_cards`),`red_cards`=VALUES(`red_cards`),
`source_url`=VALUES(`source_url`);

-- 足协杯第4轮津门虎真实出场名单；王政豪打入津门虎常规时间进球。
INSERT INTO `football_match_player`
(`match_id`,`player_id`,`is_starter`,`minutes_played`,`goals`,`assists`,`yellow_cards`,`red_cards`,`source_url`)
VALUES
(31,3,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,12,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,6,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,4,1,NULL,1,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,11,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,9,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,20,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,25,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,21,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,18,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,29,1,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,5,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,7,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,19,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,22,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm'),
(31,28,0,NULL,0,NULL,NULL,NULL,'https://news.zhibo8.com/zuqiu/2026-06-19/match1982562date2026vnative.htm')
ON DUPLICATE KEY UPDATE
`is_starter`=VALUES(`is_starter`),`minutes_played`=VALUES(`minutes_played`),`goals`=VALUES(`goals`),
`assists`=VALUES(`assists`),`yellow_cards`=VALUES(`yellow_cards`),`red_cards`=VALUES(`red_cards`),
`source_url`=VALUES(`source_url`);

-- 比赛自动映射到统一日程。训练与会议应由俱乐部内部用户录入。
INSERT INTO `football_schedule_event`
(`match_id`,`title`,`event_type`,`start_time`,`end_time`,`location`,`description`,`status`,`create_by`)
SELECT
  m.id,
  CONCAT('2026中超第', m.round_no, '轮：', m.home_team, ' vs ', m.away_team),
  '比赛', m.match_date, DATE_ADD(m.match_date, INTERVAL 2 HOUR), m.venue,
  CONCAT('公开赛程同步；数据源：', m.source_url),
  CASE m.status WHEN '已完成' THEN '已完成' WHEN '已推迟' THEN '已推迟' ELSE '已安排' END,
  'system'
FROM `football_match` m
WHERE m.season='2026' AND m.competition_name='中国足球超级联赛'
ON DUPLICATE KEY UPDATE
`title`=VALUES(`title`),`start_time`=VALUES(`start_time`),`end_time`=VALUES(`end_time`),
`location`=VALUES(`location`),`description`=VALUES(`description`),`status`=VALUES(`status`);

-- ============================================================
-- 三、接口聚合视图
-- ============================================================

CREATE OR REPLACE VIEW `v_football_season_snapshot` AS
SELECT
  m.season,
  COUNT(*) AS matches_played,
  SUM(CASE
      WHEN (m.home_team='天津津门虎' AND m.home_score>m.away_score)
        OR (m.away_team='天津津门虎' AND m.away_score>m.home_score) THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN m.home_score=m.away_score THEN 1 ELSE 0 END) AS draws,
  SUM(CASE
      WHEN (m.home_team='天津津门虎' AND m.home_score<m.away_score)
        OR (m.away_team='天津津门虎' AND m.away_score<m.home_score) THEN 1 ELSE 0 END) AS losses,
  SUM(CASE WHEN m.home_team='天津津门虎' THEN m.home_score ELSE m.away_score END) AS goals_for,
  SUM(CASE WHEN m.home_team='天津津门虎' THEN m.away_score ELSE m.home_score END) AS goals_against,
  SUM(CASE
      WHEN (m.home_team='天津津门虎' AND m.home_score>m.away_score)
        OR (m.away_team='天津津门虎' AND m.away_score>m.home_score) THEN 3
      WHEN m.home_score=m.away_score THEN 1 ELSE 0 END) AS points_earned,
  SUM(CASE
      WHEN (m.home_team='天津津门虎' AND m.home_score>m.away_score)
        OR (m.away_team='天津津门虎' AND m.away_score>m.home_score) THEN 3
      WHEN m.home_score=m.away_score THEN 1 ELSE 0 END) - COALESCE(s.points_deduction,0) AS table_points,
  COALESCE(s.points_deduction,0) AS points_deduction
FROM `football_match` m
LEFT JOIN `football_season` s
  ON s.season=m.season AND s.competition=m.competition_name
WHERE m.status='已完成'
  AND m.competition_name='中国足球超级联赛'
  AND m.del_flag='0'
GROUP BY m.season, s.points_deduction;

CREATE OR REPLACE VIEW `v_football_next_match` AS
SELECT m.*
FROM `football_match` m
WHERE m.status IN ('已安排','已推迟')
  AND m.del_flag='0'
  AND m.match_date >= CURRENT_TIMESTAMP
  AND m.match_date = (
    SELECT MIN(m2.match_date)
    FROM `football_match` m2
    WHERE m2.status IN ('已安排','已推迟')
      AND m2.del_flag='0'
      AND m2.match_date >= CURRENT_TIMESTAMP
  );

CREATE OR REPLACE VIEW `v_football_finance_summary` AS
SELECT
  season,
  SUM(CASE WHEN record_type='收入' THEN amount ELSE 0 END) AS total_income,
  SUM(CASE WHEN record_type='支出' THEN amount ELSE 0 END) AS total_expense,
  SUM(CASE WHEN record_type='收入' THEN amount ELSE -amount END) AS net_profit
FROM `football_finance_record`
WHERE del_flag='0'
GROUP BY season;

CREATE OR REPLACE VIEW `v_football_training_attendance` AS
SELECT
  tp.player_id,
  p.name_cn,
  COUNT(*) AS planned_count,
  SUM(tp.attendance_status='已出勤') AS attended_count,
  ROUND(100.0 * SUM(tp.attendance_status='已出勤') / NULLIF(COUNT(*),0), 2) AS attendance_rate
FROM `football_training_player` tp
JOIN `football_player` p ON p.id=tp.player_id
JOIN `football_training` t ON t.id=tp.training_id AND t.del_flag='0'
GROUP BY tp.player_id, p.name_cn;

SET FOREIGN_KEY_CHECKS = 1;

-- 安装后校验（预期截至2026-08-25：23场、7胜7平9负、进32失30、所得28分、扣分后18分）
SELECT * FROM `v_football_season_snapshot` WHERE `season`='2026';
SELECT COUNT(*) AS player_records_2026 FROM `football_player` WHERE `del_flag`='0';
SELECT COUNT(*) AS scheduled_league_matches FROM `football_match`
 WHERE `season`='2026' AND `competition_name`='中国足球超级联赛' AND `del_flag`='0';
