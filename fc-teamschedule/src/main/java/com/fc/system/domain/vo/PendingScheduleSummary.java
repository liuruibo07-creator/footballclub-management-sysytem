package com.fc.system.domain.vo;

import java.io.Serializable;
import java.util.List;
import com.fc.system.domain.FootballScheduleEvent;

/**
 * 首页待办日程汇总
 */
public class PendingScheduleSummary implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 首页展示的日程（最多三条） */
    private List<FootballScheduleEvent> events;

    /** 已安排日程总数 */
    private long total;

    /** 未在首页展示的日程数量 */
    private long remaining;

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
