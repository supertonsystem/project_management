package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.business.service.CustContactService;
import com.suteng.shiro.business.vo.CustContactConditionVo;
import com.suteng.shiro.persistence.beans.CustContact;
import com.suteng.shiro.persistence.mapper.CustContactMapper;
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
public class CustContactServiceImpl implements CustContactService {

    @Autowired
    private CustContactMapper CustContactMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CustContactEntity insert(CustContactEntity entity) {
        Assert.notNull(entity, "CustContactEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        CustContactMapper.insertSelective(entity.getCustContact());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<CustContactEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<CustContact> CustContacts = new ArrayList<>();
        for (CustContactEntity entity : entities) {
            entity.setUpdateTime(new Date());
            entity.setCreateTime(new Date());
            CustContacts.add(entity.getCustContact());
        }
        CustContactMapper.insertList(CustContacts);
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
        return CustContactMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(CustContactEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        entity.setUpdateTime(new Date());
        return CustContactMapper.updateByPrimaryKey(entity.getCustContact()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(CustContactEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        entity.setUpdateTime(new Date());
        return CustContactMapper.updateByPrimaryKeySelective(entity.getCustContact()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public CustContactEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        CustContact CustContact = CustContactMapper.selectByPrimaryKey(primaryKey);
        return null == CustContact ? null : new CustContactEntity(CustContact);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public CustContactEntity getOneByEntity(CustContactEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        CustContact CustContact = CustContactMapper.selectOne(entity.getCustContact());
        return null == CustContact ? null : new CustContactEntity(CustContact);
    }

    @Override
    public List<CustContactEntity> listAll() {
        List<CustContact> CustContacts = CustContactMapper.selectAll();
        if (CollectionUtils.isEmpty(CustContacts)) {
            return null;
        }
        List<CustContactEntity> CustContactEntities = new ArrayList<>();
        for (CustContact CustContact : CustContacts) {
            CustContactEntities.add(new CustContactEntity(CustContact));
        }
        return CustContactEntities;
    }

    @Override
    public List<CustContactEntity> listByEntity(CustContactEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        List<CustContact> CustContacts = CustContactMapper.select(entity.getCustContact());
        if (CollectionUtils.isEmpty(CustContacts)) {
            return null;
        }
        List<CustContactEntity> CustContactEntities = new ArrayList<>();
        for (CustContact CustContact : CustContacts) {
            CustContactEntities.add(new CustContactEntity(CustContact));
        }
        return CustContactEntities;
    }

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<CustContactEntity> findPageBreakByCondition(CustContactConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<CustContact> CustContacts = CustContactMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(CustContacts)) {
            return null;
        }
        List<CustContactEntity> entities = new ArrayList<>();
        for (CustContact CustContact : CustContacts) {
            entities.add(new CustContactEntity(CustContact));
        }
        PageInfo bean = new PageInfo<CustContact>(CustContacts);
        bean.setList(entities);
        return bean;
    }
}
