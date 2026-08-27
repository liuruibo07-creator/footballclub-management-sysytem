package com.fc.system.mapper;

import java.util.List;
import com.fc.system.domain.FootballScheduleEvent;
import com.fc.system.domain.FootballSchedulePlayer;

/**
 * 球队日程Mapper接口
 * 
 * @author 冷云鹏
 * @date 2026-08-27
 */
public interface FootballScheduleEventMapper 
{
    /**
     * 查询球队日程
     * 
     * @param id 球队日程主键
     * @return 球队日程
     */
    public FootballScheduleEvent selectFootballScheduleEventById(Long id);

    /**
     * 查询球队日程列表
     * 
     * @param footballScheduleEvent 球队日程
     * @return 球队日程集合
     */
    public List<FootballScheduleEvent> selectFootballScheduleEventList(FootballScheduleEvent footballScheduleEvent);

    /**
     * 新增球队日程
     * 
     * @param footballScheduleEvent 球队日程
     * @return 结果
     */
    public int insertFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent);

    /**
     * 修改球队日程
     * 
     * @param footballScheduleEvent 球队日程
     * @return 结果
     */
    public int updateFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent);

    /**
     * 删除球队日程
     * 
     * @param id 球队日程主键
     * @return 结果
     */
    public int deleteFootballScheduleEventById(Long id);

    /**
     * 批量删除球队日程
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFootballScheduleEventByIds(Long[] ids);

    /**
     * 批量删除日程参与人
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFootballSchedulePlayerByEventIds(Long[] ids);
    
    /**
     * 批量新增日程参与人
     * 
     * @param footballSchedulePlayerList 日程参与人列表
     * @return 结果
     */
    public int batchFootballSchedulePlayer(List<FootballSchedulePlayer> footballSchedulePlayerList);
    

    /**
     * 通过球队日程主键删除日程参与人信息
     * 
     * @param id 球队日程ID
     * @return 结果
     */
    public int deleteFootballSchedulePlayerByEventId(Long id);
}
