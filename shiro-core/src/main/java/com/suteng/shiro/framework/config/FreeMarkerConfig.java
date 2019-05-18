package com.suteng.shiro.framework.config;

import java.util.HashMap;

import com.jagregory.shiro.freemarker.ShiroTags;
import com.suteng.shiro.business.util.DepartmentUtil;
import com.suteng.shiro.framework.tag.CustomTagDirective;
import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

import javax.annotation.PostConstruct;

/**
 * freemarker配置类
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Configuration
public class FreeMarkerConfig {

    @Autowired
    protected freemarker.template.Configuration configuration;
    @Autowired
    protected CustomTagDirective customTagDirective;
    @Autowired
    protected FreeMarkerViewResolver freeMarkerViewResolver;

    /**
     * 添加自定义标签
     */
    @PostConstruct
    public void setSharedVariable() {
        configuration.setSharedVariable("customTag", customTagDirective);
        //shiro标签
        configuration.setSharedVariable("shiro", new ShiroTags());

        FreemarkerStaticModels staticModels = FreeMarkerConfig.FreemarkerStaticModels.getInstance();
        //设置在模板中调用的名称，和要调用的Java类
        staticModels.setStaticModels("DepartmentUtil", DepartmentUtil.class.getName());
        freeMarkerViewResolver.setAttributesMap(staticModels);
    }


    static class FreemarkerStaticModels extends HashMap<String, Object> {
        private static FreemarkerStaticModels FREEMARKER_STATIC_MODELS;

        private FreemarkerStaticModels() {

        }

        public static FreemarkerStaticModels getInstance() {
            if (FREEMARKER_STATIC_MODELS == null) {
                FREEMARKER_STATIC_MODELS = new FreemarkerStaticModels();
            }
            return FREEMARKER_STATIC_MODELS;
        }

        void setStaticModels(String key, String value) {
            FREEMARKER_STATIC_MODELS.put(key, useStaticPackage(value));
        }

        static TemplateHashModel useStaticPackage(String packageName) {
            try {
                BeansWrapper wrapper = new BeansWrapper(new Version("2.3.28"));
                TemplateHashModel staticModels = wrapper.getStaticModels();
                return (TemplateHashModel) staticModels.get(packageName);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }
    }
}
