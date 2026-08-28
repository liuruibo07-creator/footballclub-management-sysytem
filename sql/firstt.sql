create table sys_dept
(
    dept_id     bigint auto_increment comment '部门id'
        primary key,
    parent_id   bigint      default 0   null comment '父部门id',
    ancestors   varchar(50) default ''  null comment '祖级列表',
    dept_name   varchar(30) default ''  null comment '部门名称',
    order_num   int         default 0   null comment '显示顺序',
    leader      varchar(20)             null comment '负责人',
    phone       varchar(11)             null comment '联系电话',
    email       varchar(50)             null comment '邮箱',
    status      char        default '0' null comment '部门状态（0正常 1停用）',
    del_flag    char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) default ''  null comment '创建者',
    create_time datetime                null comment '创建时间',
    update_by   varchar(64) default ''  null comment '更新者',
    update_time datetime                null comment '更新时间'
)
    comment '部门表';

create table sys_role
(
    role_id             bigint auto_increment comment '角色ID'
        primary key,
    role_name           varchar(30)             not null comment '角色名称',
    role_key            varchar(100)            not null comment '角色权限字符串',
    role_sort           int                     not null comment '显示顺序',
    data_scope          char        default '1' null comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
    menu_check_strictly tinyint(1)  default 1   null comment '菜单树选择项是否关联显示',
    dept_check_strictly tinyint(1)  default 1   null comment '部门树选择项是否关联显示',
    status              char                    not null comment '角色状态（0正常 1停用）',
    del_flag            char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by           varchar(64) default ''  null comment '创建者',
    create_time         datetime                null comment '创建时间',
    update_by           varchar(64) default ''  null comment '更新者',
    update_time         datetime                null comment '更新时间',
    remark              varchar(500)            null comment '备注'
)
    comment '角色信息表';

create table sys_user
(
    user_id     bigint auto_increment comment '用户ID'
        primary key,
    dept_id     bigint                    null comment '部门ID',
    user_name   varchar(30)               not null comment '用户账号',
    nick_name   varchar(30)               not null comment '用户昵称',
    user_type   varchar(2)   default '00' null comment '用户类型（00系统用户）',
    email       varchar(50)  default ''   null comment '用户邮箱',
    phonenumber varchar(11)  default ''   null comment '手机号码',
    sex         char         default '0'  null comment '用户性别（0男 1女 2未知）',
    avatar      varchar(100) default ''   null comment '头像地址',
    password    varchar(100) default ''   null comment '密码',
    status      char         default '0'  null comment '帐号状态（0正常 1停用）',
    del_flag    char         default '0'  null comment '删除标志（0代表存在 2代表删除）',
    login_ip    varchar(128) default ''   null comment '最后登录IP',
    login_date  datetime                  null comment '最后登录时间',
    create_by   varchar(64)  default ''   null comment '创建者',
    create_time datetime                  null comment '创建时间',
    update_by   varchar(64)  default ''   null comment '更新者',
    update_time datetime                  null comment '更新时间',
    remark      varchar(500)              null comment '备注'
)
    comment '用户信息表';


