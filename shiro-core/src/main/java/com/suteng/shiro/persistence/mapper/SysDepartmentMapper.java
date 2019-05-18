package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.DepartmentConditionVO;
import com.suteng.shiro.persistence.beans.SysDepartment;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 11:40 2019/4/26
 */
@Repository
public interface SysDepartmentMapper extends BaseMapper<SysDepartment> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<SysDepartment> findPageBreakByCondition(DepartmentConditionVO vo);
    /**
     * tree列表
     * @return
     */
    List<SysDepartment> listAllAvailableDepartment();
}
