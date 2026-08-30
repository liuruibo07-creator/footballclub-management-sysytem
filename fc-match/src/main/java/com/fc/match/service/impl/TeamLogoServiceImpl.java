package com.fc.match.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.common.utils.DateUtils;
import com.fc.match.domain.TeamLogo;
import com.fc.match.mapper.TeamLogoMapper;
import com.fc.match.service.ITeamLogoService;

/**
 * 球队队徽服务实现。
 */
@Service
public class TeamLogoServiceImpl implements ITeamLogoService
{
    @Autowired
    private TeamLogoMapper teamLogoMapper;

    @Override
    public TeamLogo selectTeamLogoById(Long id)
    {
        return teamLogoMapper.selectTeamLogoById(id);
    }

    @Override
    public List<TeamLogo> selectTeamLogoList(TeamLogo teamLogo)
    {
        return teamLogoMapper.selectTeamLogoList(teamLogo);
    }

    @Override
    public int insertTeamLogo(TeamLogo teamLogo)
    {
        teamLogo.setCreateTime(DateUtils.getNowDate());
        return teamLogoMapper.insertTeamLogo(teamLogo);
    }

    @Override
    public int updateTeamLogo(TeamLogo teamLogo)
    {
        teamLogo.setUpdateTime(DateUtils.getNowDate());
        return teamLogoMapper.updateTeamLogo(teamLogo);
    }

    @Override
    public int deleteTeamLogoById(Long id)
    {
        return teamLogoMapper.deleteTeamLogoById(id);
    }
}
