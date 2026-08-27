package com.fc.injury.service;

import java.util.List;
import com.fc.injury.domain.Injury;

/**
 * 伤病康复Service接口
 * 
 * @author xiaomu
 * @date 2026-08-26
 */
public interface IInjuryService 
{
    /**
     * 查询伤病康复
     * 
     * @param id 伤病康复主键
     * @return 伤病康复
     */
    public Injury selectInjuryById(Long id);

    /**
     * 查询伤病康复列表
     * 
     * @param injury 伤病康复
     * @return 伤病康复集合
     */
    public List<Injury> selectInjuryList(Injury injury);

    /**
     * 新增伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    public int insertInjury(Injury injury);

    /**
     * 修改伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    public int updateInjury(Injury injury);

    /**
     * 批量删除伤病康复
     * 
     * @param ids 需要删除的伤病康复主键集合
     * @return 结果
     */
    public int deleteInjuryByIds(Long[] ids);

    /**
     * 删除伤病康复信息
     * 
     * @param id 伤病康复主键
     * @return 结果
     */
    public int deleteInjuryById(Long id);
}
