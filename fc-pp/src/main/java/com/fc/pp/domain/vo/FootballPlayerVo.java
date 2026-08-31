package com.fc.pp.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fc.common.annotation.Excel;
import com.fc.pp.domain.FootballPlayer;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 球员档案视图对象（含合同到期日）
 *
 * @author lrb
 * @date 2026-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class FootballPlayerVo extends FootballPlayer
{
    private static final long serialVersionUID = 1L;

    /** 合同到期日 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "合同到期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;

    /** 最新赛季统计截止日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date statAsOf;

    /** 最新赛季比赛数据 */
    private Integer appearances;
    private Integer starts;
    private Integer minutesPlayed;
    private Integer goals;
    private Integer assists;
    private Integer yellowCards;
    private Integer redCards;

    /** 已完成训练及球员缺席次数 */
    private Integer completedTrainingCount;
    private Integer missedTrainingCount;

    /** 最近一次已完成训练日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date lastTrainingDate;

    /** 最近一条未完全康复的伤病记录 */
    private String injuryType;
    private String injuryLocation;
    private Integer recoveryStatus;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date expectedReturnDate;
}
