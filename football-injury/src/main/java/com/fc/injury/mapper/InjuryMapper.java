package com.fc.injury.mapper;

import java.util.List;
import java.util.Map;
import com.fc.injury.domain.Injury;
import org.apache.ibatis.annotations.Param;

/**
 * 伤病康复Mapper接口
 * 
 * @author xiaomu
 * @date 2026-08-26
 */
public interface InjuryMapper 
{
    /**
     * 查询伤病康复
     * 
     * @param id 伤病康复主键
     * @return 伤病康复
     */
    public Injury selectInjuryById(Long id);

    /**
     * 查询伤病康复列表
     * 
     * @param injury 伤病康复
     * @return 伤病康复集合
     */
    public List<Injury> selectInjuryList(Injury injury);

    /**
     * 新增伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    public int insertInjury(Injury injury);

    /**
     * 修改伤病康复
     * 
     * @param injury 伤病康复
     * @return 结果
     */
    public int updateInjury(Injury injury);

    /**
     * 删除伤病康复
     * 
     * @param id 伤病康复主键
     * @return 结果
     */
    public int deleteInjuryById(Long id);

    /**
     * 批量删除伤病康复
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteInjuryByIds(Long[] ids);

    /**
     * 查询球员下拉列表（id, name_cn）
     */
    public List<Map<String, Object>> selectPlayerOptions();

    /**
     * 按康复状态统计人数
     * status为null时统计未康复（0,1,2），不为null时统计指定状态
     */
    public int countByStatus(@Param("status") Integer status);

    /**
     * 统计本月已康复人数
     */
    public int countRecoveredThisMonth();

    /**
     * 根据sys_user的user_id查对应的球员id
     */
    public Long selectPlayerIdByUserId(@Param("userId") Long userId);
}
