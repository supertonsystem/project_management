package com.suteng.shiro.persistence.beans;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SysRoleResources extends AbstractDO {
    private Long roleId;
    private Long resourcesId;
}
