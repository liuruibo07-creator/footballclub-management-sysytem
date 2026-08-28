package com.fc.match.controller;

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
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.match.domain.Match;
import com.fc.match.service.IMatchService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 比赛管理Controller
 * 
 * @author yr
 * @date 2026-08-28
 */
@RestController
@RequestMapping("/match/match")
@Api(tags = "比赛管理控制器")
public class MatchController extends BaseController
{
    @Autowired
    private IMatchService matchService;

    /**
     * 查询比赛管理列表
     */
    @PreAuthorize("@ss.hasPermi('match:match:list')")
    @GetMapping("/list")
    @ApiOperation("查询比赛管理列表")
    public TableDataInfo list(Match match)
    {
        startPage();
        List<Match> list = matchService.selectMatchList(match);
        return getDataTable(list);
    }

    /**
     * 查询首页赛季概览
     */
    @PreAuthorize("@ss.hasPermi('match:match:list')")
    @GetMapping("/season-overview")
    @ApiOperation("查询首页赛季概览")
    public AjaxResult seasonOverview()
    {
        return success(matchService.selectSeasonOverview());
    }

    /**
     * 导出比赛管理列表
     */
    @PreAuthorize("@ss.hasPermi('match:match:export')")
    @Log(title = "比赛管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出比赛管理列表")
    public void export(HttpServletResponse response, Match match)
    {
        List<Match> list = matchService.selectMatchList(match);
        ExcelUtil<Match> util = new ExcelUtil<Match>(Match.class);
        util.exportExcel(response, list, "比赛管理数据");
    }

    /**
     * 获取比赛管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('match:match:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取比赛管理详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(matchService.selectMatchById(id));
    }

    /**
     * 新增比赛管理
     */
    @PreAuthorize("@ss.hasPermi('match:match:add')")
    @Log(title = "比赛管理", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增比赛管理")
    public AjaxResult add(@RequestBody Match match)
    {
        return toAjax(matchService.insertMatch(match));
    }

    /**
     * 修改比赛管理
     */
    @PreAuthorize("@ss.hasPermi('match:match:edit')")
    @Log(title = "比赛管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改比赛管理")
    public AjaxResult edit(@RequestBody Match match)
    {
        return toAjax(matchService.updateMatch(match));
    }

    /**
     * 删除比赛管理
     */
    @PreAuthorize("@ss.hasPermi('match:match:remove')")
    @Log(title = "比赛管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除比赛管理")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(matchService.deleteMatchByIds(ids));
    }
}
