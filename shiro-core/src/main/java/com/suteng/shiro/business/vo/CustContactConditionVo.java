package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;
import lombok.Data;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
@Data
public class CustContactConditionVo extends BaseConditionVO {
    //排除ids
    private String excludeIds;
    //客户名称
    private String personName;

    public CustContactConditionVo() {
        this.custContactEntity = new CustContactEntity();
    }

    private CustContactEntity custContactEntity;
}
