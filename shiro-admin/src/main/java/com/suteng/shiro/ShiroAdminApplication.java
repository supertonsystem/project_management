
package com.suteng.shiro;

import org.activiti.spring.boot.SecurityAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 程序启动类
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class ShiroAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShiroAdminApplication.class, args);
    }
}
