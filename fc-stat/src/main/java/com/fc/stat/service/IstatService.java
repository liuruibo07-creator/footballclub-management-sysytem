package com.fc.stat.service;

import java.util.List;
import java.util.Map;
import com.fc.stat.domain.stat;

/**
 * 赛季数据统计Service接口
 *
 * @author mumu
 * @date 2026-08-28
 */
public interface IstatService
{
    public stat selectstatById(Long id);

    public List<stat> selectstatList(stat stat);

    public int insertstat(stat stat);

    public int updatestat(stat stat);

    public int deletestatByIds(Long[] ids);

    public int deletestatById(Long id);

    /** 查询排行榜数据 */
    public List<stat> selectStatRanking(stat stat);

    /** 查询球队赛季汇总 */
    public List<stat> selectTeamSeasonStats(stat stat);

    /** 查询球员对比数据 */
    public List<stat> selectCompareStats(Long[] playerIds, String season, String competition);

    /** 查询球员下拉选项 */
    public List<Map<String, Object>> selectPlayerOptions();
}
