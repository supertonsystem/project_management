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
public class ContactExcel {
    @Excel(name = "序号",orderNum="0")
    private Long id;
    @Excel(name = "会面时间",format = "yyyy-MM-dd",orderNum="1")
    private Date meetTime;
    @Excel(name = "会面地址",orderNum="2")
    private String meetAddress;
    @Excel(name = "活动方式",orderNum="3")
    private String activityMode;
    @Excel(name = "费用", orderNum="4")
    private Double expenses;
    @Excel(name = "参与人员",orderNum="5")
    private String participant;
    @Excel(name = "人数",orderNum="6")
    private Integer peopleNum;
    @Excel(name = "聊天记录",orderNum="7")
    private String chat;
    @Excel(name = "关联客户",orderNum="8")
    private String personName;
    @Excel(name = "备注",orderNum="9")
    private String remark;
}
