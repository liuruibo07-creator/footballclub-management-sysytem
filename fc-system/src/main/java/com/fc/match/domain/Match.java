package com.fc.match.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;

/**
 * 比赛对象 football_match
 * 
 * @author yangrun
 * @date 2026-08-26
 */
public class Match extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    private Long id;

    /** 赛季 */
    @Excel(name = "赛季")
    private String season;

    /** 轮次 */
    @Excel(name = "轮次")
    private Integer roundNo;

    /** 比赛时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "比赛时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date matchDate;

    /** 主队 */
    @Excel(name = "主队")
    private String homeTeam;

    /** 客队 */
    @Excel(name = "客队")
    private String awayTeam;

    /** 主队比分 */
    @Excel(name = "主队比分")
    private Integer homeScore;

    /** 客队比分 */
    @Excel(name = "客队比分")
    private Integer awayScore;

    /** 状态 */
    @Excel(name = "状态")
    private String status;

    /** 场地 */
    @Excel(name = "场地")
    private String venue;

    /** 赛事类型 */
    @Excel(name = "赛事类型")
    private String competitionType;

    /** 赛事名称 */
    @Excel(name = "赛事名称")
    private String competitionName;

    /** 数据来源 */
    @Excel(name = "数据来源")
    private String sourceUrl;

    /** 数据源截至日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "数据源截至日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date sourceAsOf;

    /** 删除标记 */
    private String delFlag;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setSeason(String season) 
    {
        this.season = season;
    }

    public String getSeason() 
    {
        return season;
    }
    public void setRoundNo(Integer roundNo) 
    {
        this.roundNo = roundNo;
    }

    public Integer getRoundNo() 
    {
        return roundNo;
    }
    public void setMatchDate(Date matchDate) 
    {
        this.matchDate = matchDate;
    }

    public Date getMatchDate() 
    {
        return matchDate;
    }
    public void setHomeTeam(String homeTeam) 
    {
        this.homeTeam = homeTeam;
    }

    public String getHomeTeam() 
    {
        return homeTeam;
    }
    public void setAwayTeam(String awayTeam) 
    {
        this.awayTeam = awayTeam;
    }

    public String getAwayTeam() 
    {
        return awayTeam;
    }
    public void setHomeScore(Integer homeScore) 
    {
        this.homeScore = homeScore;
    }

    public Integer getHomeScore() 
    {
        return homeScore;
    }
    public void setAwayScore(Integer awayScore) 
    {
        this.awayScore = awayScore;
    }

    public Integer getAwayScore() 
    {
        return awayScore;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }
    public void setVenue(String venue) 
    {
        this.venue = venue;
    }

    public String getVenue() 
    {
        return venue;
    }
    public void setCompetitionType(String competitionType) 
    {
        this.competitionType = competitionType;
    }

    public String getCompetitionType() 
    {
        return competitionType;
    }
    public void setCompetitionName(String competitionName) 
    {
        this.competitionName = competitionName;
    }

    public String getCompetitionName() 
    {
        return competitionName;
    }
    public void setSourceUrl(String sourceUrl) 
    {
        this.sourceUrl = sourceUrl;
    }

    public String getSourceUrl() 
    {
        return sourceUrl;
    }
    public void setSourceAsOf(Date sourceAsOf) 
    {
        this.sourceAsOf = sourceAsOf;
    }

    public Date getSourceAsOf() 
    {
        return sourceAsOf;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("season", getSeason())
            .append("roundNo", getRoundNo())
            .append("matchDate", getMatchDate())
            .append("homeTeam", getHomeTeam())
            .append("awayTeam", getAwayTeam())
            .append("homeScore", getHomeScore())
            .append("awayScore", getAwayScore())
            .append("status", getStatus())
            .append("venue", getVenue())
            .append("competitionType", getCompetitionType())
            .append("competitionName", getCompetitionName())
            .append("sourceUrl", getSourceUrl())
            .append("sourceAsOf", getSourceAsOf())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .append("remark", getRemark())
            .toString();
    }
}
