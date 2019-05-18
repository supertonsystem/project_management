package com.suteng.shiro.business.entity;

import java.util.Date;
import java.util.List;

import com.suteng.shiro.persistence.beans.SysDepartment;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:18 2019/4/26
 */
public class Department {
    private SysDepartment sysDepartment;

    public Department() {
        this.sysDepartment = new SysDepartment();
    }

    public Department(SysDepartment sysDepartment) {
        this.sysDepartment = sysDepartment;
    }

    public SysDepartment getSysDepartment() {
        return this.sysDepartment;
    }

    public Long getId() {
        return this.sysDepartment.getId();
    }

    public void setId(Long id) {
        this.sysDepartment.setId(id);
    }

    public String getName() {
        return this.sysDepartment.getName();
    }

    public void setName(String name) {
        this.sysDepartment.setName(name);
    }

    public Long getParentId() {
        return this.sysDepartment.getParentId();
    }

    public void setParentId(Long parentId) {
        this.sysDepartment.setParentId(parentId);
    }

    public Integer getSort() {
        return this.sysDepartment.getSort();
    }

    public void setSort(Integer sort) {
        this.sysDepartment.setSort(sort);
    }

    public Date getCreateTime() {
        return this.sysDepartment.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.sysDepartment.setCreateTime(regTime);
    }

    public Date getUpdateTime() {
        return this.sysDepartment.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.sysDepartment.setUpdateTime(updateTime);
    }

    public SysDepartment getParent() {
        return this.sysDepartment.getParent();
    }

    public void setParent(SysDepartment parent) {
        this.sysDepartment.setParent(parent);
    }

    public List<SysDepartment> getNodes() {
        return this.sysDepartment.getNodes();
    }

    public void setNodes(List<SysDepartment> nodes) {
        this.sysDepartment.setNodes(nodes);
    }

}
