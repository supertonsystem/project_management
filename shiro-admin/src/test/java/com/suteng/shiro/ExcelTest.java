package com.suteng.shiro;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.business.util.DepartmentUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.business.vo.ProjectMgtConditionVO;
import com.suteng.shiro.framework.easypoi.ExcelUtil;
import com.suteng.shiro.framework.easypoi.bean.ProjectMgtExcel;
import org.apache.commons.beanutils.BeanUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 14:21 2019/4/30
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = {ShiroAdminApplication.class})// 指定启动类
public class ExcelTest {
    @Autowired
    private WorkProjectMgtService workProjectMgtService;

    @Test
    public void exportTest() throws InvocationTargetException, IllegalAccessException {
        ProjectMgtConditionVO vo = new ProjectMgtConditionVO();
        PageInfo<ProjectMgt> projectMgts = workProjectMgtService.findPageBreakByCondition(vo);
        List<ProjectMgtExcel> list=new ArrayList<>();
        for (ProjectMgt p : projectMgts.getList()) {
            ProjectMgtExcel excel=new ProjectMgtExcel();
            BeanUtils.copyProperties(excel,p.getWorkProjectMgt());
            excel.setCheckDepName(DepartmentUtil.getDepartmentName(p.getCheckDepId()));
            excel.setOwnerDepName(DepartmentUtil.getDepartmentName(p.getOwnerDepId()));
            excel.setOwnerUserName(UserUtil.getUserName(p.getOwnerUserId()));
            list.add(excel);
        }
    }

    @Test
    public void importTest() {

    }
}
