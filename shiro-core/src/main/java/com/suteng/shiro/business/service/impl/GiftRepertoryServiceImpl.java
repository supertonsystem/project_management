package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftRepertoryEntity;
import com.suteng.shiro.business.service.GiftRepertoryService;
import com.suteng.shiro.business.vo.GiftRepertoryConditionVo;
import com.suteng.shiro.persistence.beans.GiftRepertory;
import com.suteng.shiro.persistence.mapper.GiftRepertoryMapper;
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
public class GiftRepertoryServiceImpl implements GiftRepertoryService {

    @Autowired
    private GiftRepertoryMapper giftRepertoryMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public GiftRepertoryEntity insert(GiftRepertoryEntity entity) {
        Assert.notNull(entity, "GiftRepertoryEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        giftRepertoryMapper.insertSelective(entity.getGiftRepertory());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<GiftRepertoryEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<GiftRepertory> GiftRepertorys = new ArrayList<>();
        for (GiftRepertoryEntity entity : entities) {
            entity.setUpdateTime(new Date());
            entity.setCreateTime(new Date());
            GiftRepertorys.add(entity.getGiftRepertory());
        }
        giftRepertoryMapper.insertList(GiftRepertorys);
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
        return giftRepertoryMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(GiftRepertoryEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftRepertoryMapper.updateByPrimaryKey(entity.getGiftRepertory()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(GiftRepertoryEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftRepertoryMapper.updateByPrimaryKeySelective(entity.getGiftRepertory()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public GiftRepertoryEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        GiftRepertory giftRepertory = giftRepertoryMapper.selectByPrimaryKey(primaryKey);
        return null == giftRepertory ? null : new GiftRepertoryEntity(giftRepertory);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public GiftRepertoryEntity getOneByEntity(GiftRepertoryEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        GiftRepertory giftRepertory = giftRepertoryMapper.selectOne(entity.getGiftRepertory());
        return null == giftRepertory ? null : new GiftRepertoryEntity(giftRepertory);
    }

    @Override
    public List<GiftRepertoryEntity> listAll() {
        List<GiftRepertory> giftRepertorys = giftRepertoryMapper.selectAll();
        if (CollectionUtils.isEmpty(giftRepertorys)) {
            return null;
        }
        List<GiftRepertoryEntity> giftRepertoryEntities = new ArrayList<>();
        for (GiftRepertory giftRepertory : giftRepertorys) {
            giftRepertoryEntities.add(new GiftRepertoryEntity(giftRepertory));
        }
        return giftRepertoryEntities;
    }

    @Override
    public List<GiftRepertoryEntity> listByEntity(GiftRepertoryEntity entity) {
        List<GiftRepertoryEntity> giftRepertoryEntities = new ArrayList<>();
        Assert.notNull(entity, "entity不可为空！");
        List<GiftRepertory> giftRepertorys = giftRepertoryMapper.select(entity.getGiftRepertory());
        if (CollectionUtils.isEmpty(giftRepertorys)) {
            return giftRepertoryEntities;
        }

        for (GiftRepertory giftRepertory : giftRepertorys) {
            giftRepertoryEntities.add(new GiftRepertoryEntity(giftRepertory));
        }
        return giftRepertoryEntities;
    }

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<GiftRepertoryEntity> findPageBreakByCondition(GiftRepertoryConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<GiftRepertory> giftRepertorys = giftRepertoryMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(giftRepertorys)) {
            return null;
        }
        List<GiftRepertoryEntity> entities = new ArrayList<>();
        for (GiftRepertory GiftRepertory : giftRepertorys) {
            entities.add(new GiftRepertoryEntity(GiftRepertory));
        }
        PageInfo bean = new PageInfo<GiftRepertory>(giftRepertorys);
        bean.setList(entities);
        return bean;
    }

    @Override
    public List<GiftRepertoryEntity> availableRepertoryList() {
        List<GiftRepertoryEntity> giftRepertoryEntities = new ArrayList<>();
        List<GiftRepertory> giftRepertorys = giftRepertoryMapper.availableRepertoryList();
        if (CollectionUtils.isEmpty(giftRepertorys)) {
            return giftRepertoryEntities;
        }

        for (GiftRepertory giftRepertory : giftRepertorys) {
            giftRepertoryEntities.add(new GiftRepertoryEntity(giftRepertory));
        }
        return giftRepertoryEntities;
    }

    @Override
    @Transactional
    public GiftRepertory findGiftRepertoryByLock(Long id) {
        return giftRepertoryMapper.findGiftRepertoryByLock(id);
    }
}
