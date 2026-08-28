package com.fc.finance.controller;

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
import com.fc.finance.domain.FinanceRecord;
import com.fc.finance.service.IFinanceRecordService;
import com.fc.common.utils.poi.ExcelUtil;
import com.fc.common.core.page.TableDataInfo;

/**
 * 财务收支Controller
 * 
 * @author ruoyi
 * @date 2026-08-26
 */
@RestController
@RequestMapping("/finance/finance")
@Api(tags = "财务收支控制器")
public class FinanceRecordController extends BaseController
{
    @Autowired
    private IFinanceRecordService financeRecordService;

    /**
     * 查询财务收支列表
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:list')")
    @GetMapping("/list")
    @ApiOperation("查询财务收支列表")
    public TableDataInfo list(FinanceRecord financeRecord)
    {
        startPage();
        List<FinanceRecord> list = financeRecordService.selectFinanceRecordList(financeRecord);
        return getDataTable(list);
    }

    /**
     * 查询全部有效财务记录的汇总数据
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:list')")
    @GetMapping("/summary")
    @ApiOperation("查询财务收支汇总")
    public AjaxResult summary()
    {
        return success(financeRecordService.selectFinanceSummary());
    }

    /**
     * 导出财务收支列表
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:export')")
    @Log(title = "财务收支", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出财务收支列表")
    public void export(HttpServletResponse response, FinanceRecord financeRecord)
    {
        List<FinanceRecord> list = financeRecordService.selectFinanceRecordList(financeRecord);
        ExcelUtil<FinanceRecord> util = new ExcelUtil<FinanceRecord>(FinanceRecord.class);
        util.exportExcel(response, list, "财务收支数据");
    }

    /**
     * 获取财务收支详细信息
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取财务收支详细信息")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(financeRecordService.selectFinanceRecordById(id));
    }

    /**
     * 新增财务收支
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:add')")
    @Log(title = "财务收支", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增财务收支")
    public AjaxResult add(@RequestBody FinanceRecord financeRecord)
    {
        return toAjax(financeRecordService.insertFinanceRecord(financeRecord));
    }

    /**
     * 修改财务收支
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:edit')")
    @Log(title = "财务收支", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改财务收支")
    public AjaxResult edit(@RequestBody FinanceRecord financeRecord)
    {
        return toAjax(financeRecordService.updateFinanceRecord(financeRecord));
    }

    /**
     * 删除财务收支
     */
    @PreAuthorize("@ss.hasPermi('finance:finance:remove')")
    @Log(title = "财务收支", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    @ApiOperation("删除财务收支")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(financeRecordService.deleteFinanceRecordByIds(ids));
    }
}
