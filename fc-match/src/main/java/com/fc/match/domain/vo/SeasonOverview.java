package com.fc.match.domain.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;

/**
 * 首页赛季概览
 */
@Data
public class SeasonOverview implements Serializable
{
    private static final long serialVersionUID = 1L;

    private String season;

    private int rank;

    private int totalTeams;

    private int points;

    private int pointsDeduction;

    private int wins;

    private int draws;

    private int losses;

    private int goalsFor;

    private int goalsAgainst;

    private List<RecentMatchResult> recentMatches = new ArrayList<>();
}
