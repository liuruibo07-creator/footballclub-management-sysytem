package com.fc.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;

/**
 * 日程参与球员实体类，对应数据库表 football_schedule_player
 * <p>
 * 这是日程表（football_schedule_event）的子表，记录每条日程关联的参与球员。
 * 与训练参与球员表（football_training_player）不同，本表只存储"谁参加了哪条日程"，
 * 不记录出勤状态（出勤状态由训练模块单独管理）。
 * </p>
 * <p>关联关系：event_id → football_schedule_event.id（逻辑外键，无物理约束）。</p>
 *
 * @author 冷云鹏
 * @date 2026-08-27
 */
public class FootballSchedulePlayer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键（自增） */
    private Long id;

    /** 关联日程 ID（指向 football_schedule_event.id） */
    private Long eventId;

    /** 关联球员 ID（指向 football_player.id） */
    private Long playerId;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setEventId(Long eventId)
    {
        this.eventId = eventId;
    }

    public Long getEventId()
    {
        return eventId;
    }
    public void setPlayerId(Long playerId)
    {
        this.playerId = playerId;
    }

    public Long getPlayerId()
    {
        return playerId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("eventId", getEventId())
            .append("playerId", getPlayerId())
            .append("createTime", getCreateTime())
            .toString();
    }
}
