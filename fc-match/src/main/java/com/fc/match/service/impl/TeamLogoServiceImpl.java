package com.fc.match.service.impl;

import java.util.List;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.match.mapper.TeamLogoMapper;
import com.fc.match.domain.TeamLogo;
import com.fc.match.service.ITeamLogoService;

/**
 * 球队队徽Service业务层处理
 * 
 * @author lrb
 * @date 2026-08-30
 */
@Service
public class TeamLogoServiceImpl implements ITeamLogoService
{
    @Autowired
    private TeamLogoMapper teamLogoMapper;

    /**
     * 查询球队队徽列表
     * 
     * @param teamLogo 球队队徽
     * @return 球队队徽集合
     */
    @Override
    public List<TeamLogo> selectTeamLogoList(TeamLogo teamLogo)
    {
        return teamLogoMapper.selectTeamLogoList(teamLogo);
    }

    /**
     * 按球队名称查询队徽
     * 
     * @param teamName 球队名称
     * @return 球队队徽
     */
    @Override
    public TeamLogo selectTeamLogoByName(String teamName)
    {
        return teamLogoMapper.selectTeamLogoByName(teamName);
    }

    /**
     * 查询球队队徽
     * 
     * @param id 球队队徽主键
     * @return 球队队徽
     */
    @Override
    public TeamLogo selectTeamLogoById(Long id)
    {
        return teamLogoMapper.selectTeamLogoById(id);
    }

    /**
     * 新增球队队徽
     * 
     * @param teamLogo 球队队徽
     * @return 结果
     */
    @Override
    public int insertTeamLogo(TeamLogo teamLogo)
    {
        teamLogo.setCreateTime(DateUtils.getNowDate());
        return teamLogoMapper.insertTeamLogo(teamLogo);
    }

    /**
     * 修改球队队徽
     * 
     * @param teamLogo 球队队徽
     * @return 结果
     */
    @Override
    public int updateTeamLogo(TeamLogo teamLogo)
    {
        teamLogo.setUpdateTime(DateUtils.getNowDate());
        return teamLogoMapper.updateTeamLogo(teamLogo);
    }

    /**
     * 批量删除球队队徽
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    @Override
    public int deleteTeamLogoByIds(Long[] ids)
    {
        return teamLogoMapper.deleteTeamLogoByIds(ids);
    }
}
