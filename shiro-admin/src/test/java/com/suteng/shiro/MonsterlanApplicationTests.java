package com.suteng.shiro;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 12:41 2019/4/24
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes={ShiroAdminApplication.class})// 指定启动类
public class MonsterlanApplicationTests {
    @Autowired
    DataSourceProperties dataSourceProperties;

    @Autowired
    ApplicationContext applicationContext;

    @Test
    public void contextLoads() {
        // 获取配置的数据源
        DataSource dataSource = applicationContext.getBean(DataSource.class);
        // 查看配置数据源信息
        //System.out.println(dataSource);
        //System.out.println(data/Source.getClass().getName());
        System.out.println(dataSourceProperties.getUrl());
    }
}
