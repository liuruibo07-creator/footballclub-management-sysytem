package com.fc.match.service;

import java.util.List;
import com.fc.match.domain.TeamLogo;

/**
 * 球队队徽服务。
 */
public interface ITeamLogoService
{
    TeamLogo selectTeamLogoById(Long id);

    List<TeamLogo> selectTeamLogoList(TeamLogo teamLogo);

    int insertTeamLogo(TeamLogo teamLogo);

    int updateTeamLogo(TeamLogo teamLogo);

    int deleteTeamLogoById(Long id);
}
