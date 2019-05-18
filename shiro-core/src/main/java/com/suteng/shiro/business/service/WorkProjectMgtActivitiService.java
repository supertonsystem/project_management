package com.suteng.shiro.business.service;


import java.io.InputStream;
import java.util.List;

import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.entity.activiti.HistoricActivityInstanceCopy;
import com.suteng.shiro.framework.exception.SupertonActivitiException;
import org.activiti.engine.task.Task;

/**
 * 流程关联
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface WorkProjectMgtActivitiService {
    /**
     * 根据流程实例ID和用户ID获取待办任务列表
     *
     * @param userId
     * @return
     */
    List<ProjectMgt> queryGendaTask(String userId);

    /**
     * 待办任务信息
     *
     * @param userId
     * @param processInstanceId
     * @return
     */
    Task queryGendaTaskInfo(String userId, String processInstanceId);

    /**
     * 启动流程
     *
     * @param projectMgt
     * @return ProcessInstanceId
     */
    String startWorkProjectMgtProcess(ProjectMgt projectMgt, String operatorId);

    /**
     * 完成任务
     * @param projectMgt
     * @param taskId
     * @param operatorId
     * @throws SupertonActivitiException
     */
    void completeWorkProjectMgtProcess(ProjectMgt projectMgt, String taskId, String operatorId) throws SupertonActivitiException;

    /**
     * 完成任务
     * @param task
     * @param operatorId
     * @throws SupertonActivitiException
     */
    void completeWorkProjectMgtProcess(ProjectMgt projectMgt, Task task, String operatorId) throws SupertonActivitiException;

    /**
     * 根据项目ID
     *
     * @param projectMgtId
     * @return
     */
    List<HistoricActivityInstanceCopy> findHistoryActivity(Long projectMgtId);

    /**
     * 根据流程实例ID
     *
     * @param processInstanceId
     * @return
     */
    List<HistoricActivityInstanceCopy> findHistoryActivity(String processInstanceId);

    /**
     * 今日新增的任务数
     *
     * @param userId
     * @return
     */
    Integer queryGendaTaskByTodayAdd(String userId);

    /**
     * 延期的任务数
     *
     * @param userId
     * @return
     */
    Integer queryDelayGendaTask(String userId, int day);

    InputStream getDiagram(String processInstanceId);

    /**
     * 根据任务ID获取
     * @param taskId
     * @return
     */
    Task queryActivityTask(String taskId);

    /**
     * 根据实例id获取
     * @param processInstanceId
     * @return
     */
    Task queryActivityTaskByProcessInstanceId(String processInstanceId);

    /**
     * 退回至上一个节点
     * @param taskId
     */
    String rollbackLastTask(String taskId);

    /**
     * 查找可退回的节点
     * @param processInstanceId
     * @return
     */
    List<HistoricActivityInstanceCopy> queryRollbackTaskList(String processInstanceId,String currentTaskId);

    /**
     * 结束流程
     * @param processId
     */
    void deleteTaskByProcessId(String processId);
}
