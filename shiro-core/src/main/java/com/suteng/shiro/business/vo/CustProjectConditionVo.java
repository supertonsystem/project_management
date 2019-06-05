package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;
import lombok.Data;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
@Data
public class CustProjectConditionVo extends BaseConditionVO {
    //排除ids
    private String excludeIds;
    /**
     * 关联id
     */
    private Long personId;


    private Long deptId;
    public CustProjectConditionVo() {
        this.custProjectEntity = new CustProjectEntity();
    }

    private CustProjectEntity custProjectEntity;
}
