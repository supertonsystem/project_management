package com.suteng.shiro.business.entity;

import com.suteng.shiro.persistence.beans.SysRoleResources;

import java.util.Date;

/**
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public class RoleResources {

    private SysRoleResources sysRoleResources;

    public RoleResources() {
        this.sysRoleResources = new SysRoleResources();
    }

    public RoleResources(SysRoleResources sysRoleResources) {
        this.sysRoleResources = sysRoleResources;
    }

    public SysRoleResources getSysRoleResources() {
        return this.sysRoleResources;
    }

    public Long getRoleId() {
        return this.sysRoleResources.getRoleId();
    }

    public void setRoleId(Long roleId) {
        this.sysRoleResources.setRoleId(roleId);
    }

    public Long getResourcesId() {
        return this.sysRoleResources.getResourcesId();
    }

    public void setResourcesId(Long resourcesId) {
        this.sysRoleResources.setResourcesId(resourcesId);
    }

    public Date getCreateTime() {
        return this.sysRoleResources.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.sysRoleResources.setCreateTime(regTime);
    }

    public Date getUpdateTime() {
        return this.sysRoleResources.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.sysRoleResources.setUpdateTime(updateTime);
    }

}
