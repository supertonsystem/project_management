package com.suteng.shiro.business.service.impl;

import java.io.StringWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import com.suteng.shiro.business.service.MailService;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:55 2019/4/30
 */
@Service
public class MailServiceImpl implements MailService {
    @Autowired
    private JavaMailSender mailSender;

    /**
     * 用来发送模版邮件
     */
    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @Value("${spring.mail.username}")
    private String from;

    @Override
    public void sendProjectRemind(String to, String subject, String text) {
        String emailContent = "";
        Map<String, String> dataModel = new HashMap();
        dataModel.put("project", text);
        Configuration configuration = freeMarkerConfigurer.getConfiguration();
        try {
            Template template = configuration.getTemplate("mail/projectRemindMail.ftl");
            StringWriter writer = new StringWriter();
            template.process(dataModel, writer);
            emailContent = writer.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        MimeMessage message = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(from);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(emailContent, true);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        mailSender.send(message);
    }

    @Override
    public void sendPersonVisitRemind(String to, String subject, String personName, Date visitTime) {
        String emailContent = "";
        Map<String, String> dataModel = new HashMap();
        dataModel.put("personName", personName);
        dataModel.put("visitTime", DateFormatUtils.format(visitTime,"yyyy-MM-dd"));
        Configuration configuration = freeMarkerConfigurer.getConfiguration();
        try {
            Template template = configuration.getTemplate("mail/personVisitRemindMail.ftl");
            StringWriter writer = new StringWriter();
            template.process(dataModel, writer);
            emailContent = writer.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        MimeMessage message = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(from);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(emailContent, true);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        mailSender.send(message);
    }

    @Override
    public void sendProjectFinishRemind(String to, String subject, String text) {
        String emailContent = "";
        Map<String, String> dataModel = new HashMap();
        dataModel.put("project", text);
        Configuration configuration = freeMarkerConfigurer.getConfiguration();
        try {
            Template template = configuration.getTemplate("mail/projectFinishMail.ftl");
            StringWriter writer = new StringWriter();
            template.process(dataModel, writer);
            emailContent = writer.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        MimeMessage message = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(from);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(emailContent, true);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        mailSender.send(message);
    }
}
