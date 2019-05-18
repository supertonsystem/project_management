package com.suteng.shiro.persistence.beans;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Table;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 项目管理bean
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:26 2019/4/26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Table(name="work_projectmgt")
public class WorkProjectMgt extends AbstractDO {
        private String title;
        //登记人Id
        @Column(name="register_userId")
        private Long registerUserId;
        //责任部门id
        @Column(name="owner_depId")
        private Long ownerDepId;
        //责任人
        @Column(name="owner_userId")
        private Long ownerUserId;
        //核实部门
        @Column(name="check_depId")
        private Long checkDepId;
        //任务内容
        private String content;
        //计划时间
        private Date plannedTime;
        //实际进度
        private Integer progress;
        //完成时间
        private Date finishTime;
        //绩效奖金
        private Double price;
        //延期原因
        private String delayReason;
        //办公室意见
        private String officeOpinion;
        //总经理意见
        private String gmOpinion;
        //备注
        private String remark;
        //状态
        private Integer status;
        //流程实例id
        @Column(name="process_instance_id")
        private String processInstanceId;

}
