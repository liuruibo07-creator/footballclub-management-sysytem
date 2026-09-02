package com.fc.system.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;

/**
 * 球队日程实体类，对应数据库表 football_schedule_event
 * <p>
 * 日程是整个系统的"统一时间线"，汇聚三种类型的事件：
 * - event_type=0：比赛（由比赛模块同步写入，match_id 指向 football_match.id）
 * - event_type=1：训练（由训练模块同步写入，training_id 指向 football_training.id）
 * - event_type=2：会议（由日程模块独立管理）
 * </p>
 * <p>match_id 和 training_id 是可选的外键，同一时刻只有一个有值（互斥）。
 * 例如：当 event_type=1 时，training_id 有值，match_id 为 null。</p>
 * <p>状态 status：0=已安排（待办），1=已完成，2=已推迟，3=已取消。</p>
 *
 * @author 冷云鹏
 * @date 2026-08-27
 */
public class FootballScheduleEvent extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 日程主键（自增） */
    private Long id;

    /** 关联比赛 ID（event_type=0 时有值，指向 football_match.id） */
    private Long matchId;

    /** 关联训练 ID（event_type=1 时有值，指向 football_training.id） */
    private Long trainingId;

    /** 日程标题（如"第5轮联赛"、"体能训练"、"战术会议"） */
    @Excel(name = "日程标题")
    private String title;

    /** 日程类型：0=比赛, 1=训练, 2=会议（字典 football_event_type） */
    @Excel(name = "日程类型")
    private String eventType;

    /** 开始时间（JSON 序列化格式：yyyy-MM-dd HH:mm:ss） */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 地点（比赛时为球场，训练时为训练场，会议时为会议室） */
    @Excel(name = "地点")
    private String location;

    /** 详细描述（HTML 富文本或纯文本） */
    private String description;

    /** 状态：0=已安排, 1=已完成, 2=已推迟, 3=已取消（字典 football_event_status） */
    @Excel(name = "状态")
    private String status;

    /** 删除标志：0=正常, 2=已删除（若依约定） */
    private String delFlag;

    /** 日程参与球员列表（子表 football_schedule_player，通过 LEFT JOIN 查出） */
    private List<FootballSchedulePlayer> footballSchedulePlayerList;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setMatchId(Long matchId)
    {
        this.matchId = matchId;
    }

    public Long getMatchId()
    {
        return matchId;
    }
    public void setTrainingId(Long trainingId)
    {
        this.trainingId = trainingId;
    }

    public Long getTrainingId()
    {
        return trainingId;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTitle()
    {
        return title;
    }
    public void setEventType(String eventType)
    {
        this.eventType = eventType;
    }

    public String getEventType()
    {
        return eventType;
    }
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getStartTime()
    {
        return startTime;
    }
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }
    public void setLocation(String location)
    {
        this.location = location;
    }

    public String getLocation()
    {
        return location;
    }
    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getDescription()
    {
        return description;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    /**
     * 开始时间范围查询 - 起始值
     * <p>若依约定：日期范围查询参数不直接映射到实体字段，
     * 而是委托到父类 BaseEntity 的 params Map 中，
     * 在 Mapper XML 中通过 beginStartTime / endStartTime 读取。</p>
     */
    public String getBeginStartTime()
    {
        return (String) getParams().get("beginStartTime");
    }

    public void setBeginStartTime(String beginStartTime)
    {
        getParams().put("beginStartTime", beginStartTime);
    }

    /** 开始时间范围查询 - 结束值（委托到 params Map） */
    public String getEndStartTime()
    {
        return (String) getParams().get("endStartTime");
    }

    public void setEndStartTime(String endStartTime)
    {
        getParams().put("endStartTime", endStartTime);
    }

    public List<FootballSchedulePlayer> getFootballSchedulePlayerList()
    {
        return footballSchedulePlayerList;
    }

    public void setFootballSchedulePlayerList(List<FootballSchedulePlayer> footballSchedulePlayerList)
    {
        this.footballSchedulePlayerList = footballSchedulePlayerList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("matchId", getMatchId())
            .append("trainingId", getTrainingId())
            .append("title", getTitle())
            .append("eventType", getEventType())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("location", getLocation())
            .append("description", getDescription())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .append("remark", getRemark())
            .append("footballSchedulePlayerList", getFootballSchedulePlayerList())
            .toString();
    }
}
