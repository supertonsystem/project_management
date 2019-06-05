package com.suteng.shiro.business.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.util.GiftUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.GiftRepertory;

/**
 * 礼品库存
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class GiftRepertoryEntity {
    private GiftRepertory giftRepertory;

    public GiftRepertoryEntity() {
        this.giftRepertory = new GiftRepertory();
    }

    public GiftRepertoryEntity(GiftRepertory giftRepertory) {
        this.giftRepertory = giftRepertory;
    }

    public Long getId() {
        return this.giftRepertory.getId();
    }

    public void setId(Long id) {
        this.giftRepertory.setId(id);
    }
    public Long getRegister() {
        return giftRepertory.getRegister();
    }

    public void setRegister(Long register) {
        this.giftRepertory.setRegister(register);
    }
    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.giftRepertory.getRegister());
    }
    public String getName() {
        return giftRepertory.getName();
    }

    public void setName(String name) {
        this.giftRepertory.setName(name);
    }

    public Long getTypeId() {
        return giftRepertory.getTypeId();
    }

    public void setTypeId(Long typeId) {
        this.giftRepertory.setTypeId(typeId);
    }
    public String getTypeName(){
        if(this.getTypeId()==null){
            return "";
        }
        return GiftUtil.getGiftTypeName(this.getTypeId());
    }
    public Long getSum() {
        return giftRepertory.getSum();
    }

    public void setSum(Long sum) {
        this.giftRepertory.setSum(sum);
    }

    public Double getAmount() {
        return this.getGiftRepertory().getAmount();
    }
    public void setAmount(Double amount){
        this.getGiftRepertory().setAmount(amount);
    }
    public Double getUnit() {
        return giftRepertory.getUnit();
    }

    public void setUnit(Double unit) {
        this.giftRepertory.setUnit(unit);
    }

    public Long getRepertory() {
        return giftRepertory.getRepertory();
    }

    public void setRepertory(Long repertory) {
        this.giftRepertory.setRepertory(repertory);
    }

    public String getDescription() {
        return giftRepertory.getDescription();
    }

    public void setDescription(String description) {
        this.giftRepertory.setDescription(description);
    }

    public String getRemark(){
            return giftRepertory.getRemark();
    }
    public void setRemark(String remark){
        giftRepertory.setRemark(remark);
    }

    public GiftRepertory getGiftRepertory() {
        return giftRepertory;
    }

    public void setGiftRepertory(GiftRepertory giftRepertory) {
        this.giftRepertory = giftRepertory;
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.giftRepertory.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.giftRepertory.setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.giftRepertory.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.giftRepertory.setUpdateTime(updateTime);
    }
}
