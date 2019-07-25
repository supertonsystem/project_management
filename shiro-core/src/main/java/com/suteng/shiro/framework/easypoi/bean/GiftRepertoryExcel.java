package com.suteng.shiro.framework.easypoi.bean;

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
public class GiftRepertoryExcel {
    @Excel(name = "序号",orderNum="0")
    private Long id;
    @Excel(name = "礼品名称",orderNum="1")
    private String name;
    @Excel(name = "礼品类型",orderNum="2")
    private String typeName;
    @Excel(name = "礼品总数量",orderNum="3")
    private Long sum;
    @Excel(name = "总价", orderNum="4")
    private Double amount;
    @Excel(name = "单价",orderNum="5")
    private Double unit;
    @Excel(name = "库存",orderNum="6")
    private Long repertory;
    @Excel(name = "礼品说明",orderNum="7")
    private String description;
    @Excel(name = "备注",orderNum="9")
    private String remark;
}
