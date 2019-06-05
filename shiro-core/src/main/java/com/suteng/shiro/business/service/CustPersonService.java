package com.suteng.shiro.business.service;


import java.util.List;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.CustPersonEntity;
import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.framework.object.AbstractService;

/**
 * 客户信息
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface CustPersonService extends AbstractService<CustPersonEntity, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<CustPersonEntity> findPageBreakByCondition(CustPersonConditionVo vo);
    /**
     * 客户之间关联
     * @param vo
     * @return
     */
    PageInfo<CustPersonEntity> findPageChoosePerson(CustPersonConditionVo vo);

    /**
     * 项目客户关联
     * @param vo
     * @return
     */
    PageInfo<CustPersonEntity> findPageChoosePersonByProject(CustPersonConditionVo vo);

    /**
     * 客户与客户之间关联的项目
     * @param id
     * @return
     */
    List<CustPersonEntity> findPersonRelationList(Long id);

    /**
     * 客户与项目之间关联
     * @param projectId
     * @return
     */
    List<CustPersonEntity> findPersonRelationListByProjectId(Long projectId);

    /**
     * 查询当前用户需要拜访的客户信息(近一个月)
     * @return
     */
    List<CustPersonEntity> findVisitPersonList(Long userId);
}
