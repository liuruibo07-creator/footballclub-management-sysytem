package com.fc.match.mapper;

import java.util.List;
import com.fc.match.domain.TeamLogo;

/**
 * 球队队徽数据访问层。
 */
public interface TeamLogoMapper
{
    TeamLogo selectTeamLogoById(Long id);

    List<TeamLogo> selectTeamLogoList(TeamLogo teamLogo);

    int insertTeamLogo(TeamLogo teamLogo);

    int updateTeamLogo(TeamLogo teamLogo);

    int deleteTeamLogoById(Long id);
}
