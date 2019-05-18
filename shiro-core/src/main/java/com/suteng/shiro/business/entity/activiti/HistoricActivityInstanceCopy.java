package com.suteng.shiro.business.entity.activiti;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.suteng.shiro.business.util.UserUtil;
import lombok.Data;

/**
 *  copy类.
 * @Author:louyi
 * @Description：
 * @Date:Create in 8:53 2019/5/7
 */
@Data
public class HistoricActivityInstanceCopy {
    private String taskId;
    private String activityName;
    private String assignee;
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    public String getAssigneeUserName(){
        if(this.assignee==null){
            return "系统";
        }
        return UserUtil.getUserNickName(Long.valueOf(this.assignee));
    }
}
