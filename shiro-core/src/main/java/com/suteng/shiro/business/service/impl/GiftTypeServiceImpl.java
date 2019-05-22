package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftTypeEntity;
import com.suteng.shiro.business.service.GiftTypeService;
import com.suteng.shiro.business.vo.GiftTypeConditionVo;
import com.suteng.shiro.persistence.beans.GiftType;
import com.suteng.shiro.persistence.mapper.GiftTypeMapper;
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
public class GiftTypeServiceImpl implements GiftTypeService {

    @Autowired
    private GiftTypeMapper giftTypeMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public GiftTypeEntity insert(GiftTypeEntity entity) {
        Assert.notNull(entity, "GiftTypeEntity不可为空！");
        giftTypeMapper.insertSelective(entity.getGiftType());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<GiftTypeEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<GiftType> GiftTypes = new ArrayList<>();
        for (GiftTypeEntity entity : entities) {
            GiftTypes.add(entity.getGiftType());
        }
        giftTypeMapper.insertList(GiftTypes);
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
        return giftTypeMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(GiftTypeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftTypeMapper.updateByPrimaryKey(entity.getGiftType()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(GiftTypeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftTypeMapper.updateByPrimaryKeySelective(entity.getGiftType()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public GiftTypeEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        GiftType giftType = giftTypeMapper.selectByPrimaryKey(primaryKey);
        return null == giftType ? null : new GiftTypeEntity(giftType);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public GiftTypeEntity getOneByEntity(GiftTypeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        GiftType giftType = giftTypeMapper.selectOne(entity.getGiftType());
        return null == giftType ? null : new GiftTypeEntity(giftType);
    }

    @Override
    public List<GiftTypeEntity> listAll() {
        List<GiftType> giftTypes = giftTypeMapper.selectAll();
        if (CollectionUtils.isEmpty(giftTypes)) {
            return null;
        }
        List<GiftTypeEntity> giftTypeEntities = new ArrayList<>();
        for (GiftType giftType : giftTypes) {
            giftTypeEntities.add(new GiftTypeEntity(giftType));
        }
        return giftTypeEntities;
    }

    @Override
    public List<GiftTypeEntity> listByEntity(GiftTypeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        List<GiftType> giftTypes = giftTypeMapper.select(entity.getGiftType());
        if (CollectionUtils.isEmpty(giftTypes)) {
            return null;
        }
        List<GiftTypeEntity> giftTypeEntities = new ArrayList<>();
        for (GiftType giftType : giftTypes) {
            giftTypeEntities.add(new GiftTypeEntity(giftType));
        }
        return giftTypeEntities;
    }

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<GiftTypeEntity> findPageBreakByCondition(GiftTypeConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<GiftType> giftTypes = giftTypeMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(giftTypes)) {
            return null;
        }
        List<GiftTypeEntity> entities = new ArrayList<>();
        for (GiftType GiftType : giftTypes) {
            entities.add(new GiftTypeEntity(GiftType));
        }
        PageInfo bean = new PageInfo<GiftType>(giftTypes);
        bean.setList(entities);
        return bean;
    }
}
