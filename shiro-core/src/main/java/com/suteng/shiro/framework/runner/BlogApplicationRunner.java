package com.suteng.shiro.framework.runner;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

/**
 * 程序启动后通过ApplicationRunner处理一些事务
 *
 * @date 2018/6/6 16:07
 * @since 1.0
 */
@Slf4j
@Component
public class BlogApplicationRunner implements ApplicationRunner {

    @Value("${server.port}")
    private int port;
    @Value("${server.address}")
    private String address;
    @Override
    public void run(ApplicationArguments applicationArguments) {
        log.info("程序部署完成，访问地址：http://"+address+":" + port);
    }
}
