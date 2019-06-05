package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.suteng.shiro.business.entity.CustProjectRelationEntity;
import com.suteng.shiro.business.service.CustProjectRelationService;
import com.suteng.shiro.persistence.beans.CustProjectRelation;
import com.suteng.shiro.persistence.mapper.CustProjectRelationMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

/**
 * 用户
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Slf4j
@Service
public class CustProjectRelationServiceImpl implements CustProjectRelationService {

    @Autowired
    private CustProjectRelationMapper custProjectRelationMapper;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public CustProjectRelationEntity insert(CustProjectRelationEntity entity) {
        Assert.notNull(entity, "CustProjectRelationEntity不可为空！");
        custProjectRelationMapper.insertSelective(entity.getCustProjectRelation());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<CustProjectRelationEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<CustProjectRelation> sysUsers = new ArrayList<>();
        for (CustProjectRelationEntity entity : entities) {
            sysUsers.add(entity.getCustProjectRelation());
        }
        custProjectRelationMapper.insertList(sysUsers);
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
        return custProjectRelationMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(CustProjectRelationEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return custProjectRelationMapper.updateByPrimaryKey(entity.getCustProjectRelation()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(CustProjectRelationEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return custProjectRelationMapper.updateByPrimaryKeySelective(entity.getCustProjectRelation()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public CustProjectRelationEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        CustProjectRelation custPerson = custProjectRelationMapper.selectByPrimaryKey(primaryKey);
        return null == custPerson ? null : new CustProjectRelationEntity(custPerson);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public CustProjectRelationEntity getOneByEntity(CustProjectRelationEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        CustProjectRelation custPerson = custProjectRelationMapper.selectOne(entity.getCustProjectRelation());
        return null == custPerson ? null : new CustProjectRelationEntity(custPerson);
    }

    @Override
    public List<CustProjectRelationEntity> listAll() {
        List<CustProjectRelation> custPeople = custProjectRelationMapper.selectAll();
        if (CollectionUtils.isEmpty(custPeople)) {
            return null;
        }
        List<CustProjectRelationEntity> users = new ArrayList<>();
        for (CustProjectRelation custPersonRelation : custPeople) {
            users.add(new CustProjectRelationEntity(custPersonRelation));
        }
        return users;
    }

    @Override
    public List<CustProjectRelationEntity> listByEntity(CustProjectRelationEntity entity) {
        List<CustProjectRelationEntity> users = new ArrayList<>();
        Assert.notNull(entity, "entity不可为空！");
        List<CustProjectRelation> custPeople = custProjectRelationMapper.select(entity.getCustProjectRelation());
        if (CollectionUtils.isEmpty(custPeople)) {
            return users;
        }

        for (CustProjectRelation custPersonRelation : custPeople) {
            users.add(new CustProjectRelationEntity(custPersonRelation));
        }
        return users;
    }

    @Override
    public void deleteProjectRelationByPersonId(Long personId) {
        custProjectRelationMapper.deleteProjectRelationByPersonId(personId);
    }

    @Override
    public void deleteProjectRelationByProjectId(Long projectId) {
        custProjectRelationMapper.deleteProjectRelationByProjectId(projectId);
    }

    @Override
    public void deleteProjectRelationByProjectIdAndPersonId(Long personId, Long projectId) {
        custProjectRelationMapper.deleteProjectRelationByProjectIdAndPersonId(personId, projectId);
    }
}
