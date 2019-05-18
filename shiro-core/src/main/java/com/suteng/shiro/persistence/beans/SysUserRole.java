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
public class SysUserRole extends AbstractDO {
    private Long userId;
    private Long roleId;
}
