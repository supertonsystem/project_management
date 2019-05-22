package com.suteng.shiro.business.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.CustContact;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 联系信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustContactEntity {
    private CustContact custContact;

    public CustContactEntity() {
        this.custContact = new CustContact();
    }

    public Long getId() {
        return this.custContact.getId();
    }

    public void setId(Long id) {
        this.custContact.setId(id);
    }

    public CustContactEntity(CustContact custContact) {
        this.custContact = custContact;
    }

    public CustContact getCustContact() {
        return custContact;
    }

    public void setCustContact(CustContact custContact) {
        this.custContact = custContact;
    }

    public Long getRegister() {
        return custContact.getRegister();
    }

    public void setRegister(Long register) {
        this.custContact.setRegister(register);
    }

    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.custContact.getRegister());
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getMeetTime() {
        return custContact.getMeetTime();
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setMeetTime(Date meetTime) {
        this.custContact.setMeetTime(meetTime);
    }

    public String getMeetAddress() {
        return custContact.getMeetAddress();
    }

    public void setMeetAddress(String meetAddress) {
        this.custContact.setMeetAddress(meetAddress);
    }

    public String getActivityMode() {
        return custContact.getActivityMode();
    }

    public void setActivityMode(String activityMode) {
        this.custContact.setActivityMode(activityMode);
    }

    public Double getExpenses() {
        return custContact.getExpenses();
    }

    public void setExpenses(Double expenses) {
        this.custContact.setExpenses(expenses);
    }

    public String getParticipant() {
        return custContact.getParticipant();
    }

    public void setParticipant(String participant) {
        this.custContact.setParticipant(participant);
    }

    public Integer getPeopleNum() {
        return custContact.getPeopleNum();
    }

    public void setPeopleNum(Integer peopleNum) {
        this.custContact.setPeopleNum(peopleNum);
    }

    public String getChat() {
        return custContact.getChat();
    }

    public void setChat(String chat) {
        this.custContact.setChat(chat);
    }

    public String getRemark() {
        return custContact.getRemark();
    }

    public void setRemark(String remark) {
        this.custContact.setRemark(remark);
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.custContact.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.custContact.setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.custContact.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.custContact.setUpdateTime(updateTime);
    }
}
