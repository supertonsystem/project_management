package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.CustPersonConditionVo;
import com.suteng.shiro.persistence.beans.CustPerson;
import com.suteng.shiro.plugin.BaseMapper;
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
}
