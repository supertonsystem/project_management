package com.suteng.shiro.controller;

import java.util.ArrayList;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.SysUserRoleService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.vo.UserConditionVO;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.PasswordUtil;
import com.suteng.shiro.util.ResultUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户管理
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@RestController
@RequestMapping("/user")
public class RestUserController {
    @Autowired
    private SysUserService userService;
    @Autowired
    private SysUserRoleService userRoleService;

    @RequiresPermissions("users")
    @PostMapping("/list")
    public PageResult list(UserConditionVO vo) {
        PageInfo<User> pageInfo = userService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(pageInfo);
    }

    /**
     * ajaxList请求
     *
     * @param vo
     * @return
     */
    @PostMapping("/ajaxlist")
    public ResponseVO listByAjax(UserConditionVO vo,String searchKey,String searchValue) {
        //selectPage.js参数专用
        if(searchValue!=null){
            if("id".equals(searchKey)){
                if(searchValue.indexOf(",")>0){
                    vo.setUserIds(searchValue);
                }else{
                    vo.getUser().setId(Long.valueOf(searchValue));
                }
            }
        }
        PageInfo<User> pageInfo = userService.findPageBreakByCondition(vo);
        JSONObject result = new JSONObject();
        result.put("totalRow", pageInfo == null ? 0 : pageInfo.getTotal());
        result.put("list", pageInfo == null ? new ArrayList<>() : pageInfo.getList());
        return ResultUtil.success(null, result);
    }

    /**
     * 保存用户角色
     *
     * @param userId
     * @param roleIds 用户角色
     *                此处获取的参数的角色id是以 “,” 分隔的字符串
     * @return
     */
    @RequiresPermissions("user:allotRole")
    @PostMapping("/saveUserRoles")
    public ResponseVO saveUserRoles(Long userId, String roleIds) {
        if (StringUtils.isEmpty(userId)) {
            return ResultUtil.error("error");
        }
        userRoleService.addUserRole(userId, roleIds);
        return ResultUtil.success("成功");
    }

    @RequiresPermissions("user:add")
    @PostMapping(value = "/add")
    public ResponseVO add(User user) {
        User u = userService.getByUserName(user.getUsername());
        if (u != null) {
            return ResultUtil.error("该用户名[" + user.getUsername() + "]已存在！请更改用户名");
        }
        try {
            user.setPassword(PasswordUtil.encrypt(user.getPassword(), user.getUsername()));
            userService.insert(user);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }

    @RequiresPermissions(value = {"user:batchDelete", "user:delete"}, logical = Logical.OR)
    @PostMapping(value = "/remove")
    public ResponseVO remove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            userService.removeByPrimaryKey(id);
            userRoleService.removeByUserId(id);
        }
        return ResultUtil.success("成功删除 [" + ids.length + "] 个用户");
    }

    @RequiresPermissions("user:edit")
    @PostMapping("/get/{id}")
    public ResponseVO get(@PathVariable Long id) {
        return ResultUtil.success(null, this.userService.getByPrimaryKey(id));
    }

    @RequiresPermissions("user:edit")
    @PostMapping("/edit")
    public ResponseVO edit(User user) {
        try {
            userService.updateSelective(user);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("用户修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    @PostMapping(value = "/updatePwd")
    public ResponseVO updatePwd(@RequestParam(name = "oldPwd")String oldPwd, @RequestParam(name = "newPwd")String newPwd) {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        User u = userService.getByPrimaryKey(userId);
        if (u == null) {
            return ResultUtil.error("该用户名不存在！");
        }
        try {
            String encryptPwd=PasswordUtil.encrypt(oldPwd, u.getUsername());
            if(!encryptPwd.equals(u.getPassword())){
                return ResultUtil.error("原密码不正确");
            }
            u.setPassword(newPwd);
            userService.updateSelective(u);
            return ResultUtil.success("成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("error");
        }
    }
}
