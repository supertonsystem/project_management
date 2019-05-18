package com.suteng.shiro.business.util;

import java.util.List;

import com.suteng.shiro.business.entity.Department;
import com.suteng.shiro.business.service.SysDepartmentService;
import com.suteng.shiro.util.SpringUtil;

/**
 * 提供静态方法
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 15:34 2019/4/29
 */
public class DepartmentUtil {

    public static Department getDepartmentbyId(long id) {
        SysDepartmentService departmentService = (SysDepartmentService) SpringUtil.getBean("sysDepartmentServiceImpl");
        if (departmentService != null) {
            return departmentService.getByPrimaryKey(id);
        }
        return null;
    }

    /**
     * 如果有重名
     * 默认取第一条
     *
     * @param name
     * @return
     */
    public static Department getDepartmentbyName(String name) {
        SysDepartmentService departmentService = (SysDepartmentService) SpringUtil.getBean("sysDepartmentServiceImpl");
        if (departmentService != null) {
            Department d = new Department();
            d.setName(name);
            List<Department> list = departmentService.listByEntity(d);
            if (list != null) {
                return list.get(0);
            }
        }
        return null;
    }

    /**
     * 根据id返回name
     * @param id
     * @return
     */
    public static String getDepartmentName(Long id) {
        if (id == null) {
            return "";
        }
        Department department = getDepartmentbyId(id);
        return department == null ? "" : department.getName();
    }

    /**
     * 根据name返回id
     * @param name
     * @return
     */
    public static Long getDepartmentId(String name) {
        Department d = getDepartmentbyName(name);
        if (d == null) {
            return null;
        }
        return d.getId();
    }
}
