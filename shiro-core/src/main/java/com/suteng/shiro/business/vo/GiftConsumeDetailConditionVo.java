package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.GiftConsumeDetailEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;
import lombok.Data;

/**
 * 送礼明细
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
@Data
public class GiftConsumeDetailConditionVo extends BaseConditionVO {
    private String projectName;
    private String personName;
    public GiftConsumeDetailConditionVo() {
        this.giftConsumeDetailEntity = new GiftConsumeDetailEntity();
    }

    private GiftConsumeDetailEntity giftConsumeDetailEntity;
}
