package com.fc.system.domain.vo;

import java.io.Serializable;
import java.util.List;
import com.fc.system.domain.FootballScheduleEvent;

/**
 * 首页待办日程汇总 VO（Value Object）
 * <p>
 * 用于首页 Dashboard 展示"待办日程"卡片，包含：
 * - events：最多 3 条最近的待办日程（按开始时间升序）
 * - total：所有待办日程的总数
 * - remaining：未在首页展示的剩余数量（total - events.size()）
 * </p>
 * <p>前端根据 remaining 决定是否显示"查看更多"链接。</p>
 */
public class PendingScheduleSummary implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 首页展示的日程列表（最多 3 条，按开始时间升序排列） */
    private List<FootballScheduleEvent> events;

    /** 所有"已安排"状态的日程总数 */
    private long total;

    /** 未在首页展示的日程数量（total - events.size()，用于"还有 X 条"提示） */
    private long remaining;

    /**
     * 构造方法：根据日程列表和总数自动计算 remaining
     *
     * @param events 首页展示的日程（通常最多 3 条）
     * @param total  待办日程总数
     */
    public PendingScheduleSummary(List<FootballScheduleEvent> events, long total)
    {
        this.events = events;
        this.total = total;
        this.remaining = Math.max(total - events.size(), 0);
    }

    public List<FootballScheduleEvent> getEvents()
    {
        return events;
    }

    public void setEvents(List<FootballScheduleEvent> events)
    {
        this.events = events;
    }

    public long getTotal()
    {
        return total;
    }

    public void setTotal(long total)
    {
        this.total = total;
    }

    public long getRemaining()
    {
        return remaining;
    }

    public void setRemaining(long remaining)
    {
        this.remaining = remaining;
    }
}
