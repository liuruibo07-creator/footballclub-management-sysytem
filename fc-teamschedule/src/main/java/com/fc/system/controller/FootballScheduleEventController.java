package com.fc.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fc.common.annotation.Log;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.system.domain.FootballScheduleEvent;
import com.fc.system.service.IFootballScheduleEventService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 球队日程Controller
 * <p>
 * 职责：提供球队日程的 RESTful 接口，包括标准 CRUD 和首页待办查询。
 * 路径前缀：/system/event
 * </p>
 * <p>日程是整个系统的"统一时间线"，汇聚比赛（match）、训练（training）、会议（meeting）
 * 三种类型的事件。其中训练和比赛由各自模块自动同步写入，会议由日程模块独立管理。</p>
 * <p>权限标识统一为 system:event:*，需在 sys_menu 中配置对应菜单和按钮权限。</p>
 *
 * @author 冷云鹏
 * @date 2026-08-27
 */
@RestController
@RequestMapping("/system/event")
public class FootballScheduleEventController extends BaseController
{
    @Autowired
    private IFootballScheduleEventService footballScheduleEventService;

    /**
     * 查询日程列表（分页）
     * <p>startPage() 从请求参数中读取 pageNum/pageSize，通过 PageHelper 实现分页。
     * 支持按标题、类型、开始时间范围、状态进行条件筛选。</p>
     *
     * @param footballScheduleEvent 查询条件
     * @return 分页结果（含 total、rows）
     */
    @PreAuthorize("@ss.hasPermi('system:event:list')")
    @GetMapping("/list")
    public TableDataInfo list(FootballScheduleEvent footballScheduleEvent)
    {
        startPage();
        List<FootballScheduleEvent> list = footballScheduleEventService.selectFootballScheduleEventList(footballScheduleEvent);
        return getDataTable(list);
    }

    /**
     * 查询首页待办日程汇总
     * <p>返回最多 3 条"已安排"状态的日程（按开始时间升序），
     * 以及待办总数和剩余数量，供首页 Dashboard 卡片展示。</p>
     *
     * @return PendingScheduleSummary 对象（events/total/remaining）
     */
    @PreAuthorize("@ss.hasPermi('system:event:list')")
    @GetMapping("/pending")
    public AjaxResult pending()
    {
        return success(footballScheduleEventService.selectPendingScheduleSummary());
    }

    /**
     * 导出日程列表为 Excel
     * <p>使用若依内置的 ExcelUtil，基于 @Excel 注解自动映射列。
     * 需要 system:event:export 权限，操作日志记录为 EXPORT 类型。</p>
     */
    @PreAuthorize("@ss.hasPermi('system:event:export')")
    @Log(title = "球队日程", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FootballScheduleEvent footballScheduleEvent)
    {
        List<FootballScheduleEvent> list = footballScheduleEventService.selectFootballScheduleEventList(footballScheduleEvent);
        ExcelUtil<FootballScheduleEvent> util = new ExcelUtil<FootballScheduleEvent>(FootballScheduleEvent.class);
        util.exportExcel(response, list, "球队日程数据");
    }

    /**
     * 获取日程详情（含参与球员子表）
     * <p>通过 LEFT JOIN 一并查出 football_schedule_player 列表，
     * 前端据此回显已选的参与球员。</p>
     *
     * @param id 日程主键
     * @return 日程对象（含 footballSchedulePlayerList）
     */
    @PreAuthorize("@ss.hasPermi('system:event:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(footballScheduleEventService.selectFootballScheduleEventById(id));
    }

    /**
     * 新增日程
     * <p>Service 层会先插入日程主表，再批量插入参与球员子表，
     * 两步操作在同一事务内完成。需要 system:event:add 权限。</p>
     */
    @PreAuthorize("@ss.hasPermi('system:event:add')")
    @Log(title = "球队日程", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FootballScheduleEvent footballScheduleEvent)
    {
        return toAjax(footballScheduleEventService.insertFootballScheduleEvent(footballScheduleEvent));
    }

    /**
     * 修改日程
     * <p>Service 层采用"先删后插"策略更新参与球员子表：
     * 先删除该日程的所有旧参与人，再重新批量插入前端传来的新列表。
     * 需要 system:event:edit 权限。</p>
     */
    @PreAuthorize("@ss.hasPermi('system:event:edit')")
    @Log(title = "球队日程", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FootballScheduleEvent footballScheduleEvent)
    {
        return toAjax(footballScheduleEventService.updateFootballScheduleEvent(footballScheduleEvent));
    }

    /**
     * 批量删除日程
     * <p>Service 层先删除关联的参与球员子表记录，再删除日程主表，
     * 保证数据一致性。需要 system:event:remove 权限。</p>
     *
     * @param ids 日程主键数组
     */
    @PreAuthorize("@ss.hasPermi('system:event:remove')")
    @Log(title = "球队日程", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(footballScheduleEventService.deleteFootballScheduleEventByIds(ids));
    }
}
