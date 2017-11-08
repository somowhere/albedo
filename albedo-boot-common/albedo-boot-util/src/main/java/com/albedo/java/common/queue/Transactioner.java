package com.albedo.java.common.queue;

/**
 * 实际执行器接口(勾子函数调用)
 *
 * @author: lijie
 * @date: 2017-8-23   上午10:56:01
 */
public interface Transactioner {
    /**
     * 键唯一标识
     *
     * @return
     */
    String getKey();

    /**
     * 具体执行方法
     *
     * @return
     */
    void excute(String params);

}
