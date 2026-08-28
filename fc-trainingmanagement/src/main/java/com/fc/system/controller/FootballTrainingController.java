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
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.fc.common.core.controller.BaseController;
import com.fc.common.core.domain.AjaxResult;
import com.fc.common.enums.BusinessType;
import com.fc.system.domain.FootballTraining;
import com.fc.system.service.IFootballTrainingService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 训练计划Controller
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
@RestController
@RequestMapping("/system/training")
@Api(tags = "训练计划控制器")
public class FootballTrainingController extends BaseController
{
    @Autowired
    private IFootballTrainingService footballTrainingService;

    /**
     * 查询训练计划列表
     */
    @PreAuthorize("@ss.hasPermi('system:training:list')")
    @GetMapping("/list")
    @ApiOperation("查询训练计划列表")
    public TableDataInfo list(FootballTraining footballTraining)
    {
        startPage();
        List<FootballTraining> list = footballTrainingService.selectFootballTrainingList(footballTraining);
        return getDataTable(list);
    }

    /**
     * 导出训练计划列表
     */
    @PreAuthorize("@ss.hasPermi('system:training:export')")
    @Log(title = "训练计划", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出训练计划列表")
    public void export(HttpServletResponse response, FootballTraining footballTraining)
    {
        List<FootballTraining> list = footballTrainingService.selectFootballTrainingList(footballTraining);
        ExcelUtil<FootballTraining> util = new ExcelUtil<FootballTraining>(FootballTraining.class);
        util.exportExcel(response, list, "训练计划数据");
    }

    /**
     * 获取训练计划详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:training:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取训练计划详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(footballTrainingService.selectFootballTrainingById(id));
    }

    /**
     * 新增训练计划
     */
    @PreAuthorize("@ss.hasPermi('system:training:add')")
    @Log(title = "训练计划", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增训练计划")
    public AjaxResult add(@RequestBody FootballTraining footballTraining)
    {
        return toAjax(footballTrainingService.insertFootballTraining(footballTraining));
    }

    /**
     * 修改训练计划
     */
    @PreAuthorize("@ss.hasPermi('system:training:edit')")
    @Log(title = "训练计划", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改训练计划")
    public AjaxResult edit(@RequestBody FootballTraining footballTraining)
    {
        return toAjax(footballTrainingService.updateFootballTraining(footballTraining));
    }

    /**
     * 删除训练计划
     */
    @PreAuthorize("@ss.hasPermi('system:training:remove')")
    @Log(title = "训练计划", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除训练计划")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(footballTrainingService.deleteFootballTrainingByIds(ids));
    }
}
