package com.suteng.shiro.persistence.mapper;

import com.suteng.shiro.persistence.beans.SysUserRole;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Repository
public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {
    List<Integer> findUserIdByRoleId(Integer roleId);
}
