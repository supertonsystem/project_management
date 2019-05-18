package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.Department;
import com.suteng.shiro.business.entity.Resources;
import com.suteng.shiro.business.service.SysDepartmentService;
import com.suteng.shiro.business.service.SysResourcesService;
import com.suteng.shiro.business.vo.DepartmentConditionVO;
import com.suteng.shiro.business.vo.ResourceConditionVO;
import com.suteng.shiro.persistence.beans.SysDepartment;
import com.suteng.shiro.persistence.beans.SysResources;
import com.suteng.shiro.persistence.mapper.SysDepartmentMapper;
import com.suteng.shiro.persistence.mapper.SysResourceMapper;
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
public class SysDepartmentServiceImpl implements SysDepartmentService {

    @Autowired
    private SysDepartmentMapper departmentMapper;

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<Department> findPageBreakByCondition(DepartmentConditionVO vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<SysDepartment> sysDepartments = departmentMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(sysDepartments)) {
            return null;
        }
        List<Department> departments = new ArrayList<>();
        for (SysDepartment d : sysDepartments) {
            departments.add(new Department(d));
        }
        PageInfo bean = new PageInfo<SysDepartment>(sysDepartments);
        bean.setList(departments);
        return bean;
    }

    /**
     * 获取所有可用的菜单资源
     *
     * @return
     */
    @Override
    public List<Department> listAllAvailableMenu() {
        List<SysDepartment> sysResources = departmentMapper.listAllAvailableDepartment();
        return getDepartments(sysResources);
    }

    /**
     * 保存一个实体，null的属性不会保存，会使用数据库默认值
     *
     * @param entity
     * @return
     */
    @Override
    public Department insert(Department entity) {
        Assert.notNull(entity, "Department不可为空！");
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        departmentMapper.insert(entity.getSysDepartment());
        return entity;
    }

    @Override
    public void insertList(List<Department> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<SysDepartment> sysDepartments = new ArrayList<>();
        for (Department department : entities) {
            department.setUpdateTime(new Date());
            department.setCreateTime(new Date());
            sysDepartments.add(department.getSysDepartment());
        }
        departmentMapper.insertList(sysDepartments);
    }

    /**
     * 根据主键字段进行删除，方法参数必须包含完整的主键属性
     *
     * @param primaryKey
     * @return
     */
    @Override
    public boolean removeByPrimaryKey(Long primaryKey) {
        return departmentMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    /**
     * 根据主键更新实体全部字段，null值会被更新
     *
     * @param entity
     * @return
     */
    @Override
    public boolean update(Department entity) {
        Assert.notNull(entity, "Department不可为空！");
        entity.setUpdateTime(new Date());
        return departmentMapper.updateByPrimaryKey(entity.getSysDepartment()) > 0;
    }

    /**
     * 根据主键更新属性不为null的值
     *
     * @param entity
     * @return
     */
    @Override
    public boolean updateSelective(Department entity) {
        Assert.notNull(entity, "Department不可为空！");
        entity.setUpdateTime(new Date());
        return departmentMapper.updateByPrimaryKeySelective(entity.getSysDepartment()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */
    @Override
    public Department getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        SysDepartment sysDepartment = departmentMapper.selectByPrimaryKey(primaryKey);
        return null == sysDepartment ? null : new Department(sysDepartment);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public Department getOneByEntity(Department entity) {
        Assert.notNull(entity, "User不可为空！");
        SysDepartment sysDepartment  = departmentMapper.selectOne(entity.getSysDepartment());
        return null == sysDepartment ? null : new Department(sysDepartment);
    }

    /**
     * 查询全部结果，listByEntity(null)方法能达到同样的效果
     *
     * @return
     */
    @Override
    public List<Department> listAll() {
        List<SysDepartment> sysDepartments = departmentMapper.selectAll();
        return getDepartments(sysDepartments);
    }

    /**
     * 根据实体中的属性值进行查询，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public List<Department> listByEntity(Department entity) {
        Assert.notNull(entity, "Department不可为空！");
        List<SysDepartment> sysDepartments = departmentMapper.select(entity.getSysDepartment());
        return getDepartments(sysDepartments);
    }

    private List<Department> getDepartments(List<SysDepartment> sysDepartments) {
        if (CollectionUtils.isEmpty(sysDepartments)) {
            return null;
        }
        List<Department> departments = new ArrayList<>();
        for (SysDepartment d : sysDepartments) {
            departments.add(new Department(d));
        }
        return departments;
    }
}
