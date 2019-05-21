package com.suteng.shiro.business.service;


import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustProjectEntity;
import com.suteng.shiro.business.vo.CustProjectConditionVo;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 客户信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface CustProjectService extends AbstractService<CustProjectEntity, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<CustProjectEntity> findPageBreakByCondition(CustProjectConditionVo vo);

}
