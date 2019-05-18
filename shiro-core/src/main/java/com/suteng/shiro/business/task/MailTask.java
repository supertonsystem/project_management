package com.suteng.shiro.business.task;

import java.util.List;

import com.suteng.shiro.business.consts.MailConst;
import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.entity.activiti.HistoricActivityInstanceCopy;
import com.suteng.shiro.business.service.MailService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.service.WorkProjectMgtActivitiService;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.util.SpringUtil;
import org.apache.commons.lang3.StringUtils;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 17:17 2019/5/10
 */
public class MailTask implements Runnable {
    private String processInstanceId;

    public MailTask(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    @Override
    public void run() {
        WorkProjectMgtService workProjectMgtService = (WorkProjectMgtService) SpringUtil.getBean("workProjectMgtServiceImpl");
        WorkProjectMgtActivitiService workProjectMgtActivitiService = (WorkProjectMgtActivitiService) SpringUtil.getBean("workProjectMgtActivitiServiceImpl");
        MailService mailService = (MailService) SpringUtil.getBean("mailServiceImpl");
        SysUserService sysUserService = (SysUserService) SpringUtil.getBean("sysUserServiceImpl");
        //邮件通知
        try {
            ProjectMgt entity = new ProjectMgt();
            entity.getWorkProjectMgt().setProcessInstanceId(processInstanceId);
            ProjectMgt projectMgt = workProjectMgtService.getOneByEntity(entity);
            if (projectMgt == null) {
                System.out.println("---------------------" + processInstanceId);
            }
            List<HistoricActivityInstanceCopy> historicActivityInstances = workProjectMgtActivitiService.findHistoryActivity(processInstanceId);
            //获取办公室节点处理人发送邮件通知
            Long userId = null;
            for (HistoricActivityInstanceCopy h : historicActivityInstances) {
                if ("办公室".equals(h.getActivityName())) {
                    userId = Long.valueOf(h.getAssignee());
                }
            }
            if (userId == null) {
                return;
            }
            User user = sysUserService.getByPrimaryKey(userId);
            String to = StringUtils.isEmpty(user.getEmail()) ? MailConst.MAIL_DEFAULT_TO : user.getEmail();
            mailService.sendProjectFinishRemind(to, "项目【" + projectMgt.getTitle() + "】已结束", projectMgt.getTitle());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
