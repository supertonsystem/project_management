package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.ProjectMgtConditionVO;
import com.suteng.shiro.persistence.beans.WorkProjectMgt;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 11:40 2019/4/26
 */
@Repository
public interface WorkProjectMgtMapper extends BaseMapper<WorkProjectMgt> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<WorkProjectMgt> findPageBreakByCondition(ProjectMgtConditionVO vo);

    /**
     * 查找我的项目列表
     * 业务特殊，故与findPageBreakByCondition区分
     *
     * @param vo
     * @return
     */
    List<WorkProjectMgt> findMyPageBreakByCondition(ProjectMgtConditionVO vo);

    /**
     * 根据流程实例id集合查询任务
     * @param processInstanceIds
     * @return
     */
    List<WorkProjectMgt> findByProcessInstanceIds(List<String> processInstanceIds);
}
