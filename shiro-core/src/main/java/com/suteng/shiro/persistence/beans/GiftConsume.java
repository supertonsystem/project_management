package com.suteng.shiro.persistence.beans;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 礼品领用
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class GiftConsume extends AbstractDO {
    /**
     * 申请人即创建人
     */
    private Long register;
    /**
     * 库存关联ID
     */
    private String title;
    /**
     * 领用数量
     */
    private Long num;
    /**
     * 金额
     */
    private Double amount;
    /**
     * 退回数量
     */
    private Long backNum;
    /**
     * 退回金额
     */
    private Double backMoney;
    /**
     * 情况
     */
    private String description;
    /**
     * 登记：0，申请中：1 已完成：2
     */
    private Integer status;

}

