package com.suteng.shiro.framework.config;

import com.suteng.shiro.framework.interceptor.RememberAuthenticationInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @date 2018/7/15 15:03
 * @since 1.0
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private RememberAuthenticationInterceptor rememberAuthenticationInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(rememberAuthenticationInterceptor)
                .excludePathPatterns("/passport/**", "/error/**", "/assets/**", "favicon.ico")
                .addPathPatterns("/**");
    }
}
