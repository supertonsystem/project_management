package com.suteng.shiro.business.entity;

import com.suteng.shiro.persistence.beans.CustProjectRelation;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustProjectRelationEntity {
   private CustProjectRelation custProjectRelation;

   public CustProjectRelationEntity(CustProjectRelation custProjectRelation){
       this.custProjectRelation=custProjectRelation;
   }

    public CustProjectRelationEntity() {
        this.custProjectRelation = new CustProjectRelation();
    }

    public CustProjectRelation getCustProjectRelation() {
        return custProjectRelation;
    }

    public void setCustProjectRelation(CustProjectRelation custProjectRelation) {
        this.custProjectRelation = custProjectRelation;
    }


    public Long getId() {
        return custProjectRelation.getId();
    }

    public void setId(Long id) {
        this.custProjectRelation.setId(id);
    }

    public Long getPersonId() {
        return custProjectRelation.getPersonId();
    }

    public void setProjectId(Long projectId) {
        this.custProjectRelation.setProjectId(projectId);
    }

    public Long getProjectId() {
        return custProjectRelation.getProjectId();
    }

    public void setPersonId(Long personId) {
        this.custProjectRelation.setPersonId(personId);
    }
}
