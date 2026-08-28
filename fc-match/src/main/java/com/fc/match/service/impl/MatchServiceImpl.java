package com.fc.match.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.match.mapper.MatchMapper;
import com.fc.match.domain.Match;
import com.fc.match.service.IMatchService;

/**
 * 比赛管理Service业务层处理
 * 
 * @author yr
 * @date 2026-08-28
 */
@Service
public class MatchServiceImpl implements IMatchService 
{
    @Autowired
    private MatchMapper matchMapper;

    /**
     * 查询首页赛季概览
     */
    @Override
    public Map<String, Object> selectSeasonOverview()
    {
        Map<String, Object> result = new HashMap<>();
        // 默认值
        result.put("rank", 0);
        result.put("totalTeams", 0);
        result.put("points", 0);
        result.put("wins", 0);
        result.put("draws", 0);
        result.put("losses", 0);
        result.put("recentMatches", new ArrayList<>());

        // 汇总统计
        Map<String, Object> stats = matchMapper.selectSeasonStats();
        if (stats != null)
        {
            long wins = stats.get("wins") != null ? ((Number) stats.get("wins")).longValue() : 0;
            long draws = stats.get("draws") != null ? ((Number) stats.get("draws")).longValue() : 0;
            long losses = stats.get("losses") != null ? ((Number) stats.get("losses")).longValue() : 0;
            long points = stats.get("points") != null ? ((Number) stats.get("points")).longValue() : 0;
            result.put("wins", wins);
            result.put("draws", draws);
            result.put("losses", losses);
            result.put("points", points);
        }

        // 最近5场比赛
        List<Map<String, Object>> rows = matchMapper.selectRecentMatches();
        if (rows != null && !rows.isEmpty())
        {
            List<Map<String, Object>> recent = new ArrayList<>();
            for (Map<String, Object> row : rows)
            {
                Map<String, Object> item = new HashMap<>();
                item.put("roundNo", row.get("roundNo"));
                item.put("matchDate", row.get("matchDate"));

                String homeTeam = row.get("homeTeam") != null ? row.get("homeTeam").toString() : "";
                String awayTeam = row.get("awayTeam") != null ? row.get("awayTeam").toString() : "";
                long homeScore = row.get("homeScore") != null ? ((Number) row.get("homeScore")).longValue() : 0;
                long awayScore = row.get("awayScore") != null ? ((Number) row.get("awayScore")).longValue() : 0;

                // 判断天津津门虎的得分
                long teamScore, opponentScore;
                if ("天津津门虎".equals(homeTeam))
                {
                    teamScore = homeScore;
                    opponentScore = awayScore;
                }
                else
                {
                    teamScore = awayScore;
                    opponentScore = homeScore;
                }

                item.put("teamScore", teamScore);
                item.put("opponentScore", opponentScore);

                String result1;
                if (teamScore > opponentScore) result1 = "W";
                else if (teamScore < opponentScore) result1 = "L";
                else result1 = "D";
                item.put("result", result1);

                recent.add(item);
            }
            result.put("recentMatches", recent);
        }

        return result;
    }

    /**
     * 查询比赛管理
     * 
     * @param id 比赛管理主键
     * @return 比赛管理
     */
    @Override
    public Match selectMatchById(Long id)
    {
        return matchMapper.selectMatchById(id);
    }

    /**
     * 查询比赛管理列表
     * 
     * @param match 比赛管理
     * @return 比赛管理
     */
    @Override
    public List<Match> selectMatchList(Match match)
    {
        return matchMapper.selectMatchList(match);
    }

    /**
     * 新增比赛管理
     * 
     * @param match 比赛管理
     * @return 结果
     */
    @Override
    public int insertMatch(Match match)
    {
        match.setCreateTime(DateUtils.getNowDate());
        return matchMapper.insertMatch(match);
    }

    /**
     * 修改比赛管理
     * 
     * @param match 比赛管理
     * @return 结果
     */
    @Override
    public int updateMatch(Match match)
    {
        match.setUpdateTime(DateUtils.getNowDate());
        return matchMapper.updateMatch(match);
    }

    /**
     * 批量删除比赛管理
     * 
     * @param ids 需要删除的比赛管理主键
     * @return 结果
     */
    @Override
    public int deleteMatchByIds(Long[] ids)
    {
        return matchMapper.deleteMatchByIds(ids);
    }

    /**
     * 删除比赛管理信息
     * 
     * @param id 比赛管理主键
     * @return 结果
     */
    @Override
    public int deleteMatchById(Long id)
    {
        return matchMapper.deleteMatchById(id);
    }
}
