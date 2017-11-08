package com.albedo.java.common.queue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 执行器线程
 *
 * @author: lijie
 * @date: 2017-8-23   上午10:56:01
 */
public class ExecutorThread extends Executor implements Runnable {
    protected Logger logger = LoggerFactory.getLogger(getClass());
    private String params;
    private Transactioner transactioner;
    private long delay = 3000L;

    public ExecutorThread(Transactioner transactioner, String params) {
        this.transactioner = transactioner;
        this.params = params;
    }

    public ExecutorThread(Transactioner transactioner, String params, long delay) {
        this.transactioner = transactioner;
        this.params = params;
        if (delay > 0) {
            this.delay = delay;
        }
    }

    public String getParams() {
        return params;
    }

    public Transactioner getTransactioner() {
        return transactioner;
    }

    @Override
    public void run() {
        try {
            Thread.sleep(delay);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        doMethod(transactioner);
    }

    @Override
    public void doMethod(Transactioner t) {
        t.excute(params);
    }
}
