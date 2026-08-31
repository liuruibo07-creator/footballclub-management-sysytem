package com.fc.finance.service.impl;

import com.fc.common.utils.DateUtils;
import com.fc.finance.domain.FinanceRecord;
import com.fc.finance.domain.vo.FinanceSummary;
import com.fc.finance.mapper.FinanceRecordMapper;
import com.fc.finance.service.IFinanceRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 财务收支Service业务层处理
 * 
 * @author lrb
 * @date 2026-08-26
 */
@Service
public class FinanceRecordServiceImpl implements IFinanceRecordService 
{
    @Autowired
    private FinanceRecordMapper financeRecordMapper;

    /**
     * 查询财务收支
     * 
     * @param id 财务收支主键
     * @return 财务收支
     */
    @Override
    public FinanceRecord selectFinanceRecordById(Long id)
    {
        return financeRecordMapper.selectFinanceRecordById(id);
    }

    /**
     * 查询财务收支列表
     * 
     * @param financeRecord 财务收支
     * @return 财务收支
     */
    @Override
    public List<FinanceRecord> selectFinanceRecordList(FinanceRecord financeRecord)
    {
        return financeRecordMapper.selectFinanceRecordList(financeRecord);
    }

    /**
     * 查询全部有效财务记录的汇总数据
     *
     * @return 财务汇总
     */
    @Override
    public FinanceSummary selectFinanceSummary()
    {
        return financeRecordMapper.selectFinanceSummary();
    }

    /**
     * 新增财务收支
     * 
     * @param financeRecord 财务收支
     * @return 结果
     */
    @Override
    public int insertFinanceRecord(FinanceRecord financeRecord)
    {
        financeRecord.setCreateTime(DateUtils.getNowDate());
        return financeRecordMapper.insertFinanceRecord(financeRecord);
    }

    /**
     * 修改财务收支
     * 
     * @param financeRecord 财务收支
     * @return 结果
     */
    @Override
    public int updateFinanceRecord(FinanceRecord financeRecord)
    {
        financeRecord.setUpdateTime(DateUtils.getNowDate());
        return financeRecordMapper.updateFinanceRecord(financeRecord);
    }

    /**
     * 批量删除财务收支
     * 
     * @param ids 需要删除的财务收支主键
     * @return 结果
     */
    @Override
    public int deleteFinanceRecordByIds(Long[] ids)
    {
        return financeRecordMapper.deleteFinanceRecordByIds(ids);
    }

    /**
     * 删除财务收支信息
     * 
     * @param id 财务收支主键
     * @return 结果
     */
    @Override
    public int deleteFinanceRecordById(Long id)
    {
        return financeRecordMapper.deleteFinanceRecordById(id);
    }
}
