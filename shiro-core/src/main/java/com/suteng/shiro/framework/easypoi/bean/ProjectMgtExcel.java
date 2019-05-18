package com.suteng.shiro.framework.easypoi.bean;

import java.util.Date;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;

/**
 * 项目管理excle专用bean
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:06 2019/4/30
 */
@Data
public class ProjectMgtExcel {
    @Excel(name = "序号",orderNum="0")
    private Long id;
    @Excel(name = "状态",replace = {"进行中_1", "已完成_2" },orderNum="10")
    private Integer status;
    @Excel(name = "项目标题", isImportField = "true",orderNum="1")
    private String title;
    @Excel(name = "责任部门",isImportField = "true",orderNum="2")
    private String ownerDepName;
    @Excel(name = "责任人",isImportField = "true",orderNum="3")
    private String ownerUserName;
    @Excel(name = "项目内容", isImportField = "true",orderNum="4")
    private String content;
    @Excel(name = "核实部门",orderNum="5")
    private String checkDepName;
    @Excel(name = "计划日期", format = "yyyy-MM-dd",isImportField = "true",orderNum="7")
    private Date plannedTime;
    @Excel(name = "项目进度",suffix="%",orderNum="6")
    private Integer progress;
    @Excel(name = "完成日期",format = "yyyy-MM-dd",orderNum="8")
    private Date finishTime;
    @Excel(name = "绩效奖金",isImportField = "true",suffix="元",orderNum="9")
    private Double price;
    @Excel(name = "备注",orderNum="11")
    private String remark;
}
