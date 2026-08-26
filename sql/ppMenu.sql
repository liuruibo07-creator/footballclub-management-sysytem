-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('球员档案', '2000', '1', 'pp', 'pp/pp/index', 1, 0, 'C', '0', '0', 'pp:pp:list', '#', 'admin', sysdate(), '', null, '球员档案菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('球员档案查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'pp:pp:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('球员档案新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'pp:pp:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('球员档案修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'pp:pp:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('球员档案删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'pp:pp:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('球员档案导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'pp:pp:export',       '#', 'admin', sysdate(), '', null, '');