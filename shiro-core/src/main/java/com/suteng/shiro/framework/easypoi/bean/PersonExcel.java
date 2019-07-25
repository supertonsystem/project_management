package com.suteng.shiro.framework.easypoi.bean;

import java.util.Date;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;

/**
 * 项目信息excle专用bean
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:06 2019/4/30
 */
@Data
public class PersonExcel {
    @Excel(name = "序号",orderNum="0")
    private Long id;
    @Excel(name = "客户名称",orderNum="1")
    private String name;
    @Excel(name = "性别",replace = {"男_0", "女_1" },orderNum="2")
    private Integer sex;
    @Excel(name = "职位",orderNum="3")
    private String post;
    @Excel(name = "公司名称", orderNum="4")
    private String companyName;
    @Excel(name = "公司性质",orderNum="5")
    private String companyNature;
    @Excel(name = "所属行业",orderNum="6")
    private String industry;
    @Excel(name = "公司规模",orderNum="7")
    private String companyScale;
    @Excel(name = "公司地址",orderNum="8")
    private String companyAddress;
    @Excel(name = "联系方式",orderNum="9")
    private String phone;
    @Excel(name = "家庭地址",orderNum="10")
    private String homeAddress;
    @Excel(name = "家庭地址",orderNum="11")
    private String mobile;
    @Excel(name = "邮箱地址",orderNum="12")
    private String email;
    @Excel(name = "传真",orderNum="13")
    private String fax;
    @Excel(name = "公司网址",orderNum="14")
    private String companyWebsite;
    @Excel(name = "来源",orderNum="15")
    private String source;
    @Excel(name = "性别",replace = {"优秀_0", "良好_1", "一般_2", "差_3" },orderNum="16")
    private Integer credit;
    @Excel(name = "拜访日期", format = "yyyy-MM-dd",orderNum="17")
    private Date visitTime;
    @Excel(name = "备注",orderNum="18")
    private String remark;
}
