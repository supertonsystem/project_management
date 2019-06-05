package com.suteng.shiro.business.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.suteng.shiro.business.entity.Config;
import com.suteng.shiro.business.service.SysConfigService;
import com.suteng.shiro.persistence.beans.SysConfig;
import com.suteng.shiro.persistence.mapper.SysConfigMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

/**
 * 用户
 *
 * @date 2018/4/16 16:26
 * @since 1.0
 */
@Slf4j
@Service
public class SysConfigServiceImpl implements SysConfigService {

    @Autowired
    private SysConfigMapper sysConfigMapper;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Config insert(Config entity) {
        Assert.notNull(entity, "Config不可为空！");
        sysConfigMapper.insertSelective(entity.getSysConfig());
        return entity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void insertList(List<Config> entities) {
        Assert.notNull(entities, "entities不可为空！");
        List<SysConfig> sysUsers = new ArrayList<>();
        for (Config entity : entities) {
            sysUsers.add(entity.getSysConfig());
        }
        sysConfigMapper.insertList(sysUsers);
    }

    /**
     * 根据主键字段进行删除，方法参数必须包含完整的主键属性
     *
     * @param primaryKey
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByPrimaryKey(Long primaryKey) {
        return sysConfigMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(Config entity) {
        Assert.notNull(entity, "entity不可为空！");
        return sysConfigMapper.updateByPrimaryKey(entity.getSysConfig()) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSelective(Config entity) {
        Assert.notNull(entity, "entity不可为空！");
        return sysConfigMapper.updateByPrimaryKeySelective(entity.getSysConfig()) > 0;
    }

    /**
     * 根据主键字段进行查询，方法参数必须包含完整的主键属性，查询条件使用等号
     *
     * @param primaryKey
     * @return
     */

    @Override
    public Config getByPrimaryKey(Long primaryKey) {
        Assert.notNull(primaryKey, "PrimaryKey不可为空！");
        SysConfig custPerson = sysConfigMapper.selectByPrimaryKey(primaryKey);
        return null == custPerson ? null : new Config(custPerson);
    }

    /**
     * 根据实体中的属性进行查询，只能有一个返回值，有多个结果时抛出异常，查询条件使用等号
     *
     * @param entity
     * @return
     */
    @Override
    public Config getOneByEntity(Config entity) {
        Assert.notNull(entity, "entity不可为空！");
        SysConfig custPerson = sysConfigMapper.selectOne(entity.getSysConfig());
        return null == custPerson ? null : new Config(custPerson);
    }

    @Override
    public List<Config> listAll() {
        List<SysConfig> custPeople = sysConfigMapper.selectAll();
        if (CollectionUtils.isEmpty(custPeople)) {
            return null;
        }
        List<Config> users = new ArrayList<>();
        for (SysConfig sysConfig : custPeople) {
            users.add(new Config(sysConfig));
        }
        return users;
    }

    @Override
    public List<Config> listByEntity(Config entity) {
        List<Config> users = new ArrayList<>();
        Assert.notNull(entity, "entity不可为空！");
        List<SysConfig> custPeople = sysConfigMapper.select(entity.getSysConfig());
        if (CollectionUtils.isEmpty(custPeople)) {
            return users;
        }

        for (SysConfig sysConfig : custPeople) {
            users.add(new Config(sysConfig));
        }
        return users;
    }
}
