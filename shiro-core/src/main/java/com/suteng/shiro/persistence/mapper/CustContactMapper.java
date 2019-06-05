package com.suteng.shiro.persistence.mapper;

import java.util.List;

import com.suteng.shiro.business.vo.CustContactConditionVo;
import com.suteng.shiro.persistence.beans.CustContact;
import com.suteng.shiro.plugin.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * 联系信息
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:40 2019/5/17
 */
@Repository
public interface CustContactMapper extends BaseMapper<CustContact> {
    /**
     * 分页查询
     *
     * @param vo
     * @return
     */
    List<CustContact> findPageBreakByCondition(CustContactConditionVo vo);


    /**
     * 過濾ids的联系记录
     * @param vo
     * @return
     */
    List<CustContact> findPageChooseContact(CustContactConditionVo vo);

    /**
     * 删除关联
     * @param personId
     */
    void deletePersonRelation(Long personId);

}
