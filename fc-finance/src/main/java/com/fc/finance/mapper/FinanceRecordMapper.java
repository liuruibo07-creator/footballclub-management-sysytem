package com.fc.finance.mapper;

import java.util.List;
import com.fc.finance.domain.FinanceRecord;
import com.fc.finance.domain.vo.FinanceSummary;

/**
 * 财务收支Mapper接口
 * 
 * @author ruoyi
 * @date 2026-08-26
 */
public interface FinanceRecordMapper 
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
     * 查询全部有效财务记录的汇总数据
     *
     * @return 财务汇总
     */
    public FinanceSummary selectFinanceSummary();

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
     * 删除财务收支
     * 
     * @param id 财务收支主键
     * @return 结果
     */
    public int deleteFinanceRecordById(Long id);

    /**
     * 批量删除财务收支
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFinanceRecordByIds(Long[] ids);
}
