package com.suteng.shiro.framework.tag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.suteng.shiro.business.entity.Resources;
import com.suteng.shiro.business.service.SysDepartmentService;
import com.suteng.shiro.business.service.SysResourcesService;
import freemarker.core.Environment;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapperBuilder;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * 自定义的freemarker标签
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Component
public class CustomTagDirective implements TemplateDirectiveModel {
    private static final String METHOD_KEY = "method";
    @Autowired
    private SysResourcesService resourcesService;
    @Autowired
    private SysDepartmentService sysDepartmentService;
    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException {
        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_25);
        if (map.containsKey(METHOD_KEY)) {
            String method = map.get(METHOD_KEY).toString();
            switch (method) {
                case "availableMenus":

                    environment.setVariable("availableMenus", builder.build().wrap(resourcesService.listAllAvailableMenu()));
                    break;
                case "availableDepartments":
                    // 获取所有可用的部门资源
                    environment.setVariable("availableDepartments", builder.build().wrap(sysDepartmentService.listAllAvailableMenu()));
                    break;
                case "menus":
                    // 获取所有可用的菜单资源
                    //Subject currentUser = SecurityUtils.getSubject();
                    //boolean hasRole=currentUser.hasRole("role:custmgt");
                    Integer userId = null;
                    if (map.containsKey("userId")) {
                        String userIdStr = map.get("userId").toString();
                        if(StringUtils.isEmpty(userIdStr)){
                            return;
                        }
                        userId = Integer.parseInt(userIdStr);
                    }
                    Map<String, Object> params = new HashMap<>(2);
                    params.put("type", "menu");
                    params.put("userId", userId);
                    List<Resources> resources=resourcesService.listUserResources(params);
                    environment.setVariable("menus", builder.build().wrap(resources));
                    break;
                default:
                    break;
            }
        }
        templateDirectiveBody.render(environment.getOut());
    }
}
