package com.suteng.shiro.persistence.mapper;

import com.suteng.shiro.persistence.beans.CustPersonRelation;
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
public interface CustPersonRelationMapper extends BaseMapper<CustPersonRelation> {

    /**
     * 删除关联
     * @param sourceId
     */
    void deletePersonRelationBySourceId(Long sourceId);

    /**
     * 删除关联
     * @param sourceId
     */
    void deletePersonRelationByDestId(@Param("sourceId") Long sourceId, @Param("destId")Long destId);
}
