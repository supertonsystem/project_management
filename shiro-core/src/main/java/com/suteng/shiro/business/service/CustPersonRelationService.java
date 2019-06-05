package com.suteng.shiro.business.service;


import com.suteng.shiro.business.entity.CustPersonRelationEntity;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 客户信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface CustPersonRelationService extends AbstractService<CustPersonRelationEntity, Long> {
    /**
     * 删除关联
     * @param sourceId
     */
    void deletePersonRelationBySourceId(Long sourceId);

    /**
     * 删除关联
     * @param sourceId
     */
    void deletePersonRelationByDestId(Long sourceId,Long destId);
}
