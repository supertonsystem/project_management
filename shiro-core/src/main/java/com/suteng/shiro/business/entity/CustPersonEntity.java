package com.suteng.shiro.business.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.enums.CustEnum;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.CustPerson;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustPersonEntity {
    private CustPerson custPerson;

    private String addProjectIds;
    private String addContactIds;
    private String addPersonIds;
    private Long sourceId;
    /**
     * 项目关联列表用
     */
    private Long currProjectId;

    public Long getCurrProjectId() {
        return currProjectId;
    }

    public void setCurrProjectId(Long currProjectId) {
        this.currProjectId = currProjectId;
    }

    public Long getSourceId() {
        return sourceId;
    }

    public void setSourceId(Long sourceId) {
        this.sourceId = sourceId;
    }

    public String getAddContactIds() {
        return addContactIds;
    }

    public void setAddContactIds(String addContactIds) {
        this.addContactIds = addContactIds;
    }

    public String getAddProjectIds() {
        return addProjectIds;
    }

    public void setAddProjectIds(String addProjectIds) {
        this.addProjectIds = addProjectIds;
    }

    public String getAddPersonIds() {
        return addPersonIds;
    }

    public void setAddPersonIds(String addPersonIds) {
        this.addPersonIds = addPersonIds;
    }

    public CustPersonEntity() {
        this.custPerson = new CustPerson();
    }

    public Long getId() {
        return this.custPerson.getId();
    }

    public void setId(Long id) {
        this.getCustPerson().setId(id);
    }

    public CustPersonEntity(CustPerson custPerson) {
        this.custPerson = custPerson;
    }

    public CustPerson getCustPerson() {
        return custPerson;
    }

    public void setCustPerson(CustPerson custPerson) {
        this.custPerson = custPerson;
    }

    public Long getRegister() {
        return custPerson.getRegister();
    }

    public void setRegister(Long register) {
        this.getCustPerson().setRegister(register);
    }
    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.getCustPerson().getRegister());
    }
    public String getName() {
        return custPerson.getName();
    }

    public void setName(String name) {
        this.getCustPerson().setName(name);
    }

    public int getSex() {
        return this.getCustPerson().getSex();
    }

    public void setSex(int sex) {
        this.getCustPerson().setSex(sex);
    }

    public String getSexName(){
        return CustEnum.SEX.get(this.getSex()).sexName();
    }

    public String getPost() {
        return this.getCustPerson().getPost();
    }

    public void setPost(String post) {
        this.getCustPerson().setPost(post);
    }

    public String getCompanyName() {
        return this.getCustPerson().getCompanyName();
    }

    public void setCompanyName(String companyName) {
        this.getCustPerson().setCompanyName(companyName);
    }

    public String getCompanyNature() {
        return this.getCustPerson().getCompanyNature();
    }

    public void setCompanyNature(String companyNature) {
        this.getCustPerson().setCompanyNature(companyNature);
    }

    public String getIndustry() {
        return this.getCustPerson().getIndustry();
    }

    public void setIndustry(String industry) {
        this.getCustPerson().setIndustry(industry);
    }

    public String getCompanyScale() {
        return this.getCustPerson().getCompanyScale();
    }

    public void setCompanyScale(String companyScale) {
        this.getCustPerson().setCompanyScale(companyScale);
    }

    public String getCompanyAddress() {
        return this.getCustPerson().getCompanyAddress();
    }

    public void setCompanyAddress(String companyAddress) {
        this.getCustPerson().setCompanyAddress(companyAddress);
    }

    public String getPhone() {
        return this.getCustPerson().getPhone();
    }

    public void setPhone(String phone) {
        this.getCustPerson().setPhone(phone);
    }

    public String getHomeAddress() {
        return this.getCustPerson().getHomeAddress();
    }

    public void setHomeAddress(String homeAddress) {
        this.getCustPerson().setHomeAddress(homeAddress);
    }

    public String getMobile() {
        return this.getCustPerson().getMobile();
    }

    public void setMobile(String mobile) {
        this.getCustPerson().setMobile(mobile);
    }

    public String getEmail() {
        return this.getCustPerson().getEmail();
    }

    public void setEmail(String email) {
        this.getCustPerson().setEmail(email);
    }

    public String getFax() {
        return this.getCustPerson().getFax();
    }

    public void setFax(String fax) {
        this.getCustPerson().setFax(fax);
    }

    public String getCompanyWebsite() {
        return this.getCustPerson().getCompanyWebsite();
    }

    public void setCompanyWebsite(String companyWebsite) {
        this.getCustPerson().setCompanyWebsite(companyWebsite);
    }

    public String getSource() {
        return this.getCustPerson().getSource();
    }

    public void setSource(String source) {
        this.getCustPerson().setSource(source);
    }


    public Integer getCredit() {
        return this.getCustPerson().getCredit();
    }

    public void setCredit(Integer credit) {
        this.getCustPerson().setCredit(credit);
    }

    public String getCreditName(){
        return CustEnum.CREDIT.get(this.getCredit()).creditName();
    }
    public String getRemark() {
        return this.getCustPerson().getRemark();
    }

    public void setRemark(String remark) {
        this.getCustPerson().setRemark(remark);
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.getCustPerson().getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.getCustPerson().setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.getCustPerson().getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.getCustPerson().setUpdateTime(updateTime);
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getVisitTime() {
        return getCustPerson().getVisitTime();
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setVisitTime(Date visitTime) {
        this.getCustPerson().setVisitTime(visitTime);
    }


    public String getIcon() {
        return this.getCustPerson().getIcon();
    }

    public void setIcon(String icon) {
        this.getCustPerson().setIcon(icon);
    }
}
