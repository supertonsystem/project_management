package com.suteng.shiro.business.entity;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.enums.ProjectMgtRemindEnum;
import com.suteng.shiro.business.enums.ProjectMgtStatusEnum;
import com.suteng.shiro.business.util.DepartmentUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.persistence.beans.WorkProjectMgt;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:14 2019/4/28
 */
public class ProjectMgt {
    private WorkProjectMgt workProjectMgt;
    //当前所处任务节点
    private String taskName;

    public ProjectMgt() {
        this.workProjectMgt = new WorkProjectMgt();
    }

    public ProjectMgt(WorkProjectMgt workProjectMgt) {
        this.workProjectMgt = workProjectMgt;
    }

    public WorkProjectMgt getWorkProjectMgt() {
        return this.workProjectMgt;
    }

    public void setWorkProjectMgt(WorkProjectMgt workProjectMgt) {
        this.workProjectMgt = workProjectMgt;
    }

    public Long getId() {
        return this.workProjectMgt.getId();
    }

    public void setId(Long id) {
        this.workProjectMgt.setId(id);
    }

    public String getNumber() {
        return this.workProjectMgt.getNumber();
    }

    public void setNumber(String number) {
        this.workProjectMgt.setNumber(number);
    }
    public String getTitle() {
        return this.workProjectMgt.getTitle();
    }

    public void setTitle(String title) {
        this.workProjectMgt.setTitle(title);
    }

    public Long getRegisterUserId() {
        return this.workProjectMgt.getRegisterUserId();
    }

    public void setRegisterUserId(Long registerUserId) {
        this.workProjectMgt.setRegisterUserId(registerUserId);
    }

    public String getRegisterUserName() {
        return UserUtil.getUserNickName(this.workProjectMgt.getRegisterUserId());
    }

    public Long getOwnerDepId() {
        return this.workProjectMgt.getOwnerDepId();
    }

    public void setOwnerDepId(Long ownerDepId) {
        this.workProjectMgt.setOwnerDepId(ownerDepId);
    }

    public String getOwnerDepName() {
        return DepartmentUtil.getDepartmentName(this.workProjectMgt.getOwnerDepId());
    }

    public Long getOwnerUserId() {
        return this.workProjectMgt.getOwnerUserId();
    }

    public void setOwnerUserId(Long ownerUserId) {
        this.workProjectMgt.setOwnerUserId(ownerUserId);
    }

    public String getOwnerUserName() {
        if(this.workProjectMgt.getOwnerUserId()==null){
            return getOwnerDepName();
        }
        return UserUtil.getUserNickName(this.workProjectMgt.getOwnerUserId());
    }

    public Long getCheckDepId() {
        return this.workProjectMgt.getCheckDepId();
    }

    public String getCheckDepName() {
        return DepartmentUtil.getDepartmentName(this.workProjectMgt.getCheckDepId());
    }

    public void setCheckDepId(Long checkDepId) {
        this.workProjectMgt.setCheckDepId(checkDepId);
    }

    public String getContent() {
        return this.workProjectMgt.getContent();
    }

    public void setContent(String content) {
        this.workProjectMgt.setContent(content);
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getPlannedTime() {
        return this.workProjectMgt.getPlannedTime();
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setPlannedTime(Date plannedTime) {
        this.workProjectMgt.setPlannedTime(plannedTime);
    }

    public Integer getProgress() {
        return this.workProjectMgt.getProgress();
    }

    public void setProgress(Integer progress) {
        this.workProjectMgt.setProgress(progress);
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getFinishTime() {
        return this.workProjectMgt.getFinishTime();
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setFinishTime(Date finishTime) {
        this.workProjectMgt.setFinishTime(finishTime);
    }

    public String getPrice() {
        return this.workProjectMgt.getPrice();
    }

    public void setPrice(String price) {
        this.workProjectMgt.setPrice(price);
    }

    public String getDelayReason() {
        return this.workProjectMgt.getDelayReason();
    }

    public void setDelayReason(String delayReason) {
        this.workProjectMgt.setDelayReason(delayReason);
    }

    public String getOfficeOpinion() {
        return this.workProjectMgt.getOfficeOpinion();
    }

    public void setOfficeOpinion(String officeOpinion) {
        this.workProjectMgt.setOfficeOpinion(officeOpinion);
    }

    public String getGmOpinion() {
        return this.workProjectMgt.getGmOpinion();
    }

    public void setGmOpinion(String gmOpinion) {
        this.workProjectMgt.setGmOpinion(gmOpinion);
    }

    public String getRemark() {
        return this.workProjectMgt.getRemark();
    }

    public void setRemark(String remark) {
        this.workProjectMgt.setRemark(remark);
    }

    @JSONField(format = "yyyy-MM-dd")
    public Date getCreateTime() {
        return this.workProjectMgt.getCreateTime();
    }

    public void setCreateTime(Date regTime) {
        this.workProjectMgt.setCreateTime(regTime);
    }

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateTime() {
        return this.workProjectMgt.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.workProjectMgt.setUpdateTime(updateTime);
    }

    public void setStatus(Integer status) {
        this.workProjectMgt.setStatus(status);
    }

    public Integer getStatus() {
        return this.workProjectMgt.getStatus();
    }

    public String getStatusName() {
        return ProjectMgtStatusEnum.get(this.workProjectMgt.getStatus()).getName();
    }

    public String getRemindGrade() {
        if (this.workProjectMgt.getPlannedTime() == null || this.getStatus().intValue() == ProjectMgtStatusEnum.FINISH.getStatus()) {
            return ProjectMgtRemindEnum.UNKNOW.getGrade();
        }
        Date plannedTime = workProjectMgt.getPlannedTime();
        Instant instant = plannedTime.toInstant();
        ZoneId zone = ZoneId.systemDefault();
        LocalDateTime localPlannedTime = LocalDateTime.ofInstant(instant, zone);
        LocalDateTime now = LocalDateTime.now();

        if(now.isAfter(localPlannedTime)){
            return ProjectMgtRemindEnum.DANGER.getGrade();
        }
        int plannedTimeDay = localPlannedTime.getDayOfYear();
        int nowDay = now.getDayOfYear();
        int difDay = plannedTimeDay - nowDay;
        if (difDay > ProjectMgtRemindEnum.WARNING.getDay() && difDay <= ProjectMgtRemindEnum.INFO.getDay()) {
            //距离截至时间提前5天
            return ProjectMgtRemindEnum.INFO.getGrade();
        }

        if (difDay > ProjectMgtRemindEnum.DANGER.getDay() && difDay <= ProjectMgtRemindEnum.WARNING.getDay()) {
            return ProjectMgtRemindEnum.WARNING.getGrade();
        }

        return ProjectMgtRemindEnum.UNKNOW.getGrade();
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public void setFocus(Integer focus){
        this.workProjectMgt.setFocus(focus);
    }

    public Integer getFocus(){
        return this.workProjectMgt.getFocus();
    }

    public String getProcessInstanceId() {
        return this.workProjectMgt.getProcessInstanceId();
    }

    public void setProcessInstanceId(String processInstanceId) {
        this.workProjectMgt.setProcessInstanceId(processInstanceId);
    }
}
