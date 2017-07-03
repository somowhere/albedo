package com.albedo.java.util.base;

import com.albedo.java.util.exception.RuntimeMsgException;
import org.apache.commons.lang3.StringUtils;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Collection;


public class Assert {

    /**
     * 判定对象为指定类型或其子类型
     *
     * @param obj         待判定对象
     * @param supperClass 带判定类型
     * @param message     如果类型不匹配，抛出错误的消息
     */
    public static void assertIsAssignableFrom(Object obj, Class<?> supperClass, String message) {
        if (!supperClass.isAssignableFrom(obj.getClass())) {
            buildException(message);
        }
    }

    /**
     * 判定为真
     *
     * @param flag    待判定值
     * @param message 如果为假，抛出的错误异常消息
     */
    public static void assertIsTrue(Boolean flag, String message) {
        if (flag == null || flag == false) {
            buildException(message);
        }
    }

    /**
     * 判定为假
     *
     * @param flag    待判定值
     * @param message 如果为真，抛出的异常消息
     */
    public static void assertIsFalse(Boolean flag, String message) {
        if (flag == null || flag == true) {
            buildException(message);
        }
    }

    /**
     * 判定对象标注有指定注解
     *
     * @param object          待判定对象
     * @param annotationClass 注解类型
     * @param message         如果对象没有标注指定注解，抛出的异常消息
     */
    public static void assertHasAnnotation(Object object, Class<? extends Annotation> annotationClass, String message) {
        if (!object.getClass().isAnnotationPresent(annotationClass)) {
            buildException(message);
        }
    }

    /**
     * 判定方法标注有指定注解
     *
     * @param method          待判定方法
     * @param annotationClass 注解类型
     * @param message         如果方法没有标注指定注解，抛出的异常消息
     */
    public static void assertHasAnnotation(Method method, Class<? extends Annotation> annotationClass, String message) {
        if (!method.isAnnotationPresent(annotationClass)) {
            buildException(message);
        }
    }

    /**
     * 判定类型上标注有指定注解
     *
     * @param objectClass     待判定Class
     * @param annotationClass 注解类型
     * @param message         如果类型上没有标注有该指定注解，抛出的异常消息
     */
    public static void assertHasAnnotation(Class<?> objectClass, Class<? extends Annotation> annotationClass, String message) {
        if (!objectClass.isAnnotationPresent(annotationClass)) {
            buildException(message);
        }
    }

    /**
     * 判定对象不为空
     *
     * @param object  待判定对象
     * @param message 如果对象为空，抛出的异常消息
     */
    public static void assertNotNull(Object object, String message) {
        if (object == null) {
            buildException(message);
        }
    }

    /**
     * 判定对象为空
     *
     * @param object  待判定对象
     * @param message 如果对象为空，抛出的异常消息
     */
    public static void assertIsNull(Object object, String message) {
        if (object != null) {
            buildException(message);
        }
    }

    /**
     * 判定字符串不为null、空字符串以及"NUll"字符串的大小写
     *
     * @param text    待判定字符串
     * @param message 如果待判定字符串为空，抛出的异常消息
     */
    public static void assertNotBlank(String text, String message) {
        if (StringUtils.isBlank(text)) {
            buildException(message);
        }
    }

    /**
     * 判定集合是否包含内容，不为空且长度大于0
     *
     * @param collection 待判定集合
     * @param message    如果集合为空或者长度为0，抛出的异常信息
     */
    public static void assertHasLength(Collection<?> collection, String message) {
        if (collection == null || collection.size() == 0) {
            buildException(message);
        }
    }

    /**
     * 判定对象部位空且长度大于0
     *
     * @param object  待判定对象
     * @param message 如果不满足抛出的异常信息
     */
    public static void assertHasLength(Object object, String message) {
        Object[] objects = null;
        try {
            objects = (Object[]) object;
        } catch (ClassCastException e) {
            buildException(object.getClass() + "is not array");
        }
        if (objects == null || objects.length == 0) {
            buildException(message);
        }
    }

    /**
     * 判定两Interger类型数值是否相等
     *
     * @param num1
     * @param num2
     */
    public static void assertEqual(Integer num1, Integer num2, String message) {
        if (num1 == null || num2 == null || !num1.equals(num2)) {
            buildException(message);
        }
    }

    /**
     * 断言collection长度
     *
     * @param collection
     * @param num
     * @param message
     */
    public static void assertLengthEqual(Collection<?> collection, Integer num, String message) {
        if (collection == null || collection.size() != num) {
            buildException(message);
        }
    }

    public static void assertGt(Integer max, Integer min, String message) {
        if (max == null || min == null || min > max) {
            buildException(message);
        }
    }

    /**
     * 使用异常信息构建异常
     *
     * @param message 信息内容
     */
    public static void buildException(String message) {
        if (message != null && !"".equals(message)) {
            throw new RuntimeMsgException(message);
        } else {
            throw new RuntimeMsgException();
        }
    }

}
