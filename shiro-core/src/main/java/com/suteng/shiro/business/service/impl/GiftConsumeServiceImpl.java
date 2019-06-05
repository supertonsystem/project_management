package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftConsumeDetailEntity;
import com.suteng.shiro.business.entity.GiftConsumeEntity;
import com.suteng.shiro.business.service.GiftConsumeDetailService;
import com.suteng.shiro.business.service.GiftConsumeService;
import com.suteng.shiro.business.vo.GiftConsumeConditionVo;
import com.suteng.shiro.persistence.beans.GiftConsume;
import com.suteng.shiro.persistence.mapper.GiftConsumeMapper;
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
public class GiftConsumeServiceImpl implements GiftConsumeService {

    @Autowired
    private GiftConsumeMapper giftConsumeMapper;
    @Autowired
    private GiftConsumeDetailService giftConsumeDetailService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public GiftConsumeEntity insert(GiftConsumeEntity entity) {
        Assert.notNull(entity, "GiftConsumeEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        giftConsumeMapper.insertSelective(entity.getGiftConsume());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String insertConsumeAndDetailList(GiftConsumeEntity entity, List<GiftConsumeDetailEntity> list) {
        Assert.notNull(entity, "GiftConsumeEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        giftConsumeMapper.insertSelective(entity.getGiftConsume());
        insertConsumeDetail(entity, list);
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<GiftConsumeEntity> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<GiftConsume> GiftConsumes = new ArrayList<>();
        for (GiftConsumeEntity entity : entities) {
            entity.setUpdateTime(new Date());
            entity.setCreateTime(new Date());
            GiftConsumes.add(entity.getGiftConsume());
        }
        giftConsumeMapper.insertList(GiftConsumes);
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
        return giftConsumeMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(GiftConsumeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftConsumeMapper.updateByPrimaryKey(entity.getGiftConsume()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(GiftConsumeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftConsumeMapper.updateByPrimaryKeySelective(entity.getGiftConsume()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String updateConsumeAndDetailList(GiftConsumeEntity entity, List<GiftConsumeDetailEntity> list) {
        Assert.notNull(entity, "entity不可为空！");
        if(entity.getId()==null){
            giftConsumeMapper.insertSelective(entity.getGiftConsume());
        }else {
            giftConsumeMapper.updateByPrimaryKeySelective(entity.getGiftConsume());
        }
        insertConsumeDetail(entity, list);
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeConsumeAndDetailList(Long primaryKey) {
        GiftConsumeEntity consume = getByPrimaryKey(primaryKey);
        if(consume!=null){
            giftConsumeDetailService.removeByConsumeId(consume.getId());
            removeByPrimaryKey(primaryKey);
        }
    }

    /**
     * 新增详情
     *
     * @param list
     */
    private void insertConsumeDetail(GiftConsumeEntity entity, List<GiftConsumeDetailEntity> list) {
        if (list == null || list.isEmpty()) {
            return;
        }
        for (GiftConsumeDetailEntity detailEntity : list) {
            detailEntity.setConsumeId(entity.getId());
            detailEntity.setRegister(entity.getRegister());
            detailEntity.setDrawStatus(0);
            detailEntity.setStatus(0);
        }
        giftConsumeDetailService.insertList(list);
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public GiftConsumeEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        GiftConsume giftConsume = giftConsumeMapper.selectByPrimaryKey(primaryKey);
        return null == giftConsume ? null : new GiftConsumeEntity(giftConsume);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public GiftConsumeEntity getOneByEntity(GiftConsumeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        GiftConsume giftConsume = giftConsumeMapper.selectOne(entity.getGiftConsume());
        return null == giftConsume ? null : new GiftConsumeEntity(giftConsume);
    }

    @Override
    public List<GiftConsumeEntity> listAll() {
        List<GiftConsume> giftConsumes = giftConsumeMapper.selectAll();
        if (CollectionUtils.isEmpty(giftConsumes)) {
            return null;
        }
        List<GiftConsumeEntity> giftConsumeEntities = new ArrayList<>();
        for (GiftConsume giftConsume : giftConsumes) {
            giftConsumeEntities.add(new GiftConsumeEntity(giftConsume));
        }
        return giftConsumeEntities;
    }

    @Override
    public List<GiftConsumeEntity> listByEntity(GiftConsumeEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        List<GiftConsume> giftConsumes = giftConsumeMapper.select(entity.getGiftConsume());
        if (CollectionUtils.isEmpty(giftConsumes)) {
            return null;
        }
        List<GiftConsumeEntity> giftConsumeEntities = new ArrayList<>();
        for (GiftConsume giftConsume : giftConsumes) {
            giftConsumeEntities.add(new GiftConsumeEntity(giftConsume));
        }
        return giftConsumeEntities;
    }

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    @Override
    public PageInfo<GiftConsumeEntity> findPageBreakByCondition(GiftConsumeConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<GiftConsume> giftConsumes = giftConsumeMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(giftConsumes)) {
            return null;
        }
        List<GiftConsumeEntity> entities = new ArrayList<>();
        for (GiftConsume GiftConsume : giftConsumes) {
            entities.add(new GiftConsumeEntity(GiftConsume));
        }
        PageInfo bean = new PageInfo<GiftConsume>(giftConsumes);
        bean.setList(entities);
        return bean;
    }
}
