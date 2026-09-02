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
 * <p>
 * 本控制器提供训练计划的 CRUD 接口，路径前缀为 /system/training。
 * 前端通过该控制器完成训练列表查询、新增、修改、删除和导出操作。
 * 注意：新增和修改操作会在 Service 层自动同步到球队日程表（football_schedule_event），
 * 删除操作会级联清理日程表中对应的日程事件和日程参与人。
 * </p>
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
     * 查询训练计划列表（分页）
     * <p>
     * 支持按标题（模糊）、训练类型、状态筛选。
     * 返回结果包含由 SQL 子查询实时计算的 participantCount（参与人数）和 attendanceRate（出勤率）。
     * 权限标识：system:training:list
     * </p>
     */
    @PreAuthorize("@ss.hasPermi('system:training:list')")
    @GetMapping("/list")
    @ApiOperation("查询训练计划列表")
    public TableDataInfo list(FootballTraining footballTraining)
    {
        startPage();  // 若依分页插件：从请求中读取 pageNum、pageSize，设置 PageHelper
        List<FootballTraining> list = footballTrainingService.selectFootballTrainingList(footballTraining);
        return getDataTable(list);  // 包装为 { total, rows } 格式返回前端
    }

    /**
     * 导出训练计划列表为 Excel 文件
     * <p>
     * 使用若依 ExcelUtil 工具类，根据 FootballTraining 实体上的 @Excel 注解生成列。
     * 权限标识：system:training:export
     * </p>
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
     * <p>
     * 返回训练主表数据 + 子表 footballTrainingPlayerList（缺席球员列表，
     * 通过 LEFT JOIN football_training_player 和 football_player 关联查出球员姓名和位置）。
     * 权限标识：system:training:query
     * </p>
     *
     * @param id 训练计划主键
     * @return 训练计划完整信息（含缺席球员子表）
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
     * <p>
     * 接收前端提交的训练数据（含缺席球员列表），Service 层会依次执行：
     * 1. 插入训练主表
     * 2. 批量插入缺席球员子表（attendanceStatus 强制设为 2=缺勤）
     * 3. 同步到日程表（INSERT ... WHERE NOT EXISTS + UPDATE）
     * 权限标识：system:training:add
     * </p>
     *
     * @param footballTraining 训练计划对象（JSON 请求体）
     * @return 影响行数
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
     * <p>
     * 接收前端提交的训练数据（含更新后的缺席球员列表），Service 层会依次执行：
     * 1. 更新训练主表
     * 2. 先删除旧子表 → 再批量插入新子表（若依"先删后插"模式）
     * 3. 从数据库重新查出完整数据，同步更新日程表
     * 权限标识：system:training:edit
     * </p>
     *
     * @param footballTraining 训练计划对象（JSON 请求体，必须包含 id）
     * @return 影响行数
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
     * 批量删除训练计划
     * <p>
     * 支持一次删除多条（前端传逗号分隔的 id 数组）。
     * Service 层会级联清理：日程参与人 → 日程事件 → 训练参与人 → 训练主表。
     * 权限标识：system:training:remove
     * </p>
     *
     * @param ids 训练计划主键数组
     * @return 影响行数
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
