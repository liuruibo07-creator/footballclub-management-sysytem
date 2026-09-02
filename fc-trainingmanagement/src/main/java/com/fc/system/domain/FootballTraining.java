package com.fc.system.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 训练计划对象 —— 对应数据库表 football_training
 * <p>
 * 本实体是训练管理模块的核心数据载体，存储每一次训练的基本信息。
 * 训练管理模块在新增/修改/删除时，会通过 Mapper 中的跨表 SQL 主动同步到
 * 球队日程表 football_schedule_event，确保日程中心能展示训练安排。
 * </p>
 * <p>
 * 字段映射说明：
 * - training_type 存储数字编码，对应字典 football_training_type（0=体能/1=战术/2=技术/3=恢复/4=热身）
 * - status 存储数字编码，对应字典 football_training_status（0=已计划/1=已完成/2=已取消）
 * - participantCount 和 attendanceRate 不是数据库列，由列表查询的 SQL 子查询实时计算
 * </p>
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FootballTraining extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 训练ID（主键，自增） */
    private Long id;

    /** 赛季（如 "2026"），用于按赛季筛选训练记录 */
    @Excel(name = "赛季")
    private String season;

    /** 训练标题，如 "第12周体能恢复训练" */
    @Excel(name = "训练标题")
    private String title;

    /**
     * 训练类型（字典编码，Long 类型）
     * <p>对应字典 football_training_type：0=体能, 1=战术, 2=技术, 3=恢复, 4=热身</p>
     */
    @Excel(name = "训练类型:0体能/1战术/2技术/3恢复/4热身")
    private Long trainingType;

    /** 训练开始时间，JSON 序列化格式为 yyyy-MM-dd HH:mm:ss */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 训练结束时间，JSON 序列化格式为 yyyy-MM-dd HH:mm:ss */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 训练场地，同步到日程表时映射为 location 字段 */
    @Excel(name = "训练场地")
    private String venue;

    /** 训练描述，同步到日程表时直接映射 */
    private String description;

    /** 训练目标，仅训练模块使用，不同步到日程表 */
    private String trainingGoal;

    /**
     * 训练状态（字典编码，Long 类型）
     * <p>对应字典 football_training_status：0=已计划, 1=已完成, 2=已取消</p>
     * <p>同步到日程表时，status 值直接映射（0→已安排, 1→已完成, 2→已取消）</p>
     */
    @Excel(name = "状态:0已计划/1已完成/2已取消")
    private Long status;

    /** 删除标志（'0'正常, '2'删除），若依逻辑删除约定 */
    private String delFlag;

    /* ========== 以下字段不对应数据库列，由列表查询 SQL 子查询实时计算 ========== */

    /** 参与人数 = football_player 表的总行数（由 SQL 子查询计算） */
    private Integer participantCount;

    /** 出勤率 = (总人数 - 缺席人数) / 总人数，格式如 "85%"（由 SQL 子查询计算） */
    private String attendanceRate;

    /* ========== 一对多子表：训练参与及出勤信息 ========== */

    /**
     * 缺席球员列表（一对多子表）
     * <p>
     * 注意：该列表只存储缺席/请假的球员（attendanceStatus=2或3），
     * 出勤球员由"全体球员 - 缺席球员"推导，不在此列表中。
     * 详情查询时通过 LEFT JOIN football_training_player + football_player 关联查出。
     * </p>
     */
    private List<FootballTrainingPlayer> footballTrainingPlayerList;


}
