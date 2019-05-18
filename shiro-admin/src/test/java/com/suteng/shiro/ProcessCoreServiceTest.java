package com.suteng.shiro;

import com.suteng.shiro.business.service.ProcessCoreService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author:louyi
 * @Description：
 * @Date:Create in 9:48 2019/5/13
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = {ShiroAdminApplication.class})// 指定启动类
public class ProcessCoreServiceTest {
    @Autowired
    private ProcessCoreService processCoreService;
    @Test
    public void findHistoryActivity() {
        String taskId="2517";
    }
}
