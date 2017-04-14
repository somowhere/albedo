package com.albedo.java.rpc.common.protocol;

import lombok.Data;
import lombok.ToString;

/**
 * Created by lijie on 9/8/16.
 */
@Data @ToString
public class Request {
    private String requestId;
    private String className;
    private String methodName;
    private Class<?>[] paramsType;
    private Object[] params;


}
