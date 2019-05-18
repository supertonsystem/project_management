package com.suteng.shiro;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngineConfiguration;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:41 2019/4/24
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = {ShiroAdminApplication.class})// 指定启动类
public class MyWorkDeploy {
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

    //获取下一个节点
    public void getNextNode() {
        String taskId = "105006";

        Task task = processEngine.getTaskService()//与正在执行的任务管理相关的Service
                .createTaskQuery().taskId(taskId)//创建任务查询对象
                .orderByTaskCreateTime().asc().singleResult();
        RepositoryService rs = processEngine.getRepositoryService();
        // 2、然后根据当前任务获取当前流程的流程定义，然后根据流程定义获得所有的节点：
        ProcessDefinitionEntity def = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
                .getDeployedProcessDefinition(task.getProcessDefinitionId());
    }

    /**
     * 查询历史任务
     */
    @Test
    public void findHistoryTask() {
        String processInstanceId = "20003";
        List<HistoricTaskInstance> list = processEngine.getHistoryService()// 与历史数据（历史表）相关的Service
                .createHistoricTaskInstanceQuery()// 创建历史任务实例查询
                .processInstanceId(processInstanceId)//
                .orderByHistoricTaskInstanceStartTime().asc().list();
        if (list != null && list.size() > 0) {
            for (HistoricTaskInstance hti : list) {
                System.out.println("\n 任务Id：" + hti.getId() + "    任务名称：" + hti.getName() + "    流程实例Id：" + hti.getProcessInstanceId() + "\n 开始时间："
                        + hti.getStartTime() + "   结束时间：" + hti.getEndTime() + "   持续时间：" + hti.getDurationInMillis());
            }
        }
    }

    @Test
    public void findHisActivity(){
        String taskId="20026";
        HistoricTaskInstance hisTask = processEngine.getHistoryService().createHistoricTaskInstanceQuery().taskId(taskId).singleResult();
        String processInstanceId="20003";
        //进而获取流程实例
        ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        //取得流程定义
        ProcessDefinitionEntity definition = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(hisTask.getProcessDefinitionId());
        Map<String, TaskDefinition> map=definition.getTaskDefinitions();
        map.clear();
    }

    /**
     * 历史活动查询接口
     */
    @Test
    public void findHistoryActivity() {
        String processInstanceId = "20003";
        List<HistoricActivityInstance> hais = processEngine.getHistoryService()//
                .createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .list();
        for (HistoricActivityInstance hai : hais) {
            System.out.println("活动name：" + hai.getActivityName()
                    + "   审批人：" + hai.getAssignee()
                    + "   任务id：" + hai.getTaskId()
                    + "   任务id：" + hai.getStartTime()
                    + "   任务id：" + hai.getEndTime());
            System.out.println("************************************");
        }
    }


    @Test
    public void deployProcess() {
        RepositoryService repositoryService = processEngine.getRepositoryService();
        // DeploymentBuilder builder = repositoryService.createDeployment();
        // builder.addClasspathResource("processes/learn.bpmn");//bpmn文件的名称
        //// builder.addClasspathResource("learn.bpmn");//bpmn文件的名称
        // Deployment deploy =builder.deploy();

        //获取流程定义
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey("learn").latestVersion().singleResult();
        Map<String, Object> variables = new HashMap<String, Object>();
        variables.put("studentId", "张三峰");
        variables.put("teacherId", "英语");
        //启动流程定义，返回流程实例
        ProcessInstance pi = runtimeService.startProcessInstanceById(processDefinition.getId(), variables);
        String processId = pi.getId();
        System.out.println("流程创建成功，当前流程实例ID：" + processId);

        String assignee = "张三峰";
        List<Task> list = processEngine.getTaskService()//与正在执行的任务管理相关的Service
                .createTaskQuery()//创建任务查询对象
                /**查询条件（where部分）*/
                //               .taskAssignee(assignee)//指定个人任务查询，指定办理人
//                      .taskCandidateUser(candidateUser)//组任务的办理人查询
//                      .processDefinitionId(processDefinitionId)//使用流程定义ID查询
                .processInstanceId(processId)//使用流程实例ID查询
//                      .executionId(executionId)//使用执行对象ID查询
                /**排序*/
                .orderByTaskCreateTime().asc()//使用创建时间的升序排列
                /**返回结果集*/
//                      .singleResult()//返回惟一结果集
//                      .count()//返回结果集的数量
//                      .listPage(firstResult, maxResults);//分页查询
                .list();//返回列表
        if (list != null && list.size() > 0) {
            for (Task task : list) {
                System.out.println("任务ID:" + task.getId());
                System.out.println("任务名称:" + task.getName());
                System.out.println("任务的创建时间:" + task.getCreateTime());
                System.out.println("任务的办理人:" + task.getAssignee());
                System.out.println("流程实例ID：" + task.getProcessInstanceId());
                System.out.println("执行对象ID:" + task.getExecutionId());
                System.out.println("流程定义ID:" + task.getProcessDefinitionId());
                System.out.println("********************************************");
            }
        }


        //TaskCopy task=taskService.createTaskQuery().processInstanceId(processId).singleResult();
        //System.out.println("执行前，任务名称："+task.getName());
        //taskService.complete(task.getId());
        //
        //task = taskService.createTaskQuery().processInstanceId(processId).singleResult();
        //System.out.println("task为"+task.getName()+"，任务执行完毕："+task);
    }

    @Test
    public void findProcessDefinition(){
        List<ProcessDefinition> list = processEngine.getRepositoryService()//与流程定义和部署对象相关的Service
                .createProcessDefinitionQuery()//创建一个流程定义查询
                        /*指定查询条件,where条件*/
                //.deploymentId(deploymentId)//使用部署对象ID查询
                //.processDefinitionId(processDefinitionId)//使用流程定义ID查询
                //.processDefinitionKey(processDefinitionKey)//使用流程定义的KEY查询
                //.processDefinitionNameLike(processDefinitionNameLike)//使用流程定义的名称模糊查询

                        /*排序*/
                .orderByProcessDefinitionVersion().asc()//按照版本的升序排列
                //.orderByProcessDefinitionName().desc()//按照流程定义的名称降序排列

                .list();//返回一个集合列表，封装流程定义
        //.singleResult();//返回唯一结果集
        //.count();//返回结果集数量
        //.listPage(firstResult, maxResults)//分页查询

        if(list != null && list.size()>0){
            for(ProcessDefinition processDefinition:list){
                System.out.println("流程定义ID:"+processDefinition.getId());//流程定义的key+版本+随机生成数
                System.out.println("流程定义名称:"+processDefinition.getName());//对应HelloWorld.bpmn文件中的name属性值
                System.out.println("流程定义的key:"+processDefinition.getKey());//对应HelloWorld.bpmn文件中的id属性值
                System.out.println("流程定义的版本:"+processDefinition.getVersion());//当流程定义的key值相同的情况下，版本升级，默认从1开始
                System.out.println("资源名称bpmn文件:"+processDefinition.getResourceName());
                System.out.println("资源名称png文件:"+processDefinition.getDiagramResourceName());
                System.out.println("部署对象ID:"+processDefinition.getDeploymentId());
                System.out.println("################################");
            }
        }

    }
}
