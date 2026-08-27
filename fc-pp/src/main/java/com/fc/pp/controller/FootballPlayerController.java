package com.fc.pp.controller;

import com.fc.common.annotation.Log;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.core.page.TableDataInfo;
import com.fc.common.enums.BusinessType;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.pp.domain.FootballPlayer;
import com.fc.pp.service.IFootballPlayerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 球员档案Controller
 * 
 * @author ruoyi
 * @date 2026-08-26
 */
@RestController
@RequestMapping("/pp/pp")
@Api(tags = "球员档案控制器")
public class FootballPlayerController extends BaseController
{
    @Autowired
    private IFootballPlayerService footballPlayerService;

    /**
     * 查询球员档案列表
     */
    @PreAuthorize("@ss.hasPermi('pp:pp:list')")
    @GetMapping("/list")
    @ApiOperation("查询球员档案列表")
    public TableDataInfo list(FootballPlayer footballPlayer)
    {
        startPage();
        List<FootballPlayer> list = footballPlayerService.selectFootballPlayerList(footballPlayer);
        return getDataTable(list);
    }

    /**
     * 导出球员档案列表
     */
    @PreAuthorize("@ss.hasPermi('pp:pp:export')")
    @Log(title = "球员档案", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出球员档案列表")
    public void export(HttpServletResponse response, FootballPlayer footballPlayer)
    {
        List<FootballPlayer> list = footballPlayerService.selectFootballPlayerList(footballPlayer);
        ExcelUtil<FootballPlayer> util = new ExcelUtil<FootballPlayer>(FootballPlayer.class);
        util.exportExcel(response, list, "球员档案数据");
    }

    /**
     * 获取球员档案详细信息
     */
    @PreAuthorize("@ss.hasPermi('pp:pp:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取球员档案详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(footballPlayerService.selectFootballPlayerById(id));
    }

    /**
     * 新增球员档案
     */
    @PreAuthorize("@ss.hasPermi('pp:pp:add')")
    @Log(title = "球员档案", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增球员档案")
    public AjaxResult add(@RequestBody FootballPlayer footballPlayer)
    {
        return toAjax(footballPlayerService.insertFootballPlayer(footballPlayer));
    }

    /**
     * 修改球员档案
     */
    @PreAuthorize("@ss.hasPermi('pp:pp:edit')")
    @Log(title = "球员档案", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改球员档案")
    public AjaxResult edit(@RequestBody FootballPlayer footballPlayer)
    {
        return toAjax(footballPlayerService.updateFootballPlayer(footballPlayer));
    }

    /**
     * 删除球员档案
     */
    @PreAuthorize("@ss.hasPermi('pp:pp:remove')")
    @Log(title = "球员档案", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除球员档案")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(footballPlayerService.deleteFootballPlayerByIds(ids));
    }
}
