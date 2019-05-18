package com.suteng.shiro.persistence.beans;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Transient;

/**
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SysRole extends AbstractDO {
    private String name;
    private String description;
    private Boolean available;

    @Transient
    private Integer selected;
}
