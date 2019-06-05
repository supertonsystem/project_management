package com.suteng.shiro.persistence.beans;

import java.util.Date;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 礼品领用
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class GiftConsumeDetail extends AbstractDO {
    /**
     * 创建人
     */
    private Long register;
    /**
     * 领用ID
     */
    private Long consumeId;
    /**
     * 客户id
     */
    private Long personId;
    /**
     * 项目id
     */
    private Long projectId;
    /**
     * 库存id
     */
    private Long repertoryId;
    /**
     * 份数
     */
    private Long num;
    /**
     * 金额
     */
    private Double amount;
    /**
     * 送礼时间
     */
    private Date sendTime;
    /**
     * 送礼地点
     */
    private String sendSite;
   /**
     * 礼品明细说明
     */
    private String description;

    /**
     *  使用状态
     *  未送0，已送1，退回2
     */
    private Integer status;
    /**
     * 领用状态
     * 0：待领
     * 1：已领
     */
    private Integer drawStatus;
    /**
     * 备注
     */
    private String remark;


}

