package com.fc.match.domain.vo;

import java.io.Serializable;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 首页近期比赛结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecentMatchResult implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long roundNo;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date matchDate;

    private String opponent;

    private Long teamScore;

    private Long opponentScore;

    /** W=胜，D=平，L=负 */
    private String result;
}
