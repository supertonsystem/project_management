package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.enums.ProjectMgtStatusEnum;
import com.suteng.shiro.business.service.WorkProjectMgtActivitiService;
import com.suteng.shiro.business.service.WorkProjectMgtService;
import com.suteng.shiro.business.vo.ProjectMgtConditionVO;
import com.suteng.shiro.persistence.beans.WorkProjectMgt;
import com.suteng.shiro.persistence.mapper.WorkProjectMgtMapper;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

/**
 * 系统资源
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Service
public class WorkProjectMgtServiceImpl implements WorkProjectMgtService {

    @Autowired
    private WorkProjectMgtMapper workProjectMgtMapper;
    @Autowired
    private WorkProjectMgtActivitiService workProjectMgtActivitiService;
    @Autowired
    ProcessEngine processEngine;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<ProjectMgt> findPageBreakByCondition(ProjectMgtConditionVO vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<WorkProjectMgt> workProjectMgts = workProjectMgtMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(workProjectMgts)) {
            return null;
        }
        List<ProjectMgt> projectMgts = new ArrayList<>();
        for (WorkProjectMgt p : workProjectMgts) {
            ProjectMgt m = new ProjectMgt(p);
            if (m.getStatus().intValue() == ProjectMgtStatusEnum.FINISH.getStatus()) {
                m.setTaskName("结束");
            } else {
                Task task = workProjectMgtActivitiService.queryActivityTaskByProcessInstanceId(p.getProcessInstanceId());
                m.setTaskName(task==null?"":task.getName());
            }
            projectMgts.add(m);
        }
        PageInfo bean = new PageInfo<WorkProjectMgt>(workProjectMgts);
        bean.setList(projectMgts);
        return bean;
    }

    @Override
    public PageInfo<ProjectMgt> findMyPageBreakByCondition(ProjectMgtConditionVO vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<WorkProjectMgt> workProjectMgts = workProjectMgtMapper.findMyPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(workProjectMgts)) {
            return null;
        }
        List<ProjectMgt> projectMgts = new ArrayList<>();
        for (WorkProjectMgt p : workProjectMgts) {
            ProjectMgt m = new ProjectMgt(p);
            if (m.getStatus().intValue() == ProjectMgtStatusEnum.FINISH.getStatus()) {
                m.setTaskName("结束");
            } else {
                Task task = workProjectMgtActivitiService.queryActivityTaskByProcessInstanceId(p.getProcessInstanceId());
                m.setTaskName(task==null?"":task.getName());
            }
            projectMgts.add(m);
        }
        PageInfo bean = new PageInfo<WorkProjectMgt>(workProjectMgts);
        bean.setList(projectMgts);
        return bean;
    }

    @Override
    public List<WorkProjectMgt> findByProcessInstanceIds(List<String> ids) {
        return workProjectMgtMapper.findByProcessInstanceIds(ids);
    }


    /**
     * 保存一个实体，null的属性不会保存，会使用数据库默认值
     *
     * @param entity
     * @return
     */
    @Override
    public ProjectMgt insert(ProjectMgt entity) {
        Assert.notNull(entity, "ProjectMgt不可为空！");
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        workProjectMgtMapper.insert(entity.getWorkProjectMgt());
        return entity;
    }

    @Override
    public void insertList(List<ProjectMgt> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<WorkProjectMgt> workProjectMgts = new ArrayList<>();
        for (ProjectMgt projectMgt : entities) {
            projectMgt.setUpdateTime(new Date());
            projectMgt.setCreateTime(new Date());
            workProjectMgts.add(projectMgt.getWorkProjectMgt());
        }
        workProjectMgtMapper.insertList(workProjectMgts);
    }

    /**
     * 根据主键字段进行删除，方法参数必须包含完整的主键属性
     *
     * @param primaryKey
     * @return
     */
    @Override
    public boolean removeByPrimaryKey(Long primaryKey) {
        WorkProjectMgt workProjectMgt= workProjectMgtMapper.selectByPrimaryKey(primaryKey);
        if(workProjectMgt==null){
            return false;
        }
        workProjectMgtActivitiService.deleteTaskByProcessId(workProjectMgt.getProcessInstanceId());
        return workProjectMgtMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    /**
     * 根据主键更新实体全部字段，null值会被更新
     *
     * @param entity
     * @return
     */
    @Override
    public boolean update(ProjectMgt entity) {
        Assert.notNull(entity, "ProjectMgt不可为空！");
        entity.setUpdateTime(new Date());
        return workProjectMgtMapper.updateByPrimaryKey(entity.getWorkProjectMgt()) > 0;
    }

    /**
     * 根据主键更新属性不为null的值
     *
     * @param entity
     * @return
     */
    @Override
    public boolean updateSelective(ProjectMgt entity) {
        Assert.notNull(entity, "Department不可为空！");
        entity.setUpdateTime(new Date());
        return workProjectMgtMapper.updateByPrimaryKeySelective(entity.getWorkProjectMgt()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */
    @Override
    public ProjectMgt getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        WorkProjectMgt workProjectMgt = workProjectMgtMapper.selectByPrimaryKey(primaryKey);
        return null == workProjectMgt ? null : new ProjectMgt(workProjectMgt);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public ProjectMgt getOneByEntity(ProjectMgt entity) {
        Assert.notNull(entity, "ProjectMgt不可为空！");
        WorkProjectMgt workProjectMgt = workProjectMgtMapper.selectOne(entity.getWorkProjectMgt());
        return null == workProjectMgt ? null : new ProjectMgt(workProjectMgt);
    }

    /**
     * 查询全部结果，listByEntity(null)方法能达到同样的效果
     *
     * @return
     */
    @Override
    public List<ProjectMgt> listAll() {
        List<WorkProjectMgt> workProjectMgts = workProjectMgtMapper.selectAll();
        return getProjectMgts(workProjectMgts);
    }

    /**
     * 根据实体中的属性值进行查询，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public List<ProjectMgt> listByEntity(ProjectMgt entity) {
        Assert.notNull(entity, "ProjectMgt不可为空！");
        List<WorkProjectMgt> workProjectMgts = workProjectMgtMapper.select(entity.getWorkProjectMgt());
        return getProjectMgts(workProjectMgts);
    }

    private List<ProjectMgt> getProjectMgts(List<WorkProjectMgt> workProjectMgt) {
        if (CollectionUtils.isEmpty(workProjectMgt)) {
            return null;
        }
        List<ProjectMgt> projectMgts = new ArrayList<>();
        for (WorkProjectMgt w : workProjectMgt) {
            projectMgts.add(new ProjectMgt(w));
        }
        return projectMgts;
    }
}
