package com.suteng.shiro.task;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.consts.MailConst;
import com.suteng.shiro.business.consts.RedisConst;
import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.enums.ProjectMgtRemindEnum;
import com.suteng.shiro.business.enums.ProjectMgtStatusEnum;
import com.suteng.shiro.business.service.MailService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.business.vo.ProjectMgtConditionVO;
import com.suteng.shiro.business.vo.UserConditionVO;
import com.suteng.shiro.framework.redis.RedisService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 项目管理邮件提醒定时任务
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 10:32 2019/4/30
 */
@Component
@Configuration
@EnableScheduling
public class ProjectMgtMailTask {
    @Autowired
    RedisService redisService;
    @Autowired
    private WorkProjectMgtService workProjectMgtService;
    @Autowired
    private MailService mailService;
    @Autowired
    private SysUserService userService;

    /**
     * 每小时执行一次
     */
    @Scheduled(cron = "0 0 * * * ?")
    private void task() {
        ProjectMgtConditionVO vo = new ProjectMgtConditionVO();
        //过滤进行中的项目任务
        vo.getProjectMgt().setStatus(ProjectMgtStatusEnum.PROCEED.getStatus());
        PageInfo<ProjectMgt> prjectMgts = workProjectMgtService.findPageBreakByCondition(vo);
        if (prjectMgts != null) {
            for (ProjectMgt projectMgt : prjectMgts.getList()) {
                if (send(projectMgt)) {
                    //如果责任人为空的
                    //则发送部门领导
                    if (projectMgt.getOwnerUserId() == null) {
                        UserConditionVO uv = new UserConditionVO();
                        uv.getUser().setPost(2);
                        uv.getUser().setDepId(projectMgt.getOwnerDepId().intValue());
                        PageInfo<User> users = userService.findPageBreakByCondition(uv);
                        if (users != null && !users.getList().isEmpty()) {
                            for (User user : users.getList()) {
                                String to = StringUtils.isEmpty(user.getEmail()) ? MailConst.MAIL_DEFAULT_TO : user.getEmail();
                                mailService.sendProjectRemind(to, "项目【" + projectMgt.getTitle() + "】到期提醒", projectMgt.getTitle());
                            }
                        }
                    } else {
                        String userIds = projectMgt.getOwnerUserId();
                        String[] userIdArray = userIds.split(",");
                        for (String userId : userIdArray) {
                            User user = userService.getByPrimaryKey(Long.valueOf(userId));
                            String to = StringUtils.isEmpty(user.getEmail()) ? MailConst.MAIL_DEFAULT_TO : user.getEmail();
                            mailService.sendProjectRemind(to, "项目【" + projectMgt.getTitle() + "】到期提醒", projectMgt.getTitle());
                        }
                    }
                }
            }
        }
    }

    /**
     * 处理redis缓存逻辑
     * 截至5天/1天/到期各提醒一次
     *
     * @param projectMgt
     */
    private boolean send(ProjectMgt projectMgt) {
        String hashKey = RedisConst.PROJECTMGT_KEY + projectMgt.getId();
        String id = (String) redisService.hashGet(hashKey, "id");
        String plannedTimeStr = (String) redisService.hashGet(hashKey, "plannedTime");
        //计划时间变更
        boolean change = StringUtils.isEmpty(plannedTimeStr) || projectMgt.getPlannedTime().getTime() != Long.valueOf(plannedTimeStr);
        //首次||过期||计划时间变更
        if (StringUtils.isEmpty(id) || change) {
            Date plannedTime = projectMgt.getPlannedTime();
            if (plannedTime == null) {
                return false;
            }
            if (projectMgt.getFinishTime() == null || projectMgt.getFinishTime().before(plannedTime)) {
                return false;
            }

            Instant instant = plannedTime.toInstant();
            ZoneId zone = ZoneId.systemDefault();
            LocalDateTime localPlannedTime = LocalDateTime.ofInstant(instant, zone);
            int plannedTimeDay = localPlannedTime.getDayOfYear();
            LocalDateTime now = LocalDateTime.now();
            int nowDay = now.getDayOfYear();
            int dif = plannedTimeDay - nowDay;
            boolean info = dif > ProjectMgtRemindEnum.WARNING.getDay() && dif <= ProjectMgtRemindEnum.INFO.getDay();
            boolean warning = dif > ProjectMgtRemindEnum.DANGER.getDay() && dif <= ProjectMgtRemindEnum.WARNING.getDay();
            boolean danger = dif <= ProjectMgtRemindEnum.DANGER.getDay();
            if (info || warning || danger) {
                //计算到期时间
                Long plannedMilli = localPlannedTime.toInstant(ZoneOffset.of("+8")).toEpochMilli();
                Long nowMilli = now.toInstant(ZoneOffset.of("+8")).toEpochMilli();
                Long timeout = plannedMilli - nowMilli - RedisConst.DEFULT_TIMEOUT;
                if (timeout < 0) {
                    //如果已经到期，设置默认到期时间为1天
                    timeout = RedisConst.DEFULT_TIMEOUT;
                }
                redisService.hashPut(hashKey, "id", String.valueOf(projectMgt.getId()));
                redisService.hashPut(hashKey, "plannedTime", String.valueOf(projectMgt.getPlannedTime().getTime()));
                redisService.expire(hashKey, timeout, TimeUnit.MILLISECONDS);
                return true;
            }
        }
        return false;
    }
}
