package com.albedo.java.thrift.rpc.common;

import org.apache.thrift.TServiceClient;

/**
 * Created by lijie on 2017/5/10.
 *
 * @author 837158334@qq.com
 */
public interface PoolOperationCallBack {
    // 销毁client之前执行
    void destroy(TServiceClient client);

    // 创建成功是执行
    void make(TServiceClient client);
}
