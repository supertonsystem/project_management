package com.suteng.shiro;

import java.util.UUID;

import com.suteng.shiro.business.service.MailService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 11:11 2019/4/26
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes={ShiroAdminApplication.class})// 指定启动类
public class MailTest {
    @Autowired
    private MailService mailService;

    @Test
    public void testSend() {
        String to = "453086560@qq.com";
        mailService.sendProjectRemind(to, "模板邮件", UUID.randomUUID().toString().toUpperCase());
    }
}
