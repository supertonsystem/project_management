package com.suteng.shiro.framework.easypoi.bean;

import java.util.Date;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;

/**
 * 送礼明细信息excle专用bean
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:06 2019/4/30
 */
@Data
public class GiftConsumeDetailExcel {
    @Excel(name = "序号",orderNum="0")
    private Long id;
    @Excel(name = "领用标题",orderNum="1")
    private String consumeName;
    @Excel(name = "客户名称",orderNum="2")
    private String personName;
    @Excel(name = "项目名称",orderNum="3")
    private String projectName;
    @Excel(name = "礼品名称", orderNum="4")
    private String repertoryName;
    @Excel(name = "数量",orderNum="5")
    private Long num;
    @Excel(name = "金额",orderNum="6")
    private Double amount;
    @Excel(name = "送礼时间",format = "yyyy-MM-dd",orderNum="7")
    private Date sendTime;
    @Excel(name = "送礼地点",orderNum="9")
    private String sendSite;
    @Excel(name = "说明",orderNum="10")
    private String description;
    @Excel(name = "使用状态",replace = {"未送_0", "已送_1", "退回_2"},orderNum="11")
    private Integer status;
    @Excel(name = "领用状态",replace = {"待领_0", "已领_1"},orderNum="12")
    private Integer drawStatus;
    @Excel(name = "备注",orderNum="13")
    private String remark;
}
