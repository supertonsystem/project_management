package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.business.service.CustProjectService;
import com.suteng.shiro.business.vo.CustProjectConditionVo;
import com.suteng.shiro.persistence.beans.CustProject;
import com.suteng.shiro.persistence.mapper.CustProjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

/**
 * 项目信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Slf4j
@Service
public class CustProjectServiceImpl implements CustProjectService {

    @Autowired
    private CustProjectMapper custProjectMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CustProjectEntity insert(CustProjectEntity entity) {
        Assert.notNull(entity, "CustProjectEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        custProjectMapper.insertSelective(entity.getCustProject());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<CustProjectEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<CustProject> custProjects = new ArrayList<>();
        for (CustProjectEntity entity : entities) {
            entity.setUpdateTime(new Date());
            entity.setCreateTime(new Date());
            custProjects.add(entity.getCustProject());
        }
        custProjectMapper.insertList(custProjects);
    }

    /**
     * 根据主键字段进行删除，方法参数必须包含完整的主键属性
     *
     * @param primaryKey
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByPrimaryKey(Long primaryKey) {
        return custProjectMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(CustProjectEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        entity.setUpdateTime(new Date());
        return custProjectMapper.updateByPrimaryKey(entity.getCustProject()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(CustProjectEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        entity.setUpdateTime(new Date());
        return custProjectMapper.updateByPrimaryKeySelective(entity.getCustProject()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public CustProjectEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        CustProject custProject = custProjectMapper.selectByPrimaryKey(primaryKey);
        return null == custProject ? null : new CustProjectEntity(custProject);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public CustProjectEntity getOneByEntity(CustProjectEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        CustProject custProject = custProjectMapper.selectOne(entity.getCustProject());
        return null == custProject ? null : new CustProjectEntity(custProject);
    }

    @Override
    public List<CustProjectEntity> listAll() {
        List<CustProject> custProjects = custProjectMapper.selectAll();
        if (CollectionUtils.isEmpty(custProjects)) {
            return null;
        }
        List<CustProjectEntity> custProjectEntities = new ArrayList<>();
        for (CustProject custProject : custProjects) {
            custProjectEntities.add(new CustProjectEntity(custProject));
        }
        return custProjectEntities;
    }

    @Override
    public List<CustProjectEntity> listByEntity(CustProjectEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        List<CustProject> custProjects = custProjectMapper.select(entity.getCustProject());
        if (CollectionUtils.isEmpty(custProjects)) {
            return null;
        }
        List<CustProjectEntity> custProjectEntities = new ArrayList<>();
        for (CustProject custProject : custProjects) {
            custProjectEntities.add(new CustProjectEntity(custProject));
        }
        return custProjectEntities;
    }

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<CustProjectEntity> findPageBreakByCondition(CustProjectConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<CustProject> custProjects = custProjectMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(custProjects)) {
            return null;
        }
        List<CustProjectEntity> entities = new ArrayList<>();
        for (CustProject custProject : custProjects) {
            entities.add(new CustProjectEntity(custProject));
        }
        PageInfo bean = new PageInfo<CustProject>(custProjects);
        bean.setList(entities);
        return bean;
    }
}
