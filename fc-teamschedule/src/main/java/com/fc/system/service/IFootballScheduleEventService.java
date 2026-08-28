package com.fc.system.service;

import java.util.List;
import com.fc.system.domain.FootballScheduleEvent;
import com.fc.system.domain.vo.PendingScheduleSummary;

/**
 * 球队日程Service接口
 * 
 * @author 冷云鹏
 * @date 2026-08-27
 */
public interface IFootballScheduleEventService 
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
     * 查询首页待办日程汇总
     *
     * @return 待办日程汇总
     */
    public PendingScheduleSummary selectPendingScheduleSummary();

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
     * 批量删除球队日程
     * 
     * @param ids 需要删除的球队日程主键集合
     * @return 结果
     */
    public int deleteFootballScheduleEventByIds(Long[] ids);

    /**
     * 删除球队日程信息
     * 
     * @param id 球队日程主键
     * @return 结果
     */
    public int deleteFootballScheduleEventById(Long id);
}
