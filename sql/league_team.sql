-- =============================================
-- 联赛球队管理: 建表 + 菜单权限脚本 (幂等, 可重复执行)
-- 表:    football_league_team
-- 菜单:  联赛球队管理(2095) 挂载在 球队管理(2088) 下
--        按钮: 查询(2091)/新增(2092)/修改(2093)/删除(2094)
-- 权限串: league:team:list / query / add / edit / remove
-- 执行方式 (在fc项目根目录, 由用户自行执行):
--   mysql.exe -h192.168.120.174 -uroot -p1234 --default-character-set=utf8mb4 football-club < sql/league_team.sql
-- 说明:
--   1. 菜单也可通过管理后台「系统管理->菜单管理」手动添加, 本脚本为快捷方式;
--      执行后需在「角色管理」中给相应角色勾选新菜单权限(admin默认全选, 组员需手动分配)。
--   2. 删除为逻辑删除(del_flag=2), 同名球队名称唯一; 若删除后想重新添加同名球队,
--      需先把已删除记录的队名改掉或物理清理。
--   3. 菜单component=league/team/index 对应前端 src/views/league/team/index.vue。
--   4. 菜单ID曾用2090, 但2090已被队友"阵容准备度"菜单占用(2026-08-31), 故改用2095;
--      若曾执行过旧版(2090)且侧边栏无此菜单, 请执行 sql/fix_league_team_menu.sql 修复。
-- =============================================
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `football_league_team` (
  `id`             BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  `team_name`      VARCHAR(64)  NOT NULL                COMMENT '球队名称',
  `logo_url`       VARCHAR(512) NOT NULL                COMMENT '球队logo(OSS完整URL, 必填)',
  `league_name`    VARCHAR(64)  NOT NULL                COMMENT '所属联赛/赛事',
  `division`       VARCHAR(32)  NOT NULL                COMMENT '所属俱乐部分部(一线队/U21/U19/U17/青训梯队)',
  `status`         CHAR(1)      NOT NULL DEFAULT '1'    COMMENT '球队状态(0=停用 1=启用)',
  `dissolve_flag`  CHAR(1)      NOT NULL DEFAULT '0'    COMMENT '解散标记(0=正常 1=已解散)',
  `manager_phone`  VARCHAR(20)  DEFAULT NULL            COMMENT '领队电话',
  `liaison_admin`  VARCHAR(64)  DEFAULT NULL            COMMENT '对接管理员',
  `remark`         VARCHAR(255) DEFAULT NULL            COMMENT '备注',
  `create_by`      VARCHAR(64)  DEFAULT ''              COMMENT '创建者',
  `create_time`    DATETIME     DEFAULT NULL            COMMENT '创建时间',
  `update_by`      VARCHAR(64)  DEFAULT ''              COMMENT '更新者',
  `update_time`    DATETIME     DEFAULT NULL            COMMENT '更新时间',
  `del_flag`       CHAR(1)      DEFAULT '0'             COMMENT '删除标志(0=正常 2=已删除)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_team_name` (`team_name`),
  KEY `idx_status` (`status`, `del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='联赛球队表';

-- 菜单: 联赛球队管理(2095, 菜单C) + 4个按钮(2091-2094, 按钮F), 幂等(INSERT IGNORE)
INSERT IGNORE INTO sys_menu
(menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES
(2095, '联赛球队管理', 2088, 3, 'league', 'league/team/index', '', 1, 0, 'C', '0', '0', 'league:team:list', 'people', 'admin', sysdate(), '', NULL, '联赛球队管理菜单'),
(2091, '联赛球队查询', 2095, 1, '', '', '', 1, 0, 'F', '0', '0', 'league:team:query', '#', 'admin', sysdate(), '', NULL, ''),
(2092, '联赛球队新增', 2095, 2, '', '', '', 1, 0, 'F', '0', '0', 'league:team:add', '#', 'admin', sysdate(), '', NULL, ''),
(2093, '联赛球队修改', 2095, 3, '', '', '', 1, 0, 'F', '0', '0', 'league:team:edit', '#', 'admin', sysdate(), '', NULL, ''),
(2094, '联赛球队删除', 2095, 4, '', '', '', 1, 0, 'F', '0', '0', 'league:team:remove', '#', 'admin', sysdate(), '', NULL, '');

-- 回显验证
SELECT menu_id, menu_name, parent_id, perms, component FROM sys_menu WHERE menu_id IN (2095, 2091, 2092, 2093, 2094);
SELECT COUNT(1) AS league_team_table_exists FROM information_schema.tables WHERE table_schema = 'football-club' AND table_name = 'football_league_team';
