package com.fc.injury.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.fc.common.utils.DateUtils;
import com.fc.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fc.injury.mapper.InjuryMapper;
import com.fc.injury.domain.Injury;
import com.fc.injury.service.IInjuryService;

/**
 * 伤病康复Service业务层处理
 * 
 * @author xiaomu
 * @date 2026-08-26
 */
@Service
public class InjuryServiceImpl implements IInjuryService 
{
    @Autowired
    private InjuryMapper injuryMapper;

    /**
     * 查询伤病康复
     * 
     * @param id 伤病康复主键
     * @return 伤病康复
     */
    @Override
    public Injury selectInjuryById(Long id)
    {
        return injuryMapper.selectInjuryById(id);
    }

    /**
     * 查询伤病康复列表
     * 
     * @param injury 伤病康复
     * @return 伤病康复
     */
    @Override
    public List<Injury> selectInjuryList(Injury injury)
    {
        // 权限过滤：球员角色只能看本人的伤病记录
        try {
            List<com.fc.common.core.domain.entity.SysRole> roles = SecurityUtils.getLoginUser().getUser().getRoles();
            boolean isPlayer = roles.stream().anyMatch(r -> "player".equals(r.getRoleKey()));
            if (isPlayer) {
                Long userId = SecurityUtils.getUserId();
                Long playerId = injuryMapper.selectPlayerIdByUserId(userId);
                injury.setPlayerId(playerId);
            }
        } catch (Exception e) {
            // 未登录或获取角色失败时不过滤
        }
        return injuryMapper.selectInjuryList(injury);
    }

    /**
     * 新增伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    @Override
    public int insertInjury(Injury injury)
    {
        injury.setCreateTime(DateUtils.getNowDate());
        return injuryMapper.insertInjury(injury);
    }

    /**
     * 修改伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    @Override
    public int updateInjury(Injury injury)
    {
        injury.setUpdateTime(DateUtils.getNowDate());
        return injuryMapper.updateInjury(injury);
    }

    /**
     * 批量删除伤病康复
     * 
     * @param ids 需要删除的伤病康复主键
     * @return 结果
     */
    @Override
    public int deleteInjuryByIds(Long[] ids)
    {
        return injuryMapper.deleteInjuryByIds(ids);
    }

    /**
     * 删除伤病康复信息
     * 
     * @param id 伤病康复主键
     * @return 结果
     */
    @Override
    public int deleteInjuryById(Long id)
    {
        return injuryMapper.deleteInjuryById(id);
    }

    /**
     * 查询球员下拉列表
     */
    @Override
    public List<Map<String, Object>> selectPlayerOptions()
    {
        return injuryMapper.selectPlayerOptions();
    }

    /**
     * 查询伤病统计数据（伤病管理页面用）
     */
    @Override
    public Map<String, Object> selectInjuryStats()
    {
        Map<String, Object> map = new HashMap<>();
        map.put("total", injuryMapper.countByStatus(null));
        map.put("treating", injuryMapper.countByStatus(1));
        map.put("recovering", injuryMapper.countByStatus(2));
        map.put("recoveredThisMonth", injuryMapper.countRecoveredThisMonth());
        return map;
    }

    /**
     * 查询仪表盘伤病预警数据
     */
    @Override
    public Map<String, Object> selectDashboardStats()
    {
        Map<String, Object> map = new HashMap<>();
        map.put("treating", injuryMapper.countByStatus(1));
        map.put("recovering", injuryMapper.countByStatus(2));
        return map;
    }
}
