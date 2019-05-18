package com.suteng.shiro.business.service;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:23 2019/5/13
 */
public interface ProcessCoreService {
    //退回指定节点
    String taskRollback(String taskId);
}
