package com.suteng.shiro.controller;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.vo.CustPersonConditionVo;
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

    @RequiresPermissions("custmgt:persons")
    @PostMapping("/person/list")
    public PageResult list(CustPersonConditionVo vo) {
        PageInfo<CustPersonEntity> pageInfo = custPersonService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    @RequiresPermissions("custmgt:person:add")
    @PostMapping(value = "/person/add")
    public ResponseVO add(CustPersonEntity entity) {
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
    public ResponseVO remove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            custPersonService.removeByPrimaryKey(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个客户");
    }

    @RequiresPermissions("custmgt:person:edit")
    @PostMapping("/person/get/{id}")
    public ResponseVO get(@PathVariable Long id) {
        return ResultUtil.success(null, this.custPersonService.getByPrimaryKey(id));
    }

    @RequiresPermissions("custmgt:person:edit")
    @PostMapping("/person/edit")
    public ResponseVO edit(CustPersonEntity entity) {
        try {
            custPersonService.updateSelective(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }
}
