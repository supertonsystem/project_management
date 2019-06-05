package com.suteng.shiro.business.util;

import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.util.SpringUtil;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:27 2019/5/24
 */
public class PersonUtil {
    /**
     * 客户信息
     *
     * @param id
     * @return
     */
    public static CustPersonEntity getCustPerson(Long id) {
        CustPersonService custPersonService = (CustPersonService) SpringUtil.getBean("custPersonServiceImpl");
        if (custPersonService != null) {
            return custPersonService.getByPrimaryKey(id);
        }
        return null;
    }

    /**
     * 客户名称
     * @param id
     * @return
     */
    public static String getCustPersonName(Long id) {
        CustPersonEntity entity = getCustPerson(id);
        return entity == null ? "" : entity.getName();
    }

}
