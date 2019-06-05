package com.suteng.shiro.framework.tag;

import java.io.IOException;
import java.util.Map;

import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.service.CustProjectService;
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
public class CustMgtTag implements TemplateDirectiveModel {
    private static final String METHOD_KEY = "method";
    @Autowired
    private CustPersonService custPersonService;

    @Autowired
    private CustProjectService custProjectService;
    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException {
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_25);
        if (map.containsKey(METHOD_KEY)) {
            String method = map.get(METHOD_KEY).toString();

            switch (method) {
                case "person":
                    CustPersonEntity personVo=new  CustPersonEntity();
                    if(map.containsKey("userId")){
                        String userIdStr = map.get("userId").toString();
                        personVo.setRegister(Long.valueOf(userIdStr));
                    }
                    environment.setVariable("persons", builder.build().wrap(custPersonService.listByEntity(personVo)));
                    break;
                case "project":
                    CustProjectEntity projectVo=new CustProjectEntity();
                    if(map.containsKey("userId")){
                        String userIdStr = map.get("userId").toString();
                        projectVo.setRegister(Long.valueOf(userIdStr));
                    }
                    environment.setVariable("projects", builder.build().wrap(custProjectService.listByEntity(projectVo)));
                    break;
                default:
                    break;
            }
        }
        templateDirectiveBody.render(environment.getOut());
    }
}
