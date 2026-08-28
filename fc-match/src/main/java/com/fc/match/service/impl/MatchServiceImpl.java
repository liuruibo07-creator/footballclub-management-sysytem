package com.fc.match.service.impl;

import java.util.List;
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
