package com.suteng.shiro.business.service;

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
     * 项目管理完成提醒
     * @param to
     * @param subject
     * @param text
     */
    void sendProjectFinishRemind(String to,String subject,String text);

}
