package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustContactConditionVo extends BaseConditionVO {
    public CustContactConditionVo() {
        this.custContactEntity = new CustContactEntity();
    }

    private CustContactEntity custContactEntity;
}
