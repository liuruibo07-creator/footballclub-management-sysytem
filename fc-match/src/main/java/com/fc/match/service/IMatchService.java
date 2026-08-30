package com.fc.match.service;

import java.util.List;
import com.fc.match.domain.Match;
import com.fc.match.domain.vo.SeasonOverview;

/**
 * 比赛管理Service接口
 * 
 * @author yr
 * @date 2026-08-28
 */
public interface IMatchService 
{
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
     * 查询首页赛季概览
     *
     * @return 赛季概览
     */
    public SeasonOverview selectSeasonOverview();

    /**
     * 查询下一场比赛
     *
     * @return 下一场未完赛比赛；没有时返回 null
     */
    public Match selectNextMatch();

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
     * 批量删除比赛管理
     * 
     * @param ids 需要删除的比赛管理主键集合
     * @return 结果
     */
    public int deleteMatchByIds(Long[] ids);

    /**
     * 删除比赛管理信息
     * 
     * @param id 比赛管理主键
     * @return 结果
     */
    public int deleteMatchById(Long id);
}
