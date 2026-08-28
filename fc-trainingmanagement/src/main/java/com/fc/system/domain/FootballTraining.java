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
 * 训练计划对象 football_training
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

    /** 训练ID */
    private Long id;

    /** 赛季 */
    @Excel(name = "赛季")
    private String season;

    /** 训练标题 */
    @Excel(name = "训练标题")
    private String title;

    /** 训练类型:0体能/1战术/2技术/3恢复/4热身 */
    @Excel(name = "训练类型:0体能/1战术/2技术/3恢复/4热身")
    private Long trainingType;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 训练场地 */
    @Excel(name = "训练场地")
    private String venue;

    /** 训练描述 */
    private String description;

    /** 训练目标 */
    private String trainingGoal;

    /** 状态:0已计划/1已完成/2已取消 */
    @Excel(name = "状态:0已计划/1已完成/2已取消")
    private Long status;

    /** 删除标志 */
    private String delFlag;

    /** 参与人数（非数据库字段，由子查询统计） */
    private Integer participantCount;

    /** 出勤率（非数据库字段，由子查询计算） */
    private String attendanceRate;

    /** 训练参与及出勤信息 */
    private List<FootballTrainingPlayer> footballTrainingPlayerList;


}
