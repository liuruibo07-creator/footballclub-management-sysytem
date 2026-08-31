package com.fc.pp.service;

import com.fc.pp.domain.FootballPlayer;
import com.fc.pp.domain.vo.FootballPlayerVo;

import java.util.List;

/**
 * 球员档案Service接口
 * 
 * @author lrb
 * @date 2026-08-26
 */
public interface IFootballPlayerService
{
    /**
     * 查询球员档案
     * 
     * @param id 球员档案主键
     * @return 球员档案
     */
    public FootballPlayerVo selectFootballPlayerById(Long id);

    /**
     * 查询球员档案列表
     * 
     * @param footballPlayer 球员档案
     * @return 球员档案集合
     */
    public List<FootballPlayerVo> selectFootballPlayerList(FootballPlayer footballPlayer);

    /**
     * 新增球员档案
     * 
     * @param footballPlayer 球员档案
     * @return 结果
     */
    public int insertFootballPlayer(FootballPlayer footballPlayer);

    /**
     * 修改球员档案
     * 
     * @param footballPlayer 球员档案
     * @return 结果
     */
    public int updateFootballPlayer(FootballPlayer footballPlayer);

    /**
     * 批量删除球员档案
     * 
     * @param ids 需要删除的球员档案主键集合
     * @return 结果
     */
    public int deleteFootballPlayerByIds(Long[] ids);

    /**
     * 删除球员档案信息
     * 
     * @param id 球员档案主键
     * @return 结果
     */
    public int deleteFootballPlayerById(Long id);
}
