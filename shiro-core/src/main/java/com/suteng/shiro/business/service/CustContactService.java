package com.suteng.shiro.business.service;


import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustContactEntity;
import com.suteng.shiro.business.vo.CustContactConditionVo;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 客户信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface CustContactService extends AbstractService<CustContactEntity, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<CustContactEntity> findPageBreakByCondition(CustContactConditionVo vo);

    PageInfo<CustContactEntity>  findPageChooseContact(CustContactConditionVo vo);

    /**
     * 删除关联
     */
    void deletePersonRelation(Long personId);

}
