package com.fc.stat.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 赛季数据统计对象 football_player_season_stat
 *
 * @author mumu
 * @date 2026-08-28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class stat extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 球员ID */
    @Excel(name = "球员ID")
    private Long playerId;

    /** 赛季 */
    @Excel(name = "赛季")
    private String season;

    /** 赛事名称 */
    @Excel(name = "赛事")
    private String competition;

    /** 出场次数 */
    @Excel(name = "出场次数")
    private Integer appearances;

    /** 首发次数 */
    @Excel(name = "首发次数")
    private Integer starts;

    /** 出场时间(分钟) */
    @Excel(name = "出场时间")
    private Integer minutesPlayed;

    /** 进球数 */
    @Excel(name = "进球数")
    private Integer goals;

    /** 助攻数 */
    @Excel(name = "助攻数")
    private Integer assists;

    /** 黄牌数 */
    @Excel(name = "黄牌数")
    private Integer yellowCards;

    /** 红牌数 */
    @Excel(name = "红牌数")
    private Integer redCards;

    /** 统计截至日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date statAsOf;

    /** 数据来源URL */
    private String sourceUrl;

    // ===== 以下为关联查询字段，非数据库列 =====

    /** 球员姓名（关联查询） */
    private String playerName;

    /** 球员头像地址（关联查询） */
    private String avatarUrl;

    /** 球衣号码（关联查询） */
    private Long jerseyNumber;

    /** 位置（关联查询） */
    private String position;

    /** 国籍（关联查询） */
    private String nationality;

    /** 球员状态（关联查询） */
    private String playerStatus;

    // ===== 以下为查询辅助参数，非数据库列 =====

    /** 排序字段（用于排行榜动态排序） */
    private String rankBy;
}
