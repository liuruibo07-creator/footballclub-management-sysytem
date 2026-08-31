-- =============================================
-- 联赛球队种子数据: 2026中国足球超级联赛16支球队 (幂等, 可重复执行)
-- 数据来源: football_match 中"中国足球超级联赛"赛事涉及的16支球队,
--           logo自动取自 football_team_logo 表已有OSS完整地址
--           (兰州陇原竞技仅出现在杯赛, 不导入)
-- 说明: 2026中超为16支球队(football_season.team_count=16);
--       若实际只需要14支, 请在页面上直接删除多余的2支
-- 执行方式 (在fc项目根目录):
--   mysql.exe -h192.168.120.174 -uroot -p1234 --default-character-set=utf8mb4 football-club < sql/seed_league_teams.sql
-- =============================================
SET NAMES utf8mb4;

INSERT IGNORE INTO football_league_team
(team_name, logo_url, league_name, division, status, dissolve_flag, manager_phone, liaison_admin, create_by, create_time, remark)
SELECT
  l.team_name,
  COALESCE(l.logo_url, ''),
  '中国足球超级联赛',
  '一线队',
  '1',
  '0',
  NULL,
  NULL,
  'admin',
  sysdate(),
  '2026中超种子数据'
FROM football_team_logo l
WHERE l.del_flag = '0'
  AND l.team_name IN (
    '上海海港', '上海申花', '云南玉昆', '北京国安',
    '大连英博海发', '天津津门虎', '山东泰山', '成都蓉城',
    '武汉三镇', '河南俱乐部彩陶坊', '浙江俱乐部绿城', '深圳新鹏城',
    '辽宁铁人楠波湾', '重庆铜梁龙', '青岛海牛', '青岛西海岸'
  );

-- 回显验证
SELECT team_name, league_name, division, status, dissolve_flag, logo_url
FROM football_league_team
WHERE del_flag = '0'
ORDER BY id;
