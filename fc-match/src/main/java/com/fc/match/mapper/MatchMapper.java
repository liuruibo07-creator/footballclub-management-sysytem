package com.fc.match.mapper;

import java.util.List;
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
