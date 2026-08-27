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
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.match.domain.Match;
import com.fc.match.service.IMatchService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 比赛Controller
 * 
 * @author yangrun
 * @date 2026-08-26
 */
@RestController
@RequestMapping("/match/match")
public class MatchController extends BaseController
{
    @Autowired
    private IMatchService matchService;

    /**
     * 查询比赛列表
     */
    @PreAuthorize("@ss.hasPermi('match:match:list')")
    @GetMapping("/list")
    public TableDataInfo list(Match match)
    {
        startPage();
        List<Match> list = matchService.selectMatchList(match);
        return getDataTable(list);
    }

    /**
     * 导出比赛列表
     */
    @PreAuthorize("@ss.hasPermi('match:match:export')")
    @Log(title = "比赛", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Match match)
    {
        List<Match> list = matchService.selectMatchList(match);
        ExcelUtil<Match> util = new ExcelUtil<Match>(Match.class);
        util.exportExcel(response, list, "比赛数据");
    }

    /**
     * 获取比赛详细信息
     */
    @PreAuthorize("@ss.hasPermi('match:match:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(matchService.selectMatchById(id));
    }

    /**
     * 新增比赛
     */
    @PreAuthorize("@ss.hasPermi('match:match:add')")
    @Log(title = "比赛", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Match match)
    {
        return toAjax(matchService.insertMatch(match));
    }

    /**
     * 修改比赛
     */
    @PreAuthorize("@ss.hasPermi('match:match:edit')")
    @Log(title = "比赛", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Match match)
    {
        return toAjax(matchService.updateMatch(match));
    }

    /**
     * 删除比赛
     */
    @PreAuthorize("@ss.hasPermi('match:match:remove')")
    @Log(title = "比赛", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(matchService.deleteMatchByIds(ids));
    }
}
