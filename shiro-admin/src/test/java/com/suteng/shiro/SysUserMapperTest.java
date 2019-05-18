package com.suteng.shiro;

import java.util.List;

import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.entity.Resources;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.service.SysResourcesService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.util.PasswordUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 11:11 2019/4/26
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes={ShiroAdminApplication.class})// 指定启动类
public class SysUserMapperTest {
    @Autowired
    SysUserService sysUserService;

    @Autowired
    SysResourcesService sysResourcesService;
    @Autowired
    WorkProjectMgtService workProjectMgtService;
    @Test
    public void testUserPassword() throws Exception {
        System.out.println(PasswordUtil.encrypt("123456", "lixue"));
    }
    @Test
    public void getResourceUserById() {
        List<Resources> resources= sysResourcesService.listByUserId(2L);
        System.out.println(resources.get(0));
    }
    @Test
    public void getUserById() {
        Long id = 3L;
        List<User> users= sysUserService.listByRoleId(id);
        System.out.println(users.get(0).getSysUser().getDepartment().getName());
    }

    @Test
    public void getUsersById() {
        Long id = 3L;
        //UserConditionVO vo=new UserConditionVO();
        //vo.getUser().setId(id);
        ////vo.getUser().setDepId(4);
        //PageInfo<User> users= sysUserService.findPageBreakByCondition(vo);
        User entity =new User();
        entity.setId(3L);
        User user=   sysUserService.getOneByEntity(entity);
        System.out.println("----------------------"+user.getId());
    }

    @Test
    public void getProjectMgtById() {
        String id = "132508";
        ProjectMgt entity = new ProjectMgt();
        entity.getWorkProjectMgt().setProcessInstanceId(id);
        //entity.setId(63L);
        ProjectMgt projectMgt = workProjectMgtService.getOneByEntity(entity);
        System.out.println("--------------"+projectMgt.getWorkProjectMgt().getStatus());
    }
}
