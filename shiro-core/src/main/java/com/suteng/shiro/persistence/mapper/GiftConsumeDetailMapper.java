package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.GiftConsumeDetailConditionVo;
import com.suteng.shiro.persistence.beans.GiftConsumeDetail;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * 礼物类别
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface GiftConsumeDetailMapper extends BaseMapper<GiftConsumeDetail> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<GiftConsumeDetail> findPageBreakByCondition(GiftConsumeDetailConditionVo vo);

    /**
     * 根据主表id删除
     * @param consumeId
     */
    void removeByConsumeId(Long consumeId);

    /**
     * 可认领或可修改使用状态的记录数
     */
    Long findOperabilityCountByConsumeId(Long consumeId);
}
