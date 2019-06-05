package com.suteng.shiro.persistence.beans;

import java.util.Date;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 项目基本信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class CustProject extends AbstractDO {
    /**
     * 登记人
     */
    private Long register;
    /**
     * 项目编号
     */
    private String number;
    /**
     * 项目名称
     */
    private String name;

    /**
     * 公司名称
     */
    private String companyName;
    /**
     * 区域
     */
    private String area;
    /**
     * 省份
     */
    private String province;
    /**
     *
     */
    private String address;
    /**
     * 开工日期
     */
    private Date startTime;
    /**
     * 完工日期
     */
    private Date endTime;
    /**
     * 工期
     */
    private String period;
    /**
     * 甲方负责人
     */
    private String owner;
    /**
     * 甲方部门
     */
    private String ownerDepartment;
    /**
     * 责任部门
     */
    private Long department;
    /**
     * 项目经理
     */
    private Long pm;

}

