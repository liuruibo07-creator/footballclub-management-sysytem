package com.fc.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fc.system.domain.FootballTraining;
import com.fc.system.domain.FootballTrainingPlayer;

/**
 * 训练计划Mapper接口
 * <p>
 * 职责：
 * 1. 训练主表（football_training）的标准 CRUD
 * 2. 训练参与球员子表（football_training_player）的增删
 * 3. 跨模块同步：直接操作日程表（football_schedule_event）和日程参与人表（football_schedule_player），
 *    实现"训练变更 → 日程自动同步"的单向联动。
 * </p>
 *
 * @author 冷云鹏
 * @date 2026-08-28
 */
public interface FootballTrainingMapper
{
    /* ==================== 训练主表 CRUD ==================== */

    /**
     * 根据 ID 查询单条训练计划（含子表参与球员列表）
     * <p>SQL 通过 LEFT JOIN football_training_player + football_player 一并查出参与球员，
     * 映射到 footballTrainingPlayerList 集合。</p>
     *
     * @param id 训练计划主键
     * @return 训练计划（含参与球员）；无记录时返回 null
     */
    public FootballTraining selectFootballTrainingById(Long id);

    /**
     * 条件查询训练计划列表（分页由 PageHelper 在外层处理）
     * <p>同时通过子查询计算每条训练的 participantCount（总球员数）和 attendanceRate（出勤率）。
     * 出勤率 = (总人数 - 缺勤/请假人数) / 总人数 × 100%。</p>
     *
     * @param footballTraining 查询条件（title/trainingType/startTime/status）
     * @return 训练计划集合
     */
    public List<FootballTraining> selectFootballTrainingList(FootballTraining footballTraining);

    /**
     * 新增训练主表记录
     * <p>useGeneratedKeys=true，自增主键回填到参数对象的 id 属性。</p>
     *
     * @param footballTraining 训练计划
     * @return 影响行数（成功为 1）
     */
    public int insertFootballTraining(FootballTraining footballTraining);

    /**
     * 修改训练主表记录（动态 SET，仅更新非 null 字段）
     *
     * @param footballTraining 训练计划
     * @return 影响行数
     */
    public int updateFootballTraining(FootballTraining footballTraining);

    /** 删除单条训练记录（物理删除） */
    public int deleteFootballTrainingById(Long id);

    /** 批量删除训练记录 */
    public int deleteFootballTrainingByIds(@Param("array") Long[] ids);

    /* ==================== 训练参与球员子表（football_training_player） ==================== */

    /** 按训练 ID 批量删除子表记录（用于"先删后插"的更新策略） */
    public int deleteFootballTrainingPlayerByTrainingIds(@Param("array") Long[] ids);

    /**
     * 批量插入缺席球员记录
     * <p>注意：本系统只存储"缺席/请假"的球员（attendanceStatus=2 或 3），
     * 出勤球员由"全体球员 - 缺席球员"推导，不写入子表。</p>
     *
     * @param footballTrainingPlayerList 缺席球员列表
     * @return 影响行数
     */
    public int batchFootballTrainingPlayer(@Param("list") List<FootballTrainingPlayer> footballTrainingPlayerList);

    /** 删除单条训练的所有参与球员记录 */
    public int deleteFootballTrainingPlayerByTrainingId(Long id);

    /* ==================== 跨模块同步：日程表操作 ==================== */

    /**
     * 幂等写入日程：若该训练尚无关联日程则 INSERT，否则跳过
     * <p>使用 INSERT ... SELECT ... WHERE NOT EXISTS 模式保证幂等性。
     * 字段映射：training.title→title, event_type=1(训练), training.venue→location 等。</p>
     *
     * @param footballTraining 训练计划（需已持久化，id 非空）
     * @return 影响行数（0=已存在跳过，1=新增成功）
     */
    public int insertScheduleEventIfAbsent(FootballTraining footballTraining);

    /**
     * 将训练最新信息同步到已关联的日程记录
     * <p>无条件 UPDATE，覆盖 title/start_time/end_time/location/description/status 等字段，
     * 同时将 del_flag 重置为 '0'（防止之前被软删除的日程"复活"）。</p>
     * <p>典型调用顺序：先 insertScheduleEventIfAbsent 确保记录存在，再本方法刷新字段。</p>
     *
     * @param footballTraining 训练计划
     * @return 影响行数
     */
    public int updateScheduleEventByTrainingId(FootballTraining footballTraining);

    /**
     * 级联删除日程参与人（通过 training_id 间接关联）
     * <p>SQL 使用 INNER JOIN：先从 football_schedule_event 找到 training_id 对应的 event_id，
     * 再从 football_schedule_player 中删除这些 event 的参与人。</p>
     *
     * @param ids 训练 ID 数组
     * @return 影响行数
     */
    public int deleteSchedulePlayerByTrainingIds(@Param("array") Long[] ids);

    /**
     * 删除训练关联的日程记录
     * <p>按 training_id 数组批量删除 football_schedule_event 中的对应行。</p>
     *
     * @param ids 训练 ID 数组
     * @return 影响行数
     */
    public int deleteScheduleEventByTrainingIds(@Param("array") Long[] ids);
}
