package com.suteng.shiro.persistence.beans;

import java.util.List;

import javax.persistence.Transient;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 10:24 2019/4/26
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SysDepartment extends AbstractDO {
    /**
     * 部门名称
     */
    private String name;
    /**
     * 父部门
     */
    private Long parentId;
    /**
     * 排序
     */
    private Integer sort;

    @Transient
    private String checked;
    @Transient
    private SysDepartment parent;
    @Transient
    private List<SysDepartment> nodes;
}
