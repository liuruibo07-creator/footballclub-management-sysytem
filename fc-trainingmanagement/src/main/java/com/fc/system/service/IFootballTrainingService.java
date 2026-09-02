package com.fc.system.service;

import java.util.List;
import com.fc.system.domain.FootballTraining;

/**
 * 训练计划Service接口
 * <p>
 * 定义训练管理模块的全部业务操作，实现类 {@link com.fc.system.service.impl.FootballTrainingServiceImpl}
 * 负责三项核心工作：
 * 1. 训练主表的 CRUD
 * 2. 训练参与球员子表（缺席记录）的维护
 * 3. 训练 → 日程的单向自动同步（新增/修改/删除训练时自动同步到日程表）
 * </p>
 * <p>所有写操作均标注 @Transactional，保证主表、子表、日程表在同一事务内完成。</p>
 *
 * @author 冷云鹏
 * @date 2026-08-28
 */
public interface IFootballTrainingService
{
    /**
     * 查询单条训练计划详情（含参与球员子表）
     *
     * @param id 训练计划主键
     * @return 训练计划对象；footballTrainingPlayerList 中仅包含缺席/请假球员
     */
    public FootballTraining selectFootballTrainingById(Long id);

    /**
     * 条件查询训练列表（分页由 Controller 层 PageHelper 处理）
     * <p>返回列表中每条记录附带 participantCount 和 attendanceRate 计算字段。</p>
     *
     * @param footballTraining 查询条件封装对象
     * @return 训练计划列表
     */
    public List<FootballTraining> selectFootballTrainingList(FootballTraining footballTraining);

    /**
     * 新增训练计划
     * <p>执行流程：插入主表 → 批量插入缺席球员子表 → 同步到日程表。
     * 调用前需确保 footballTrainingPlayerList 已正确设置（仅缺席球员）。</p>
     *
     * @param footballTraining 训练计划
     * @return 影响行数
     */
    public int insertFootballTraining(FootballTraining footballTraining);

    /**
     * 修改训练计划
     * <p>执行流程：更新主表 → 先删后插子表 → 同步日程。
     * 子表采用"先删后插"策略：先删除该训练的所有缺席记录，再重新批量插入。</p>
     *
     * @param footballTraining 训练计划（id 必填）
     * @return 影响行数
     */
    public int updateFootballTraining(FootballTraining footballTraining);

    /**
     * 批量删除训练计划
     * <p>级联删除顺序：日程参与人 → 日程记录 → 训练参与球员 → 训练主表，
     * 全部在同一事务内完成。</p>
     *
     * @param ids 训练计划主键数组
     * @return 影响行数
     */
    public int deleteFootballTrainingByIds(Long[] ids);

    /**
     * 删除单条训练计划（内部委托给批量删除方法）
     *
     * @param id 训练计划主键
     * @return 影响行数
     */
    public int deleteFootballTrainingById(Long id);
}
