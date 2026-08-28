package com.fc.system.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;

/**
 * 球队日程对象 football_schedule_event
 * 
 * @author 冷云鹏
 * @date 2026-08-27
 */
public class FootballScheduleEvent extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 关联比赛 */
    private Long matchId;

    /** 关联训练 */
    private Long trainingId;

    /** 日程标题 */
    @Excel(name = "日程标题")
    private String title;

    /** 日程类型 */
    @Excel(name = "日程类型")
    private String eventType;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 地点 */
    @Excel(name = "地点")
    private String location;

    /** 描述 */
    private String description;

    /** 状态 */
    @Excel(name = "状态")
    private String status;

    /** $column.columnComment */
    private String delFlag;

    /** 日程参与人信息 */
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

    /** 开始时间范围查询（委托到params Map） */
    public String getBeginStartTime()
    {
        return (String) getParams().get("beginStartTime");
    }

    public void setBeginStartTime(String beginStartTime)
    {
        getParams().put("beginStartTime", beginStartTime);
    }

    /** 结束时间范围查询（委托到params Map） */
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
