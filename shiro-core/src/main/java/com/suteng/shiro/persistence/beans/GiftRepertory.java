package com.suteng.shiro.persistence.beans;

import javax.persistence.Transient;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 礼品库存
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class GiftRepertory extends AbstractDO {
    /**
     * 登记人
     */
    private Long register;
    /**
     * 礼品名称
     */
    private String name;

    private Long typeId;
    /**
     * 礼品总数量
     */
    private Long sum;
    /**
     * 总价
     * 可能存在礼品之外的额外开销
     * 所以这里单独存一个字段
     */
    private Double amount;
    /**
     * 单价
     */
    private Double unit;
    /**
     * 库存数量
     */
    private Long repertory;
    /**
     * 礼品说明
     */
    private String description;
    @Transient
    private GiftType giftType;

    private String remark;
}

