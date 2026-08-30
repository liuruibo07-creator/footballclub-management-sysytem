package com.fc.match.service.impl;

import java.util.List;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.match.mapper.MatchMapper;
import com.fc.match.domain.Match;
import com.fc.match.domain.vo.RecentMatchResult;
import com.fc.match.domain.vo.SeasonOverview;
import com.fc.match.service.IMatchService;

/**
 * 比赛管理Service业务层处理
 * 
 * @author yr
 * @date 2026-08-28
 */
@Service
public class MatchServiceImpl implements IMatchService 
{
    private static final String CLUB_NAME = "天津津门虎";

    private static final String LEAGUE_NAME = "中国足球超级联赛";

    @Autowired
    private MatchMapper matchMapper;

    /**
     * 查询比赛管理
     * 
     * @param id 比赛管理主键
     * @return 比赛管理
     */
    @Override
    public Match selectMatchById(Long id)
    {
        return matchMapper.selectMatchById(id);
    }

    /**
     * 查询比赛管理列表
     * 
     * @param match 比赛管理
     * @return 比赛管理
     */
    @Override
    public List<Match> selectMatchList(Match match)
    {
        return matchMapper.selectMatchList(match);
    }

    /**
     * 查询首页赛季概览
     *
     * @return 赛季概览
     */
    @Override
    public SeasonOverview selectSeasonOverview()
    {
        SeasonOverview overview = new SeasonOverview();
        String season = matchMapper.selectLatestLeagueSeason();
        overview.setSeason(season);
        if (season == null)
        {
            return overview;
        }

        List<Match> completedMatches = matchMapper.selectCompletedLeagueMatches(season);
        Map<String, TeamStanding> standings = buildStandings(completedMatches);
        TeamStanding clubStanding = standings.computeIfAbsent(CLUB_NAME, TeamStanding::new);

        Integer deductionValue = matchMapper.selectPointsDeduction(season, LEAGUE_NAME);
        int pointsDeduction = deductionValue == null ? 0 : deductionValue;
        clubStanding.points -= pointsDeduction;

        List<TeamStanding> orderedStandings = new ArrayList<>(standings.values());
        orderedStandings.sort(Comparator
                .comparingInt(TeamStanding::getPoints).reversed()
                .thenComparing(Comparator.comparingInt(TeamStanding::getGoalDifference).reversed())
                .thenComparing(Comparator.comparingInt(TeamStanding::getGoalsFor).reversed())
                .thenComparing(TeamStanding::getTeamName));

        int computedRank = findClubRank(orderedStandings);
        Integer snapshotRank = matchMapper.selectLeagueRank(season, LEAGUE_NAME);
        Integer snapshotTeamCount = matchMapper.selectLeagueTeamCount(season, LEAGUE_NAME);
        boolean standingsComplete = hasCompleteStandings(orderedStandings, snapshotTeamCount);
        overview.setRank(standingsComplete || snapshotRank == null ? computedRank : snapshotRank);
        overview.setTotalTeams(standingsComplete || snapshotTeamCount == null
                ? orderedStandings.size() : snapshotTeamCount);
        overview.setPoints(clubStanding.points);
        overview.setPointsDeduction(pointsDeduction);
        overview.setWins(clubStanding.wins);
        overview.setDraws(clubStanding.draws);
        overview.setLosses(clubStanding.losses);
        overview.setGoalsFor(clubStanding.goalsFor);
        overview.setGoalsAgainst(clubStanding.goalsAgainst);
        overview.setRecentMatches(buildRecentMatches(completedMatches));
        return overview;
    }

    @Override
    public Match selectNextMatch()
    {
        return matchMapper.selectNextMatch();
    }

    private Map<String, TeamStanding> buildStandings(List<Match> matches)
    {
        Map<String, TeamStanding> standings = new HashMap<>();
        for (Match match : matches)
        {
            TeamStanding home = standings.computeIfAbsent(match.getHomeTeam(), TeamStanding::new);
            TeamStanding away = standings.computeIfAbsent(match.getAwayTeam(), TeamStanding::new);
            int homeScore = match.getHomeScore().intValue();
            int awayScore = match.getAwayScore().intValue();

            home.goalsFor += homeScore;
            home.goalsAgainst += awayScore;
            away.goalsFor += awayScore;
            away.goalsAgainst += homeScore;
            home.played++;
            away.played++;

            if (homeScore > awayScore)
            {
                home.wins++;
                home.points += 3;
                away.losses++;
            }
            else if (homeScore < awayScore)
            {
                away.wins++;
                away.points += 3;
                home.losses++;
            }
            else
            {
                home.draws++;
                away.draws++;
                home.points++;
                away.points++;
            }
        }
        return standings;
    }

    private int findClubRank(List<TeamStanding> standings)
    {
        for (int index = 0; index < standings.size(); index++)
        {
            if (CLUB_NAME.equals(standings.get(index).teamName))
            {
                return index + 1;
            }
        }
        return 0;
    }

    /**
     * 只有各队完赛场次基本一致时，现有比赛数据才足以计算完整积分榜。
     */
    private boolean hasCompleteStandings(List<TeamStanding> standings, Integer expectedTeamCount)
    {
        if (standings.isEmpty() || expectedTeamCount == null || standings.size() != expectedTeamCount)
        {
            return false;
        }
        int minPlayed = standings.stream().mapToInt(TeamStanding::getPlayed).min().orElse(0);
        int maxPlayed = standings.stream().mapToInt(TeamStanding::getPlayed).max().orElse(0);
        return maxPlayed - minPlayed <= 1;
    }

    private List<RecentMatchResult> buildRecentMatches(List<Match> completedMatches)
    {
        List<RecentMatchResult> recentMatches = new ArrayList<>();
        for (int index = completedMatches.size() - 1; index >= 0 && recentMatches.size() < 5; index--)
        {
            Match match = completedMatches.get(index);
            boolean isHome = CLUB_NAME.equals(match.getHomeTeam());
            boolean isAway = CLUB_NAME.equals(match.getAwayTeam());
            if (!isHome && !isAway)
            {
                continue;
            }

            long teamScore = isHome ? match.getHomeScore() : match.getAwayScore();
            long opponentScore = isHome ? match.getAwayScore() : match.getHomeScore();
            String result = teamScore > opponentScore ? "W" : (teamScore < opponentScore ? "L" : "D");
            String opponent = isHome ? match.getAwayTeam() : match.getHomeTeam();
            recentMatches.add(new RecentMatchResult(match.getRoundNo(), match.getMatchDate(), opponent,
                    teamScore, opponentScore, result));
        }
        return recentMatches;
    }

    private static class TeamStanding
    {
        private final String teamName;
        private int points;
        private int played;
        private int wins;
        private int draws;
        private int losses;
        private int goalsFor;
        private int goalsAgainst;

        TeamStanding(String teamName)
        {
            this.teamName = teamName;
        }

        int getPoints()
        {
            return points;
        }

        int getPlayed()
        {
            return played;
        }

        int getGoalDifference()
        {
            return goalsFor - goalsAgainst;
        }

        int getGoalsFor()
        {
            return goalsFor;
        }

        String getTeamName()
        {
            return teamName;
        }
    }

    /**
     * 新增比赛管理
     * 
     * @param match 比赛管理
     * @return 结果
     */
    @Override
    public int insertMatch(Match match)
    {
        match.setCreateTime(DateUtils.getNowDate());
        return matchMapper.insertMatch(match);
    }

    /**
     * 修改比赛管理
     * 
     * @param match 比赛管理
     * @return 结果
     */
    @Override
    public int updateMatch(Match match)
    {
        match.setUpdateTime(DateUtils.getNowDate());
        return matchMapper.updateMatch(match);
    }

    /**
     * 批量删除比赛管理
     * 
     * @param ids 需要删除的比赛管理主键
     * @return 结果
     */
    @Override
    public int deleteMatchByIds(Long[] ids)
    {
        return matchMapper.deleteMatchByIds(ids);
    }

    /**
     * 删除比赛管理信息
     * 
     * @param id 比赛管理主键
     * @return 结果
     */
    @Override
    public int deleteMatchById(Long id)
    {
        return matchMapper.deleteMatchById(id);
    }
}
