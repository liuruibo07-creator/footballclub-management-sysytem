package com.fc.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;

/**
 * 训练参与及出勤对象 football_training_player
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
public class FootballTrainingPlayer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long id;

    /** 训练ID */
    private Long trainingId;

    /** 球员ID */
    @Excel(name = "球员ID")
    private Long playerId;

    /** 出勤状态:0待确认/1已出勤/2缺勤/3请假 */
    @Excel(name = "出勤状态:0待确认/1已出勤/2缺勤/3请假")
    private Long attendanceStatus;

    /** 球员姓名（关联查询，非数据库字段） */
    private String playerName;

    /** 球员位置（关联查询，非数据库字段） */
    private String position;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setTrainingId(Long trainingId) 
    {
        this.trainingId = trainingId;
    }

    public Long getTrainingId() 
    {
        return trainingId;
    }
    public void setPlayerId(Long playerId) 
    {
        this.playerId = playerId;
    }

    public Long getPlayerId() 
    {
        return playerId;
    }
    public void setAttendanceStatus(Long attendanceStatus) 
    {
        this.attendanceStatus = attendanceStatus;
    }

    public Long getAttendanceStatus() 
    {
        return attendanceStatus;
    }
    public void setPlayerName(String playerName) 
    {
        this.playerName = playerName;
    }

    public String getPlayerName() 
    {
        return playerName;
    }
    public void setPosition(String position) 
    {
        this.position = position;
    }

    public String getPosition() 
    {
        return position;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("trainingId", getTrainingId())
            .append("playerId", getPlayerId())
            .append("attendanceStatus", getAttendanceStatus())
            .append("createTime", getCreateTime())
            .toString();
    }
}
