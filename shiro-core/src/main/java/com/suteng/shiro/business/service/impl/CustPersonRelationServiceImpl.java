package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.suteng.shiro.business.entity.CustPersonRelationEntity;
import com.suteng.shiro.business.service.CustPersonRelationService;
import com.suteng.shiro.persistence.beans.CustPersonRelation;
import com.suteng.shiro.persistence.mapper.CustPersonRelationMapper;
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
public class CustPersonRelationServiceImpl implements CustPersonRelationService {

    @Autowired
    private CustPersonRelationMapper custPersonRelationMapper;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public CustPersonRelationEntity insert(CustPersonRelationEntity entity) {
        Assert.notNull(entity, "CustPersonRelationEntity不可为空！");
        custPersonRelationMapper.insertSelective(entity.getCustPersonRelation());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<CustPersonRelationEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<CustPersonRelation> sysUsers = new ArrayList<>();
        for (CustPersonRelationEntity entity : entities) {
            sysUsers.add(entity.getCustPersonRelation());
        }
        custPersonRelationMapper.insertList(sysUsers);
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
        return custPersonRelationMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(CustPersonRelationEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return custPersonRelationMapper.updateByPrimaryKey(entity.getCustPersonRelation()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(CustPersonRelationEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return custPersonRelationMapper.updateByPrimaryKeySelective(entity.getCustPersonRelation()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public CustPersonRelationEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        CustPersonRelation custPerson = custPersonRelationMapper.selectByPrimaryKey(primaryKey);
        return null == custPerson ? null : new CustPersonRelationEntity(custPerson);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public CustPersonRelationEntity getOneByEntity(CustPersonRelationEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        CustPersonRelation custPerson = custPersonRelationMapper.selectOne(entity.getCustPersonRelation());
        return null == custPerson ? null : new CustPersonRelationEntity(custPerson);
    }

    @Override
    public List<CustPersonRelationEntity> listAll() {
        List<CustPersonRelation> custPeople = custPersonRelationMapper.selectAll();
        if (CollectionUtils.isEmpty(custPeople)) {
            return null;
        }
        List<CustPersonRelationEntity> users = new ArrayList<>();
        for (CustPersonRelation custPersonRelation : custPeople) {
            users.add(new CustPersonRelationEntity(custPersonRelation));
        }
        return users;
    }

    @Override
    public List<CustPersonRelationEntity> listByEntity(CustPersonRelationEntity entity) {
        List<CustPersonRelationEntity> users = new ArrayList<>();
        Assert.notNull(entity, "entity不可为空！");
        List<CustPersonRelation> custPeople = custPersonRelationMapper.select(entity.getCustPersonRelation());
        if (CollectionUtils.isEmpty(custPeople)) {
            return users;
        }

        for (CustPersonRelation custPersonRelation : custPeople) {
            users.add(new CustPersonRelationEntity(custPersonRelation));
        }
        return users;
    }

    @Override
    public void deletePersonRelationBySourceId(Long sourceId) {
        custPersonRelationMapper.deletePersonRelationBySourceId(sourceId);
    }

    @Override
    public void deletePersonRelationByDestId(Long sourceId, Long destId) {
        custPersonRelationMapper.deletePersonRelationByDestId(sourceId, destId);
    }
}
