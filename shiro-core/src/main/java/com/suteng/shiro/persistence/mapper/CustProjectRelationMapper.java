package com.suteng.shiro.persistence.mapper;

import com.suteng.shiro.persistence.beans.CustProjectRelation;
import com.suteng.shiro.plugin.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 人员关联
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface CustProjectRelationMapper extends BaseMapper<CustProjectRelation> {

    /**
     * 删除关联
     * @param personId
     */
    void deleteProjectRelationByPersonId(Long personId);

    /**
     * 删除关联
     * @param projectId
     */
    void deleteProjectRelationByProjectId(Long projectId);

    /**
     * 删除关联
     * @param personId
     */
    void deleteProjectRelationByProjectIdAndPersonId(@Param("personId") Long personId, @Param("projectId") Long projectId);
}
