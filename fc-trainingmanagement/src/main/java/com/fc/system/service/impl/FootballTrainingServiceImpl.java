package com.fc.system.service.impl;

import java.util.List;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.fc.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.fc.system.domain.FootballTrainingPlayer;
import com.fc.system.mapper.FootballTrainingMapper;
import com.fc.system.domain.FootballTraining;
import com.fc.system.service.IFootballTrainingService;

/**
 * 训练计划Service业务层处理
 * <p>
 * 本 Service 是训练管理模块的核心业务层，负责：
 * 1. 训练计划的 CRUD（增删改查）
 * 2. 训练缺席球员子表（football_training_player）的维护
 * 3. 与球队日程表（football_schedule_event）的单向同步
 * </p>
 * <p>
 * 同步机制说明：
 * - 新增训练时：先插训练主表 → 插缺席球员子表 → 调用 syncScheduleEvent() 同步到日程表
 * - 修改训练时：更新训练主表 → 先删后插子表 → 重新查出完整数据 → 调用 syncScheduleEvent() 同步
 * - 删除训练时：手动级联删除 日程参与人 → 日程事件 → 训练参与人 → 训练主表
 * - 同步采用幂等设计：INSERT ... WHERE NOT EXISTS + 无条件 UPDATE，保证不会重复插入
 * </p>
 * <p>
 * 注意：所有写操作都加了 @Transactional，保证事务一致性。
 * </p>
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
@Service
public class FootballTrainingServiceImpl implements IFootballTrainingService 
{
    @Autowired
    private FootballTrainingMapper footballTrainingMapper;

    /**
     * 根据主键查询训练计划详情
     * <p>
     * 返回训练主表 + 子表 footballTrainingPlayerList（缺席球员列表）。
     * 子表通过 LEFT JOIN football_training_player 和 football_player 关联查出球员姓名和位置。
     * </p>
     *
     * @param id 训练计划主键
     * @return 训练计划（含缺席球员子表）
     */
    @Override
    public FootballTraining selectFootballTrainingById(Long id)
    {
        return footballTrainingMapper.selectFootballTrainingById(id);
    }

    /**
     * 查询训练计划列表（分页）
     * <p>
     * 返回结果包含由 SQL 子查询实时计算的 participantCount 和 attendanceRate。
     * 出勤率计算逻辑：(总球员数 - 缺席球员数) / 总球员数。
     * 状态为 0（已计划）的训练显示出勤率 0%。
     * </p>
     *
     * @param footballTraining 查询条件（支持 title/trainingType/startTime/status 筛选）
     * @return 训练计划列表
     */
    @Override
    public List<FootballTraining> selectFootballTrainingList(FootballTraining footballTraining)
    {
        return footballTrainingMapper.selectFootballTrainingList(footballTraining);
    }

    /**
     * 新增训练计划
     * <p>
     * 执行流程：
     * 1. 设置 createBy（若前端未传则默认 “system”）和 createTime
     * 2. 插入训练主表（insertFootballTraining），自增主键回填到 footballTraining.id
     * 3. 批量插入缺席球员子表（insertFootballTrainingPlayer），attendanceStatus 强制设为 2（缺勤）
     * 4. 调用 syncScheduleEvent() 同步到日程表
     * </p>
     *
     * @param footballTraining 训练计划对象（含缺席球员列表）
     * @return 影响行数
     */
    @Transactional
    @Override
    public int insertFootballTraining(FootballTraining footballTraining)
    {
        if (StringUtils.isEmpty(footballTraining.getCreateBy()))
        {
            footballTraining.setCreateBy(“system”);
        }
        footballTraining.setCreateTime(DateUtils.getNowDate());
        int rows = footballTrainingMapper.insertFootballTraining(footballTraining);
        insertFootballTrainingPlayer(footballTraining);
        syncScheduleEvent(footballTraining);
        return rows;
    }

    /**
     * 修改训练计划
     * <p>
     * 执行流程：
     * 1. 设置 updateTime
     * 2. 更新训练主表
     * 3. 若更新成功（rows > 0）：
     *    a. 先删除旧的缺席球员子表（deleteFootballTrainingPlayerByTrainingId）
     *    b. 再批量插入新的缺席球员子表（insertFootballTrainingPlayer）
     *    c. 从数据库重新查出完整训练数据（确保同步时拿到最新值）
     *    d. 调用 syncScheduleEvent() 同步更新日程表
     * </p>
     *
     * @param footballTraining 训练计划对象（必须包含 id，含更新后的缺席球员列表）
     * @return 影响行数
     */
    @Transactional
    @Override
    public int updateFootballTraining(FootballTraining footballTraining)
    {
        footballTraining.setUpdateTime(DateUtils.getNowDate());
        int rows = footballTrainingMapper.updateFootballTraining(footballTraining);
        if (rows > 0)
        {
            footballTrainingMapper.deleteFootballTrainingPlayerByTrainingId(footballTraining.getId());
            insertFootballTrainingPlayer(footballTraining);
            syncScheduleEvent(footballTrainingMapper.selectFootballTrainingById(footballTraining.getId()));
        }
        return rows;
    }

    /**
     * 批量删除训练计划
     * <p>
     * 级联删除顺序（必须先删日程相关，再删训练相关）：
     * 1. 删除日程参与人（通过 JOIN 找到 training_id 对应的 event，再删其 player）
     * 2. 删除日程事件（football_schedule_event 中 training_id 对应的记录）
     * 3. 删除训练参与人（football_training_player 中 training_id 对应的记录）
     * 4. 删除训练主表（football_training 中的记录）
     * </p>
     *
     * @param ids 训练计划主键数组
     * @return 影响行数
     */
    @Transactional
    @Override
    public int deleteFootballTrainingByIds(Long[] ids)
    {
        footballTrainingMapper.deleteSchedulePlayerByTrainingIds(ids);
        footballTrainingMapper.deleteScheduleEventByTrainingIds(ids);
        footballTrainingMapper.deleteFootballTrainingPlayerByTrainingIds(ids);
        return footballTrainingMapper.deleteFootballTrainingByIds(ids);
    }

    /**
     * 删除单条训练计划
     * <p>
     * 将单个 id 包装为数组，复用批量删除的级联逻辑。
     * </p>
     *
     * @param id 训练计划主键
     * @return 影响行数
     */
    @Transactional
    @Override
    public int deleteFootballTrainingById(Long id)
    {
        Long[] ids = new Long[] { id };
        footballTrainingMapper.deleteSchedulePlayerByTrainingIds(ids);
        footballTrainingMapper.deleteScheduleEventByTrainingIds(ids);
        footballTrainingMapper.deleteFootballTrainingPlayerByTrainingId(id);
        return footballTrainingMapper.deleteFootballTrainingById(id);
    }

    /**
     * 批量插入缺席球员子表
     * <p>
     * 将前端提交的缺席球员列表写入 football_training_player 表。
     * 注意：无论前端传什么值，attendanceStatus 都会被强制设为 2（缺勤）。
     * 这是因为本表只存缺席球员，出勤球员由”全体 - 缺席”推导。
     * </p>
     *
     * @param footballTraining 训练计划对象（含缺席球员列表）
     */
    public void insertFootballTrainingPlayer(FootballTraining footballTraining)
    {
        List<FootballTrainingPlayer> footballTrainingPlayerList = footballTraining.getFootballTrainingPlayerList();
        Long id = footballTraining.getId();
        if (StringUtils.isNotNull(footballTrainingPlayerList))
        {
            List<FootballTrainingPlayer> list = new ArrayList<FootballTrainingPlayer>();
            for (FootballTrainingPlayer footballTrainingPlayer : footballTrainingPlayerList)
            {
                footballTrainingPlayer.setTrainingId(id);
                // 该关联表现在只保存缺席球员；出勤球员由”全体球员 - 缺席球员”推导。
                footballTrainingPlayer.setAttendanceStatus(2L);
                footballTrainingPlayer.setCreateTime(DateUtils.getNowDate());
                list.add(footballTrainingPlayer);
            }
            if (list.size() > 0)
            {
                footballTrainingMapper.batchFootballTrainingPlayer(list);
            }
        }
    }

    /**
     * 同步训练数据到球队日程表（幂等操作）
     * <p>
     * 本方法是训练模块与日程模块同步的核心，保证每条训练在日程表中
     * 有且只有一条对应的日程记录，并同步更新展示字段。
     * </p>
     * <p>
     * 执行流程：
     * 1. insertScheduleEventIfAbsent：如果日程表中还没有该 training_id 的记录，则插入一条
     *    （SQL: INSERT ... SELECT ... WHERE NOT EXISTS）
     * 2. updateScheduleEventByTrainingId：无条件 UPDATE，确保日程表中的字段值与训练表一致
     *    （SQL: UPDATE ... WHERE training_id = #{id}）
     * </p>
     * <p>
     * 字段映射关系：
     * - training.id → schedule_event.training_id
     * - training.title → schedule_event.title
     * - event_type 固定为 1（训练）
     * - training.startTime → schedule_event.start_time
     * - training.endTime → schedule_event.end_time
     * - training.venue → schedule_event.location
     * - training.description → schedule_event.description
     * - training.status → schedule_event.status
     * </p>
     *
     * @param footballTraining 训练计划对象（必须包含 id）
     */
    private void syncScheduleEvent(FootballTraining footballTraining)
    {
        if (footballTraining == null || footballTraining.getId() == null)
        {
            return;
        }
        footballTrainingMapper.insertScheduleEventIfAbsent(footballTraining);
        footballTrainingMapper.updateScheduleEventByTrainingId(footballTraining);
    }
}
