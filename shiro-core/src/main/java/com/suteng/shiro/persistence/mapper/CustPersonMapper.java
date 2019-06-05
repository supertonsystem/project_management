package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.persistence.beans.CustPerson;
import com.suteng.shiro.plugin.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface CustPersonMapper extends BaseMapper<CustPerson> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<CustPerson> findPageBreakByCondition(CustPersonConditionVo vo);

    /**
     *  客户关联选择列表
     * @param vo
     * @return
     */
    List<CustPerson> findPageChoosePerson(CustPersonConditionVo vo);

    /**
     *  项目关联选择列表
     * @param vo
     * @return
     */
    List<CustPerson> findPageChoosePersonByProject(CustPersonConditionVo vo);

    /**
     * 客户之间关联的项目
     * @param id
     * @return
     */
    List<CustPerson> findPersonRelationList(Long id);

    /**
     * 项目客户之间关联的项目
     * @param projectId
     * @return
     */
    List<CustPerson> findPersonRelationListByProjectId(@Param("projectId")Long projectId);

    /**
     * 拜访客户
     * @param userId
     * @return
     */
    List<CustPerson> findVisitPersonList(Long userId);
}
