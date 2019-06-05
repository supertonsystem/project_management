package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.GiftTypeEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;
import lombok.Data;

/**
 * 礼品类别
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
@Data
public class GiftTypeConditionVo extends BaseConditionVO {
    private String searchText;
    public GiftTypeConditionVo() {
        this.giftTypeEntity = new GiftTypeEntity();
    }

    private GiftTypeEntity giftTypeEntity;

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }
}
