-- 若依 RuoYi 3.8.7：天津津门虎业务菜单、权限与四类角色
-- 前置条件：先导入若依官方基础库（sys_menu/sys_role/sys_role_menu 已存在）。
-- 本文件不创建演示用户、不设置弱口令；账号由系统管理员在后台创建。

SET NAMES utf8mb4;

-- 菜单ID使用 2100-2189，角色ID使用 101-104；如现有系统占用这些ID，请整体替换后再执行。
INSERT INTO `sys_menu`
(`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
VALUES
(2100,'足球俱乐部管理',0,10,'football',NULL,NULL,1,0,'M','0','0','', 'international','admin',NOW(),'',NULL,'天津津门虎业务根菜单'),
(2110,'仪表盘',2100,1,'dashboard','football/dashboard/index',NULL,1,0,'C','0','0','football:dashboard:view','dashboard','admin',NOW(),'',NULL,''),
(2120,'球员管理',2100,2,'player','football/player/index',NULL,1,0,'C','0','0','football:player:list','peoples','admin',NOW(),'',NULL,''),
(2130,'财务管理',2100,3,'finance','football/finance/index',NULL,1,0,'C','0','0','football:finance:list','money','admin',NOW(),'',NULL,''),
(2140,'比赛管理',2100,4,'match','football/match/index',NULL,1,0,'C','0','0','football:match:list','date','admin',NOW(),'',NULL,''),
(2150,'训练管理',2100,5,'training','football/training/index',NULL,1,0,'C','0','0','football:training:list','skill','admin',NOW(),'',NULL,''),
(2160,'球队日程',2100,6,'schedule','football/schedule/index',NULL,1,0,'C','0','0','football:schedule:list','calendar','admin',NOW(),'',NULL,''),
(2170,'伤病康复',2100,7,'injury','football/injury/index',NULL,1,0,'C','0','0','football:injury:list','heart','admin',NOW(),'',NULL,''),
(2180,'用户管理',2100,8,'user','system/user/index',NULL,1,0,'C','0','0','system:user:list','user','admin',NOW(),'',NULL,'复用若依用户页面'),

(2111,'仪表盘查看',2110,1,'','','',1,0,'F','0','0','football:dashboard:view','#','admin',NOW(),'',NULL,''),

(2121,'球员查询',2120,1,'','','',1,0,'F','0','0','football:player:list','#','admin',NOW(),'',NULL,''),
(2122,'球员详情',2120,2,'','','',1,0,'F','0','0','football:player:query','#','admin',NOW(),'',NULL,''),
(2123,'球员新增',2120,3,'','','',1,0,'F','0','0','football:player:add','#','admin',NOW(),'',NULL,''),
(2124,'球员修改',2120,4,'','','',1,0,'F','0','0','football:player:edit','#','admin',NOW(),'',NULL,''),
(2125,'球员删除',2120,5,'','','',1,0,'F','0','0','football:player:remove','#','admin',NOW(),'',NULL,''),

(2131,'财务查询',2130,1,'','','',1,0,'F','0','0','football:finance:list','#','admin',NOW(),'',NULL,''),
(2132,'财务详情',2130,2,'','','',1,0,'F','0','0','football:finance:query','#','admin',NOW(),'',NULL,''),
(2133,'财务新增',2130,3,'','','',1,0,'F','0','0','football:finance:add','#','admin',NOW(),'',NULL,''),
(2134,'财务修改',2130,4,'','','',1,0,'F','0','0','football:finance:edit','#','admin',NOW(),'',NULL,''),
(2135,'财务删除',2130,5,'','','',1,0,'F','0','0','football:finance:remove','#','admin',NOW(),'',NULL,''),

(2141,'比赛查询',2140,1,'','','',1,0,'F','0','0','football:match:list','#','admin',NOW(),'',NULL,''),
(2142,'比赛详情',2140,2,'','','',1,0,'F','0','0','football:match:query','#','admin',NOW(),'',NULL,''),
(2143,'比赛新增',2140,3,'','','',1,0,'F','0','0','football:match:add','#','admin',NOW(),'',NULL,''),
(2144,'比赛修改',2140,4,'','','',1,0,'F','0','0','football:match:edit','#','admin',NOW(),'',NULL,''),
(2145,'比赛删除',2140,5,'','','',1,0,'F','0','0','football:match:remove','#','admin',NOW(),'',NULL,''),

(2151,'训练查询',2150,1,'','','',1,0,'F','0','0','football:training:list','#','admin',NOW(),'',NULL,''),
(2152,'训练详情',2150,2,'','','',1,0,'F','0','0','football:training:query','#','admin',NOW(),'',NULL,''),
(2153,'训练新增',2150,3,'','','',1,0,'F','0','0','football:training:add','#','admin',NOW(),'',NULL,''),
(2154,'训练修改',2150,4,'','','',1,0,'F','0','0','football:training:edit','#','admin',NOW(),'',NULL,''),
(2155,'训练删除',2150,5,'','','',1,0,'F','0','0','football:training:remove','#','admin',NOW(),'',NULL,''),

(2161,'日程查询',2160,1,'','','',1,0,'F','0','0','football:schedule:list','#','admin',NOW(),'',NULL,''),
(2162,'日程详情',2160,2,'','','',1,0,'F','0','0','football:schedule:query','#','admin',NOW(),'',NULL,''),
(2163,'日程新增',2160,3,'','','',1,0,'F','0','0','football:schedule:add','#','admin',NOW(),'',NULL,''),
(2164,'日程修改',2160,4,'','','',1,0,'F','0','0','football:schedule:edit','#','admin',NOW(),'',NULL,''),
(2165,'日程删除',2160,5,'','','',1,0,'F','0','0','football:schedule:remove','#','admin',NOW(),'',NULL,''),

(2171,'伤病查询',2170,1,'','','',1,0,'F','0','0','football:injury:list','#','admin',NOW(),'',NULL,''),
(2172,'伤病详情',2170,2,'','','',1,0,'F','0','0','football:injury:query','#','admin',NOW(),'',NULL,''),
(2173,'伤病新增',2170,3,'','','',1,0,'F','0','0','football:injury:add','#','admin',NOW(),'',NULL,''),
(2174,'伤病修改',2170,4,'','','',1,0,'F','0','0','football:injury:edit','#','admin',NOW(),'',NULL,''),
(2175,'伤病删除',2170,5,'','','',1,0,'F','0','0','football:injury:remove','#','admin',NOW(),'',NULL,''),

(2181,'用户查询',2180,1,'','','',1,0,'F','0','0','system:user:list','#','admin',NOW(),'',NULL,''),
(2182,'用户新增',2180,2,'','','',1,0,'F','0','0','system:user:add','#','admin',NOW(),'',NULL,''),
(2183,'用户修改',2180,3,'','','',1,0,'F','0','0','system:user:edit','#','admin',NOW(),'',NULL,''),
(2184,'用户删除',2180,4,'','','',1,0,'F','0','0','system:user:remove','#','admin',NOW(),'',NULL,''),
(2185,'重置密码',2180,5,'','','',1,0,'F','0','0','system:user:resetPwd','#','admin',NOW(),'',NULL,'')
ON DUPLICATE KEY UPDATE
`menu_name`=VALUES(`menu_name`),`parent_id`=VALUES(`parent_id`),`order_num`=VALUES(`order_num`),
`path`=VALUES(`path`),`component`=VALUES(`component`),`menu_type`=VALUES(`menu_type`),
`visible`=VALUES(`visible`),`status`=VALUES(`status`),`perms`=VALUES(`perms`),`icon`=VALUES(`icon`),
`update_by`='admin',`update_time`=NOW(),`remark`=VALUES(`remark`);

INSERT INTO `sys_role`
(`role_id`,`role_name`,`role_key`,`role_sort`,`data_scope`,`menu_check_strictly`,`dept_check_strictly`,`status`,`del_flag`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
VALUES
(101,'球队工作人员','team_staff',10,'1',1,1,'0','0','admin',NOW(),'',NULL,'全部业务模块及用户管理'),
(102,'主教练','head_coach',20,'1',1,1,'0','0','admin',NOW(),'',NULL,'除财务和用户管理外，可管理球队业务'),
(103,'助理教练','assistant_coach',30,'1',1,1,'0','0','admin',NOW(),'',NULL,'球员只读；比赛、训练、日程、伤病可管理'),
(104,'球员','player',40,'1',1,1,'0','0','admin',NOW(),'',NULL,'业务只读；本人伤病的数据隔离由后端实现')
ON DUPLICATE KEY UPDATE
`role_name`=VALUES(`role_name`),`role_key`=VALUES(`role_key`),`role_sort`=VALUES(`role_sort`),
`status`=VALUES(`status`),`del_flag`=VALUES(`del_flag`),`update_by`='admin',`update_time`=NOW(),`remark`=VALUES(`remark`);

-- 球队工作人员：全部足球业务权限及用户管理。
INSERT IGNORE INTO `sys_role_menu` (`role_id`,`menu_id`)
SELECT 101, menu_id FROM `sys_menu` WHERE menu_id BETWEEN 2100 AND 2185;

-- 主教练：仪表盘、球员（全权限）、比赛、训练、日程、伤病（全权限）。
INSERT IGNORE INTO `sys_role_menu` (`role_id`,`menu_id`) VALUES
(102,2100),(102,2110),(102,2111),
(102,2120),(102,2121),(102,2122),(102,2123),(102,2124),(102,2125),
(102,2140),(102,2141),(102,2142),(102,2143),(102,2144),(102,2145),
(102,2150),(102,2151),(102,2152),(102,2153),(102,2154),(102,2155),
(102,2160),(102,2161),(102,2162),(102,2163),(102,2164),(102,2165),
(102,2170),(102,2171),(102,2172),(102,2173),(102,2174),(102,2175);

-- 助理教练：球员只读，其余教练业务可维护。
INSERT IGNORE INTO `sys_role_menu` (`role_id`,`menu_id`) VALUES
(103,2100),(103,2110),(103,2111),
(103,2120),(103,2121),(103,2122),
(103,2140),(103,2141),(103,2142),(103,2143),(103,2144),(103,2145),
(103,2150),(103,2151),(103,2152),(103,2153),(103,2154),(103,2155),
(103,2160),(103,2161),(103,2162),(103,2163),(103,2164),(103,2165),
(103,2170),(103,2171),(103,2172),(103,2173),(103,2174),(103,2175);

-- 球员：仪表盘、球员、比赛、日程只读，以及本人伤病只读。
INSERT IGNORE INTO `sys_role_menu` (`role_id`,`menu_id`) VALUES
(104,2100),(104,2110),(104,2111),
(104,2120),(104,2121),(104,2122),
(104,2140),(104,2141),(104,2142),
(104,2160),(104,2161),(104,2162),
(104,2170),(104,2171),(104,2172);

-- 安装后校验
SELECT role_id, role_name, role_key FROM `sys_role` WHERE role_id BETWEEN 101 AND 104 ORDER BY role_id;
SELECT role_id, COUNT(*) AS menu_count FROM `sys_role_menu` WHERE role_id BETWEEN 101 AND 104 GROUP BY role_id;
