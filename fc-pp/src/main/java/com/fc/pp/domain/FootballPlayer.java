package com.fc.pp.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java .util.Date;

/**
 * 球员档案对象 football_player
 * 
 * @author lrb
 * @date 2026-08-26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor

public class FootballPlayer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 球员球衣号码 */
    @Excel(name = "球员球衣号码")
    private Long jerseyNumber;

    /** 姓名 */
    @Excel(name = "姓名")
    private String nameCn;

    /** 位置 */
    @Excel(name = "位置")
    private String position;

    /** 国籍 */
    @Excel(name = "国籍")
    private String nationality;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthDate;

    /** 身高（米） */
    @Excel(name = "身高", readConverterExp = "米=")
    private BigDecimal height;

    /** 惯用脚：左脚/右脚/双脚 */
    @Excel(name = "惯用脚：左脚/右脚/双脚")
    private String preferredFoot;

    /** 球员状态：活跃/非活跃 */
    @Excel(name = "球员状态：活跃/非活跃")
    private String status;

    /** 2026赛季报名变化说明 */
    private String registrationNote;

    /** 若依 sys_user.user_id，跨库部署时不设外键 */
    private Long userId;

    /** 数据来源 URL */
    private String sourceUrl;

    /** 数据来源截止日期 */
    private Date sourceAsOf;

    /** 删除标志：0正常 2删除 */
    private String delFlag;


}
