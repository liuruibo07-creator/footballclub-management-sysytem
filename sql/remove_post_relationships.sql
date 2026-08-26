-- 移除岗位菜单及用户岗位关联。
-- 保留 sys_post 基础表和后端岗位模块，避免破坏项目结构并便于后续恢复。

SET NAMES utf8mb4;
START TRANSACTION;

-- 删除角色与岗位菜单/按钮权限之间的关联。
DELETE rm
FROM sys_role_menu rm
JOIN sys_menu m ON m.menu_id = rm.menu_id
WHERE m.menu_id = 104 OR m.parent_id = 104;

-- 先删除岗位菜单的按钮权限，再删除岗位管理菜单。
DELETE FROM sys_menu WHERE parent_id = 104;
DELETE FROM sys_menu WHERE menu_id = 104;

-- 清理所有用户与岗位的关联数据。
DELETE FROM sys_user_post;

COMMIT;
