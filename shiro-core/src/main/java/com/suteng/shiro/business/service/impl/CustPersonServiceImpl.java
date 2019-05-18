package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.persistence.beans.CustPerson;
import com.suteng.shiro.persistence.mapper.CustPersonMapper;
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
public class CustPersonServiceImpl implements CustPersonService {

    @Autowired
    private CustPersonMapper custPersonMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CustPersonEntity insert(CustPersonEntity entity) {
        Assert.notNull(entity, "CustInfoEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        custPersonMapper.insertSelective(entity.getCustPerson());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<CustPersonEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<CustPerson> sysUsers = new ArrayList<>();
        for (CustPersonEntity entity : entities) {
            entity.setUpdateTime(new Date());
            entity.setCreateTime(new Date());
            sysUsers.add(entity.getCustPerson());
        }
        custPersonMapper.insertList(sysUsers);
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
        return custPersonMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(CustPersonEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        entity.setUpdateTime(new Date());
        return custPersonMapper.updateByPrimaryKey(entity.getCustPerson()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(CustPersonEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        entity.setUpdateTime(new Date());
        return custPersonMapper.updateByPrimaryKeySelective(entity.getCustPerson()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public CustPersonEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        CustPerson custPerson = custPersonMapper.selectByPrimaryKey(primaryKey);
        return null == custPerson ? null : new CustPersonEntity(custPerson);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public CustPersonEntity getOneByEntity(CustPersonEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        CustPerson custPerson = custPersonMapper.selectOne(entity.getCustPerson());
        return null == custPerson ? null : new CustPersonEntity(custPerson);
    }

    @Override
    public List<CustPersonEntity> listAll() {
        List<CustPerson> custPeople = custPersonMapper.selectAll();
        if (CollectionUtils.isEmpty(custPeople)) {
            return null;
        }
        List<CustPersonEntity> users = new ArrayList<>();
        for (CustPerson custPerson : custPeople) {
            users.add(new CustPersonEntity(custPerson));
        }
        return users;
    }

    @Override
    public List<CustPersonEntity> listByEntity(CustPersonEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        List<CustPerson> custPeople = custPersonMapper.select(entity.getCustPerson());
        if (CollectionUtils.isEmpty(custPeople)) {
            return null;
        }
        List<CustPersonEntity> users = new ArrayList<>();
        for (CustPerson custPerson : custPeople) {
            users.add(new CustPersonEntity(custPerson));
        }
        return users;
    }

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<CustPersonEntity> findPageBreakByCondition(CustPersonConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<CustPerson> custPeople = custPersonMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(custPeople)) {
            return null;
        }
        List<CustPersonEntity> entities = new ArrayList<>();
        for (CustPerson custPerson : custPeople) {
            entities.add(new CustPersonEntity(custPerson));
        }
        PageInfo bean = new PageInfo<CustPerson>(custPeople);
        bean.setList(entities);
        return bean;
    }
}
