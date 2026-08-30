package com.fc.match.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fc.match.domain.Match;

/**
 * 比赛管理Mapper接口
 * 
 * @author yr
 * @date 2026-08-28
 */
public interface MatchMapper 
{
    /**
     * 查询最新联赛赛季
     */
    public String selectLatestLeagueSeason();

    /**
     * 查询指定赛季所有已完赛的联赛比赛
     */
    public List<Match> selectCompletedLeagueMatches(@Param("season") String season);

    /**
     * 查询当前时间之后最早一场未完赛比赛
     */
    public Match selectNextMatch();

    /**
     * 查询扣分
     */
    public Integer selectPointsDeduction(@Param("season") String season, @Param("competitionName") String competitionName);

    /**
     * 查询快照联赛排名
     */
    public Integer selectLeagueRank(@Param("season") String season, @Param("competitionName") String competitionName);

    /**
     * 查询快照联赛球队数
     */
    public Integer selectLeagueTeamCount(@Param("season") String season, @Param("competitionName") String competitionName);

    /**
     * 查询比赛管理
     * 
     * @param id 比赛管理主键
     * @return 比赛管理
     */
    public Match selectMatchById(Long id);

    /**
     * 查询比赛管理列表
     * 
     * @param match 比赛管理
     * @return 比赛管理集合
     */
    public List<Match> selectMatchList(Match match);

    /**
     * 新增比赛管理
     * 
     * @param match 比赛管理
     * @return 结果
     */
    public int insertMatch(Match match);

    /**
     * 修改比赛管理
     * 
     * @param match 比赛管理
     * @return 结果
     */
    public int updateMatch(Match match);

    /**
     * 删除比赛管理
     * 
     * @param id 比赛管理主键
     * @return 结果
     */
    public int deleteMatchById(Long id);

    /**
     * 批量删除比赛管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMatchByIds(Long[] ids);
}
