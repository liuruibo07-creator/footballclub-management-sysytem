package com.fc.finance.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 财务收支对象 football_finance_record
 * 
 * @author lrb
 * @date 2026-08-26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FinanceRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 赛季 */
    private String season;

    /** 收支类型 */
    @Excel(name = "收支类型")
    private String recordType;

    /** 明细分类 */
    @Excel(name = "明细分类")
    private String category;

    /** 金额（元） */
    @Excel(name = "金额", readConverterExp = "元=")
    private BigDecimal amount;

    /** 业务发生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "业务发生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date recordDate;

    /** 业务描述/事由 */
    private String description;

    /** 删除标志：0-未删 1-已删 */
    private String delFlag;


}
