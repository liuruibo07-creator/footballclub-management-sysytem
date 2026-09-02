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
import com.fc.system.domain.vo.PendingScheduleSummary;
import com.fc.system.service.IFootballScheduleEventService;

/**
 * 球队日程Service业务层处理
 * <p>
 * 职责：
 * 1. 日程主表（football_schedule_event）的标准 CRUD
 * 2. 日程参与球员子表（football_schedule_player）的维护（先删后插策略）
 * 3. 首页待办日程汇总查询
 * </p>
 * <p>注意：与训练模块不同，日程模块不会主动同步到其他模块。
 * 训练和比赛模块会"推"数据到日程表，但日程表本身是被动的接收方。</p>
 * <p>所有写操作均标注 @Transactional，保证主表和子表在同一事务内完成。</p>
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
     * 查询单条日程详情（含参与球员子表）
     * <p>SQL 通过 LEFT JOIN football_schedule_player 一并查出参与球员，
     * 映射到 footballSchedulePlayerList 集合。</p>
     *
     * @param id 日程主键
     * @return 日程对象（含参与球员列表）
     */
    @Override
    public FootballScheduleEvent selectFootballScheduleEventById(Long id)
    {
        return footballScheduleEventMapper.selectFootballScheduleEventById(id);
    }

    /**
     * 条件查询日程列表
     * <p>支持按标题、类型、开始时间范围、状态筛选。
     * 分页由 Controller 层 PageHelper 处理。</p>
     *
     * @param footballScheduleEvent 查询条件
     * @return 日程列表
     */
    @Override
    public List<FootballScheduleEvent> selectFootballScheduleEventList(FootballScheduleEvent footballScheduleEvent)
    {
        return footballScheduleEventMapper.selectFootballScheduleEventList(footballScheduleEvent);
    }

    /**
     * 查询首页待办日程汇总
     * <p>执行流程：
     * 1. 查询最多 3 条"已安排"状态的日程（按开始时间升序）
     * 2. 统计所有"已安排"日程的总数
     * 3. 封装为 PendingScheduleSummary 返回，包含 events/total/remaining 三个字段
     * </p>
     * <p>remaining = total - events.size()，用于前端显示"还有 X 条待办"。</p>
     *
     * @return 待办日程汇总对象
     */
    @Override
    public PendingScheduleSummary selectPendingScheduleSummary()
    {
        final int homePageLimit = 3;
        List<FootballScheduleEvent> events = footballScheduleEventMapper.selectPendingScheduleEvents(homePageLimit);
        long total = footballScheduleEventMapper.countPendingScheduleEvents();
        return new PendingScheduleSummary(events, total);
    }

    /**
     * 新增日程
     * <p>执行流程：
     * 1. 设置 createTime 为当前时间
     * 2. 插入日程主表，自增主键回填到 footballScheduleEvent.id
     * 3. 批量插入参与球员子表（insertFootballSchedulePlayer）
     * </p>
     *
     * @param footballScheduleEvent 日程对象（含 footballSchedulePlayerList）
     * @return 影响行数
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
     * 修改日程
     * <p>执行流程：
     * 1. 设置 updateTime 为当前时间
     * 2. 删除该日程的所有旧参与球员记录（deleteFootballSchedulePlayerByEventId）
     * 3. 重新批量插入前端传来的新参与球员列表
     * 4. 更新日程主表
     * </p>
     * <p>子表采用"先删后插"策略，简单可靠，适合数据量不大的场景。</p>
     *
     * @param footballScheduleEvent 日程对象（id 必填）
     * @return 影响行数
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
     * 批量删除日程
     * <p>级联删除顺序：先删子表（参与球员）→ 再删主表（日程），
     * 保证外键引用不会悬空。</p>
     *
     * @param ids 日程主键数组
     * @return 影响行数
     */
    @Transactional
    @Override
    public int deleteFootballScheduleEventByIds(Long[] ids)
    {
        footballScheduleEventMapper.deleteFootballSchedulePlayerByEventIds(ids);
        return footballScheduleEventMapper.deleteFootballScheduleEventByIds(ids);
    }

    /**
     * 删除单条日程（内部委托给批量删除方法）
     *
     * @param id 日程主键
     * @return 影响行数
     */
    @Transactional
    @Override
    public int deleteFootballScheduleEventById(Long id)
    {
        footballScheduleEventMapper.deleteFootballSchedulePlayerByEventId(id);
        return footballScheduleEventMapper.deleteFootballScheduleEventById(id);
    }

    /**
     * 批量插入日程参与球员
     * <p>遍历前端传来的参与球员列表，为每条记录设置 eventId（指向当前日程），
     * 然后调用 Mapper 的批量插入方法。若列表为空或 null 则跳过。</p>
     *
     * @param footballScheduleEvent 日程对象（含 footballSchedulePlayerList）
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
