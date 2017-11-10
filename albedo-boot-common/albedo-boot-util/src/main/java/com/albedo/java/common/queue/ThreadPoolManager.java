package com.albedo.java.common.queue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.LinkedList;
import java.util.Queue;
import java.util.concurrent.*;

/**
 * 线程池管理类
 *
 * @author: lijie
 * @date: 2017-8-23   上午10:56:01
 */
public class ThreadPoolManager {

    /** 线程池维护线程的最少数量*/
    private final static int CORE_POOL_SIZE = 1;
    /** 线程池维护线程的最大数量*/
    private final static int MAX_POOL_SIZE = 3;
    /** 线程池维护线程所允许的空闲时间*/
    private final static int KEEP_ALIVE_TIME = 5;
    /**
     * 线程池所使用的缓冲队列大小
     */
    private final static int WORK_QUEUE_SIZE = 2;
    /**
     * 调度线程池
     */
    final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(10);
    @SuppressWarnings("rawtypes")
    final ThreadLocal<ScheduledFuture> taskHandler = ThreadLocal.withInitial(this::get);
    protected Logger logger = LoggerFactory.getLogger(getClass());
    /** 消息缓冲队列*/
    Queue<String> msgQueue = new LinkedList<String>();
    final RejectedExecutionHandler handler = new RejectedExecutionHandler() {

        @Override
        public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
            logger.info("消息放入队列中重新等待执行  -------> transactioner {} params {}",
                    ((ExecutorThread) r).getTransactioner(), ((ExecutorThread) r).getParams());
            msgQueue.offer(((ExecutorThread) r).getParams());
        }
    };
    @SuppressWarnings({"rawtypes", "unchecked"})
    final ThreadPoolExecutor threadPool = new ThreadPoolExecutor(CORE_POOL_SIZE, MAX_POOL_SIZE, KEEP_ALIVE_TIME,
            TimeUnit.SECONDS, new ArrayBlockingQueue(WORK_QUEUE_SIZE), this.handler);
    /**
     * 管理数据库访问的线程池
     */
    private Transactioner transactioner;
    //
    /**
     * 访问消息缓存的调度线程
     * 查看是否有待定请求，如果有，则创建一个新的ExecutorThread，并添加到线程池中
     */
    final Runnable accessBufferThread = new Runnable() {

        @Override
        public void run() {
            if (hasMoreAcquire()) {
                String params = (String) msgQueue.poll();
                Runnable task = new ExecutorThread(transactioner, params);
                threadPool.execute(task);
            }
        }
    };


    ThreadPoolManager(Transactioner transactioner) {
        this.transactioner = transactioner;
    }

    private boolean hasMoreAcquire() {
        return !msgQueue.isEmpty();
    }

    public void addAutoMsg(String params) {
        Runnable task = msgQueue.isEmpty() || msgQueue.size() == 1 ? new ExecutorThread(transactioner, params, 3000) :
                new ExecutorThread(transactioner, params, 0);
        threadPool.execute(task);
    }

    public void addMsg(String params) {
        Runnable task = new ExecutorThread(transactioner, params);
        threadPool.execute(task);
    }

    public void addMsg(String params, long delay) {
        Runnable task = new ExecutorThread(transactioner, params, delay);
        threadPool.execute(task);
    }

    private ScheduledFuture get() {
        return scheduler.scheduleAtFixedRate(accessBufferThread, 0, 5, TimeUnit.SECONDS);
    }
}
