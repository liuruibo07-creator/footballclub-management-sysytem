-- 将部门管理中已有的员工补充到用户管理。
-- 默认密码：123456（使用若依初始化脚本中的 BCrypt 密文）。
-- 本脚本可重复执行：已存在的账号不会重复创建，已有角色关系也不会重复添加。

SET NAMES utf8mb4;
START TRANSACTION;

INSERT INTO sys_user
  (dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar,
   password, status, del_flag, login_ip, login_date, create_by, create_time,
   update_by, update_time, remark)
SELECT
  d.dept_id,
  employee.user_name,
  d.leader,
  '00',
  employee.email,
  d.phone,
  '0',
  '',
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2',
  d.status,
  '0',
  '',
  NULL,
  'admin',
  NOW(),
  '',
  NULL,
  '由部门管理员工数据补充'
FROM sys_dept d
JOIN (
  SELECT '埃斯特乌' AS nick_name, 'estw' AS user_name, 'autes@qq.com' AS email
  UNION ALL SELECT '张朝松', 'zcs', 'zcs@qq.com'
  UNION ALL SELECT '王略', 'wl', 'wl@qq.com'
  UNION ALL SELECT '王俊', 'wj', 'wj@qq.com'
) employee ON employee.nick_name = d.leader
WHERE d.del_flag = '0'
  AND NOT EXISTS (
    SELECT 1
    FROM sys_user u
    WHERE u.user_name = employee.user_name
      AND u.del_flag = '0'
  );

INSERT IGNORE INTO sys_user_role (user_id, role_id)
SELECT u.user_id, employee.role_id
FROM sys_user u
JOIN (
  SELECT 'estw' AS user_name, 4 AS role_id
  UNION ALL SELECT 'zcs', 4
  UNION ALL SELECT 'wl', 4
  UNION ALL SELECT 'wj', 5
) employee ON employee.user_name = u.user_name
WHERE u.del_flag = '0';

COMMIT;
