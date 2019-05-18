package com.suteng.shiro.framework.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 13:24 2019/4/24
 */
@Configuration
public class DataSourceConfig {
    @Bean(name = "myDataSource")
    @Qualifier("myDataSource")
    @ConfigurationProperties(prefix="spring.datasource")
    public DataSource getMyDataSource(){
        return DataSourceBuilder.create().build();
    }

}
