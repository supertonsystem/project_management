package com.suteng.shiro.persistence.beans;

import java.util.Date;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 联系信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class CustContact extends AbstractDO {
    /**
     * 登记人
     */
    private Long register;
    /**
     * 会面时间
     */
    private Date meetTime;
    /**
     * 会面地址
     */
    private String meetAddress;

    /**
     * 活动方式
     */
    private String activityMode;
    /**
     * 费用
     */
    private Double expenses;
    /**
     * 参与人员
     */
    private String participant;
    /**
     *  人数
     */
    private Integer peopleNum;
    /**
     * 聊天记录
     */
    private String chat;
    /**
     * 备注
     */
    private String remark;

    /**
     * 关联客户
     */
    private Long personId;

}

