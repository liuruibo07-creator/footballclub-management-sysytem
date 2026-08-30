package com.fc.match.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fc.match.domain.TeamLogo;

/**
 * 球队队徽Mapper接口
 * 
 * @author lrb
 * @date 2026-08-30
 */
public interface TeamLogoMapper
{
    /**
     * 查询球队队徽列表
     * 
     * @param teamLogo 球队队徽
     * @return 球队队徽集合
     */
    public List<TeamLogo> selectTeamLogoList(TeamLogo teamLogo);

    /**
     * 按球队名称查询队徽
     * 
     * @param teamName 球队名称
     * @return 球队队徽
     */
    public TeamLogo selectTeamLogoByName(@Param("teamName") String teamName);

    /**
     * 查询球队队徽
     * 
     * @param id 球队队徽主键
     * @return 球队队徽
     */
    public TeamLogo selectTeamLogoById(Long id);

    /**
     * 新增球队队徽
     * 
     * @param teamLogo 球队队徽
     * @return 结果
     */
    public int insertTeamLogo(TeamLogo teamLogo);

    /**
     * 修改球队队徽
     * 
     * @param teamLogo 球队队徽
     * @return 结果
     */
    public int updateTeamLogo(TeamLogo teamLogo);

    /**
     * 批量删除球队队徽
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTeamLogoByIds(Long[] ids);
}
