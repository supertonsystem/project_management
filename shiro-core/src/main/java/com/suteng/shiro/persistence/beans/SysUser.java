package com.suteng.shiro.persistence.beans;

import java.util.Date;

import javax.persistence.Transient;

import com.suteng.shiro.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @version 1.0
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SysUser extends AbstractDO {
    private String username;
    private String password;
    private String nickname;
    //职位 1:员工 2：领导
    private Integer post;
    private String mobile;
    private String email;
    private String qq;
    private Date birthday;
    private Integer gender;
    private String avatar;
    private String userType;
    private String regIp;
    private String lastLoginIp;
    private Date lastLoginTime;
    private Integer loginCount;
    private String remark;
    private Integer status;
    private Integer depId;

    @Transient
    private SysDepartment department;
}
