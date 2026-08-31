package com.fc.match.service.impl;

import java.util.List;
import com.fc.common.utils.DateUtils;
import com.fc.common.exception.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.match.mapper.LeagueTeamMapper;
import com.fc.match.domain.LeagueTeam;
import com.fc.match.service.ILeagueTeamService;

/**
 * 联赛球队Service业务层处理
 * 
 * @author lrb
 * @date 2026-08-31
 */
@Service
public class LeagueTeamServiceImpl implements ILeagueTeamService
{
    @Autowired
    private LeagueTeamMapper leagueTeamMapper;

    @Override
    public List<LeagueTeam> selectLeagueTeamList(LeagueTeam leagueTeam)
    {
        return leagueTeamMapper.selectLeagueTeamList(leagueTeam);
    }

    @Override
    public List<LeagueTeam> selectLeagueTeamAll()
    {
        return leagueTeamMapper.selectLeagueTeamAll();
    }

    @Override
    public LeagueTeam selectLeagueTeamById(Long id)
    {
        return leagueTeamMapper.selectLeagueTeamById(id);
    }

    @Override
    public boolean checkTeamNameUnique(LeagueTeam leagueTeam)
    {
        Long id = leagueTeam.getId() == null ? -1L : leagueTeam.getId();
        LeagueTeam exist = leagueTeamMapper.selectLeagueTeamByName(leagueTeam.getTeamName());
        return exist == null || exist.getId().equals(id);
    }

    @Override
    public int insertLeagueTeam(LeagueTeam leagueTeam)
    {
        if (!checkTeamNameUnique(leagueTeam))
        {
            throw new ServiceException("球队名称'" + leagueTeam.getTeamName() + "'已存在, 请更换");
        }
        leagueTeam.setCreateTime(DateUtils.getNowDate());
        return leagueTeamMapper.insertLeagueTeam(leagueTeam);
    }

    @Override
    public int updateLeagueTeam(LeagueTeam leagueTeam)
    {
        if (!checkTeamNameUnique(leagueTeam))
        {
            throw new ServiceException("球队名称'" + leagueTeam.getTeamName() + "'已存在, 请更换");
        }
        leagueTeam.setUpdateTime(DateUtils.getNowDate());
        return leagueTeamMapper.updateLeagueTeam(leagueTeam);
    }

    @Override
    public int deleteLeagueTeamByIds(Long[] ids)
    {
        return leagueTeamMapper.deleteLeagueTeamByIds(ids);
    }
}
