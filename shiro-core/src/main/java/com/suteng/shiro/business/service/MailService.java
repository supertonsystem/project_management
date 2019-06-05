package com.suteng.shiro.business.service;

import java.util.Date;

/**
 * 邮箱
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface MailService{
    /**
     * 项目管理到期提醒
     * @param to
     * @param subject
     * @param text
     */
    void sendProjectRemind(String to,String subject,String text);
    /**
     * 客户拜访提醒
     * @param to
     * @param subject
     * @param personName
     */
    void sendPersonVisitRemind(String to, String subject, String personName, Date visitTime);
    /**
     * 项目管理完成提醒
     * @param to
     * @param subject
     * @param text
     */
    void sendProjectFinishRemind(String to,String subject,String text);

}
