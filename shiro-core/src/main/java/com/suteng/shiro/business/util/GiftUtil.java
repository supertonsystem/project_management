package com.suteng.shiro.business.util;

import com.suteng.shiro.business.entity.GiftRepertoryEntity;
import com.suteng.shiro.business.entity.GiftTypeEntity;
import com.suteng.shiro.business.service.GiftRepertoryService;
import com.suteng.shiro.business.service.GiftTypeService;
import com.suteng.shiro.business.service.impl.GiftRepertoryServiceImpl;
import com.suteng.shiro.business.service.impl.GiftTypeServiceImpl;
import com.suteng.shiro.util.SpringUtil;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 8:36 2019/5/23
 */
public class GiftUtil {
    /**
     * 礼品类型
     * @param id
     * @return
     */
    public static GiftTypeEntity getGiftType(Long id) {
        GiftTypeService giftTypeService = (GiftTypeServiceImpl) SpringUtil.getBean("giftTypeServiceImpl");
        if (giftTypeService != null) {
            return giftTypeService.getByPrimaryKey(id);
        }
        return null;
    }

    /**
     * 返回type
     *
     * @param id
     * @return
     */
    public static String getGiftTypeName(Long id) {
        GiftTypeEntity entity = getGiftType(id);
        if (entity == null) {
            return "";
        }
        return entity.getType();
    }


    public static GiftRepertoryEntity getGiftRepertory(Long id) {
        GiftRepertoryService giftRepertoryService = (GiftRepertoryServiceImpl) SpringUtil.getBean("giftRepertoryServiceImpl");
        if (giftRepertoryService != null) {
            return giftRepertoryService.getByPrimaryKey(id);
        }
        return null;
    }

    /**
     * 返回name
     *
     * @param id
     * @return
     */
    public static String getGiftRepertoryName(Long id) {
        GiftRepertoryEntity entity = getGiftRepertory(id);
        if (entity == null) {
            return "";
        }
        return entity.getName();
    }
}
