package com.fc.finance.domain.vo;

import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 财务收支汇总数据。
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FinanceSummary
{
    /** 总收入（元） */
    private BigDecimal totalIncome;

    /** 总支出（元） */
    private BigDecimal totalExpense;

    /** 净收支（总收入 - 总支出，元） */
    private BigDecimal netBalance;
}
