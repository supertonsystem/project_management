package com.suteng.shiro.business.service;


import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.vo.UserConditionVO;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 用户
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface SysUserService extends AbstractService<User, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<User> findPageBreakByCondition(UserConditionVO vo);

    /**
     * 更新用户最后一次登录的状态信息
     *
     * @param user
     * @return
     */
    User updateUserLastLoginInfo(User user);

    /**
     * 根据用户名查找
     *
     * @param userName
     * @return
     */
    User getByUserName(String userName);

    /**
     * 通过角色Id获取用户列表
     *
     * @param roleId
     * @return
     */
    List<User> listByRoleId(Long roleId);

    /**
     *  获取ztree使用的部门用户列表
     * @param depId
     * @return
     */
    List<Map<String, Object>> listZtreeByDepartmentId(Long depId);

    /**
     * 根据职位
     * 返回用户树结构
     * @param depId
     * @param post
     * @return
     */
    public List<Map<String, Object>> listZtreeByDepartmentId(Long depId,int post);

}
