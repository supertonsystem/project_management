package com.suteng.shiro.persistence.beans;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;

/**
 * 联系信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:19 2019/5/17
 */
@Data
public class SysConfig extends AbstractDO {
   private String name;
   private String code;
   private String value;


}

