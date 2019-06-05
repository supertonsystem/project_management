package com.suteng.shiro.business.service;


import java.util.List;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftConsumeDetailEntity;
import com.suteng.shiro.business.entity.GiftConsumeEntity;
import com.suteng.shiro.business.vo.GiftConsumeConditionVo;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 客户信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface GiftConsumeService extends AbstractService<GiftConsumeEntity, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<GiftConsumeEntity> findPageBreakByCondition(GiftConsumeConditionVo vo);

     String insertConsumeAndDetailList(GiftConsumeEntity entity, List<GiftConsumeDetailEntity> list);

     String updateConsumeAndDetailList(GiftConsumeEntity entity, List<GiftConsumeDetailEntity> list);

     void removeConsumeAndDetailList(Long primaryKey);
}
