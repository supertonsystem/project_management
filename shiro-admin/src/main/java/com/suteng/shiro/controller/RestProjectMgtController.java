package com.suteng.shiro.controller;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.result.ExcelImportResult;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.consts.ProjectConst;
import com.suteng.shiro.business.entity.Department;
import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.entity.ProjectMgtTask;
import com.suteng.shiro.business.entity.User;
import com.suteng.shiro.business.entity.activiti.HistoricActivityInstanceCopy;
import com.suteng.shiro.business.entity.activiti.TaskCopy;
import com.suteng.shiro.business.enums.ProjectMgtStatusEnum;
import com.suteng.shiro.business.enums.ResponseStatus;
import com.suteng.shiro.business.service.ShiroService;
import com.suteng.shiro.business.service.SysUserService;
import com.suteng.shiro.business.service.WorkProjectMgtActivitiService;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.business.util.DepartmentUtil;
import com.suteng.shiro.business.util.UserUtil;
import com.suteng.shiro.business.vo.ProjectMgtConditionVO;
import com.suteng.shiro.framework.easypoi.ExcelUtil;
import com.suteng.shiro.framework.easypoi.bean.ProjectMgtExcel;
import com.suteng.shiro.framework.exception.SupertonActivitiException;
import com.suteng.shiro.framework.object.PageResult;
import com.suteng.shiro.framework.object.ResponseVO;
import com.suteng.shiro.util.ResultUtil;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * 项目流程管理
 *
 * @date 2018/4/24 14:37
 * @since 1.0
 */
@RestController
@RequestMapping("/projectmgt")
public class RestProjectMgtController {

    @Autowired
    private WorkProjectMgtService workProjectMgtService;
    @Autowired
    private WorkProjectMgtActivitiService workProjectMgtActivitiService;
    @Autowired
    ProcessEngine processEngine;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private ShiroService shiroService;
    @Autowired
    private SysUserService userService;

    /**
     * 待办任务
     *
     * @param vo
     * @return
     */

    @RequiresPermissions("projectmgt:agenda")
    @PostMapping("/agendalist")
    public ResponseVO agendalist(ProjectMgt vo) {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        //2、进行中且待办的任务
        List<ProjectMgt> projectMgts = workProjectMgtActivitiService.queryGendaTask(String.valueOf(userId));
        return ResultUtil.success("成功", projectMgts);
    }

    /**
     * 项目列表查询
     *
     * @param vo
     * @return
     */
    @PostMapping("/list")
    public PageResult list(ProjectMgtConditionVO vo) {
        PageInfo<ProjectMgt> projectMgts = workProjectMgtService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(projectMgts);
    }

    /**
     * 我的项目列表查询
     *
     * @param vo
     * @return
     */
    @PostMapping("/mylist")
    public PageResult myList(ProjectMgtConditionVO vo) {
        Long userId = vo.getProjectMgt().getOwnerUserId();
        User user = UserUtil.getUserbyId(userId);
        vo.getProjectMgt().setOwnerDepId(Long.valueOf(user.getDepId()));
        PageInfo<ProjectMgt> projectMgts = workProjectMgtService.findMyPageBreakByCondition(vo);
        return ResultUtil.tablePage(projectMgts);
    }

    @PostMapping("/focuslist")
    public PageResult focusList(ProjectMgtConditionVO vo) {
        PageInfo<ProjectMgt> projectMgts = workProjectMgtService.findPageBreakByCondition(vo);
        return ResultUtil.tablePage(projectMgts);
    }

    @RequiresPermissions(value = {"projectmgt:batchDelete", "projectmgt:delete"}, logical = Logical.OR)
    @PostMapping(value = "/remove")
    public ResponseVO remove(Long[] ids) {
        if (null == ids) {
            return ResultUtil.error(500, "请至少选择一条记录");
        }
        for (Long id : ids) {
            workProjectMgtService.removeByPrimaryKey(id);
        }
        //更新权限
        shiroService.updatePermission();
        return ResultUtil.success("成功删除 [" + ids.length + "] 个项目");
    }

    /**
     * 待办view
     *
     * @param id
     * @return
     */
    @PostMapping("/handle/{id}")
    public ResponseVO handle(@PathVariable Long id) {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        ProjectMgtTask projectMgtTask = new ProjectMgtTask();

        ProjectMgt projectMgt = workProjectMgtService.getByPrimaryKey(id);
        projectMgtTask.setProjectMgt(projectMgt);
        //进行中才获取待办任务信息
        if (projectMgt.getStatus().intValue() == ProjectMgtStatusEnum.PROCEED.getStatus() && StringUtils.isNotEmpty(projectMgt.getWorkProjectMgt().getProcessInstanceId())) {
            Task task = workProjectMgtActivitiService.queryGendaTaskInfo(String.valueOf(userId), String.valueOf(projectMgt.getWorkProjectMgt().getProcessInstanceId()));
            TaskCopy taskCopy = new TaskCopy();
            BeanUtils.copyProperties(task, taskCopy);
            projectMgtTask.setTask(taskCopy);
        }
        return ResultUtil.success(null, projectMgtTask);
    }

    /**
     * 查看view
     *
     * @param id
     * @return
     */
    @PostMapping("/get/{id}")
    public ResponseVO get(@PathVariable Long id) {
        ProjectMgtTask projectMgtTask = new ProjectMgtTask();
        ProjectMgt projectMgt = workProjectMgtService.getByPrimaryKey(id);
        projectMgtTask.setProjectMgt(projectMgt);
        return ResultUtil.success(null, projectMgtTask);
    }

    @RequiresPermissions("projectmgt:edit")
    @PostMapping("/edit")
    public ResponseVO edit(ProjectMgt projectMgt) {
        try {
            workProjectMgtService.updateSelective(projectMgt);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("项目修改失败！");
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }

    /**
     * 首页统计
     *
     * @return
     */
    @PostMapping(value = "/statistics")
    public ResponseVO statistics() {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        JSONObject result = new JSONObject();
        //待办任务
        Integer agendaCount = 0;
        //进行中且待办的项目
        List<ProjectMgt> projectMgts = workProjectMgtActivitiService.queryGendaTask(String.valueOf(userId));
        if (projectMgts != null) {
            agendaCount += projectMgts.size();
        }
        //已结束的任务
        ProjectMgt vo = new ProjectMgt();
        Integer finishCount = 0;
        vo.setStatus(ProjectMgtStatusEnum.FINISH.getStatus());
        //责任人为当前登陆用户
        vo.setOwnerUserId(userId);
        List<ProjectMgt> finish = workProjectMgtService.listByEntity(vo);
        if (finish != null) {
            finishCount += finish.size();
        }
        //已结束
        result.put("finishCount", finishCount);
        //待办
        result.put("agendaCount", agendaCount);
        //今日新增项目
        result.put("todayAddCount", workProjectMgtActivitiService.queryGendaTaskByTodayAdd(String.valueOf(userId)));
        //延期1天的待办项目
        result.put("delayCount", workProjectMgtActivitiService.queryDelayGendaTask(String.valueOf(userId), 1));
        return ResultUtil.success(null, result);
    }

    /**
     * 导入待办的项目
     *
     * @param response
     */
    @RequestMapping("exportExcelByAgenda")
    public void exportExcelByAgenda(HttpServletResponse response) {
        List<ProjectMgt> result = new ArrayList<>();
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        //2、待办的任务
        List<ProjectMgt> projectMgts = workProjectMgtActivitiService.queryGendaTask(String.valueOf(userId));
        if (projectMgts != null) {
            result.addAll(projectMgts);
        }
        List<ProjectMgtExcel> list = new ArrayList<>();
        for (ProjectMgt p : result) {
            ProjectMgtExcel excel = new ProjectMgtExcel();
            try {
                BeanUtils.copyProperties(p.getWorkProjectMgt(), excel);
                excel.setCheckDepName(DepartmentUtil.getDepartmentName(p.getCheckDepId()));
                excel.setOwnerDepName(DepartmentUtil.getDepartmentName(p.getOwnerDepId()));
                excel.setOwnerUserName(UserUtil.getUserName(p.getOwnerUserId()));
                list.add(excel);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //导出操作
        ExcelUtil.exportExcel(list, ProjectMgtExcel.class, "项目管理.xls", response);
    }

    @RequestMapping("exportExcel")
    public void exportExcel(HttpServletResponse response, ProjectMgtConditionVO vo) {
        vo.setSortName("ownerDepId");
        vo.setSortOrder("ASC");
        PageInfo<ProjectMgt> projectMgts = null;
        if (vo.getProjectMgt().getOwnerUserId() != null) {
            User user = UserUtil.getUserbyId(vo.getProjectMgt().getOwnerUserId());
            vo.getProjectMgt().setOwnerDepId(Long.valueOf(user.getDepId()));
            projectMgts = workProjectMgtService.findMyPageBreakByCondition(vo);
        } else {
            projectMgts = workProjectMgtService.findPageBreakByCondition(vo);
        }
        List<ProjectMgtExcel> list = new ArrayList<>();
        if (projectMgts != null) {
            for (ProjectMgt p : projectMgts.getList()) {
                ProjectMgtExcel excel = new ProjectMgtExcel();
                try {
                    BeanUtils.copyProperties(p.getWorkProjectMgt(), excel);
                    excel.setCheckDepName(DepartmentUtil.getDepartmentName(p.getCheckDepId()));
                    excel.setOwnerDepName(DepartmentUtil.getDepartmentName(p.getOwnerDepId()));
                    excel.setOwnerUserName(UserUtil.getUserNickName(p.getOwnerUserId()));
                    list.add(excel);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //导出操作
        ExcelUtil.exportExcel(list, ProjectMgtExcel.class, "项目管理.xls", response);
    }

    @RequestMapping("importExcel")
    public ResponseVO importExcel(@RequestParam("file_data") MultipartFile file) {
        ImportParams importParams = new ImportParams();
        // 数据处理
        importParams.setHeadRows(1);
        importParams.setTitleRows(0);
        // 需要验证
        importParams.setNeedVerfiy(false);
        try {
            Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
            ExcelImportResult<ProjectMgtExcel> result = ExcelImportUtil.importExcelMore(file.getInputStream(), ProjectMgtExcel.class, importParams);
            List<ProjectMgtExcel> pList = result.getList();
            List<ProjectMgt> mgtList = new ArrayList<>();
            for (ProjectMgtExcel p : pList) {
                ProjectMgt entity = new ProjectMgt();
                BeanUtils.copyProperties(p, entity);
                entity.setId(null);//容错处理，存储时id自增
                entity.setRegisterUserId(userId);
                Department ownerDep = DepartmentUtil.getDepartmentbyName(p.getOwnerDepName());
                if (ownerDep == null) {
                    return ResultUtil.error("项目:" + entity.getTitle() + "责任部门不存在");
                }
                entity.setOwnerDepId(ownerDep.getId());
                Department checkDep = DepartmentUtil.getDepartmentbyName(p.getCheckDepName());
                if (checkDep == null) {
                    return ResultUtil.error("项目:" + entity.getTitle() + "核实部门不存在");
                }
                entity.setCheckDepId(checkDep.getId());
                mgtList.add(entity);
            }

            for (ProjectMgt mgt : mgtList) {
                if (mgt.getStatus().intValue() != ProjectMgtStatusEnum.FINISH.getStatus()) {
                    workProjectMgtActivitiService.startWorkProjectMgtProcess(mgt, String.valueOf(mgt.getRegisterUserId()));
                } else {
                    workProjectMgtService.insert(mgt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error(ResponseStatus.ERROR);
        }
        return ResultUtil.success(ResponseStatus.SUCCESS);
    }


    /**
     * 流程开始启动
     *
     * @param projectMgt
     * @return
     */
    @PostMapping(value = "/start")
    public ResponseVO start(ProjectMgt projectMgt, String operatorId) {
        Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
        projectMgt.setRegisterUserId(userId);
        if (StringUtils.isEmpty(operatorId)) {
            operatorId = String.valueOf(userId);
        }
        workProjectMgtActivitiService.startWorkProjectMgtProcess(projectMgt, operatorId);
        return ResultUtil.success("成功");
    }

    @PostMapping(value = "/operatorSelect")
    public ResponseVO operatorSelect(String taskId, Long ownerDepId) {
        List<Map<String, Object>> result = null;
        if (StringUtils.isEmpty(taskId)) {
            //任务未开始，直接提交至部门审批环节
            result = userService.listZtreeByDepartmentId(ownerDepId, 2);
            if (result == null || result.isEmpty()) {
                result = userService.listZtreeByDepartmentId(DepartmentUtil.getDepartmentId(ProjectConst.DEFAULT_DEPARTMENTNAME));
            }
        } else {
            Task task = workProjectMgtActivitiService.queryActivityTask(taskId);
            if ("登记".equals(task.getName())) {
                //部门领导
                result = userService.listZtreeByDepartmentId(ownerDepId, 2);
                if (result == null || result.isEmpty()) {
                    result = userService.listZtreeByDepartmentId(DepartmentUtil.getDepartmentId(ProjectConst.DEFAULT_DEPARTMENTNAME));
                }
            } else if ("部门审批".equals(task.getName())) {
                Department department = DepartmentUtil.getDepartmentbyName("办公室");
                result = userService.listZtreeByDepartmentId(department.getId());
            } else if ("办公室".equals(task.getName())) {
                Department department = DepartmentUtil.getDepartmentbyName("总经理");
                result = userService.listZtreeByDepartmentId(department.getId());
            }
        }

        return ResultUtil.success("成功", result);
    }

    @PostMapping(value = "/complete")
    public ResponseVO complete(ProjectMgt projectMgt, String taskId, String operatorId) {
        try {
            //直接提交至部门审批
            if (projectMgt.getId() == null && StringUtils.isEmpty(taskId)) {
                Long userId = (Long) SecurityUtils.getSubject().getPrincipal();
                projectMgt.setRegisterUserId(userId);
                String pid = workProjectMgtActivitiService.startWorkProjectMgtProcess(projectMgt, String.valueOf(userId));
                Task task = workProjectMgtActivitiService.queryActivityTaskByProcessInstanceId(pid);
                workProjectMgtActivitiService.completeWorkProjectMgtProcess(projectMgt, task, operatorId);
            } else {
                workProjectMgtActivitiService.completeWorkProjectMgtProcess(projectMgt, taskId, operatorId);
            }
        } catch (SupertonActivitiException e) {
            return ResultUtil.error(e.getMessage());
        } catch (Exception e1) {
            e1.printStackTrace();
            return ResultUtil.error("服务器内部错误");
        }
        return ResultUtil.success("成功");
    }

    /**
     * 流程记录
     *
     * @param projectMgtId
     * @return
     */
    @PostMapping(value = "/historicActivity")
    public ResponseVO historicActivity(Long projectMgtId) {
        if (projectMgtId == null) {
            return ResultUtil.error("projectMgtId不能为null");
        }
        JSONObject object = new JSONObject();
        object.put("projectMgtInfo", workProjectMgtService.getByPrimaryKey(projectMgtId));
        List<HistoricActivityInstanceCopy> historicActivityInstances = workProjectMgtActivitiService.findHistoryActivity(projectMgtId);
        object.put("historicActivity", historicActivityInstances);
        return ResultUtil.success(null, object);
    }

    /**
     * 可退回任务列表
     *
     * @param processInstanceId
     * @param currentTaskId
     * @return
     */
    @PostMapping(value = "/rollbackTaskList")
    public ResponseVO rollbackTaskList(String processInstanceId, String currentTaskId) {
        List<HistoricActivityInstanceCopy> tasks = workProjectMgtActivitiService.queryRollbackTaskList(processInstanceId, currentTaskId);
        return ResultUtil.success("", tasks);
    }

    /**
     * 退回节点
     *
     * @param taskId
     * @return
     */
    @PostMapping(value = "/rollback")
    public ResponseVO rollbackLastTask(String taskId) {
        workProjectMgtActivitiService.rollbackLastTask(taskId);
        return ResultUtil.success("");
    }

    @RequestMapping(value = "/image", method = RequestMethod.GET)
    public void image(HttpServletResponse response,
                      @RequestParam String processInstanceId) {
        try {
            InputStream is = workProjectMgtActivitiService.getDiagram(processInstanceId);
            if (is == null) {
                return;
            }
            response.setContentType("image/png");
            BufferedImage image = ImageIO.read(is);
            OutputStream out = response.getOutputStream();
            ImageIO.write(image, "png", out);
            is.close();
            out.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
