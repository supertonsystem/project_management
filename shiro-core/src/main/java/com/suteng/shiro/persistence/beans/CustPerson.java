package com.suteng.shiro.persistence.beans;

import java.util.Date;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 客户基本信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class CustPerson extends AbstractDO {
    /**
     * 登记人
     */
    private Long register;
    /**
     * 客户名称
     */
    private String name;
    /**
     * 客户性别
     * 0:男 1：女
     */
    private Integer sex;
    /**
     * 职位
     */
    private String post;

    /**
     *公司名称
     */
    private String companyName;
    /**
     * 公司性质
     */
    private String companyNature;
    /**
     * 所属行业
     */
    private String industry;
    /**
     * 公司规模
     */
    private String companyScale;
    /**
     * 公司地址
     */
    private String companyAddress;
    /**
     * 联系方式
     */
    private String phone;
    /**
     * 家庭地址
     */
    private String homeAddress;
    /**
     * 手机号码
     */
    private String mobile;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 传真
     */
    private String fax;
    /**
     * 公司网址
     */
    private String companyWebsite;
    /**
     * 来源
     */
    private String source;
    /**
     * 信用
     * 0：优秀 1：良好 2：一般 3：差
     */
    private Integer credit;
    /**
     * 备注
     */
    private String remark;



    /**
     * 拜访日期
     */
    private Date visitTime;
}

