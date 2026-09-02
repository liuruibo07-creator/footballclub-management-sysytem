package com.fc.system.service;

import java.util.List;
import com.fc.system.domain.FootballScheduleEvent;
import com.fc.system.domain.vo.PendingScheduleSummary;

/**
 * 球队日程Service接口
 * <p>
 * 定义日程管理模块的全部业务操作，实现类 {@link com.fc.system.service.impl.FootballScheduleEventServiceImpl}
 * 负责两项核心工作：
 * 1. 日程主表 + 参与球员子表的标准 CRUD（主从表结构）
 * 2. 首页待办日程汇总查询（供 Dashboard 卡片使用）
 * </p>
 * <p>注意：日程表是被动的"数据汇聚点"，训练和比赛模块会主动同步数据到日程表，
 * 但日程模块本身不会反向同步。</p>
 *
 * @author 冷云鹏
 * @date 2026-08-27
 */
public interface IFootballScheduleEventService
{
    /**
     * 查询单条日程详情（含参与球员子表）
     *
     * @param id 日程主键
     * @return 日程对象（含 footballSchedulePlayerList）
     */
    public FootballScheduleEvent selectFootballScheduleEventById(Long id);

    /**
     * 条件查询日程列表（分页由 Controller 层 PageHelper 处理）
     * <p>支持按标题、类型、开始时间范围、状态筛选。</p>
     *
     * @param footballScheduleEvent 查询条件
     * @return 日程列表
     */
    public List<FootballScheduleEvent> selectFootballScheduleEventList(FootballScheduleEvent footballScheduleEvent);

    /**
     * 查询首页待办日程汇总
     * <p>返回最多 3 条待办日程及总数，封装为 PendingScheduleSummary。</p>
     *
     * @return 待办日程汇总对象
     */
    public PendingScheduleSummary selectPendingScheduleSummary();

    /**
     * 新增日程（含参与球员子表）
     * <p>执行流程：插入主表 → 批量插入子表。两步在同一事务内完成。</p>
     *
     * @param footballScheduleEvent 日程对象（含 footballSchedulePlayerList）
     * @return 影响行数
     */
    public int insertFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent);

    /**
     * 修改日程（含参与球员子表）
     * <p>子表采用"先删后插"策略：先删除旧参与人，再插入新参与人。</p>
     *
     * @param footballScheduleEvent 日程对象（id 必填）
     * @return 影响行数
     */
    public int updateFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent);

    /**
     * 批量删除日程（级联删除参与球员子表）
     *
     * @param ids 日程主键数组
     * @return 影响行数
     */
    public int deleteFootballScheduleEventByIds(Long[] ids);

    /**
     * 删除单条日程（内部委托给批量删除方法）
     *
     * @param id 日程主键
     * @return 影响行数
     */
    public int deleteFootballScheduleEventById(Long id);
}
