package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftConsumeDetailEntity;
import com.suteng.shiro.business.entity.GiftConsumeEntity;
import com.suteng.shiro.business.entity.GiftRepertoryEntity;
import com.suteng.shiro.business.service.GiftConsumeDetailService;
import com.suteng.shiro.business.service.GiftConsumeService;
import com.suteng.shiro.business.service.GiftRepertoryService;
import com.suteng.shiro.business.vo.GiftConsumeDetailConditionVo;
import com.suteng.shiro.persistence.beans.GiftConsumeDetail;
import com.suteng.shiro.persistence.beans.GiftRepertory;
import com.suteng.shiro.persistence.mapper.GiftConsumeDetailMapper;
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
public class GiftConsumeDetailServiceImpl implements GiftConsumeDetailService {

    @Autowired
    private GiftConsumeDetailMapper giftConsumeDetailMapper;
    @Autowired
    private GiftRepertoryService giftRepertoryService;
    @Autowired
    private GiftConsumeService giftConsumeService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public GiftConsumeDetailEntity insert(GiftConsumeDetailEntity entity) {
        Assert.notNull(entity, "GiftConsumeEntity不可为空！");
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        giftConsumeDetailMapper.insertSelective(entity.getGiftConsumeDetail());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<GiftConsumeDetailEntity> entities) {
        if (CollectionUtils.isEmpty(entities)) {
            return;
        }
        Assert.notNull(entities, "entities不可为空！");
        List<GiftConsumeDetail> GiftConsumes = new ArrayList<>();
        for (GiftConsumeDetailEntity entity : entities) {
            entity.setUpdateTime(new Date());
            entity.setCreateTime(new Date());
            GiftConsumes.add(entity.getGiftConsumeDetail());
        }
        giftConsumeDetailMapper.insertList(GiftConsumes);
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
        return giftConsumeDetailMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(GiftConsumeDetailEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftConsumeDetailMapper.updateByPrimaryKey(entity.getGiftConsumeDetail()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(GiftConsumeDetailEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        return giftConsumeDetailMapper.updateByPrimaryKeySelective(entity.getGiftConsumeDetail()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public GiftConsumeDetailEntity getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        GiftConsumeDetail giftConsumeDetail = giftConsumeDetailMapper.selectByPrimaryKey(primaryKey);
        return null == giftConsumeDetail ? null : new GiftConsumeDetailEntity(giftConsumeDetail);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public GiftConsumeDetailEntity getOneByEntity(GiftConsumeDetailEntity entity) {
        Assert.notNull(entity, "entity不可为空！");
        GiftConsumeDetail giftConsumeDetail = giftConsumeDetailMapper.selectOne(entity.getGiftConsumeDetail());
        return null == giftConsumeDetail ? null : new GiftConsumeDetailEntity(giftConsumeDetail);
    }

    @Override
    public List<GiftConsumeDetailEntity> listAll() {
        List<GiftConsumeDetail> giftConsumes = giftConsumeDetailMapper.selectAll();
        if (CollectionUtils.isEmpty(giftConsumes)) {
            return null;
        }
        List<GiftConsumeDetailEntity> giftConsumeEntities = new ArrayList<>();
        for (GiftConsumeDetail giftConsume : giftConsumes) {
            GiftConsumeDetailEntity giftConsumeEntity = new GiftConsumeDetailEntity(giftConsume);
            giftConsumeEntities.add(giftConsumeEntity);
        }
        return giftConsumeEntities;
    }

    @Override
    public List<GiftConsumeDetailEntity> listByEntity(GiftConsumeDetailEntity entity) {
        List<GiftConsumeDetailEntity> giftConsumeEntities = new ArrayList<>();
        Assert.notNull(entity, "entity不可为空！");
        List<GiftConsumeDetail> giftConsumes = giftConsumeDetailMapper.select(entity.getGiftConsumeDetail());
        if (CollectionUtils.isEmpty(giftConsumes)) {
            return giftConsumeEntities;
        }
        for (GiftConsumeDetail giftConsume : giftConsumes) {
            GiftConsumeDetailEntity giftConsumeEntity = new GiftConsumeDetailEntity(giftConsume);
            giftConsumeEntities.add(giftConsumeEntity);
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
    public PageInfo<GiftConsumeDetailEntity> findPageBreakByCondition(GiftConsumeDetailConditionVo vo) {
        PageHelper.startPage(vo.getPageNumber(), vo.getPageSize());
        List<GiftConsumeDetail> giftConsumes = giftConsumeDetailMapper.findPageBreakByCondition(vo);
        if (CollectionUtils.isEmpty(giftConsumes)) {
            return null;
        }
        List<GiftConsumeDetailEntity> entities = new ArrayList<>();
        for (GiftConsumeDetail GiftConsume : giftConsumes) {
            entities.add(new GiftConsumeDetailEntity(GiftConsume));
        }
        PageInfo bean = new PageInfo<GiftConsumeDetail>(giftConsumes);
        bean.setList(entities);
        return bean;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeByLock(Long primaryKey) {
        GiftConsumeDetailEntity entity = getByPrimaryKey(primaryKey);
        if (entity != null && entity.getNum() > 0) {
            GiftRepertory giftRepertory = giftRepertoryService.findGiftRepertoryByLock(entity.getRepertoryId());
            if (giftRepertory != null) {
                giftRepertory.setRepertory(giftRepertory.getRepertory() + entity.getNum());
                giftRepertoryService.updateSelective(new GiftRepertoryEntity(giftRepertory));
            }
            GiftConsumeEntity consumeEntity = giftConsumeService.getByPrimaryKey(entity.getConsumeId());
            if (consumeEntity != null) {
                consumeEntity.setNum(consumeEntity.getNum() - entity.getNum());
                consumeEntity.setAmount(consumeEntity.getAmount() - entity.getAmount());
                giftConsumeService.updateSelective(consumeEntity);
            }
        }
        giftConsumeDetailMapper.deleteByPrimaryKey(primaryKey);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String updateDrawStatusByLock(Long id,boolean back) {
        GiftConsumeDetailEntity r = getByPrimaryKey(id);
        if (r != null) {
            GiftRepertory giftRepertory = giftRepertoryService.findGiftRepertoryByLock(r.getRepertoryId());
            if (giftRepertory != null) {
                Long repertoryNum = giftRepertory.getRepertory();
                //退回
                if(back){
                    //增加库存
                    giftRepertory.setRepertory(giftRepertory.getRepertory()+r.getNum());
                    //使用状态修改为退回
                    r.setStatus(2);
                    GiftConsumeEntity consumeEntity = giftConsumeService.getByPrimaryKey(r.getConsumeId());
                    consumeEntity.setId(r.getConsumeId());
                    Long backNum=consumeEntity.getBackNum()==null?0:consumeEntity.getBackNum();
                    consumeEntity.setBackNum(backNum+r.getNum());
                    Double backMoney=consumeEntity.getBackMoney()==null?0d:consumeEntity.getBackMoney();
                    consumeEntity.setBackMoney(backMoney+r.getAmount());
                    giftConsumeService.updateSelective(consumeEntity);
                }else {
                    if (r.getNum() > repertoryNum) {
                        return "库存数为:" + repertoryNum + ",不足";
                    }
                    //减去库存
                    giftRepertory.setRepertory(repertoryNum - r.getNum());
                    //置为已领用
                    r.setDrawStatus(1);
                }
                updateSelective(r);
                giftRepertoryService.updateSelective(new GiftRepertoryEntity(giftRepertory));
            }

        }
        return null;
    }

    @Override
    public String updateDetailAndConsumeByRepertoryId(Long id, Long repertoryId) {
        GiftConsumeDetailEntity r = getByPrimaryKey(id);
        if (r != null) {
            GiftRepertory giftRepertory = giftRepertoryService.findGiftRepertoryByLock(repertoryId);
            if (giftRepertory == null) {
                return "礼品不存在";
            }
            GiftConsumeDetailEntity entity = new GiftConsumeDetailEntity();
            entity.setId(id);
            entity.setNum(null);
            entity.setAmount(null);
            entity.setRepertoryId(repertoryId);
            updateSelective(entity);

            GiftConsumeEntity consumeEntity = giftConsumeService.getByPrimaryKey(r.getConsumeId());
            if (consumeEntity != null) {
                consumeEntity.setNum(consumeEntity.getNum() - r.getNum());
                Double amount = giftRepertory.getUnit() * r.getNum();
                consumeEntity.setAmount(consumeEntity.getAmount() - amount);
                giftConsumeService.updateSelective(consumeEntity);
            }
        }
        return null;
    }

    @Override
    public String updateDetailAndConsumeByNum(Long id, Long repertory) {
        GiftConsumeDetailEntity r = getByPrimaryKey(id);
        if (r != null) {
            GiftRepertory giftRepertory = giftRepertoryService.findGiftRepertoryByLock(r.getRepertoryId());
            if (giftRepertory == null) {
                return "礼品不存在";
            }
            //只更新数量
            GiftConsumeDetailEntity entity = new GiftConsumeDetailEntity();
            entity.setId(id);
            entity.setNum(repertory);
            entity.setAmount(giftRepertory.getUnit() * repertory);
            updateSelective(entity);

            GiftConsumeEntity consumeEntity = giftConsumeService.getByPrimaryKey(r.getConsumeId());
            if (consumeEntity != null) {
                if (r.getNum() == null) {
                    //分数增多
                    Long oNum = consumeEntity.getNum() == null ? 0 : consumeEntity.getNum();
                    consumeEntity.setNum(oNum + repertory);
                    Double amount = giftRepertory.getUnit() * repertory;
                    Double oAmount = consumeEntity.getAmount() == null ? 0 : consumeEntity.getAmount();
                    consumeEntity.setAmount(oAmount + amount);
                } else {
                    //份数变少
                    if (r.getNum() > repertory) {
                        long num = r.getNum() - repertory;
                        consumeEntity.setNum(consumeEntity.getNum() - num);
                        Double amount = giftRepertory.getUnit() * num;
                        consumeEntity.setAmount(consumeEntity.getAmount() - amount);
                    } else {
                        //份数增多
                        long num = repertory - r.getNum();
                        consumeEntity.setNum(consumeEntity.getNum() + num);
                        Double amount = giftRepertory.getUnit() * num;
                        consumeEntity.setAmount(consumeEntity.getAmount() + amount);
                    }
                }
                giftConsumeService.updateSelective(consumeEntity);
            }
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String insertByLock(GiftConsumeDetailEntity entity) {
        entity.setUpdateTime(new Date());
        entity.setCreateTime(new Date());
        //未填礼品数量
        if (entity.getNum() == null) {
            giftConsumeDetailMapper.insertSelective(entity.getGiftConsumeDetail());
        } else {
            GiftRepertory giftRepertory = giftRepertoryService.findGiftRepertoryByLock(entity.getRepertoryId());
            if (giftRepertory != null) {
                if (entity.getNum() > giftRepertory.getRepertory()) {
                    return "礼品【" + giftRepertory.getName() + "】库存数为：" + giftRepertory.getRepertory();
                }
                giftConsumeDetailMapper.insertSelective(entity.getGiftConsumeDetail());
                giftRepertory.setRepertory(giftRepertory.getRepertory() - entity.getNum());
                giftRepertoryService.updateSelective(new GiftRepertoryEntity(giftRepertory));
            }
        }
        return null;
    }

    @Override
    public void removeByConsumeId(Long consumeId) {
        giftConsumeDetailMapper.removeByConsumeId(consumeId);
    }

    @Override
    public Long findOperabilityCountByConsumeId(Long consumeId) {
        return giftConsumeDetailMapper.findOperabilityCountByConsumeId(consumeId);
    }
}
