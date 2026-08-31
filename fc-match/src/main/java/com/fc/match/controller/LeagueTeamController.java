package com.fc.match.controller;

import java.util.List;
import com.fc.common.annotation.Log;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.core.page.TableDataInfo;
import com.fc.common.enums.BusinessType;
import com.fc.match.domain.LeagueTeam;
import com.fc.match.service.ILeagueTeamService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 联赛球队Controller
 * 
 * @author lrb
 * @date 2026-08-31
 */
@RestController
@RequestMapping("/league/team")
@Api(tags = "联赛球队控制器")
public class LeagueTeamController extends BaseController
{
    @Autowired
    private ILeagueTeamService leagueTeamService;

    /**
     * 查询联赛球队列表
     */
    @PreAuthorize("@ss.hasPermi('league:team:list')")
    @GetMapping("/list")
    @ApiOperation("查询联赛球队列表")
    public TableDataInfo list(LeagueTeam leagueTeam)
    {
        startPage();
        List<LeagueTeam> list = leagueTeamService.selectLeagueTeamList(leagueTeam);
        return getDataTable(list);
    }

    /**
     * 联赛球队下拉选项(比赛管理新增弹窗主客队共用)
     * 不加@PreAuthorize: 比赛管理用户可能只有match:match:*权限, 缺少league:team:list;
     * 接口已受登录鉴权保护, 且仅返回球队基础信息, 数据不敏感
     */
    @GetMapping("/optionselect")
    @ApiOperation("查询联赛球队下拉选项")
    public AjaxResult optionselect()
    {
        return success(leagueTeamService.selectLeagueTeamAll());
    }

    /**
     * 获取联赛球队详细信息
     */
    @PreAuthorize("@ss.hasPermi('league:team:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取联赛球队详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(leagueTeamService.selectLeagueTeamById(id));
    }

    /**
     * 新增联赛球队
     */
    @PreAuthorize("@ss.hasPermi('league:team:add')")
    @Log(title = "联赛球队", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增联赛球队")
    public AjaxResult add(@RequestBody LeagueTeam leagueTeam)
    {
        return toAjax(leagueTeamService.insertLeagueTeam(leagueTeam));
    }

    /**
     * 修改联赛球队
     */
    @PreAuthorize("@ss.hasPermi('league:team:edit')")
    @Log(title = "联赛球队", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改联赛球队")
    public AjaxResult edit(@RequestBody LeagueTeam leagueTeam)
    {
        return toAjax(leagueTeamService.updateLeagueTeam(leagueTeam));
    }

    /**
     * 删除联赛球队(逻辑删除)
     */
    @PreAuthorize("@ss.hasPermi('league:team:remove')")
    @Log(title = "联赛球队", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除联赛球队")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(leagueTeamService.deleteLeagueTeamByIds(ids));
    }
}
