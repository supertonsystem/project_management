package com.suteng.shiro.controller;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.Department;
import com.suteng.shiro.business.entity.Resources;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.ShiroService;
import com.suteng.shiro.business.service.SysDepartmentService;
import com.suteng.shiro.business.service.SysResourcesService;
import com.suteng.shiro.business.vo.DepartmentConditionVO;
import com.suteng.shiro.business.vo.ResourceConditionVO;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.ResultUtil;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 部门管理
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@RestController
@RequestMapping("/department")
public class RestDepartmentController {

    @Autowired
    private SysDepartmentService departmentService;
    @Autowired
    private ShiroService shiroService;

    @RequiresPermissions("departments")
    @PostMapping("/list")
    public PageResult getAll(DepartmentConditionVO vo) {
        PageInfo<Department> pageInfo = departmentService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("department:add")
    @PostMapping(value = "/add")
    public ResponseVO add(Department department) {
        departmentService.insert(department);
        //更新权限
        shiroService.updatePermission();
        return ResultUtil.success("成功");
    }

    @RequiresPermissions(value = {"department:batchDelete", "department:delete"}, logical = Logical.OR)
    @PostMapping(value = "/remove")
    public ResponseVO remove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            departmentService.removeByPrimaryKey(id);
        }

        //更新权限
        shiroService.updatePermission();
        return ResultUtil.success("成功删除 [" + ids.length + "] 个部门");
    }

    @RequiresPermissions("department:edit")
    @PostMapping("/get/{id}")
    public ResponseVO get(@PathVariable Long id) {
        return ResultUtil.success(null, this.departmentService.getByPrimaryKey(id));
    }

    @RequiresPermissions("department:edit")
    @PostMapping("/edit")
    public ResponseVO edit(Department department) {
        try {
            departmentService.updateSelective(department);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("部门修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }
}
