package com.albedo.java.util;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;
import java.util.List;

/**
 * bean copy 工具类
 *
 * @author lijie
 */
public class BeanVoUtil extends BeanUtils {

    public static void copyProperties(Object source, Object target, boolean ignoreNull, String... ignoreProperties) throws BeansException {
        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");
        Class<?> actualEditable = target.getClass();


        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        List<String> ignoreList = ignoreProperties != null ? Arrays.asList(ignoreProperties) : null;
        PropertyDescriptor[] var7 = targetPds;
        int var8 = targetPds.length;

        for (int var9 = 0; var9 < var8; ++var9) {
            PropertyDescriptor targetPd = var7[var9];
            Method writeMethod = targetPd.getWriteMethod();
            if (writeMethod != null && (ignoreList == null || !ignoreList.contains(targetPd.getName()))) {
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null) {
                    Method readMethod = sourcePd.getReadMethod();
                    if (readMethod != null && ClassUtils.isAssignable(writeMethod.getParameterTypes()[0], readMethod.getReturnType())) {
                        try {
                            if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                                readMethod.setAccessible(true);
                            }

                            Object value = readMethod.invoke(source);
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }
                            if (ignoreNull && PublicUtil.isNotEmpty(value) || !ignoreNull) {
                                writeMethod.invoke(target, value);
                            }
                        } catch (Throwable var15) {
                            throw new FatalBeanException("Could not copy property '" + targetPd.getName() + "' from source to target", var15);
                        }
                    }
                }
            }
        }

    }

}
