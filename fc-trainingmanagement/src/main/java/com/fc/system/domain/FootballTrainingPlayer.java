package com.fc.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;

/**
 * 训练参与及出勤对象 —— 对应数据库表 football_training_player
 * <p>
 * 本表采用"只存缺席"的设计：每次训练只把缺席/请假的球员写入本表，
 * 出勤球员不写入，由"全体球员 - 缺席球员"推导得出。
 * 这样设计的好处是：新增训练时只需提交缺席球员列表，无需提交全部球员。
 * </p>
 * <p>
 * 字段映射说明：
 * - attendance_status 存储数字编码：0=待确认, 1=已出勤, 2=缺勤, 3=请假
 * - 实际写入时 Service 层会强制将 attendanceStatus 设为 2（缺勤）
 * - playerName 和 position 不是数据库列，详情查询时通过 LEFT JOIN football_player 关联查出
 * </p>
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
public class FootballTrainingPlayer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID（主键，自增） */
    private Long id;

    /** 训练ID（外键，关联 football_training.id） */
    private Long trainingId;

    /** 球员ID（外键，关联 football_player.id） */
    @Excel(name = "球员ID")
    private Long playerId;

    /**
     * 出勤状态（字典编码，Long 类型）
     * <p>对应字典：0=待确认, 1=已出勤, 2=缺勤, 3=请假</p>
     * <p>注意：Service 层在插入时会强制设为 2（缺勤），前端提交的值会被覆盖</p>
     */
    @Excel(name = "出勤状态:0待确认/1已出勤/2缺勤/3请假")
    private Long attendanceStatus;

    /** 球员姓名（关联查询字段，非数据库列，由 LEFT JOIN football_player 查出） */
    private String playerName;

    /** 球员位置（关联查询字段，非数据库列，由 LEFT JOIN football_player 查出，如 "中场"、"前锋"） */
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
