package com.suteng.shiro.business.thread;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * 线程池工具类
 *
 * @Author:louyi
 * @Description：
 * @Date:Create in 10:58 2019/5/9
 */
public class ThreadPoolManager<T> {
    private static final int CPU_COUNT = Runtime.getRuntime().availableProcessors();
    private static final int CORE_POOL_SIZE = CPU_COUNT + 1;
    private static final int MAXIMUM_POOL_SIZE = CPU_COUNT * 2 + 1;
    private static final int KEEP_ALIVE = 1;
    private ThreadPoolExecutor executor;

    private ThreadPoolManager() {
        executor = new ThreadPoolExecutor(CORE_POOL_SIZE, MAXIMUM_POOL_SIZE,
                KEEP_ALIVE, TimeUnit.SECONDS, new ArrayBlockingQueue<Runnable>(20),
                Executors.defaultThreadFactory(), new ThreadPoolExecutor.AbortPolicy());
    }

    private static ThreadPoolManager instance;

    public synchronized static ThreadPoolManager getsInstance() {
        if (instance == null) {
            instance = new ThreadPoolManager();
        }
        return instance;
    }

    public void execute(Runnable r) {
        executor.execute(r);
    }

    public Future<T> submit(Callable<T> r) {
        return executor.submit(r);
    }

}
