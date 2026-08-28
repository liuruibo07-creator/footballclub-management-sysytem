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
     * 查询训练计划
     * 
     * @param id 训练计划主键
     * @return 训练计划
     */
    @Override
    public FootballTraining selectFootballTrainingById(Long id)
    {
        return footballTrainingMapper.selectFootballTrainingById(id);
    }

    /**
     * 查询训练计划列表
     * 
     * @param footballTraining 训练计划
     * @return 训练计划
     */
    @Override
    public List<FootballTraining> selectFootballTrainingList(FootballTraining footballTraining)
    {
        return footballTrainingMapper.selectFootballTrainingList(footballTraining);
    }

    /**
     * 新增训练计划
     * 
     * @param footballTraining 训练计划
     * @return 结果
     */
    @Transactional
    @Override
    public int insertFootballTraining(FootballTraining footballTraining)
    {
        footballTraining.setCreateTime(DateUtils.getNowDate());
        int rows = footballTrainingMapper.insertFootballTraining(footballTraining);
        insertFootballTrainingPlayer(footballTraining);
        return rows;
    }

    /**
     * 修改训练计划
     * 
     * @param footballTraining 训练计划
     * @return 结果
     */
    @Transactional
    @Override
    public int updateFootballTraining(FootballTraining footballTraining)
    {
        footballTraining.setUpdateTime(DateUtils.getNowDate());
        footballTrainingMapper.deleteFootballTrainingPlayerByTrainingId(footballTraining.getId());
        insertFootballTrainingPlayer(footballTraining);
        return footballTrainingMapper.updateFootballTraining(footballTraining);
    }

    /**
     * 批量删除训练计划
     * 
     * @param ids 需要删除的训练计划主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteFootballTrainingByIds(Long[] ids)
    {
        footballTrainingMapper.deleteFootballTrainingPlayerByTrainingIds(ids);
        return footballTrainingMapper.deleteFootballTrainingByIds(ids);
    }

    /**
     * 删除训练计划信息
     * 
     * @param id 训练计划主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteFootballTrainingById(Long id)
    {
        footballTrainingMapper.deleteFootballTrainingPlayerByTrainingId(id);
        return footballTrainingMapper.deleteFootballTrainingById(id);
    }

    /**
     * 新增训练参与及出勤信息
     * 
     * @param footballTraining 训练计划对象
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
                footballTrainingPlayer.setCreateTime(DateUtils.getNowDate());
                list.add(footballTrainingPlayer);
            }
            if (list.size() > 0)
            {
                footballTrainingMapper.batchFootballTrainingPlayer(list);
            }
        }
    }
}
