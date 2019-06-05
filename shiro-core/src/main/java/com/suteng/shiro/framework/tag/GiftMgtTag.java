package com.suteng.shiro.framework.tag;

import java.io.IOException;
import java.util.Map;

import com.suteng.shiro.business.service.GiftRepertoryService;
import com.suteng.shiro.business.service.GiftTypeService;
import freemarker.core.Environment;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapperBuilder;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 自定义的freemarker标签
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Component
public class GiftMgtTag implements TemplateDirectiveModel {
    private static final String METHOD_KEY = "method";
    @Autowired
    private GiftTypeService giftTypeService;

    @Autowired
    private GiftRepertoryService giftRepertoryService;
    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException {
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_25);
        if (map.containsKey(METHOD_KEY)) {
            String method = map.get(METHOD_KEY).toString();
            switch (method) {
                case "type":
                    environment.setVariable("types", builder.build().wrap(giftTypeService.listAll()));
                    break;
                case "repertory":
                    environment.setVariable("repertorys", builder.build().wrap(giftRepertoryService.listAll()));
                    break;
                default:
                    break;
            }
        }
        templateDirectiveBody.render(environment.getOut());
    }
}
