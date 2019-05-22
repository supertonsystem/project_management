package com.suteng.shiro.business.entity;

import com.suteng.shiro.persistence.beans.GiftType;

/**
 * 联系信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class GiftTypeEntity {
    private GiftType giftType;

    public GiftTypeEntity() {
        this.giftType = new GiftType();
    }

    public GiftTypeEntity(GiftType giftType) {
        this.giftType = giftType;
    }

    public Long getId() {
        return this.giftType.getId();
    }

    public void setId(Long id) {
        this.giftType.setId(id);
    }

    public String getType(){
        return this.giftType.getType();
    }

    public void setType(String type){
        this.giftType.setType(type);
    }

    public GiftType getGiftType() {
        return giftType;
    }

    public void setGiftType(GiftType giftType) {
        this.giftType = giftType;
    }
}
