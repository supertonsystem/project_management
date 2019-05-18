package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.UserConditionVO;
import com.suteng.shiro.persistence.beans.SysUser;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Repository
public interface SysUserMapper extends BaseMapper<SysUser> {

    List<SysUser> findPageBreakByCondition(UserConditionVO vo);

    List<SysUser> listByRoleId(Long roleId);

    List<SysUser> listByDepartmentId(Long depId);
}
