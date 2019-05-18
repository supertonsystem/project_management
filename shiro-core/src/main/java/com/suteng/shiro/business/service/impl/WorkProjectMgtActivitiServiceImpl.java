package com.suteng.shiro.business.service.impl;


import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.entity.activiti.HistoricActivityInstanceCopy;
import com.suteng.shiro.business.enums.ProjectMgtStatusEnum;
import com.suteng.shiro.business.service.ProcessCoreService;
import com.suteng.shiro.business.service.WorkProjectMgtActivitiService;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.framework.config.ActivitiConfig;
import com.suteng.shiro.framework.exception.SupertonActivitiException;
import com.suteng.shiro.persistence.beans.WorkProjectMgt;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngineConfiguration;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.image.ProcessDiagramGenerator;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 * 流程关联
 *
 * @author
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Service
public class WorkProjectMgtActivitiServiceImpl implements WorkProjectMgtActivitiService {
    @Autowired
    private WorkProjectMgtService workProjectMgtService;
    @Autowired
    ProcessEngine processEngine;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private ProcessEngineConfiguration processEngineConfiguration;
    @Autowired
    private ProcessCoreService processCoreService;

    @Override
    public List<ProjectMgt> queryGendaTask(String userId) {
        List<ProjectMgt> projectMgts = new ArrayList<>();
        List<Task> tasks = queryTask(userId);
        if (tasks != null && !tasks.isEmpty()) {
            List<String> processInstanceIds = tasks.stream()
                    .map(task -> task.getProcessInstanceId())
                    .collect(Collectors.toList());
            List<WorkProjectMgt> workProjectMgts = workProjectMgtService.findByProcessInstanceIds(processInstanceIds);
            projectMgts = new ArrayList<>();
            for (WorkProjectMgt p : workProjectMgts) {
                projectMgts.add(new ProjectMgt(p));
            }
        }
        return projectMgts;
    }

    @Override
    public Task queryGendaTaskInfo(String userId, String processInstanceId) {
        List<Task> tasks = processEngine.getTaskService()
                .createTaskQuery()
                .taskAssignee(userId)
                .processInstanceId(processInstanceId)
                .orderByTaskCreateTime().asc()
                .list();//返回列表
        if (tasks != null && !tasks.isEmpty()) {
            Task task = tasks.get(0);
            return task;
        }
        return null;
    }

    /**
     * 启动流程
     *
     * @param projectMgt
     */
    @Override
    public String startWorkProjectMgtProcess(ProjectMgt projectMgt, String operatorId) {
        RepositoryService repositoryService = processEngine.getRepositoryService();
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey(ActivitiConfig.DEFAULT_BPMN_KEY).latestVersion().singleResult();
        Map<String, Object> variables = new HashMap<String, Object>();
        //登记环境执行人
        variables.put("registerUserId", operatorId);
        //启动流程定义，返回流程实例
        ProcessInstance pi = runtimeService.startProcessInstanceById(processDefinition.getId(), variables);
        projectMgt.setStatus(ProjectMgtStatusEnum.PROCEED.getStatus());
        projectMgt.getWorkProjectMgt().setProcessInstanceId(pi.getId());
        if (projectMgt.getProgress() == null) {
            projectMgt.setProgress(0);
        }
        workProjectMgtService.insert(projectMgt);
        return pi.getId();
    }

    @Override
    public void completeWorkProjectMgtProcess(ProjectMgt projectMgt, String taskId, String operatorId) throws SupertonActivitiException {
        Task task = processEngine.getTaskService()
                .createTaskQuery().taskId(taskId).singleResult();
        if (task == null) {
            throw new SupertonActivitiException("任务不存在");
        }
        Map<String, Object> variables = new HashMap<String, Object>();
        //下一个节点assignee赋值
        if ("登记".equals(task.getName())) {
            variables.put("officeId", operatorId);
        } else if ("办公室".equals(task.getName())) {
            variables.put("gmId", operatorId);
        } else if ("总经理".equals(task.getName())) {
            //任务结束
            projectMgt.setStatus(ProjectMgtStatusEnum.FINISH.getStatus());
        }
        workProjectMgtService.updateSelective(projectMgt);
        processEngine.getTaskService().complete(task.getId(), variables);
    }

    @Override
    public void completeWorkProjectMgtProcess(ProjectMgt projectMgt, Task task, String operatorId) throws SupertonActivitiException {
        if (task == null) {
            throw new SupertonActivitiException("任务不存在");
        }
        Map<String, Object> variables = new HashMap<String, Object>();
        //下一个节点assignee赋值
        if ("登记".equals(task.getName())) {
            variables.put("officeId", operatorId);
        } else if ("办公室".equals(task.getName())) {
            variables.put("gmId", operatorId);
        } else if ("总经理".equals(task.getName())) {
            //任务结束
            projectMgt.setStatus(ProjectMgtStatusEnum.FINISH.getStatus());
        }
        workProjectMgtService.updateSelective(projectMgt);
        processEngine.getTaskService().complete(task.getId(), variables);
    }

    @Override
    public List<HistoricActivityInstanceCopy> findHistoryActivity(Long projectMgtId) {
        List<HistoricActivityInstanceCopy> instanceList = new ArrayList<>();
        if (projectMgtId == null) {
            return instanceList;
        }
        ProjectMgt projectMgt = workProjectMgtService.getByPrimaryKey(projectMgtId);
        if (projectMgt != null && StringUtils.isNotEmpty(projectMgt.getWorkProjectMgt().getProcessInstanceId())) {
            List<HistoricActivityInstance> hais = processEngine.getHistoryService()
                    .createHistoricActivityInstanceQuery()
                    .processInstanceId(projectMgt.getWorkProjectMgt().getProcessInstanceId())
                    .orderByHistoricActivityInstanceStartTime().asc()
                    .list();
            if (hais != null) {
                for (HistoricActivityInstance h : hais) {
                    HistoricActivityInstanceCopy instance = new HistoricActivityInstanceCopy();
                    BeanUtils.copyProperties(h, instance);
                    instanceList.add(instance);
                }
            }
        }
        return instanceList;
    }

    @Override
    public List<HistoricActivityInstanceCopy> findHistoryActivity(String processInstanceId) {
        List<HistoricActivityInstanceCopy> instanceList = new ArrayList<>();
        if (StringUtils.isEmpty(processInstanceId)) {
            return instanceList;
        }
        List<HistoricActivityInstance> hais = processEngine.getHistoryService()
                .createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .orderByHistoricActivityInstanceStartTime().asc()
                .list();
        if (hais != null) {
            for (HistoricActivityInstance h : hais) {
                HistoricActivityInstanceCopy instance = new HistoricActivityInstanceCopy();
                BeanUtils.copyProperties(h, instance);
                instanceList.add(instance);
            }
        }
        return instanceList;
    }

    @Override
    public Integer queryGendaTaskByTodayAdd(String userId) {
        Integer todayAddNum = 0;
        List<Task> tasks = queryTask(userId);
        if (tasks != null && !tasks.isEmpty()) {
            for (Task task : tasks) {
                if (DateUtils.isSameDay(task.getCreateTime(), new Date())) {
                    todayAddNum++;
                }
            }
        }
        return todayAddNum;
    }

    @Override
    public Integer queryDelayGendaTask(String userId, int day) {
        Integer delayNum = 0;
        List<Task> tasks = queryTask(userId);
        if (tasks != null && !tasks.isEmpty()) {
            for (Task task : tasks) {
                if (DateUtils.addDays(task.getCreateTime(), day).after(new Date())) {
                    delayNum++;
                }
            }
        }
        return delayNum;
    }

    /**
     * 查询待办任务
     *
     * @param userId
     * @return
     */
    private List<Task> queryTask(String userId) {
        List<Task> tasks = processEngine.getTaskService()
                .createTaskQuery()
                .taskAssignee(userId)
                .orderByTaskCreateTime().asc()
                .list();
        return tasks;
    }

    @Override
    public Task queryActivityTask(String taskId) {
        return processEngine.getTaskService()
                .createTaskQuery()
                .taskId(taskId)
                .orderByTaskCreateTime().asc().singleResult();
    }

    @Override
    public Task queryActivityTaskByProcessInstanceId(String processInstanceId) {
        return processEngine.getTaskService()
                .createTaskQuery()
                .processInstanceId(processInstanceId)
                .orderByTaskCreateTime().asc().singleResult();
    }

    @Override
    public String rollbackLastTask(String taskId) {
        return processCoreService.taskRollback(taskId);
    }

    @Override
    public List<HistoricActivityInstanceCopy> queryRollbackTaskList(String processInstanceId, String currentTaskId) {
        List<HistoricActivityInstanceCopy> tasks = new ArrayList<>();
        Task task = queryActivityTask(currentTaskId);
        if (task != null) {
            List<HistoricActivityInstanceCopy> list = findHistoryActivity(processInstanceId);
            //目前没有好的办法 获取之前的节点。
            //待选节点数
            if ("办公室".equals(task.getName())) {
                if (!CollectionUtils.isEmpty(list)) {
                    tasks.add(list.stream().filter(b -> b.getActivityName().equals("登记")).findFirst().get());
                }
            } else if ("总经理".equals(task.getName())) {
                if (!CollectionUtils.isEmpty(list)) {
                    tasks.add(list.stream().filter(b -> b.getActivityName().equals("登记")).findFirst().get());
                    tasks.add(list.stream().filter(b -> b.getActivityName().equals("办公室")).findFirst().get());
                }
            }
        }
        return tasks;
    }

    @Override
    public void deleteTaskByProcessId(String processId) {
        runtimeService.deleteProcessInstance(processId, "结束");
    }


    @Override
    public InputStream getDiagram(String processInstanceId) {
        //获取历史流程实例
        HistoricProcessInstance processInstance = processEngine.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        //获取流程图
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
        ProcessEngineConfiguration processEngineConfiguration = processEngine.getProcessEngineConfiguration();
        Context.setProcessEngineConfiguration((ProcessEngineConfigurationImpl) processEngineConfiguration);

        ProcessDiagramGenerator diagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();
        ProcessDefinitionEntity definitionEntity = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processInstance.getProcessDefinitionId());

        List<HistoricActivityInstance> highLightedActivitList = processEngine.getHistoryService().createHistoricActivityInstanceQuery().processInstanceId(processInstanceId).list();
        //高亮环节id集合
        List<String> highLightedActivitis = new ArrayList<String>();
        //高亮线路id集合
        List<String> highLightedFlows = getHighLightedFlows(definitionEntity, highLightedActivitList);

        for (HistoricActivityInstance tempActivity : highLightedActivitList) {
            String activityId = tempActivity.getActivityId();
            highLightedActivitis.add(activityId);
        }
        //中文显示的是口口口，设置字体就好了
        InputStream imageStream = diagramGenerator.generateDiagram(bpmnModel, "png", highLightedActivitis, highLightedFlows, "宋体", "宋体", "宋体", null, 1.0);
        //单独返回流程图，不高亮显示
        return imageStream;
    }

    /**
     * 获取需要高亮的线
     *
     * @param processDefinitionEntity
     * @param historicActivityInstances
     * @return
     */

    private List<String> getHighLightedFlows(
            ProcessDefinitionEntity processDefinitionEntity,
            List<HistoricActivityInstance> historicActivityInstances) {
        List<String> highFlows = new ArrayList<String>();// 用以保存高亮的线flowId

        for (int i = 0; i < historicActivityInstances.size() - 1; i++) {// 对历史流程节点进行遍历
            ActivityImpl activityImpl = processDefinitionEntity
                    .findActivity(historicActivityInstances.get(i)
                            .getActivityId());// 得到节点定义的详细信息
            List<ActivityImpl> sameStartTimeNodes = new ArrayList<ActivityImpl>();// 用以保存后需开始时间相同的节点

            ActivityImpl sameActivityImpl1 = processDefinitionEntity
                    .findActivity(historicActivityInstances.get(i + 1)
                            .getActivityId());
            // 将后面第一个节点放在时间相同节点的集合里
            sameStartTimeNodes.add(sameActivityImpl1);

            for (int j = i + 1; j < historicActivityInstances.size() - 1; j++) {

                HistoricActivityInstance activityImpl1 = historicActivityInstances
                        .get(j);// 后续第一个节点
                HistoricActivityInstance activityImpl2 = historicActivityInstances
                        .get(j + 1);// 后续第二个节点
                if (activityImpl1.getStartTime().equals(
                        activityImpl2.getStartTime())) {
                    // 如果第一个节点和第二个节点开始时间相同保存
                    ActivityImpl sameActivityImpl2 = processDefinitionEntity
                            .findActivity(activityImpl2.getActivityId());
                    sameStartTimeNodes.add(sameActivityImpl2);
                } else {
                    // 有不相同跳出循环
                    break;
                }
            }
            List<PvmTransition> pvmTransitions = activityImpl
                    .getOutgoingTransitions();// 取出节点的所有出去的线
            for (PvmTransition pvmTransition : pvmTransitions) {
                // 对所有的线进行遍历
                ActivityImpl pvmActivityImpl = (ActivityImpl) pvmTransition
                        .getDestination();
                // 如果取出的线的目标节点存在时间相同的节点里，保存该线的id，进行高亮显示
                if (sameStartTimeNodes.contains(pvmActivityImpl)) {
                    highFlows.add(pvmTransition.getId());
                }
            }
        }
        return highFlows;

    }

}
