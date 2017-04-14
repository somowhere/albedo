package com.albedo.java.rpc.common.protocol;

import lombok.Data;
import lombok.ToString;

/**
 * Created by lijie on 9/8/16.
 */
@Data
@ToString
public class Response {
    private String requestId;
    private Boolean successed;
    private Object result;
    private Class<?> resultType;

}
