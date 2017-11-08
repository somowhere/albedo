package com.albedo.java.common.queue.log;

import com.albedo.java.common.queue.Transactioner;

/**
 * 实际执行器接口(勾子函数调用)
 *
 * @author: lijie
 * @date: 2017-8-23   上午10:56:01
 */
public class TransactionerLog implements Transactioner {

    public final static String KEY_QUEUE = "LOG_KEY_QUEUE";


    @Override
    public String getKey() {
        return TransactionerLog.KEY_QUEUE;
    }

    @Override
    public void excute(String params) {

    }
}
