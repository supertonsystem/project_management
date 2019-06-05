package com.suteng.shiro.business.util;

import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.business.service.CustProjectService;
import com.suteng.shiro.util.SpringUtil;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:27 2019/5/24
 */
public class ProjectUtil {
    /**
     * 项目信息
     *
     * @param id
     * @return
     */
    public static CustProjectEntity getCustProject(Long id) {
        CustProjectService custProjectService = (CustProjectService) SpringUtil.getBean("custProjectServiceImpl");
        if (custProjectService != null) {
            return custProjectService.getByPrimaryKey(id);
        }
        return null;
    }

    /**
     * 项目名称
     * @param id
     * @return
     */
    public static String getCustProjectName(Long id) {
        CustProjectEntity entity = getCustProject(id);
        return entity == null ? "" : entity.getName();
    }

}
