package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.GiftConsumeConditionVo;
import com.suteng.shiro.persistence.beans.GiftConsume;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * 礼物类别
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface GiftConsumeMapper extends BaseMapper<GiftConsume> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<GiftConsume> findPageBreakByCondition(GiftConsumeConditionVo vo);
}
