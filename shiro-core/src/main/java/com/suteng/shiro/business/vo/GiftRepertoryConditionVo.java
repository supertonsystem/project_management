package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.GiftRepertoryEntity;
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
public class GiftRepertoryConditionVo extends BaseConditionVO {
    public GiftRepertoryConditionVo() {
        this.giftRepertoryEntity = new GiftRepertoryEntity();
    }

    private GiftRepertoryEntity giftRepertoryEntity;
}
