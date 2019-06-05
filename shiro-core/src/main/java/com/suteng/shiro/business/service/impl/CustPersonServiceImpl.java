package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.entity.CustPersonRelationEntity;
import com.suteng.shiro.business.entity.CustProjectRelationEntity;
import com.suteng.shiro.business.service.CustContactService;
import com.suteng.shiro.business.service.CustPersonRelationService;
import com.suteng.shiro.business.service.CustPersonService;
import com.suteng.shiro.business.service.CustProjectRelationService;
import com.suteng.shiro.business.service.CustProjectService;
import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.persistence.beans.CustPerson;
import com.suteng.shiro.persistence.mapper.CustPersonMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
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
    @Autowired
    private CustProjectService custProjectService;
    @Autowired
    private CustContactService custContactService;
    @Autowired
    private CustPersonRelationService custPersonRelationervice;
    @Autowired
    private CustProjectRelationService custProjectRelationService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CustPersonEntity insert(CustPersonEntity entity) {
        Assert.notNull(entity, "CustInfoEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        custPersonMapper.insertSelective(entity.getCustPerson());
        addRelation(entity.getId(),entity);
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
        boolean result=custPersonMapper.deleteByPrimaryKey(primaryKey) > 0;
        if(result){
            custProjectRelationService.deleteProjectRelationByPersonId(primaryKey);
            custContactService.deletePersonRelation(primaryKey);
            custPersonRelationervice.deletePersonRelationBySourceId(primaryKey);
        }
        return result;
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
        addRelation(entity.getId(),entity);
        return custPersonMapper.updateByPrimaryKeySelective(entity.getCustPerson()) > 0;
    }

    private void addRelation(Long personId,CustPersonEntity entity){
        if(StringUtils.isNotEmpty(entity.getAddProjectIds())){
            String [] ids=entity.getAddProjectIds().split(",");
            for(String id:ids){
                CustProjectRelationEntity custProjectRelation=new CustProjectRelationEntity();
                custProjectRelation.setPersonId(personId);
                custProjectRelation.setProjectId(Long.valueOf(id));
                custProjectRelationService.insert(custProjectRelation);
            }
        }
        if(StringUtils.isNotEmpty(entity.getAddContactIds())){
            String [] ids=entity.getAddContactIds().split(",");
            for(String id:ids){
                CustContactEntity contactEntity=new CustContactEntity();
                contactEntity.setPersonId(personId);
                contactEntity.setId(Long.valueOf(id));
                custContactService.updateSelective(contactEntity);
            }
        }
        if(StringUtils.isNotEmpty(entity.getAddPersonIds())){
            String [] ids=entity.getAddPersonIds().split(",");
            for(String id:ids){
                CustPersonRelationEntity custPersonRelation=new CustPersonRelationEntity();
                custPersonRelation.setSourceId(personId);
                custPersonRelation.setDestId(Long.valueOf(id));
                custPersonRelationervice.insert(custPersonRelation);
            }
        }

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
        List<CustPersonEntity> users = new ArrayList<>();
        Assert.notNull(entity, "entity不可为空！");
        List<CustPerson> custPeople = custPersonMapper.select(entity.getCustPerson());
        if (CollectionUtils.isEmpty(custPeople)) {
            return users;
        }

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

    @Override
    public PageInfo<CustPersonEntity> findPageChoosePerson(CustPersonConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<CustPerson> custPeople = custPersonMapper.findPageChoosePerson(vo);
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

    @Override
    public PageInfo<CustPersonEntity> findPageChoosePersonByProject(CustPersonConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<CustPerson> custPeople = custPersonMapper.findPageChoosePersonByProject(vo);
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

    @Override
    public List<CustPersonEntity> findPersonRelationList(Long id) {
        List<CustPersonEntity> entities = new ArrayList<>();
        List<CustPerson> custPeople = custPersonMapper.findPersonRelationList(id);
        if (CollectionUtils.isEmpty(custPeople)) {
            return entities;
        }
        for (CustPerson custPerson : custPeople) {
            CustPersonEntity custPersonEntity=new CustPersonEntity(custPerson);
            custPersonEntity.setSourceId(id);
            entities.add(custPersonEntity);
        }
        return entities;
    }

    @Override
    public List<CustPersonEntity> findPersonRelationListByProjectId(Long projectId) {
        List<CustPersonEntity> entities = new ArrayList<>();
        List<CustPerson> custPeople = custPersonMapper.findPersonRelationListByProjectId(projectId);
        if (CollectionUtils.isEmpty(custPeople)) {
            return entities;
        }
        for (CustPerson custPerson : custPeople) {
            CustPersonEntity custPersonEntity=new CustPersonEntity(custPerson);
            custPersonEntity.setCurrProjectId(projectId);
            entities.add(custPersonEntity);
        }
        return entities;
    }

    @Override
    public List<CustPersonEntity> findVisitPersonList(Long userId) {
        List<CustPersonEntity> entities = new ArrayList<>();
        List<CustPerson> custPeople = custPersonMapper.findVisitPersonList(userId);
        if (CollectionUtils.isEmpty(custPeople)) {
            return entities;
        }
        for (CustPerson custPerson : custPeople) {
            CustPersonEntity custPersonEntity=new CustPersonEntity(custPerson);
            entities.add(custPersonEntity);
        }
        return entities;
    }
}
