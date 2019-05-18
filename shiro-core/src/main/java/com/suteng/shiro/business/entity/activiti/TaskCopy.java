package com.suteng.shiro.business.entity.activiti;

import lombok.Data;

/**

 * copy类。
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:20 2019/5/6
 */
@Data
public class TaskCopy {
    private String id;
    private String name;
    private String description;
    private String assignee;
    private String processInstanceId;
    private String executionId;
    private String processDefinitionId;
    private String taskDefinitionKey;
    private String parentTaskId;
    private String tenantId;
    private String formKey;
    private String owner;

}
