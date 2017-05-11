package com.albedo.java.thrift.rpc.common.annotion;

import org.springframework.boot.autoconfigure.AutoConfigureAfter;

import java.lang.annotation.*;

/**
 * Created by chenshunyang on 2016/9/23.
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ThriftServiceApi {
//    Class<?> clazz() ;
    //名称
    String name();
    // 优先级
    int weight() default 1;// default
    //服务版本号
    String version() default "1.0.0";

}
