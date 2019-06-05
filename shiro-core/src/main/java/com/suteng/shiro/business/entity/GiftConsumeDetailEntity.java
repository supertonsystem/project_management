package com.suteng.shiro.business.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.util.GiftUtil;
import com.suteng.shiro.business.util.PersonUtil;
import com.suteng.shiro.business.util.ProjectUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.GiftConsumeDetail;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 送礼记录
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class GiftConsumeDetailEntity {
    private GiftConsumeDetail giftConsumeDetail;

    public GiftConsumeDetailEntity() {
        this.giftConsumeDetail = new GiftConsumeDetail();
    }

    public GiftConsumeDetailEntity(GiftConsumeDetail giftConsumeDetail) {
        this.giftConsumeDetail = giftConsumeDetail;
    }

    public Long getId() {
        return this.giftConsumeDetail.getId();
    }

    public void setId(Long id) {
        this.giftConsumeDetail.setId(id);
    }

    public Long getRegister() {
        return giftConsumeDetail.getRegister();
    }

    public void setRegister(Long register) {
        this.giftConsumeDetail.setRegister(register);
    }

    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.giftConsumeDetail.getRegister());
    }

    public Long getConsumeId() {
        return giftConsumeDetail.getConsumeId();
    }

    public void setConsumeId(Long consumeId) {
        this.giftConsumeDetail.setConsumeId(consumeId);
    }

    public Long getPersonId() {
        return giftConsumeDetail.getPersonId();
    }

    public void setPersonId(Long personId) {
        this.giftConsumeDetail.setPersonId(personId);
    }

    public String getPersonName(){
        if(giftConsumeDetail.getPersonId()==null){
            return "";
        }
        return PersonUtil.getCustPersonName(giftConsumeDetail.getPersonId());
    }

    public Long getProjectId() {
        return giftConsumeDetail.getProjectId();
    }

    public void setProjectId(Long projectId) {
        this.giftConsumeDetail.setProjectId(projectId);
    }

    public String getProjectName(){
        if(giftConsumeDetail.getProjectId()==null){
            return "";
        }
        return ProjectUtil.getCustProjectName(giftConsumeDetail.getProjectId());
    }

    public void setRepertoryId(Long repertoryId){
        this.giftConsumeDetail.setRepertoryId(repertoryId);
    }

    public Long getRepertoryId(){
        return giftConsumeDetail.getRepertoryId();
    }

    public String getRepertoryName(){
        if(giftConsumeDetail.getRepertoryId()==null){
            return "";
        }
        return GiftUtil.getGiftRepertoryName(giftConsumeDetail.getRepertoryId());
    }
    @JSONField(format = "yyyy-MM-dd")
    public Date getSendTime() {
        return giftConsumeDetail.getSendTime();
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setSendTime(Date sendTime) {
        this.giftConsumeDetail.setSendTime(sendTime);
    }

    public String getSendSite() {
        return giftConsumeDetail.getSendSite();
    }

    public void setSendSite(String sendSite) {
        this.giftConsumeDetail.setSendSite(sendSite);
    }

    public Integer getDrawStatus() {
        return giftConsumeDetail.getDrawStatus();
    }

    public void setDrawStatus(Integer drawStatus) {
        this.giftConsumeDetail.setDrawStatus(drawStatus);
    }

    public Integer getStatus() {
        return giftConsumeDetail.getStatus();
    }

    public void setStatus(Integer status) {
        this.giftConsumeDetail.setStatus(status);
    }

    public String getRemark() {
        return giftConsumeDetail.getRemark();
    }

    public void setRemark(String remark) {
        this.giftConsumeDetail.setRemark(remark);
    }

    /**
     * 领用的数量
     * @return
     */
    public Long getNum() {
        return giftConsumeDetail.getNum();
    }

    public void setNum(Long num) {
        this.giftConsumeDetail.setNum(num);
    }

    public Double getAmount() {
        return this.getGiftConsumeDetail().getAmount();
    }

    public void setAmount(Double amount) {
        this.getGiftConsumeDetail().setAmount(amount);
    }

    public String getDescription() {
        return giftConsumeDetail.getDescription();
    }

    public void setDescription(String description) {
        this.giftConsumeDetail.setDescription(description);
    }

    public GiftConsumeDetail getGiftConsumeDetail() {
        return giftConsumeDetail;
    }

    public void setGiftConsumeDetail(GiftConsumeDetail giftConsumeDetail) {
        this.giftConsumeDetail = giftConsumeDetail;
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.giftConsumeDetail.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.giftConsumeDetail.setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.giftConsumeDetail.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.giftConsumeDetail.setUpdateTime(updateTime);
    }
}
