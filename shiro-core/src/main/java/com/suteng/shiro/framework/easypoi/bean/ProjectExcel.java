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
public class ProjectExcel {
    @Excel(name = "序号",orderNum="0")
    private Long id;
    @Excel(name = "项目编号",orderNum="1")
    private String number;
    @Excel(name = "项目名称",orderNum="2")
    private String name;
    @Excel(name = "公司名称",orderNum="3")
    private String companyName;
    @Excel(name = "区域", orderNum="4")
    private String area;
    @Excel(name = "省份",orderNum="5")
    private String province;
    @Excel(name = "地址",orderNum="6")
    private String address;
    @Excel(name = "开工日期",format = "yyyy-MM-dd",orderNum="7")
    private Date startTime;
    @Excel(name = "完工日期",format = "yyyy-MM-dd",orderNum="8")
    private Date endTime;
    @Excel(name = "工期",orderNum="9")
    private String period;
    @Excel(name = "甲方负责人",orderNum="10")
    private String owner;
    @Excel(name = "甲方部门",orderNum="11")
    private String ownerDepartment;
    @Excel(name = "责任部门",orderNum="12")
    private String departmentName;
    @Excel(name = "项目经理",orderNum="13")
    private String pmName;

}
