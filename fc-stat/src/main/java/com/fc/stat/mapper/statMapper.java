package com.fc.stat.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.fc.stat.domain.stat;

/**
 * 赛季数据统计Mapper接口
 *
 * @author mumu
 * @date 2026-08-28
 */
public interface statMapper
{
    public stat selectstatById(Long id);

    public List<stat> selectstatList(stat stat);

    public int insertstat(stat stat);

    public int updatestat(stat stat);

    public int deletestatById(Long id);

    public int deletestatByIds(Long[] ids);

    /** 查询排行榜数据 */
    public List<stat> selectStatRanking(stat stat);

    /** 查询球队赛季汇总 */
    public List<stat> selectTeamSeasonStats(stat stat);

    /** 查询球队已完赛场次 */
    public List<Map<String, Object>> selectTeamMatchCount(stat stat);

    /** 查询球员对比数据 */
    public List<stat> selectCompareStats(@Param("playerIds") Long[] playerIds, @Param("season") String season, @Param("competition") String competition);

    /** 查询球员下拉选项 */
    public List<Map<String, Object>> selectPlayerOptions();
}
