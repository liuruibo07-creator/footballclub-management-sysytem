package com.fc.injury.service.impl;

import java.util.List;
import com.fc.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.injury.mapper.InjuryMapper;
import com.fc.injury.domain.Injury;
import com.fc.injury.service.IInjuryService;

/**
 * 伤病康复Service业务层处理
 * 
 * @author xiaomu
 * @date 2026-08-26
 */
@Service
public class InjuryServiceImpl implements IInjuryService 
{
    @Autowired
    private InjuryMapper injuryMapper;

    /**
     * 查询伤病康复
     * 
     * @param id 伤病康复主键
     * @return 伤病康复
     */
    @Override
    public Injury selectInjuryById(Long id)
    {
        return injuryMapper.selectInjuryById(id);
    }

    /**
     * 查询伤病康复列表
     * 
     * @param injury 伤病康复
     * @return 伤病康复
     */
    @Override
    public List<Injury> selectInjuryList(Injury injury)
    {
        return injuryMapper.selectInjuryList(injury);
    }

    /**
     * 新增伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    @Override
    public int insertInjury(Injury injury)
    {
        injury.setCreateTime(DateUtils.getNowDate());
        return injuryMapper.insertInjury(injury);
    }

    /**
     * 修改伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    @Override
    public int updateInjury(Injury injury)
    {
        injury.setUpdateTime(DateUtils.getNowDate());
        return injuryMapper.updateInjury(injury);
    }

    /**
     * 批量删除伤病康复
     * 
     * @param ids 需要删除的伤病康复主键
     * @return 结果
     */
    @Override
    public int deleteInjuryByIds(Long[] ids)
    {
        return injuryMapper.deleteInjuryByIds(ids);
    }

    /**
     * 删除伤病康复信息
     * 
     * @param id 伤病康复主键
     * @return 结果
     */
    @Override
    public int deleteInjuryById(Long id)
    {
        return injuryMapper.deleteInjuryById(id);
    }
}
