package com.albedo.java.thrift.rpc.server.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ThriftLogUtility
 */
public class ThriftLogUtility {

    private static final Logger rpcLogger = LoggerFactory.getLogger(ThriftLogUtility.class);

    public static final ThreadLocal<StringBuilder> threadLocals = new ThreadLocal<StringBuilder>();

    public static final ThreadLocal<Long> threadTimeLocals = new ThreadLocal<Long>();

    public static void beforeInvoke(Class targetClass, String method, Object[] args) {
        long startTime = System.currentTimeMillis();
        threadTimeLocals.set(startTime);
        StringBuilder sb = threadLocals.get();
        if (sb == null) {
            sb = new StringBuilder();
            threadLocals.set(sb);
        }
        sb.delete(0, sb.length());

        StringBuffer argBuffer = new StringBuffer();
        if (null != args) {
            for (int i = 0; i < args.length; i++) {
                String value = null == args[i] ? "null" : args[i].toString();
                argBuffer.append("arg" + i + "=" + value + ",");
            }
        }
        sb.append(String.format("thrift服务[%s] invoke method[%s] args[%s]....", targetClass.getSimpleName(), method,
                argBuffer.toString()));

    }

    public static void returnInvoke(Object result) {
        long endTime = System.currentTimeMillis();
        long startTime = threadTimeLocals.get();
        StringBuilder sb = threadLocals.get();
        if (sb != null) {
            sb.append(String.format("invoke success cast[%s] return[%s]....", (endTime - startTime),
                    null != result ? result.toString() : "null"));
            rpcLogger.info(sb.toString());
        }
    }

    public static void throwableInvoke(String fmt, Object... args) {
        StringBuilder sb = threadLocals.get();
        if (sb != null) {
            rpcLogger.info(sb.toString() + " " + String.format(fmt, args));
        }
    }

    public static void noticeLog(String fmt, Object... args) {
        StringBuilder sb = threadLocals.get();
        if (sb != null) {
            sb.append(" " + String.format(fmt, args));
        }
    }
}
