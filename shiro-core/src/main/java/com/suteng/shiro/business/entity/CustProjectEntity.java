package com.suteng.shiro.business.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.util.DepartmentUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.CustProject;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustProjectEntity {
    private CustProject custProject;

    public CustProjectEntity() {
        this.custProject = new CustProject();
    }

    public Long getId() {
        return this.custProject.getId();
    }

    public void setId(Long id) {
        this.custProject.setId(id);
    }

    public CustProjectEntity(CustProject custProject) {
        this.custProject = custProject;
    }

    public CustProject getCustProject() {
        return custProject;
    }

    public void setCustProject(CustProject custProject) {
        this.custProject = custProject;
    }

    public Long getRegister() {
        return custProject.getRegister();
    }

    public void setRegister(Long register) {
        this.custProject.setRegister(register);
    }
    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.custProject.getRegister());
    }
    public String getName() {
        return custProject.getName();
    }

    public void setName(String name) {
        this.custProject.setName(name);
    }

    public String getNumber() {
        return custProject.getNumber();
    }

    public void setNumber(String number) {
        this.custProject.setNumber(number);
    }

    public String getCompanyName() {
        return custProject.getCompanyName();
    }

    public void setCompanyName(String companyName) {
        this.custProject.setCompanyName(companyName);
    }

    public String getArea() {
        return custProject.getArea();
    }

    public void setArea(String area) {
        this.custProject.setArea(area);
    }

    public String getProvince() {
        return custProject.getProvince();
    }

    public void setProvince(String province) {
        this.custProject.setProvince(province);
    }

    public String getAddress() {
        return custProject.getAddress();
    }

    public void setAddress(String address) {
        this.custProject.setAddress(address);
    }
    @JSONField(format = "yyyy-MM-dd")
    public Date getStartTime() {
        return custProject.getStartTime();
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setStartTime(Date startTime) {
        this.custProject.setStartTime(startTime);
    }
    @JSONField(format = "yyyy-MM-dd")
    public Date getEndTime() {
        return custProject.getStartTime();
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setEndTime(Date endTime) {
        this.custProject.setEndTime(endTime);
    }

    public String getPeriod() {
        return custProject.getPeriod();
    }

    public void setPeriod(String period) {
        this.custProject.setPeriod(period);
    }

    public String getOwner() {
        return custProject.getOwner();
    }

    public void setOwner(String owner) {
        this.custProject.setOwner(owner);
    }

    public String getOwnerDepartment() {
        return custProject.getOwnerDepartment();
    }

    public void setOwnerDepartment(String ownerDepartment) {
        this.custProject.setOwnerDepartment(ownerDepartment);
    }

    public Long getDepartment() {
        return custProject.getDepartment();
    }
    public String getDepartmentName(){
        return DepartmentUtil.getDepartmentName(this.custProject.getDepartment());
    }
    public void setDepartment(Long department) {
        this.custProject.setDepartment(department);
    }

    public Long getPm() {
        return custProject.getPm();
    }

    public void setPm(Long pm) {
        this.custProject.setPm(pm);
    }
    public String getPmName(){
        return UserUtil.getUserNickName(this.custProject.getPm());
    }
    public Long getPersonId() {
        return custProject.getPersonId();
    }

    public void setPersonId(Long personId) {
        this.custProject.setPersonId(personId);
    }



    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.custProject.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.custProject.setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.custProject.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.custProject.setUpdateTime(updateTime);
    }
}
