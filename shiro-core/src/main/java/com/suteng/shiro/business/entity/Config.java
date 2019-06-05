package com.suteng.shiro.business.entity;

import com.suteng.shiro.persistence.beans.SysConfig;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 16:57 2019/6/3
 */
public class Config {
    private SysConfig sysConfig;
    public Config(){
        this.sysConfig=new SysConfig();
    }
    public Config(SysConfig sysConfig){
        this.sysConfig=sysConfig;
    }
    public SysConfig getSysConfig() {
        return sysConfig;
    }

    public void setSysConfig(SysConfig sysConfig) {
        this.sysConfig = sysConfig;
    }

    public String getName() {
        return sysConfig.getName();
    }

    public void setName(String name) {
        this.sysConfig.setName(name);
    }

    public String getCode() {
        return sysConfig.getCode();
    }

    public void setCode(String code) {
        this.sysConfig.setCode(code);
    }

    public String getValue() {
        return sysConfig.getValue();
    }

    public void setValue(String value) {
        this.sysConfig.setValue(value);
    }
}
