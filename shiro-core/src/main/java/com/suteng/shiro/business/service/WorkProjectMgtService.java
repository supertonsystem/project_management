package com.suteng.shiro.business.service;


import java.util.List;

import com.github.pagehelper.PageInfo;
import com.suteng.shiro.business.entity.ProjectMgt;
import com.suteng.shiro.business.vo.ProjectMgtConditionVO;
import com.suteng.shiro.framework.object.AbstractService;
import com.suteng.shiro.persistence.beans.WorkProjectMgt;

/**
 * 系统资源
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
public interface WorkProjectMgtService extends AbstractService<ProjectMgt, Long> {

    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    PageInfo<ProjectMgt> findPageBreakByCondition(ProjectMgtConditionVO vo);

    /**
     * 我的项目列表查询
     * @param vo
     * @return
     */
    PageInfo<ProjectMgt> findMyPageBreakByCondition(ProjectMgtConditionVO vo);

    /**
     * 根据id集合查询
     * @param ids
     * @return
     */
    List<WorkProjectMgt> findByProcessInstanceIds(List<String> ids);

}
