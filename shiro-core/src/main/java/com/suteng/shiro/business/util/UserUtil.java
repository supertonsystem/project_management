package com.suteng.shiro.business.util;

import java.util.List;

import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.service.impl.SysUserServiceImpl;
import com.suteng.shiro.util.SpringUtil;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 16:26 2019/4/29
 */
public class UserUtil {

    public static User getUserbyId(long id) {
        SysUserService sysUserServiceImpl = (SysUserServiceImpl) SpringUtil.getBean("sysUserServiceImpl");
        if (sysUserServiceImpl != null) {
            return sysUserServiceImpl.getByPrimaryKey(id);
        }
        return null;
    }

    /**
     * 如果有重名
     * 默认取第一个
     * @param username
     * @return
     */
    public static User getUserbyName(String username) {
        SysUserService sysUserServiceImpl = (SysUserServiceImpl) SpringUtil.getBean("sysUserServiceImpl");
        if (sysUserServiceImpl != null) {
            User u=new User();
            u.setUsername(username);
            List<User> users= sysUserServiceImpl.listByEntity(u);
            if(users!=null){
                return users.get(0);
            }
        }
        return null;
    }

    /**
     * 如果有重名
     * 默认取第一个
     * @param nickName
     * @return
     */
    public static User getUserbyNickName(String nickName) {
        SysUserService sysUserServiceImpl = (SysUserServiceImpl) SpringUtil.getBean("sysUserServiceImpl");
        if (sysUserServiceImpl != null) {
            User u=new User();
            u.setNickname(nickName);
            List<User> users= sysUserServiceImpl.listByEntity(u);
            if(users!=null){
                return users.get(0);
            }
        }
        return null;
    }
    /**
     * 根据id返回name
     * @param id
     * @return
     */
    public static String getUserName(Long id){
        if(id==null){
            return "";
        }
        User user=getUserbyId(id);
        return user==null?"":user.getUsername();
    }

    /**
     * 根据id返回name
     * @param id
     * @return
     */
    public static String getUserNickName(Long id){
        if(id==null){
            return "";
        }
        User user=getUserbyId(id);
        return user==null?"":user.getNickname();
    }

    /**
     * 根据name返回id
     * @param username
     * @return
     */
    public static Long getUserId(String username){
        User user=getUserbyName(username);
        return user==null?null:user.getId();
    }
}
