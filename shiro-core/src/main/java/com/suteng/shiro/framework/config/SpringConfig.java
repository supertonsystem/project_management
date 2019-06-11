package com.suteng.shiro.framework.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 12:12 2019/5/6
 */
@Configuration
public class SpringConfig implements WebMvcConfigurer {
    @Value("${web.person-icon-upload-Uri}")
    private String path;
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //第一个方法设置访问路径前缀，第二个方法设置资源路径icon/
        registry.addResourceHandler("/processes/**").addResourceLocations("classpath:/processes/");
        registry.addResourceHandler("/person/icon/**").addResourceLocations("file:" + path);
    }

}
