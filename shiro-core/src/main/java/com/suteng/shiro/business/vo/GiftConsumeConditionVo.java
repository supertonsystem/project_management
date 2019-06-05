package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.GiftConsumeEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;
import lombok.Data;

/**
 * 礼品库存
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
@Data
public class GiftConsumeConditionVo extends BaseConditionVO {
    public GiftConsumeConditionVo() {
        this.giftConsumeEntity = new GiftConsumeEntity();
    }

    private GiftConsumeEntity giftConsumeEntity;

    public GiftConsumeEntity getGiftConsumeEntity() {
        return giftConsumeEntity;
    }

    public void setGiftConsumeEntity(GiftConsumeEntity giftConsumeEntity) {
        this.giftConsumeEntity = giftConsumeEntity;
    }
}
