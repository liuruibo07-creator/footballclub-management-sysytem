-- ============================================================
-- 球队队徽OSS映射表 football_team_logo
-- 用途: 队名 -> 阿里云OSS队徽图片URL, 首页"下一场比赛"横幅按队名精确渲染队徽
-- 创建日期: 2026-08-30
-- 执行方式: mysql -h192.168.120.174 -P3306 -uroot -p1234 --default-character-set=utf8mb4 football-club < football_team_logo.sql
-- 说明: 脚本可重复执行(建表用 IF NOT EXISTS, 插入用 INSERT IGNORE)
-- ============================================================

SET NAMES utf8mb4;

-- ------------------------------------------------------------
-- 1. 建表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `football_team_logo` (
  `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  `team_name`   VARCHAR(64)  NOT NULL                COMMENT '球队名称(与football_match.home_team/away_team保持一致)',
  `logo_url`    VARCHAR(512) DEFAULT NULL            COMMENT '队徽图片OSS完整URL(为空时前端显示"队名前两字"圆形兜底)',
  `remark`      VARCHAR(255) DEFAULT NULL            COMMENT '备注',
  `create_by`   VARCHAR(64)  DEFAULT ''              COMMENT '创建者',
  `create_time` DATETIME     DEFAULT NULL            COMMENT '创建时间',
  `update_by`   VARCHAR(64)  DEFAULT ''              COMMENT '更新者',
  `update_time` DATETIME     DEFAULT NULL            COMMENT '更新时间',
  `del_flag`    CHAR(1)      DEFAULT '0'             COMMENT '删除标志(0=正常 2=已删除)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_team_name` (`team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='球队队徽OSS映射表';

-- ------------------------------------------------------------
-- 2. 预置当前赛季17支球队(logo_url先留空, 上传OSS后回填)
--    del_flag='0' 表示正常状态, 应用内查询可见
-- ------------------------------------------------------------
INSERT IGNORE INTO `football_team_logo` (`team_name`, `del_flag`) VALUES
('兰州陇原竞技','0'),
('天津津门虎','0'),
('深圳新鹏城','0'),
('云南玉昆','0'),
('北京国安','0'),
('青岛西海岸','0'),
('浙江俱乐部绿城','0'),
('上海海港','0'),
('重庆铜梁龙','0'),
('上海申花','0'),
('青岛海牛','0'),
('山东泰山','0'),
('武汉三镇','0'),
('成都蓉城','0'),
('河南俱乐部彩陶坊','0'),
('大连英博海发','0'),
('辽宁铁人楠波湾','0');

-- ------------------------------------------------------------
-- 3. 回填全部17支已上传OSS的队徽URL(2026-08-30已上传并验证公共可读)
--    执行方式: 直接重跑整个脚本即可(建表/插入均可重复执行, UPDATE幂等)
-- ------------------------------------------------------------
UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a9400a013658c98cba5258b.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '兰州陇原竞技' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee0113657fb6434f12e1.png',
       `update_time` = NOW()
 WHERE `team_name` = '天津津门虎' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fdfb13658c98cba5257f.png',
       `update_time` = NOW()
 WHERE `team_name` = '深圳新鹏城' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe1113658c98cba52580.png',
       `update_time` = NOW()
 WHERE `team_name` = '云南玉昆' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe4113658c98cba52581.png',
       `update_time` = NOW()
 WHERE `team_name` = '北京国安' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e2.png',
       `update_time` = NOW()
 WHERE `team_name` = '青岛西海岸' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e4.png',
       `update_time` = NOW()
 WHERE `team_name` = '浙江俱乐部绿城' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe5613658c98cba52582.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '上海海港' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fe7113658c98cba52583.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '重庆铜梁龙' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93feb413658c98cba52584.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '上海申花' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93febd13658c98cba52585.png',
       `update_time` = NOW()
 WHERE `team_name` = '青岛海牛' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93ee2313657fb6434f12e3.png',
       `update_time` = NOW()
 WHERE `team_name` = '山东泰山' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fec813658c98cba52586.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '武汉三镇' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fed113658c98cba52587.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '成都蓉城' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fee013658c98cba52588.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '河南俱乐部彩陶坊' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93feef13658c98cba52589.png',
       `update_time` = NOW()
 WHERE `team_name` = '大连英博海发' AND `del_flag` = '0';

UPDATE `football_team_logo`
   SET `logo_url` = 'https://football-team-logo.oss-cn-beijing.aliyuncs.com/logo/2026/08/30/6a93fefc13658c98cba5258a.jpg',
       `update_time` = NOW()
 WHERE `team_name` = '辽宁铁人楠波湾' AND `del_flag` = '0';
-- ------------------------------------------------------------
