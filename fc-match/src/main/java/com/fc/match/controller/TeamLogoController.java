package com.fc.match.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fc.common.annotation.Log;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.match.domain.TeamLogo;
import com.fc.match.service.ITeamLogoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 球队队徽接口。
 */
@RestController
@RequestMapping("/match/teamlogo")
@Api(tags = "球队队徽管理控制器")
public class TeamLogoController extends BaseController
{
    @Autowired
    private ITeamLogoService teamLogoService;

    /**
     * 首页和管理页共用该接口。返回 AjaxResult.data，与前端 listTeamLogo 保持一致。
     */
    @PreAuthorize("@ss.hasPermi('match:match:list') or @ss.hasPermi('match:teamlogo:list')")
    @GetMapping("/list")
    @ApiOperation("查询球队队徽列表")
    public AjaxResult list(TeamLogo teamLogo)
    {
        List<TeamLogo> list = teamLogoService.selectTeamLogoList(teamLogo);
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('match:teamlogo:query')")
    @GetMapping("/{id}")
    @ApiOperation("查询球队队徽详情")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(teamLogoService.selectTeamLogoById(id));
    }

    @PreAuthorize("@ss.hasPermi('match:teamlogo:add')")
    @Log(title = "球队队徽", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增球队队徽")
    public AjaxResult add(@RequestBody TeamLogo teamLogo)
    {
        return toAjax(teamLogoService.insertTeamLogo(teamLogo));
    }

    @PreAuthorize("@ss.hasPermi('match:teamlogo:edit')")
    @Log(title = "球队队徽", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改球队队徽")
    public AjaxResult edit(@RequestBody TeamLogo teamLogo)
    {
        return toAjax(teamLogoService.updateTeamLogo(teamLogo));
    }

    @PreAuthorize("@ss.hasPermi('match:teamlogo:remove')")
    @Log(title = "球队队徽", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    @ApiOperation("删除球队队徽")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(teamLogoService.deleteTeamLogoById(id));
    }
}
