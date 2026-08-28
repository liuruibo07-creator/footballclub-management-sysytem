package com.fc.finance.service;

import java.util.List;
import com.fc.finance.domain.FinanceRecord;

/**
 * 财务收支Service接口
 * 
 * @author ruoyi
 * @date 2026-08-26
 */
public interface IFinanceRecordService 
{
    /**
     * 查询财务收支
     * 
     * @param id 财务收支主键
     * @return 财务收支
     */
    public FinanceRecord selectFinanceRecordById(Long id);

    /**
     * 查询财务收支列表
     * 
     * @param financeRecord 财务收支
     * @return 财务收支集合
     */
    public List<FinanceRecord> selectFinanceRecordList(FinanceRecord financeRecord);

    /**
     * 新增财务收支
     * 
     * @param financeRecord 财务收支
     * @return 结果
     */
    public int insertFinanceRecord(FinanceRecord financeRecord);

    /**
     * 修改财务收支
     * 
     * @param financeRecord 财务收支
     * @return 结果
     */
    public int updateFinanceRecord(FinanceRecord financeRecord);

    /**
     * 批量删除财务收支
     * 
     * @param ids 需要删除的财务收支主键集合
     * @return 结果
     */
    public int deleteFinanceRecordByIds(Long[] ids);

    /**
     * 删除财务收支信息
     * 
     * @param id 财务收支主键
     * @return 结果
     */
    public int deleteFinanceRecordById(Long id);
}
