package com.suteng.shiro.framework.config;

import tk.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Component;

/**
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Component
@MapperScan("com.suteng.shiro.persistence.mapper")
public class MybatisConfig {
}
