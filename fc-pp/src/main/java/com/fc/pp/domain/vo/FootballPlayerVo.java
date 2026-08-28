package com.fc.pp.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fc.common.annotation.Excel;
import com.fc.pp.domain.FootballPlayer;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 球员档案视图对象（含合同到期日）
 *
 * @author ruoyi
 * @date 2026-08-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class FootballPlayerVo extends FootballPlayer
{
    private static final long serialVersionUID = 1L;

    /** 合同到期日 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "合同到期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;
}
