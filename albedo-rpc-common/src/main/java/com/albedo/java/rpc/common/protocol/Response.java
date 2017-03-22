package com.albedo.java.rpc.common.protocol;

/**
 * Created by chenghao on 9/8/16.
 */
public class Response {
    private String requestId;
    private Boolean successed;
    private Object result;
    private Class<?> resultType;

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }

    public Boolean getSuccessed() {
        return successed;
    }

    public void setSuccessed(Boolean successed) {
        this.successed = successed;
    }

    public String getRequestId() {
        return requestId;
    }

    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }
}
