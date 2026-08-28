package com.fc.stat.service.impl;

import java.util.List;
import java.util.Map;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.stat.mapper.statMapper;
import com.fc.stat.domain.stat;
import com.fc.stat.service.IstatService;

/**
 * 赛季数据统计Service业务层处理
 *
 * @author mumu
 * @date 2026-08-28
 */
@Service
public class statServiceImpl implements IstatService
{
    @Autowired
    private statMapper statMapper;

    @Override
    public stat selectstatById(Long id)
    {
        return statMapper.selectstatById(id);
    }

    @Override
    public List<stat> selectstatList(stat stat)
    {
        return statMapper.selectstatList(stat);
    }

    @Override
    public int insertstat(stat stat)
    {
        stat.setCreateTime(DateUtils.getNowDate());
        return statMapper.insertstat(stat);
    }

    @Override
    public int updatestat(stat stat)
    {
        stat.setUpdateTime(DateUtils.getNowDate());
        return statMapper.updatestat(stat);
    }

    @Override
    public int deletestatByIds(Long[] ids)
    {
        return statMapper.deletestatByIds(ids);
    }

    @Override
    public int deletestatById(Long id)
    {
        return statMapper.deletestatById(id);
    }

    @Override
    public List<stat> selectStatRanking(stat stat)
    {
        return statMapper.selectStatRanking(stat);
    }

    @Override
    public List<stat> selectTeamSeasonStats(stat stat)
    {
        return statMapper.selectTeamSeasonStats(stat);
    }

    @Override
    public List<stat> selectCompareStats(Long[] playerIds, String season, String competition)
    {
        return statMapper.selectCompareStats(playerIds, season, competition);
    }

    @Override
    public List<Map<String, Object>> selectPlayerOptions()
    {
        return statMapper.selectPlayerOptions();
    }
}
