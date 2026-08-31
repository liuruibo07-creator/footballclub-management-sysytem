package com.fc.pp.service.impl;

import com.fc.common.utils.DateUtils;
import com.fc.pp.domain.FootballPlayer;
import com.fc.pp.domain.vo.FootballPlayerVo;
import com.fc.pp.mapper.FootballPlayerMapper;
import com.fc.pp.service.IFootballPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 球员档案Service业务层处理
 * 
 * @author lrb
 * @date 2026-08-26
 */
@Service
public class FootballPlayerServiceImpl implements IFootballPlayerService
{
    @Autowired
    private FootballPlayerMapper footballPlayerMapper;

    /**
     * 查询球员档案
     * 
     * @param id 球员档案主键
     * @return 球员档案
     */
    @Override
    public FootballPlayerVo selectFootballPlayerById(Long id)
    {
        return footballPlayerMapper.selectFootballPlayerById(id);
    }

    /**
     * 查询球员档案列表
     * 
     * @param footballPlayer 球员档案
     * @return 球员档案
     */
    @Override
    public List<FootballPlayerVo> selectFootballPlayerList(FootballPlayer footballPlayer)
    {
        return footballPlayerMapper.selectFootballPlayerList(footballPlayer);
    }

    /**
     * 新增球员档案
     * 
     * @param footballPlayer 球员档案
     * @return 结果
     */
    @Override
    public int insertFootballPlayer(FootballPlayer footballPlayer)
    {
        footballPlayer.setCreateTime(DateUtils.getNowDate());
        return footballPlayerMapper.insertFootballPlayer(footballPlayer);
    }

    /**
     * 修改球员档案
     * 
     * @param footballPlayer 球员档案
     * @return 结果
     */
    @Override
    public int updateFootballPlayer(FootballPlayer footballPlayer)
    {
        footballPlayer.setUpdateTime(DateUtils.getNowDate());
        return footballPlayerMapper.updateFootballPlayer(footballPlayer);
    }

    /**
     * 批量删除球员档案
     * 
     * @param ids 需要删除的球员档案主键
     * @return 结果
     */
    @Override
    public int deleteFootballPlayerByIds(Long[] ids)
    {
        return footballPlayerMapper.deleteFootballPlayerByIds(ids);
    }

    /**
     * 删除球员档案信息
     * 
     * @param id 球员档案主键
     * @return 结果
     */
    @Override
    public int deleteFootballPlayerById(Long id)
    {
        return footballPlayerMapper.deleteFootballPlayerById(id);
    }
}
