package com.fc.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fc.system.domain.FootballTraining;
import com.fc.system.domain.FootballTrainingPlayer;

/**
 * 训练计划Mapper接口
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
public interface FootballTrainingMapper 
{
    /**
     * 查询训练计划
     * 
     * @param id 训练计划主键
     * @return 训练计划
     */
    public FootballTraining selectFootballTrainingById(Long id);

    /**
     * 查询训练计划列表
     * 
     * @param footballTraining 训练计划
     * @return 训练计划集合
     */
    public List<FootballTraining> selectFootballTrainingList(FootballTraining footballTraining);

    /**
     * 新增训练计划
     * 
     * @param footballTraining 训练计划
     * @return 结果
     */
    public int insertFootballTraining(FootballTraining footballTraining);

    /**
     * 修改训练计划
     * 
     * @param footballTraining 训练计划
     * @return 结果
     */
    public int updateFootballTraining(FootballTraining footballTraining);

    /**
     * 删除训练计划
     * 
     * @param id 训练计划主键
     * @return 结果
     */
    public int deleteFootballTrainingById(Long id);

    /**
     * 批量删除训练计划
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFootballTrainingByIds(@Param("array") Long[] ids);

    /**
     * 批量删除训练参与及出勤
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFootballTrainingPlayerByTrainingIds(@Param("array") Long[] ids);
    
    /**
     * 批量新增训练参与及出勤
     * 
     * @param footballTrainingPlayerList 训练参与及出勤列表
     * @return 结果
     */
    public int batchFootballTrainingPlayer(@Param("list") List<FootballTrainingPlayer> footballTrainingPlayerList);
    

    /**
     * 通过训练计划主键删除训练参与及出勤信息
     * 
     * @param id 训练计划ID
     * @return 结果
     */
    public int deleteFootballTrainingPlayerByTrainingId(Long id);

    /** 新增训练对应的日程（已存在时跳过） */
    public int insertScheduleEventIfAbsent(FootballTraining footballTraining);

    /** 将训练信息同步到关联日程 */
    public int updateScheduleEventByTrainingId(FootballTraining footballTraining);

    /** 删除训练关联日程的参与人数据 */
    public int deleteSchedulePlayerByTrainingIds(@Param("array") Long[] ids);

    /** 删除训练关联日程 */
    public int deleteScheduleEventByTrainingIds(@Param("array") Long[] ids);
}
