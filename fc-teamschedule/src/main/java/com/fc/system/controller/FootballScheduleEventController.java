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
     * 查询球队日程列表
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
     * 查询首页待办日程（最多三条）
     */
    @PreAuthorize("@ss.hasPermi('system:event:list')")
    @GetMapping("/pending")
    public AjaxResult pending()
    {
        return success(footballScheduleEventService.selectPendingScheduleSummary());
    }

    /**
     * 导出球队日程列表
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
     * 获取球队日程详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:event:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(footballScheduleEventService.selectFootballScheduleEventById(id));
    }

    /**
     * 新增球队日程
     */
    @PreAuthorize("@ss.hasPermi('system:event:add')")
    @Log(title = "球队日程", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FootballScheduleEvent footballScheduleEvent)
    {
        return toAjax(footballScheduleEventService.insertFootballScheduleEvent(footballScheduleEvent));
    }

    /**
     * 修改球队日程
     */
    @PreAuthorize("@ss.hasPermi('system:event:edit')")
    @Log(title = "球队日程", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FootballScheduleEvent footballScheduleEvent)
    {
        return toAjax(footballScheduleEventService.updateFootballScheduleEvent(footballScheduleEvent));
    }

    /**
     * 删除球队日程
     */
    @PreAuthorize("@ss.hasPermi('system:event:remove')")
    @Log(title = "球队日程", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(footballScheduleEventService.deleteFootballScheduleEventByIds(ids));
    }
}
