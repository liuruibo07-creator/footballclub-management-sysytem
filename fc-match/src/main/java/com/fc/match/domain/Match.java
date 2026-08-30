package com.fc.match.domain;

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
 * 比赛管理对象 football_match
 * 
 * @author yr
 * @date 2026-08-28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Match extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    private Long id;

    /** 赛季 */
    private String season;

    /** 轮次 */
    @Excel(name = "轮次")
    private Long roundNo;

    /** 比赛时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Excel(name = "比赛时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date matchDate;

    /** 主队 */
    @Excel(name = "主队")
    private String homeTeam;

    /** 客队 */
    @Excel(name = "客队")
    private String awayTeam;

    /** 主队得分 */
    @Excel(name = "主队得分")
    private Long homeScore;

    /** 客队得分 */
    @Excel(name = "客队得分")
    private Long awayScore;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

    /** 场地 */
    @Excel(name = "场地")
    private String venue;

    /** 赛事类型 */
    private Long competitionType;

    /** 赛事名称 */
    @Excel(name = "赛事名称")
    private String competitionName;

    /** 数据源 */
    private String sourceUrl;

    /** 数据源截至日期 */
    private Date sourceAsOf;

    /** $column.columnComment */
    private String delFlag;


}
