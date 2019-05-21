package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustProjectConditionVo extends BaseConditionVO {
    public CustProjectConditionVo() {
        this.custProjectEntity = new CustProjectEntity();
    }

    private CustProjectEntity custProjectEntity;
}
