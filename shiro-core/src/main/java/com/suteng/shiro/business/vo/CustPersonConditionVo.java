package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustPersonConditionVo extends BaseConditionVO {
    public CustPersonConditionVo() {
        this.custPersonEntity = new CustPersonEntity();
    }

    private CustPersonEntity custPersonEntity;
}
