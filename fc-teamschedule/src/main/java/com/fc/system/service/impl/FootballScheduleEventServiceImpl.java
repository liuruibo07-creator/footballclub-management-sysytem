package com.fc.system.service.impl;

import java.util.List;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.fc.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.fc.system.domain.FootballSchedulePlayer;
import com.fc.system.mapper.FootballScheduleEventMapper;
import com.fc.system.domain.FootballScheduleEvent;
import com.fc.system.service.IFootballScheduleEventService;

/**
 * 球队日程Service业务层处理
 * 
 * @author 冷云鹏
 * @date 2026-08-27
 */
@Service
public class FootballScheduleEventServiceImpl implements IFootballScheduleEventService 
{
    @Autowired
    private FootballScheduleEventMapper footballScheduleEventMapper;

    /**
     * 查询球队日程
     * 
     * @param id 球队日程主键
     * @return 球队日程
     */
    @Override
    public FootballScheduleEvent selectFootballScheduleEventById(Long id)
    {
        return footballScheduleEventMapper.selectFootballScheduleEventById(id);
    }

    /**
     * 查询球队日程列表
     * 
     * @param footballScheduleEvent 球队日程
     * @return 球队日程
     */
    @Override
    public List<FootballScheduleEvent> selectFootballScheduleEventList(FootballScheduleEvent footballScheduleEvent)
    {
        return footballScheduleEventMapper.selectFootballScheduleEventList(footballScheduleEvent);
    }

    /**
     * 新增球队日程
     * 
     * @param footballScheduleEvent 球队日程
     * @return 结果
     */
    @Transactional
    @Override
    public int insertFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent)
    {
        footballScheduleEvent.setCreateTime(DateUtils.getNowDate());
        int rows = footballScheduleEventMapper.insertFootballScheduleEvent(footballScheduleEvent);
        insertFootballSchedulePlayer(footballScheduleEvent);
        return rows;
    }

    /**
     * 修改球队日程
     * 
     * @param footballScheduleEvent 球队日程
     * @return 结果
     */
    @Transactional
    @Override
    public int updateFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent)
    {
        footballScheduleEvent.setUpdateTime(DateUtils.getNowDate());
        footballScheduleEventMapper.deleteFootballSchedulePlayerByEventId(footballScheduleEvent.getId());
        insertFootballSchedulePlayer(footballScheduleEvent);
        return footballScheduleEventMapper.updateFootballScheduleEvent(footballScheduleEvent);
    }

    /**
     * 批量删除球队日程
     * 
     * @param ids 需要删除的球队日程主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteFootballScheduleEventByIds(Long[] ids)
    {
        footballScheduleEventMapper.deleteFootballSchedulePlayerByEventIds(ids);
        return footballScheduleEventMapper.deleteFootballScheduleEventByIds(ids);
    }

    /**
     * 删除球队日程信息
     * 
     * @param id 球队日程主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteFootballScheduleEventById(Long id)
    {
        footballScheduleEventMapper.deleteFootballSchedulePlayerByEventId(id);
        return footballScheduleEventMapper.deleteFootballScheduleEventById(id);
    }

    /**
     * 新增日程参与人信息
     * 
     * @param footballScheduleEvent 球队日程对象
     */
    public void insertFootballSchedulePlayer(FootballScheduleEvent footballScheduleEvent)
    {
        List<FootballSchedulePlayer> footballSchedulePlayerList = footballScheduleEvent.getFootballSchedulePlayerList();
        Long id = footballScheduleEvent.getId();
        if (StringUtils.isNotNull(footballSchedulePlayerList))
        {
            List<FootballSchedulePlayer> list = new ArrayList<FootballSchedulePlayer>();
            for (FootballSchedulePlayer footballSchedulePlayer : footballSchedulePlayerList)
            {
                footballSchedulePlayer.setEventId(id);
                list.add(footballSchedulePlayer);
            }
            if (list.size() > 0)
            {
                footballScheduleEventMapper.batchFootballSchedulePlayer(list);
            }
        }
    }
}
