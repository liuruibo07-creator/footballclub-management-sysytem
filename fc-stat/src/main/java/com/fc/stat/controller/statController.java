package com.fc.stat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.fc.common.annotation.Log;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.stat.domain.stat;
import com.fc.stat.service.IstatService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 赛季数据统计Controller
 *
 * @author mumu
 * @date 2026-08-28
 */
@RestController
@RequestMapping("/stat/stat")
@Api(tags = "赛季数据统计控制器")
public class statController extends BaseController
{
    @Autowired
    private IstatService statService;

    @PreAuthorize("@ss.hasPermi('stat:stat:list')")
    @GetMapping("/list")
    @ApiOperation("查询赛季数据统计列表")
    public TableDataInfo list(stat stat)
    {
        startPage();
        List<stat> list = statService.selectstatList(stat);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:export')")
    @Log(title = "赛季数据统计", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出赛季数据统计列表")
    public void export(HttpServletResponse response, stat stat)
    {
        List<stat> list = statService.selectstatList(stat);
        ExcelUtil<stat> util = new ExcelUtil<stat>(stat.class);
        util.exportExcel(response, list, "赛季数据统计数据");
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取赛季数据统计详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(statService.selectstatById(id));
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:add')")
    @Log(title = "赛季数据统计", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增赛季数据统计")
    public AjaxResult add(@RequestBody stat stat)
    {
        return toAjax(statService.insertstat(stat));
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:edit')")
    @Log(title = "赛季数据统计", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改赛季数据统计")
    public AjaxResult edit(@RequestBody stat stat)
    {
        return toAjax(statService.updatestat(stat));
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:remove')")
    @Log(title = "赛季数据统计", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除赛季数据统计")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(statService.deletestatByIds(ids));
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:list')")
    @GetMapping("/teamSummary")
    @ApiOperation("获取球队赛季汇总统计")
    public AjaxResult teamSummary(stat stat)
    {
        List<stat> list = statService.selectTeamSeasonStats(stat);
        List<Map<String, Object>> matchCounts = statService.selectTeamMatchCount(stat);
        Map<String, Object> data = new HashMap<>();
        data.put("list", list);
        data.put("matchCounts", matchCounts);
        return success(data);
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:list')")
    @GetMapping("/ranking")
    @ApiOperation("获取排行榜数据")
    public AjaxResult ranking(stat stat)
    {
        List<stat> list = statService.selectStatRanking(stat);
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:list')")
    @GetMapping("/compare")
    @ApiOperation("获取球员对比数据")
    public AjaxResult compare(@RequestParam Long playerIdA,
                              @RequestParam Long playerIdB,
                              @RequestParam(required = false) String season,
                              @RequestParam(required = false) String competition)
    {
        Long[] playerIds = new Long[]{ playerIdA, playerIdB };
        List<stat> list = statService.selectCompareStats(playerIds, season, competition);
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('stat:stat:list')")
    @GetMapping("/playerOptions")
    @ApiOperation("获取球员下拉列表")
    public AjaxResult playerOptions()
    {
        List<Map<String, Object>> list = statService.selectPlayerOptions();
        return success(list);
    }
}
