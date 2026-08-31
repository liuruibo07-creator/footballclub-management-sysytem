package com.fc.match.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fc.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 联赛球队对象 football_league_team
 * 
 * @author lrb
 * @date 2026-08-31
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LeagueTeam extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 球队名称 */
    private String teamName;

    /** 球队logo(OSS完整URL) */
    private String logoUrl;

    /** 所属联赛/赛事 */
    private String leagueName;

    /** 所属俱乐部分部(一线队/U21/U19/U17/青训梯队) */
    private String division;

    /** 球队状态(0=停用 1=启用) */
    private String status;

    /** 解散标记(0=正常 1=已解散) */
    private String dissolveFlag;

    /** 领队电话 */
    private String managerPhone;

    /** 对接管理员 */
    private String liaisonAdmin;

    /** 删除标志 */
    private String delFlag;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("teamName", getTeamName())
            .append("logoUrl", getLogoUrl())
            .append("leagueName", getLeagueName())
            .append("division", getDivision())
            .append("status", getStatus())
            .append("dissolveFlag", getDissolveFlag())
            .append("managerPhone", getManagerPhone())
            .append("liaisonAdmin", getLiaisonAdmin())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .append("delFlag", getDelFlag())
            .toString();
    }
}
