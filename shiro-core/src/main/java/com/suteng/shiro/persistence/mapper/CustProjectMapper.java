package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.CustProjectConditionVo;
import com.suteng.shiro.persistence.beans.CustProject;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * 项目信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface CustProjectMapper extends BaseMapper<CustProject> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<CustProject> findPageBreakByCondition(CustProjectConditionVo vo);

    /**
     * 過濾ids的项目
     * @param vo
     * @return
     */
    List<CustProject> findPageChooseProject(CustProjectConditionVo vo);

    /**
     * 关联的项目
     * @param personId
     * @return
     */
    List<CustProject> findProjectRelationList(Long personId);
}
