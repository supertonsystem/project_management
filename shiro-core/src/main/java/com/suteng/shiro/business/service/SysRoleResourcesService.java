package com.suteng.shiro.business.service;


import com.suteng.shiro.business.entity.RoleResources;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 角色资源
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface SysRoleResourcesService extends AbstractService<RoleResources, Long> {

    /**
     * 添加角色资源
     *
     * @param roleId
     * @param resourcesIds
     */
    void addRoleResources(Long roleId, String resourcesIds);

    /**
     * 通过角色id批量删除
     *
     * @param roleId
     */
    void removeByRoleId(Long roleId);
}
