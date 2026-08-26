package com.fc.injury.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 伤病康复对象 football_injury
 * 
 * @author xiaomu
 * @date 2026-08-26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Injury extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    private Long id;

    /** 球员 */
    @Excel(name = "球员")
    private Long playerId;

    /** 球员姓名（关联查询用，非数据库字段） */
    private String playerName;

    /** 伤病类型 */
    @Excel(name = "伤病类型")
    private String injuryType;

    /** 受伤位置 */
    @Excel(name = "受伤位置")
    private String injuryLocation;

    /** 受伤日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "受伤日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date injuryDate;

    /** 预期复出日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预期复出日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date expectedReturnDate;

    /** 实际返回日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际返回日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date actualReturnDate;

    /** 康复状态 */
    @Excel(name = "康复状态")
    private Integer recoveryStatus;

    /** 康复计划 */
    private String rehabPlan;

    /** 删除 */
    private String delFlag;


}
