package com.fc.match.service;

import java.util.List;
import com.fc.match.domain.LeagueTeam;

/**
 * 联赛球队Service接口
 * 
 * @author lrb
 * @date 2026-08-31
 */
public interface ILeagueTeamService
{
    /**
     * 查询联赛球队列表
     * 
     * @param leagueTeam 联赛球队
     * @return 联赛球队集合
     */
    public List<LeagueTeam> selectLeagueTeamList(LeagueTeam leagueTeam);

    /**
     * 查询全部未删除的联赛球队(比赛管理新增弹窗主客队下拉共用)
     * 
     * @return 联赛球队集合
     */
    public List<LeagueTeam> selectLeagueTeamAll();

    /**
     * 查询联赛球队
     * 
     * @param id 联赛球队主键
     * @return 联赛球队
     */
    public LeagueTeam selectLeagueTeamById(Long id);

    /**
     * 校验球队名称是否唯一(不区分删除标志)
     * 
     * @param leagueTeam 联赛球队(teamName必填, id修改时传)
     * @return true=唯一可用 false=已存在
     */
    public boolean checkTeamNameUnique(LeagueTeam leagueTeam);

    /**
     * 新增联赛球队
     * 
     * @param leagueTeam 联赛球队
     * @return 结果
     */
    public int insertLeagueTeam(LeagueTeam leagueTeam);

    /**
     * 修改联赛球队
     * 
     * @param leagueTeam 联赛球队
     * @return 结果
     */
    public int updateLeagueTeam(LeagueTeam leagueTeam);

    /**
     * 批量删除联赛球队(逻辑删除)
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteLeagueTeamByIds(Long[] ids);
}
