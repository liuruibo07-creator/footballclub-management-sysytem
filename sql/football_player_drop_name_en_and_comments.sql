-- ============================================================
-- 修改表 football_player
-- 1) 删除 name_en 列
-- 2) 为每个字段添加 COMMENT 注释
-- ============================================================

USE `football-club`;

-- 删除 name_en 列
ALTER TABLE `football_player` DROP COLUMN `name_en`;

-- 为每个字段添加注释（逐列 MODIFY COLUMN 以便使用 COMMENT 子句）
ALTER TABLE `football_player`
    MODIFY COLUMN `id`                BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    MODIFY COLUMN `jersey_number`     INT          NOT NULL                COMMENT '球员球衣号码',
    MODIFY COLUMN `name_cn`           VARCHAR(64)  NOT NULL                COMMENT '中文姓名',
    MODIFY COLUMN `position`          VARCHAR(16)  NOT NULL                COMMENT '位置：守门员/后卫/中场/前锋',
    MODIFY COLUMN `nationality`       VARCHAR(32)  NOT NULL                COMMENT '国籍',
    MODIFY COLUMN `birth_date`        DATE         DEFAULT NULL           COMMENT '出生日期',
    MODIFY COLUMN `height`            DECIMAL(3,2) DEFAULT NULL           COMMENT '身高（米）',
    MODIFY COLUMN `preferred_foot`    VARCHAR(8)   DEFAULT NULL           COMMENT '惯用脚：左脚/右脚/双脚',
    MODIFY COLUMN `status`            VARCHAR(16)  NOT NULL DEFAULT '活跃' COMMENT '球员状态：活跃/非活跃',
    MODIFY COLUMN `registration_note` VARCHAR(255) DEFAULT NULL           COMMENT '2026赛季报名变化说明',
    MODIFY COLUMN `user_id`           BIGINT       DEFAULT NULL           COMMENT '若依 sys_user.user_id，跨库部署时不设外键',
    MODIFY COLUMN `source_url`        VARCHAR(1000) DEFAULT NULL          COMMENT '数据来源 URL',
    MODIFY COLUMN `source_as_of`      DATE         DEFAULT NULL           COMMENT '数据来源截止日期',
    MODIFY COLUMN `create_by`         VARCHAR(64)  NOT NULL DEFAULT 'system' COMMENT '创建者',
    MODIFY COLUMN `create_time`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    MODIFY COLUMN `update_by`         VARCHAR(64)  DEFAULT NULL            COMMENT '更新者',
    MODIFY COLUMN `update_time`       DATETIME     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    MODIFY COLUMN `del_flag`          CHAR(1)      NOT NULL DEFAULT '0'    COMMENT '删除标志：0正常 2删除',
    MODIFY COLUMN `remark`            VARCHAR(500) DEFAULT NULL            COMMENT '备注';
