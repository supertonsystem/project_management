package com.suteng.shiro;

import java.util.UUID;

import com.suteng.shiro.business.service.MailService;
import com.suteng.shiro.framework.redis.RedisService;
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
public class RedisTest {
    @Autowired
    RedisService redisService;

    @Test
    public void testSet()  {
        redisService.setValue("key","hello");
    }


    @Test
    public void testGet()  {
        System.out.println("get key value:"+ redisService.getValue("key"));
    }
}
