-- 天津津门虎项目数据库协作更新脚本
-- 生成日期：2026-08-26
-- 适用数据库：football-club（MySQL 8.0+）
--
-- 包含内容：
-- 1. 同步部门、角色、用户数据；
-- 2. 修正用户角色、角色菜单和角色部门关联；
-- 3. 删除岗位管理菜单及用户岗位关联；
-- 4. 使用主键更新，可重复执行。
--
-- 建议执行前先备份目标数据库。

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

-- ============================================================
-- 一、同步部门数据
-- ============================================================

-- 删除本项目不再使用的旧部门节点。
DELETE FROM sys_dept WHERE dept_id IN (107, 109);

INSERT INTO sys_dept
  (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email,
   status, del_flag, create_by, create_time, update_by, update_time)
VALUES
  (100, 0,   '0',         '天津津门虎足球俱乐部', 0, '',       '15888888888', 'ygw@qq.com',   '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:33:30'),
  (101, 100, '0,100',     '教练组',               1, '',       '13125312345', 'rly@qq.com',   '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:33:09'),
  (102, 100, '0,100',     '后勤部',               2, '',       '15888888888', 'wj@qq.com',    '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:33:44'),
  (103, 101, '0,100,101', '主教练',               1, '于根伟', '15888888822', 'yg@qq.com',    '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:06:16'),
  (104, 101, '0,100,101', '助理教练（战术）',     2, '埃斯特乌', '15453888888', 'autes@qq.com', '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:22:23'),
  (105, 101, '0,100,101', '助理教练（体能）',     3, '张朝松', '15823488881', 'zcs@qq.com',   '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:22:00'),
  (106, 101, '0,100,101', '助理教练（守门员）',   4, '王略',   '15823388888', 'wj@qq.com',    '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:23:37'),
  (108, 102, '0,100,102', '领队',                 1, '王俊',   '15234888888', 'wj@qq.com',    '0', '0', 'admin', '2026-08-25 18:47:51', 'admin', '2026-08-26 09:19:56')
ON DUPLICATE KEY UPDATE
  parent_id = VALUES(parent_id),
  ancestors = VALUES(ancestors),
  dept_name = VALUES(dept_name),
  order_num = VALUES(order_num),
  leader = VALUES(leader),
  phone = VALUES(phone),
  email = VALUES(email),
  status = VALUES(status),
  del_flag = VALUES(del_flag),
  update_by = VALUES(update_by),
  update_time = VALUES(update_time);

-- ============================================================
-- 二、同步角色数据
-- ============================================================

INSERT INTO sys_role
  (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly,
   dept_check_strictly, status, del_flag, create_by, create_time, update_by,
   update_time, remark)
VALUES
  (1, '超级管理员', 'admin',           1, '1', 1, 1, '0', '0', 'admin', '2026-08-25 18:47:52', '',      NULL,                  '超级管理员'),
  (2, '主教练',     'coach',           2, '1', 1, 1, '0', '0', 'admin', '2026-08-25 21:02:02', 'admin', '2026-08-25 21:03:28', NULL),
  (3, '球员',       'player',          3, '2', 1, 1, '0', '0', 'admin', '2026-08-25 18:47:52', 'admin', '2026-08-25 21:06:45', '普通角色'),
  (4, '助理教练',   'assistant-coach', 4, '1', 1, 1, '0', '0', 'admin', '2026-08-25 21:08:25', '',      NULL,                  NULL),
  (5, '球队工作人员','team-staff',     5, '1', 1, 1, '0', '0', 'admin', '2026-08-25 21:11:07', '',      NULL,                  NULL)
ON DUPLICATE KEY UPDATE
  role_name = VALUES(role_name),
  role_key = VALUES(role_key),
  role_sort = VALUES(role_sort),
  data_scope = VALUES(data_scope),
  menu_check_strictly = VALUES(menu_check_strictly),
  dept_check_strictly = VALUES(dept_check_strictly),
  status = VALUES(status),
  del_flag = VALUES(del_flag),
  update_by = VALUES(update_by),
  update_time = VALUES(update_time),
  remark = VALUES(remark);

-- ============================================================
-- 三、同步用户数据
-- ============================================================

-- 清除之前脚本产生、但已被重新编号的旧用户记录和关联。
DELETE FROM sys_user_role WHERE user_id IN (100, 101, 102, 103, 107);
DELETE FROM sys_user_post WHERE user_id IN (100, 101, 102, 103, 107);
DELETE FROM sys_user
WHERE user_id IN (100, 101, 102, 103, 107)
  AND user_name IN ('estw', 'zcs', 'wl', 'wj', 'player');

-- 新账号的默认密码为 123456；重复执行时不会覆盖已有密码。
INSERT INTO sys_user
  (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex,
   avatar, password, status, del_flag, login_ip, login_date, create_by,
   create_time, update_by, update_time, remark)
VALUES
  (1, 103, 'admin',  '于根伟',   '00', 'ry@163.com',    '18822738101', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2026-08-25 18:47:51', '',      '2026-08-26 08:43:34', '管理员'),
  (2, 104, 'estw',   '埃斯特乌', '00', 'autes@qq.com', '15453888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2026-08-26 10:00:11', 'admin', '2026-08-26 10:04:42', ''),
  (3, 105, 'zcs',    '张朝松',   '00', 'zcs@qq.com',   '15823488881', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2026-08-26 10:00:11', '',      NULL,                  '由部门管理员工数据补充'),
  (4, 106, 'wl',     '王略',     '00', 'wl@qq.com',    '15823388888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2026-08-26 10:00:11', '',      NULL,                  '由部门管理员工数据补充'),
  (5, 108, 'wj',     '王俊',     '00', 'wj@qq.com',    '15234888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2026-08-26 10:00:11', '',      NULL,                  '由部门管理员工数据补充'),
  (6, 100, 'player', '球员',     '00', '',             '18222562601', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2026-08-26 10:14:06', 'admin', '2026-08-26 10:15:17', NULL)
ON DUPLICATE KEY UPDATE
  dept_id = VALUES(dept_id),
  user_name = VALUES(user_name),
  nick_name = VALUES(nick_name),
  user_type = VALUES(user_type),
  email = VALUES(email),
  phonenumber = VALUES(phonenumber),
  sex = VALUES(sex),
  status = VALUES(status),
  del_flag = VALUES(del_flag),
  update_by = VALUES(update_by),
  update_time = VALUES(update_time),
  remark = VALUES(remark);

-- 修正用户角色关系，并清除旧编号产生的孤立关联。
DELETE ur
FROM sys_user_role ur
LEFT JOIN sys_user u ON u.user_id = ur.user_id
WHERE u.user_id IS NULL;

DELETE FROM sys_user_role WHERE user_id IN (1, 2, 3, 4, 5, 6);
INSERT INTO sys_user_role (user_id, role_id) VALUES
  (1, 1),
  (2, 4),
  (3, 4),
  (4, 4),
  (5, 5),
  (6, 3);

-- ============================================================
-- 四、同步角色权限和数据范围
-- ============================================================

DELETE FROM sys_role_menu WHERE role_id IN (2, 3, 4, 5);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES
  (2,1),(2,2),(2,3),(2,100),(2,101),(2,102),(2,103),(2,105),(2,106),(2,107),
  (2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),
  (2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),
  (2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),
  (2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1025),
  (2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),
  (2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),
  (2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),
  (2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),
  (2,1058),(2,1059),(2,1060);

DELETE FROM sys_role_dept WHERE role_id IN (2, 3, 4, 5);
INSERT INTO sys_role_dept (role_id, dept_id) VALUES
  (2, 100),
  (2, 101),
  (2, 105);

-- ============================================================
-- 五、移除岗位关系
-- ============================================================

DELETE rm
FROM sys_role_menu rm
JOIN sys_menu m ON m.menu_id = rm.menu_id
WHERE m.menu_id = 104 OR m.parent_id = 104 OR m.perms LIKE 'system:post%';

-- 同时清理可能已经失去菜单主记录的岗位权限关联。
DELETE FROM sys_role_menu WHERE menu_id IN (104, 1020, 1021, 1022, 1023, 1024);

DELETE FROM sys_menu
WHERE parent_id = 104 OR perms LIKE 'system:post%';
DELETE FROM sys_menu WHERE menu_id = 104;

DELETE FROM sys_user_post;

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;

-- 导入后核对结果。
SELECT dept_id, dept_name, leader FROM sys_dept WHERE del_flag = '0' ORDER BY dept_id;
SELECT role_id, role_name, role_key FROM sys_role WHERE del_flag = '0' ORDER BY role_id;
SELECT user_id, user_name, nick_name, dept_id FROM sys_user WHERE del_flag = '0' ORDER BY user_id;
SELECT user_id, role_id FROM sys_user_role ORDER BY user_id, role_id;
