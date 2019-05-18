package com.suteng.shiro.business.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.Department;
import com.suteng.shiro.business.vo.DepartmentConditionVO;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 系统资源
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface SysDepartmentService extends AbstractService<Department, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<Department> findPageBreakByCondition(DepartmentConditionVO vo);

    /**
     * 获取所有可用的菜单资源
     *
     * @return
     */
    List<Department> listAllAvailableMenu();


}
