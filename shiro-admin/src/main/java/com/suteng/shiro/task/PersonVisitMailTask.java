package com.suteng.shiro.task;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import com.suteng.shiro.business.consts.MailConst;
import com.suteng.shiro.business.consts.RedisConst;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.service.MailService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.framework.redis.RedisService;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
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
public class PersonVisitMailTask {
    @Autowired
    RedisService redisService;
    @Autowired
    private CustPersonService custPersonService;
    @Autowired
    private MailService mailService;
    @Autowired
    private SysUserService userService;

    /**
     * 每小时执行一次
     */
    @Scheduled(cron = "0 0 * * * ?")
    private void task() {
        List<CustPersonEntity> custPersonEntityList = custPersonService.listAll();
        if (custPersonEntityList != null && !custPersonEntityList.isEmpty()) {
            for (CustPersonEntity custPersonEntity : custPersonEntityList) {
                if (send(custPersonEntity)) {
                    Long userId = custPersonEntity.getRegister();
                    User user = userService.getByPrimaryKey(userId);
                    if (user != null) {
                        String to = StringUtils.isEmpty(user.getEmail()) ? MailConst.MAIL_DEFAULT_TO : user.getEmail();
                        mailService.sendPersonVisitRemind(to, "客户拜访提醒", custPersonEntity.getName(), custPersonEntity.getVisitTime());
                    }
                }
            }
        }
    }

    /**
     * 处理redis缓存逻辑
     * 截至5天/1天/到期各提醒一次
     *
     * @param custPersonEntity
     */
    private boolean send(CustPersonEntity custPersonEntity) {
        if (custPersonEntity.getVisitTime() == null) {
            return false;
        }
        ///提早一天提醒
        boolean sammDaty = DateUtils.isSameDay(DateUtils.addDays(new Date(), 1), custPersonEntity.getVisitTime());
        if (!sammDaty) {
            return false;
        }
        String hashKey = RedisConst.PERSON_VISIT_KEY + custPersonEntity.getId();
        String id = (String) redisService.hashGet(hashKey, "id");
        if (StringUtils.isEmpty(id)) {
            redisService.hashPut(hashKey, "id", String.valueOf(custPersonEntity.getId()));
            redisService.expire(hashKey, RedisConst.DEFULT_TIMEOUT, TimeUnit.MILLISECONDS);
            return true;
        }
        return false;
    }
}
