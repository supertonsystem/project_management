package com.suteng.shiro.framework.activiti;

import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:39 2019/5/13
 */
public class JumpCmd implements Command<ExecutionEntity> {
    private String processInstanceId;
    private String activityId;
    public static final String REASION_DELETE = "deleted";

    public JumpCmd(String processInstanceId, String activityId) {
        this.processInstanceId = processInstanceId;
        this.activityId = activityId;
    }

    @Override
    public ExecutionEntity execute(CommandContext commandContext) {
        ExecutionEntity executionEntity = commandContext.getExecutionEntityManager().findExecutionById(processInstanceId);
        executionEntity.destroyScope(REASION_DELETE);
        ProcessDefinitionImpl processDefinition = executionEntity.getProcessDefinition();
        ActivityImpl activity = processDefinition.findActivity(activityId);
        String name= (String) activity.getProperty("name");
        activity.setProperty("name",name+"(退回)");
        executionEntity.executeActivity(activity);
        return executionEntity;
    }
}
