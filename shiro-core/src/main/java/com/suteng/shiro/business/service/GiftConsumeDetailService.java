package com.suteng.shiro.business.service;


import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.GiftConsumeDetailEntity;
import com.suteng.shiro.business.vo.GiftConsumeDetailConditionVo;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 送礼记录
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface GiftConsumeDetailService extends AbstractService<GiftConsumeDetailEntity, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<GiftConsumeDetailEntity> findPageBreakByCondition(GiftConsumeDetailConditionVo vo);

    /**
     * 业务删掉
     * 联动库存修改
     * @param primaryKey
     * @return
     */
    void removeByLock(Long primaryKey);

    /**
     * 更新领用状态
     * @param id
     * @return error
     */
    String updateDrawStatusByLock(Long id,boolean back);

    /**
     * 联动更新主表库存数量
     * @param id
     * @param repertory
     * @return
     */
    String updateDetailAndConsumeByNum(Long id, Long repertory);

    /**
     * 更新礼品
     * 联动主表库存数量
     * @param id
     * @param repertoryId
     * @return
     */
    String updateDetailAndConsumeByRepertoryId(Long id, Long repertoryId);
    /**
     * 新增库存
     * 联动库存修改
     * @param entity
     * @return
     */
    String insertByLock(GiftConsumeDetailEntity entity);

    /**
     * 根据主表ID删除
     * @param consumeId
     */
    void removeByConsumeId(Long consumeId);
    /**
     * 可认领或可修改使用状态的记录数
     */
    Long findOperabilityCountByConsumeId(Long consumeId);
}
