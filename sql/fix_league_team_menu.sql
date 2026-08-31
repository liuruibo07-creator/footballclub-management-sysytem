-- =============================================
-- 修复脚本: "联赛球队管理"菜单未出现在侧边栏的问题
-- 背景: league_team.sql 与队友的"阵容准备度"脚本同时使用了菜单ID 2090,
--       队友的菜单先插入(2090 阵容准备度, 挂在2087竞技管理下),
--       本模块的C菜单因 INSERT IGNORE 被静默跳过,
--       仅4个按钮(2091-2094)插入成功且挂在了阵容准备度(2090)下。
-- 本脚本: 用空闲ID 2095 重建"联赛球队管理"菜单(挂2088球队管理下),
--         把2091-2094四个按钮改挂到2095下, 并给角色补授权。幂等, 可重复执行。
-- 执行方式:
--   mysql.exe -h192.168.120.174 -uroot -p1234 --default-character-set=utf8mb4 football-club < sql/fix_league_team_menu.sql
-- =============================================
SET NAMES utf8mb4;

-- 1. 新建菜单 联赛球队管理(2095) 挂载在 球队管理(2088) 下
INSERT IGNORE INTO sys_menu
(menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES
(2095, '联赛球队管理', 2088, 3, 'league', 'league/team/index', '', 1, 0, 'C', '0', '0', 'league:team:list', 'people', 'admin', sysdate(), '', NULL, '联赛球队管理菜单(2090被阵容准备度占用, 改用2095)');

-- 2. 若库里2090已被"阵容准备度"占用, 把4个联赛球队按钮从2090改挂到2095
--    (若2090本身就是联赛球队管理, 则不动, 避免重复)
UPDATE sys_menu
SET parent_id = 2095
WHERE menu_id IN (2091, 2092, 2093, 2094)
  AND parent_id = 2090
  AND EXISTS (SELECT 1 FROM (SELECT menu_name FROM sys_menu WHERE menu_id = 2090) t WHERE t.menu_name <> '联赛球队管理');

-- 3. 角色授权: 超级管理员(1)/主教练(2)/助理教练(4)
--    admin本身全量可见, 此处主要补主教练与助理教练
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id
FROM sys_role r
JOIN sys_menu m ON m.menu_id IN (2095, 2091, 2092, 2093, 2094)
WHERE r.role_id IN (1, 2, 4);

-- 4. 回显验证
SELECT menu_id, menu_name, parent_id, perms, component FROM sys_menu WHERE menu_id IN (2095, 2091, 2092, 2093, 2094) ORDER BY menu_id;
SELECT role_id, menu_id FROM sys_role_menu WHERE menu_id IN (2095, 2091, 2092, 2093, 2094) ORDER BY role_id, menu_id;
