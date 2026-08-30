package com.fc.match.controller;

import com.fc.common.annotation.Log;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.match.domain.TeamLogo;
import com.fc.match.service.ITeamLogoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 球队队徽Controller
 * 
 * @author lrb
 * @date 2026-08-30
 */
@RestController
@RequestMapping("/match/teamlogo")
@Api(tags = "球队队徽控制器")
public class TeamLogoController extends BaseController
{
    @Autowired
    private ITeamLogoService teamLogoService;

    /**
     * 查询球队队徽列表
     * 首页横幅与管理页共用；不加@PreAuthorize（沿用season-overview先例，
     * 防止角色缺少权限时首页403；接口已受登录鉴权保护，数据不敏感）
     */
    @GetMapping("/list")
    @ApiOperation("查询球队队徽列表")
    public AjaxResult list()
    {
        TeamLogo query = new TeamLogo();
        List<TeamLogo> list = teamLogoService.selectTeamLogoList(query);
        return success(list);
    }

    /**
     * 获取球队队徽详细信息
     */
    @PreAuthorize("@ss.hasPermi('match:teamlogo:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取球队队徽详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(teamLogoService.selectTeamLogoById(id));
    }

    /**
     * 新增球队队徽
     */
    @PreAuthorize("@ss.hasPermi('match:teamlogo:add')")
    @Log(title = "球队队徽", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增球队队徽")
    public AjaxResult add(@RequestBody TeamLogo teamLogo)
    {
        return toAjax(teamLogoService.insertTeamLogo(teamLogo));
    }

    /**
     * 修改球队队徽
     */
    @PreAuthorize("@ss.hasPermi('match:teamlogo:edit')")
    @Log(title = "球队队徽", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改球队队徽")
    public AjaxResult edit(@RequestBody TeamLogo teamLogo)
    {
        return toAjax(teamLogoService.updateTeamLogo(teamLogo));
    }

    /**
     * 删除球队队徽
     */
    @PreAuthorize("@ss.hasPermi('match:teamlogo:remove')")
    @Log(title = "球队队徽", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除球队队徽")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(teamLogoService.deleteTeamLogoByIds(ids));
    }
}
