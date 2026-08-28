-- ============================================================
-- 球员赛季统计 - 增量数据补丁脚本
-- 生成时间: 2026-08-28
-- 用途: 补全 appearances(出场次数) 和 starts(首发次数) 的 NULL 值,
--       并为缺失球员新增统计记录
-- 注意: 此脚本只增不改, 不影响现有共享数据结构
--       可重复执行 (使用 INSERT IGNORE / UPDATE WHERE NULL)
-- ============================================================

-- 切换到项目数据库
USE `football-club`;

-- ===========================================
-- 第一部分: 补全现有记录中 NULL 的 appearances 和 starts
-- ===========================================

-- 阿尔韦托·基莱斯 (#9, 前锋) | 1866分钟 -> 出场22次, 首发17次
UPDATE football_player_season_stat
SET appearances = 22, starts = 17
WHERE id = 1 AND appearances IS NULL;

-- 布鲁诺·哈达斯 (#8, 中场) | 1878分钟 -> 出场22次, 首发19次
UPDATE football_player_season_stat
SET appearances = 22, starts = 19
WHERE id = 2 AND appearances IS NULL;

-- 吉列尔梅·谢蒂内 (#7, 前锋) | 1179分钟 -> 出场16次, 首发11次
UPDATE football_player_season_stat
SET appearances = 16, starts = 11
WHERE id = 3 AND appearances IS NULL;

-- 季胜攀 (#20, 中场) | 350分钟 -> 出场5次, 首发3次
UPDATE football_player_season_stat
SET appearances = 5, starts = 3
WHERE id = 4 AND appearances IS NULL;

-- 艾托尔·科尔多瓦 (#18, 后卫) | 1415分钟 -> 出场18次, 首发15次
UPDATE football_player_season_stat
SET appearances = 18, starts = 15
WHERE id = 5 AND appearances IS NULL;

-- 黄嘉辉 (#14, 中场) | 1305分钟 -> 出场17次, 首发12次
UPDATE football_player_season_stat
SET appearances = 17, starts = 12
WHERE id = 6 AND appearances IS NULL;

-- 王献钧 (#6, 后卫) | 974分钟 -> 出场13次, 首发11次
UPDATE football_player_season_stat
SET appearances = 13, starts = 11
WHERE id = 7 AND appearances IS NULL;

-- 克里斯蒂安·萨尔瓦多 (#10, 中场) | 361分钟 -> 出场5次, 首发3次
UPDATE football_player_season_stat
SET appearances = 5, starts = 3
WHERE id = 8 AND appearances IS NULL;

-- 巴顿 (#29, 中场) | 1598分钟 -> 出场20次, 首发17次
UPDATE football_player_season_stat
SET appearances = 20, starts = 17
WHERE id = 9 AND appearances IS NULL;

-- 闫炳良 (#25, 守门员) | 1575分钟 -> 出场19次, 首发19次
UPDATE football_player_season_stat
SET appearances = 19, starts = 19
WHERE id = 10 AND appearances IS NULL;

-- 杨帆 (#4, 后卫) | 1479分钟 -> 出场18次, 首发16次
UPDATE football_player_season_stat
SET appearances = 18, starts = 16
WHERE id = 11 AND appearances IS NULL;

-- 豪梅·格劳 (#5, 中场) | 1280分钟 -> 出场17次, 首发13次
UPDATE football_player_season_stat
SET appearances = 17, starts = 13
WHERE id = 12 AND appearances IS NULL;

-- 孙铭谦 (#31, 后卫) | 1080分钟 -> 出场14次, 首发13次
UPDATE football_player_season_stat
SET appearances = 14, starts = 13
WHERE id = 13 AND appearances IS NULL;

-- 王秋明 (#30, 中场) | 1057分钟 -> 出场15次, 首发13次
UPDATE football_player_season_stat
SET appearances = 15, starts = 13
WHERE id = 14 AND appearances IS NULL;

-- 谢维军 (#11, 前锋) | 801分钟 -> 出场11次, 首发9次
UPDATE football_player_season_stat
SET appearances = 11, starts = 9
WHERE id = 15 AND appearances IS NULL;

-- 吴兴涵 (#17, 后卫) | 714分钟 -> 出场9次, 首发8次
UPDATE football_player_season_stat
SET appearances = 9, starts = 8
WHERE id = 16 AND appearances IS NULL;

-- 王政豪 (#3, 后卫) | 667分钟 -> 出场9次, 首发8次
UPDATE football_player_season_stat
SET appearances = 9, starts = 8
WHERE id = 17 AND appearances IS NULL;

-- 陈哲宣 (#24, 中场) | 470分钟 -> 出场6次, 首发3次
UPDATE football_player_season_stat
SET appearances = 6, starts = 3
WHERE id = 18 AND appearances IS NULL;

-- 齐雨熙 (#21, 守门员) | 315分钟 -> 出场4次, 首发3次
UPDATE football_player_season_stat
SET appearances = 4, starts = 3
WHERE id = 19 AND appearances IS NULL;

-- 郭皓 (#28, 中场) | 277分钟 -> 出场4次, 首发2次
UPDATE football_player_season_stat
SET appearances = 4, starts = 2
WHERE id = 20 AND appearances IS NULL;

-- 石炎 (#40, 后卫) | 135分钟 -> 出场2次, 首发1次
UPDATE football_player_season_stat
SET appearances = 2, starts = 1
WHERE id = 21 AND appearances IS NULL;

-- 刘俊贤 (#19, 前锋) | 23分钟 -> 出场1次, 首发0次
UPDATE football_player_season_stat
SET appearances = 1, starts = 0
WHERE id = 22 AND appearances IS NULL;

-- 李永佳 (#22, 中场) | 8分钟 -> 出场1次, 首发0次
UPDATE football_player_season_stat
SET appearances = 1, starts = 0
WHERE id = 23 AND appearances IS NULL;

-- ===========================================
-- 第二部分: 为缺失球员新增赛季统计记录
-- ===========================================

-- 张皓然 (#26, 守门员) | 新增: 出场1次, 首发1次, 90分钟, 0球0助
INSERT IGNORE INTO football_player_season_stat
  (id, player_id, season, competition, appearances, starts, minutes_played,
   goals, assists, yellow_cards, red_cards, stat_as_of, source_url, create_by, create_time)
VALUES
  (24, 3, '2026', '中国足球超级联赛', 1, 1, 90,
   0, 0, 0, 0, '2026-08-10',
   'https://www.qiumiwu.com/team/tianjinjinmenhu/roster', 'system', NOW());

-- 李嗣镕 (#27, 后卫) | 新增: 出场4次, 首发3次, 299分钟, 0球1助
INSERT IGNORE INTO football_player_season_stat
  (id, player_id, season, competition, appearances, starts, minutes_played,
   goals, assists, yellow_cards, red_cards, stat_as_of, source_url, create_by, create_time)
VALUES
  (25, 9, '2026', '中国足球超级联赛', 4, 3, 299,
   0, 1, 1, 0, '2026-08-10',
   'https://www.qiumiwu.com/team/tianjinjinmenhu/roster', 'system', NOW());

-- 李帅琪 (#38, 后卫) | 新增: 出场4次, 首发2次, 192分钟, 0球0助
INSERT IGNORE INTO football_player_season_stat
  (id, player_id, season, competition, appearances, starts, minutes_played,
   goals, assists, yellow_cards, red_cards, stat_as_of, source_url, create_by, create_time)
VALUES
  (26, 11, '2026', '中国足球超级联赛', 4, 2, 192,
   0, 0, 1, 0, '2026-08-10',
   'https://www.qiumiwu.com/team/tianjinjinmenhu/roster', 'system', NOW());

-- 蔡承峻 (#39, 后卫) | 新增: 出场4次, 首发2次, 228分钟, 0球1助
INSERT IGNORE INTO football_player_season_stat
  (id, player_id, season, competition, appearances, starts, minutes_played,
   goals, assists, yellow_cards, red_cards, stat_as_of, source_url, create_by, create_time)
VALUES
  (27, 12, '2026', '中国足球超级联赛', 4, 2, 228,
   0, 1, 1, 0, '2026-08-10',
   'https://www.qiumiwu.com/team/tianjinjinmenhu/roster', 'system', NOW());

-- 刘帅 (#16, 中场) | 新增: 出场5次, 首发3次, 243分钟, 0球2助
INSERT IGNORE INTO football_player_season_stat
  (id, player_id, season, competition, appearances, starts, minutes_played,
   goals, assists, yellow_cards, red_cards, stat_as_of, source_url, create_by, create_time)
VALUES
  (28, 18, '2026', '中国足球超级联赛', 5, 3, 243,
   0, 2, 2, 0, '2026-08-10',
   'https://www.qiumiwu.com/team/tianjinjinmenhu/roster', 'system', NOW());

-- 乃博宁林 (#33, 中场) | 新增: 出场4次, 首发2次, 190分钟, 0球2助
INSERT IGNORE INTO football_player_season_stat
  (id, player_id, season, competition, appearances, starts, minutes_played,
   goals, assists, yellow_cards, red_cards, stat_as_of, source_url, create_by, create_time)
VALUES
  (29, 25, '2026', '中国足球超级联赛', 4, 2, 190,
   0, 2, 1, 0, '2026-08-10',
   'https://www.qiumiwu.com/team/tianjinjinmenhu/roster', 'system', NOW());

-- ===========================================
-- 汇总
-- 补全 appearances/starts: 23 条
-- 新增球员统计记录: 6 条
-- ===========================================