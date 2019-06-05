package com.suteng.shiro.business.service;


import java.util.List;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftRepertoryEntity;
import com.suteng.shiro.business.vo.GiftRepertoryConditionVo;
import com.suteng.shiro.framework.object.AbstractService;
import com.suteng.shiro.persistence.beans.GiftRepertory;

/**
 * 客户信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface GiftRepertoryService extends AbstractService<GiftRepertoryEntity, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<GiftRepertoryEntity> findPageBreakByCondition(GiftRepertoryConditionVo vo);

    /**
     * 库存大于0的
     * @return
     */
    List<GiftRepertoryEntity> availableRepertoryList();

    /**
     * 悲观锁
     * @param id
     * @return
     */
    GiftRepertory findGiftRepertoryByLock(Long id);

}
