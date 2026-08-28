package com.fc.system.service;

import java.util.List;
import com.fc.system.domain.FootballTraining;

/**
 * 训练计划Service接口
 * 
 * @author 冷云鹏
 * @date 2026-08-28
 */
public interface IFootballTrainingService 
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
     * 批量删除训练计划
     * 
     * @param ids 需要删除的训练计划主键集合
     * @return 结果
     */
    public int deleteFootballTrainingByIds(Long[] ids);

    /**
     * 删除训练计划信息
     * 
     * @param id 训练计划主键
     * @return 结果
     */
    public int deleteFootballTrainingById(Long id);
}
