package com.fc.match.service;

import java.util.List;
import com.fc.match.domain.Match;

/**
 * 比赛Service接口
 * 
 * @author yangrun
 * @date 2026-08-26
 */
public interface IMatchService 
{
    /**
     * 查询比赛
     * 
     * @param id 比赛主键
     * @return 比赛
     */
    public Match selectMatchById(Long id);

    /**
     * 查询比赛列表
     * 
     * @param match 比赛
     * @return 比赛集合
     */
    public List<Match> selectMatchList(Match match);

    /**
     * 新增比赛
     * 
     * @param match 比赛
     * @return 结果
     */
    public int insertMatch(Match match);

    /**
     * 修改比赛
     * 
     * @param match 比赛
     * @return 结果
     */
    public int updateMatch(Match match);

    /**
     * 批量删除比赛
     * 
     * @param ids 需要删除的比赛主键集合
     * @return 结果
     */
    public int deleteMatchByIds(Long[] ids);

    /**
     * 删除比赛信息
     * 
     * @param id 比赛主键
     * @return 结果
     */
    public int deleteMatchById(Long id);
}
