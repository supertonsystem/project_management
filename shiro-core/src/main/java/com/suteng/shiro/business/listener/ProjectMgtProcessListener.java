package com.suteng.shiro.business.listener;

import com.suteng.shiro.business.task.MailTask;
import com.suteng.shiro.business.thread.ThreadPoolManager;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;

/**
 * 项目管理工作流监听
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 16:09 2019/5/6
 */
public class ProjectMgtProcessListener implements ExecutionListener {
    @Override
    public void notify(DelegateExecution delegateExecution) {
        String eventName = delegateExecution.getEventName();
        String processInstanceId = delegateExecution.getProcessInstanceId();
        if ("start".equals(eventName)) {
            //暂无业务需要
        } else if ("end".equals(eventName)) {
            ThreadPoolManager.getsInstance().execute(new MailTask(processInstanceId));
        }
    }
}
