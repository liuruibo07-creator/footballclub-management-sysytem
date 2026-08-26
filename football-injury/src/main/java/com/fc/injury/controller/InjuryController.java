package com.fc.injury.controller;

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
import com.fc.injury.domain.Injury;
import com.fc.injury.service.IInjuryService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 伤病康复Controller
 * 
 * @author xiaomu
 * @date 2026-08-26
 */
@RestController
@RequestMapping("/injury/injury")
@Api(tags = "伤病康复控制器")
public class InjuryController extends BaseController
{
    @Autowired
    private IInjuryService injuryService;

    /**
     * 查询伤病康复列表
     */
    @PreAuthorize("@ss.hasPermi('injury:injury:list')")
    @GetMapping("/list")
    @ApiOperation("查询伤病康复列表")
    public TableDataInfo list(Injury injury)
    {
        startPage();
        List<Injury> list = injuryService.selectInjuryList(injury);
        return getDataTable(list);
    }

    /**
     * 导出伤病康复列表
     */
    @PreAuthorize("@ss.hasPermi('injury:injury:export')")
    @Log(title = "伤病康复", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出伤病康复列表")
    public void export(HttpServletResponse response, Injury injury)
    {
        List<Injury> list = injuryService.selectInjuryList(injury);
        ExcelUtil<Injury> util = new ExcelUtil<Injury>(Injury.class);
        util.exportExcel(response, list, "伤病康复数据");
    }

    /**
     * 获取伤病康复详细信息
     */
    @PreAuthorize("@ss.hasPermi('injury:injury:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取伤病康复详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(injuryService.selectInjuryById(id));
    }

    /**
     * 新增伤病康复
     */
    @PreAuthorize("@ss.hasPermi('injury:injury:add')")
    @Log(title = "伤病康复", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增伤病康复")
    public AjaxResult add(@RequestBody Injury injury)
    {
        return toAjax(injuryService.insertInjury(injury));
    }

    /**
     * 修改伤病康复
     */
    @PreAuthorize("@ss.hasPermi('injury:injury:edit')")
    @Log(title = "伤病康复", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改伤病康复")
    public AjaxResult edit(@RequestBody Injury injury)
    {
        return toAjax(injuryService.updateInjury(injury));
    }

    /**
     * 删除伤病康复
     */
    @PreAuthorize("@ss.hasPermi('injury:injury:remove')")
    @Log(title = "伤病康复", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除伤病康复")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(injuryService.deleteInjuryByIds(ids));
    }
}
