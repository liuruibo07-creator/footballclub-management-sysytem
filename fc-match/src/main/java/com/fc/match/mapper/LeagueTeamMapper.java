package com.fc.match.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fc.match.domain.LeagueTeam;

/**
 * 联赛球队Mapper接口
 * 
 * @author lrb
 * @date 2026-08-31
 */
public interface LeagueTeamMapper
{
    /**
     * 查询联赛球队列表
     * 
     * @param leagueTeam 联赛球队
     * @return 联赛球队集合
     */
    public List<LeagueTeam> selectLeagueTeamList(LeagueTeam leagueTeam);

    /**
     * 查询全部未删除的联赛球队(比赛管理新增弹窗主客队下拉共用, 仅返回基础信息)
     * 
     * @return 联赛球队集合
     */
    public List<LeagueTeam> selectLeagueTeamAll();

    /**
     * 按球队名称查询(不区分删除标志, 用于名称唯一性校验)
     * 
     * @param teamName 球队名称
     * @return 联赛球队
     */
    public LeagueTeam selectLeagueTeamByName(@Param("teamName") String teamName);

    /**
     * 查询联赛球队
     * 
     * @param id 联赛球队主键
     * @return 联赛球队
     */
    public LeagueTeam selectLeagueTeamById(Long id);

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
     * 批量删除联赛球队(逻辑删除 del_flag='2')
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteLeagueTeamByIds(Long[] ids);
}
