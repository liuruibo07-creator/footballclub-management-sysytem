package com.fc.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fc.system.domain.FootballScheduleEvent;
import com.fc.system.domain.FootballSchedulePlayer;

/**
 * 球队日程Mapper接口
 * <p>
 * 职责：
 * 1. 日程主表（football_schedule_event）的标准 CRUD
 * 2. 日程参与球员子表（football_schedule_player）的增删
 * 3. 首页待办日程查询（selectPendingScheduleEvents、countPendingScheduleEvents）
 * </p>
 * <p>注意：与训练模块的 Mapper 不同，本 Mapper 不涉及跨模块表操作，
 * 所有 SQL 仅操作 football_schedule_event 和 football_schedule_player 两张表。</p>
 *
 * @author 冷云鹏
 * @date 2026-08-27
 */
public interface FootballScheduleEventMapper
{
    /* ==================== 日程主表 CRUD ==================== */

    /**
     * 根据 ID 查询单条日程（含参与球员子表）
     * <p>SQL 通过 LEFT JOIN football_schedule_player 一并查出参与球员。</p>
     *
     * @param id 日程主键
     * @return 日程对象（含 footballSchedulePlayerList）
     */
    public FootballScheduleEvent selectFootballScheduleEventById(Long id);

    /**
     * 条件查询日程列表
     * <p>支持按标题、类型、开始时间范围、状态筛选。分页由 PageHelper 在外层处理。</p>
     *
     * @param footballScheduleEvent 查询条件
     * @return 日程列表
     */
    public List<FootballScheduleEvent> selectFootballScheduleEventList(FootballScheduleEvent footballScheduleEvent);

    /**
     * 查询首页待办日程（最多 limit 条）
     * <p>筛选条件：status='0'（已安排）且 del_flag='0'（未删除）。
     * 排序：按 start_time 升序（最近的优先），再按 id 升序。</p>
     *
     * @param limit 最大返回数量（通常为 3）
     * @return 待办日程列表
     */
    public List<FootballScheduleEvent> selectPendingScheduleEvents(@Param("limit") int limit);

    /**
     * 统计所有"已安排"状态的日程总数
     * <p>用于首页待办汇总，与 selectPendingScheduleEvents 配合使用：
     * 前者取最多 3 条展示，后者取总数计算 remaining。</p>
     *
     * @return 待办日程总数
     */
    public long countPendingScheduleEvents();

    /**
     * 新增日程主表记录
     * <p>useGeneratedKeys=true，自增主键回填到参数对象的 id 属性。</p>
     *
     * @param footballScheduleEvent 日程对象
     * @return 影响行数
     */
    public int insertFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent);

    /**
     * 修改日程主表记录（动态 SET，仅更新非 null 字段）
     *
     * @param footballScheduleEvent 日程对象
     * @return 影响行数
     */
    public int updateFootballScheduleEvent(FootballScheduleEvent footballScheduleEvent);

    /** 删除单条日程记录（物理删除） */
    public int deleteFootballScheduleEventById(Long id);

    /** 批量删除日程记录 */
    public int deleteFootballScheduleEventByIds(@Param("ids") Long[] ids);

    /* ==================== 日程参与球员子表（football_schedule_player） ==================== */

    /** 按日程 ID 批量删除子表记录（用于级联删除） */
    public int deleteFootballSchedulePlayerByEventIds(@Param("ids") Long[] ids);

    /**
     * 批量插入日程参与球员
     * <p>注意：与训练模块不同，本表不存储出勤状态，只记录"谁参加了哪条日程"。</p>
     *
     * @param footballSchedulePlayerList 参与球员列表
     * @return 影响行数
     */
    public int batchFootballSchedulePlayer(@Param("list") List<FootballSchedulePlayer> footballSchedulePlayerList);

    /** 删除单条日程的所有参与球员记录（用于"先删后插"的更新策略） */
    public int deleteFootballSchedulePlayerByEventId(Long id);
}
