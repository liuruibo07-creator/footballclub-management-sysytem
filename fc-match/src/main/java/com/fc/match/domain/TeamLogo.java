package com.fc.match.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.annotation.Excel;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 球队队徽对象 football_team_logo
 * 
 * @author lrb
 * @date 2026-08-30
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TeamLogo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 球队名称 */
    @Excel(name = "球队名称")
    private String teamName;

    /** 队徽图片OSS完整URL */
    @Excel(name = "队徽URL")
    private String logoUrl;

    /** 删除标志 */
    private String delFlag;
}
