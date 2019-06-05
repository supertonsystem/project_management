package com.suteng.shiro.business.entity;

import com.suteng.shiro.persistence.beans.CustPersonRelation;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:41 2019/5/17
 */
public class CustPersonRelationEntity {
   private CustPersonRelation custPersonRelation;

   public CustPersonRelationEntity(CustPersonRelation custPersonRelation){
       this.custPersonRelation=custPersonRelation;
   }

    public CustPersonRelationEntity() {
        this.custPersonRelation = new CustPersonRelation();
    }

    public CustPersonRelation getCustPersonRelation() {
        return custPersonRelation;
    }

    public void setCustPersonRelation(CustPersonRelation custPersonRelation) {
        this.custPersonRelation = custPersonRelation;
    }

    public Long getId() {
        return custPersonRelation.getId();
    }

    public void setId(Long id) {
        this.custPersonRelation.setId(id);
    }

    public Long getSourceId() {
        return custPersonRelation.getSourceId();
    }

    public void setSourceId(Long sourceId) {
        this.custPersonRelation.setSourceId(sourceId);
    }

    public Long getDestId() {
        return custPersonRelation.getDestId();
    }

    public void setDestId(Long destId) {
        this.custPersonRelation.setDestId(destId);
    }
}
