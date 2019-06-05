package com.suteng.shiro.business.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.GiftConsume;

/**
 * 礼品库存
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class GiftConsumeEntity {
    private GiftConsume giftConsume;

    public GiftConsumeEntity() {
        this.giftConsume = new GiftConsume();
    }

    public GiftConsumeEntity(GiftConsume giftConsume) {
        this.giftConsume = giftConsume;
    }

    public Long getId() {
        return this.giftConsume.getId();
    }

    public void setId(Long id) {
        this.giftConsume.setId(id);
    }
    public Long getRegister() {
        return giftConsume.getRegister();
    }

    public void setRegister(Long register) {
        this.giftConsume.setRegister(register);
    }
    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.giftConsume.getRegister());
    }

    public Long getNum() {
        return giftConsume.getNum();
    }

    public void setNum(Long num) {
        this.giftConsume.setNum(num);
    }

    public Double getAmount() {
        return this.getGiftConsume().getAmount();
    }
    public void setAmount(Double amount){
        this.getGiftConsume().setAmount(amount);
    }

    public String getTitle() {
        return giftConsume.getTitle();
    }

    public void setTitle(String title) {
        this.giftConsume.setTitle(title);
    }

    public Integer getStatus(){
        return this.getGiftConsume().getStatus();
    }

    public void setStatus(Integer status){
        this.giftConsume.setStatus(status);
    }

    public Long getBackNum() {
        return giftConsume.getBackNum();
    }

    public void setBackNum(Long backNum) {
        this.giftConsume.setBackNum(backNum);
    }

    public Double getBackMoney() {
        return giftConsume.getBackMoney();
    }

    public void setBackMoney(Double backMoney) {
        this.giftConsume.setBackMoney(backMoney);
    }

    public String getDescription() {
        return giftConsume.getDescription();
    }

    public void setDescription(String description) {
        this.giftConsume.setDescription(description);
    }

    public GiftConsume getGiftConsume() {
        return giftConsume;
    }

    public void setGiftConsume(GiftConsume giftConsume) {
        this.giftConsume = giftConsume;
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.giftConsume.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.giftConsume.setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.giftConsume.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.giftConsume.setUpdateTime(updateTime);
    }
}
