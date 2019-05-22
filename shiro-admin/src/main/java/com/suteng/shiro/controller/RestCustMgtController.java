package com.suteng.shiro.controller;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.CustContactService;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.service.CustProjectService;
import com.suteng.shiro.business.vo.CustContactConditionVo;
import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.business.vo.CustProjectConditionVo;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.ResultUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 客户管理
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@RestController
@RequestMapping("/custmgt")
public class RestCustMgtController {
    @Autowired
    private CustPersonService custPersonService;
    @Autowired
    private CustProjectService custProjectService;
    @Autowired
    private CustContactService custContactService;


    @RequiresPermissions("custmgt:persons")
    @PostMapping("/person/list")
    public PageResult personList(CustPersonConditionVo vo) {
        PageInfo<CustPersonEntity> pageInfo = custPersonService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("custmgt:person:add")
    @PostMapping(value = "/person/add")
    public ResponseVO personAdd(CustPersonEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            custPersonService.insert(entity);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"custmgt:person:batchDelete", "custmgt:person:delete"}, logical = Logical.OR)
    @PostMapping(value = "/person/remove")
    public ResponseVO personRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custPersonService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个客户信息");
    }

    @RequiresPermissions("custmgt:person:edit")
    @PostMapping("/person/get/{id}")
    public ResponseVO personGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.custPersonService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:person:edit")
    @PostMapping("/person/edit")
    public ResponseVO personEdit(CustPersonEntity entity) {
        try {
            custPersonService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }


    @RequiresPermissions("custmgt:projects")
    @PostMapping("/project/list")
    public PageResult projectList(CustProjectConditionVo vo) {
        PageInfo<CustProjectEntity> pageInfo = custProjectService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("custmgt:project:add")
    @PostMapping(value = "/project/add")
    public ResponseVO projectAdd(CustProjectEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            custProjectService.insert(entity);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"custmgt:project:batchDelete", "custmgt:project:delete"}, logical = Logical.OR)
    @PostMapping(value = "/project/remove")
    public ResponseVO projectRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custProjectService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个项目信息");
    }

    @RequiresPermissions("custmgt:project:edit")
    @PostMapping("/project/get/{id}")
    public ResponseVO projectGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.custProjectService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:project:edit")
    @PostMapping("/project/edit")
    public ResponseVO projectEdit(CustProjectEntity entity) {
        try {
            custProjectService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @RequiresPermissions("custmgt:contacts")
    @PostMapping("/contact/list")
    public PageResult contactList(CustContactConditionVo vo) {
        PageInfo<CustContactEntity> pageInfo = custContactService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("custmgt:contact:add")
    @PostMapping(value = "/contact/add")
    public ResponseVO contactAdd(CustContactEntity entity) {
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            entity.setRegister(userId);
            custContactService.insert(entity);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"custmgt:contact:batchDelete", "custmgt:contact:delete"}, logical = Logical.OR)
    @PostMapping(value = "/contact/remove")
    public ResponseVO contactRemove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custContactService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个联系信息");
    }

    @RequiresPermissions("custmgt:contact:edit")
    @PostMapping("/contact/get/{id}")
    public ResponseVO contactGet(@PathVariable Long id) {
        return ResultUtil.success(null, this.custContactService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:contact:edit")
    @PostMapping("/contact/edit")
    public ResponseVO contactEdit(CustContactEntity entity) {
        try {
            custContactService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }
}
