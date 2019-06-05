package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.GiftRepertoryConditionVo;
import com.suteng.shiro.persistence.beans.GiftRepertory;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * 礼物类别
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface GiftRepertoryMapper extends BaseMapper<GiftRepertory> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<GiftRepertory> findPageBreakByCondition(GiftRepertoryConditionVo vo);

    /**
     * 库存大于0的
     * @return
     */
    List<GiftRepertory> availableRepertoryList();

    /**
     * 悲观锁
     * @param id
     * @return
     */
    GiftRepertory findGiftRepertoryByLock(Long id);
}
