package com.suteng.shiro.business.vo;

import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.framework.object.BaseConditionVO;
import lombok.Data;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
@Data
public class CustPersonConditionVo extends BaseConditionVO {
    /**
     * 关联id
     */
    private Long sourceId;
    //排除ids
    private String excludeIds;

    private Long projectId;

    private Long deptId;

    public CustPersonConditionVo() {
        this.custPersonEntity = new CustPersonEntity();
    }

    private CustPersonEntity custPersonEntity;
}
