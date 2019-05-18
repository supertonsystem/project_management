package com.suteng.shiro.business.service;


import com.suteng.shiro.business.entity.UserRole;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 用户角色
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface SysUserRoleService extends AbstractService<UserRole, Long> {

    /**
     * 添加用户角色
     *
     * @param userId
     * @param roleIds
     */
    void addUserRole(Long userId, String roleIds);

    /**
     * 根据用户ID删除用户角色
     *
     * @param userId
     */
    void removeByUserId(Long userId);
}
