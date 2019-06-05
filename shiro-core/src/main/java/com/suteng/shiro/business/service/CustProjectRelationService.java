package com.suteng.shiro.business.service;


import com.suteng.shiro.business.entity.CustProjectRelationEntity;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 客户与项目关联
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface CustProjectRelationService extends AbstractService<CustProjectRelationEntity, Long> {
    /**
     * 删除关联
     * @param personId
     */
    void deleteProjectRelationByPersonId(Long personId);
    /**
     *  根据项目ID删除
     * @param projectId
     */
    void deleteProjectRelationByProjectId(Long projectId);
    /**
     * 删除关联
     * @param personId
     * @param projectId
     */
    void deleteProjectRelationByProjectIdAndPersonId(Long personId, Long projectId);
}
