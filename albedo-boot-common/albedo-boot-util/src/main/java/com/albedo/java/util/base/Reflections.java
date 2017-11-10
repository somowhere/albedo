package com.albedo.java.util.base;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.config.SystemConfig;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import javassist.*;
import javassist.bytecode.CodeAttribute;
import javassist.bytecode.LocalVariableAttribute;
import javassist.bytecode.MethodInfo;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.framework.AdvisedSupport;
import org.springframework.beans.DirectFieldAccessor;
import org.springframework.util.Assert;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.annotation.Annotation;
import java.lang.reflect.*;
import java.lang.reflect.Modifier;
import java.util.*;

/**
 * @author lijie version 2013-12-26 下午2:43:53
 */
@SuppressWarnings("rawtypes")
public class Reflections {

    private static final String SETTER_PREFIX = "set";

    private static final String GETTER_PREFIX = "get";

    private static final String CGLIB_CLASS_SEPARATOR = "$$";

    private static final String ADVISED_FIELD_NAME = "advised";

    private static final String CLASS_JDK_DYNAMIC_AOP_PROXY = "org.springframework.aop.framework.JdkDynamicAopProxy";
    public static String classPackge = SystemConfig.get("system.base.class.path");
    private static Logger logger = LoggerFactory.getLogger(Reflections.class);

    public static boolean checkClassIsBase(String className) {
        if (PublicUtil.isNotEmpty(className) && PublicUtil.isNotEmpty(classPackge)) {
            String[] strs = classPackge.split(",");
            for (String item : strs) {
                if (className.contains(item)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 调用Getter方法. 支持多级，如：对象名.对象名.方法
     */
    public static Object invokeGetter(Object obj, String propertyName) {
        if (obj instanceof Map) {
            return ((Map) obj).get(propertyName);
        }
        Object object = obj;
        for (String name : StringUtil.split(propertyName, ".")) {
            object = invokeMethod(object, PublicUtil.toAppendStr(GETTER_PREFIX, StringUtil.capitalize(name)),
                    new Class[]{}, new Object[]{});
        }
        return object;
    }

    /**
     * 调用Setter方法, 仅匹配方法名。 支持多级，如：对象名.对象名.方法
     */
    public static void invokeSetter(Object obj, String propertyName, Object value) {
        Object object = obj;
        String[] names = StringUtil.split(propertyName, ".");
        for (int i = 0; i < names.length; i++) {
            if (i < names.length - 1) {
                object = invokeMethod(object, PublicUtil.toAppendStr(GETTER_PREFIX, StringUtil.capitalize(names[i])),
                        new Class[]{}, new Object[]{});
            } else {
                invokeMethodByName(object, PublicUtil.toAppendStr(SETTER_PREFIX, StringUtil.capitalize(names[i])),
                        new Object[]{value});
            }
        }
    }

    /**
     * 直接读取对象属性值, 无视private/protected修饰符, 不经过getter函数.
     */
    public static Object getFieldValue(final Object obj, final String fieldName) {
        if (obj instanceof Map) {
            return ((Map) obj).get(fieldName);
        }
        Field field = getAccessibleField(obj, fieldName);

        if (field == null) {
            throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + obj + "]");
        }

        Object result = null;
        try {
            result = field.get(obj);
        } catch (IllegalAccessException e) {
            logger.error("不可能抛出的异常{}", e.getMessage());
        }
        return result;
    }

    /**
     * 直接设置对象属性值, 无视private/protected修饰符, 不经过setter函数.
     */
    public static void setFieldValue(final Object obj, final String fieldName, final Object value) {
        Field field = getAccessibleField(obj, fieldName);

        if (field == null) {
            throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + obj + "]");
        }

        try {
            field.set(obj, value);
        } catch (IllegalAccessException e) {
            logger.error("不可能抛出的异常:{}", e.getMessage());
        }
    }

    /**
     * 直接设置对象属性值, 经过setter函数. PropertyUtil操作 自动判断值类型（仅包含基础类型）
     *
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public static void setProperty(final Object obj, final PropertyDescriptor p, final Object value)
            throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        String typeName = p.getPropertyType().getName();
        if (typeName.contains(SystemConfig.TYPE_INT) || typeName.contains(SystemConfig.TYPE_INTEGER)) {
            PropertyUtils.setProperty(obj, p.getName(), Integer.parseInt(PublicUtil.toStrString(value)));
        } else if (typeName.contains("float") || typeName.contains(SystemConfig.TYPE_FLOAT)) {
            PropertyUtils.setProperty(obj, p.getName(), Float.parseFloat(PublicUtil.toStrString(value)));
        } else if (typeName.contains("double") || typeName.contains(SystemConfig.TYPE_DOUBLE)) {
            PropertyUtils.setProperty(obj, p.getName(), Double.parseDouble(PublicUtil.toStrString(value)));
        } else if (typeName.contains("long") || typeName.contains(SystemConfig.TYPE_LONG)) {
            PropertyUtils.setProperty(obj, p.getName(), Long.parseLong(PublicUtil.toStrString(value)));
        } else {
            PropertyUtils.setProperty(obj, p.getName(), value);
        }
    }

    /**
     * 直接设置对象属性值, 经过setter函数. PropertyUtil操作 自动判断值类型（仅包含基础类型）
     *
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public static void setProperty(final Object obj, final String propertyName, final Object value)
            throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        if (PublicUtil.isNotEmpty(value)) {
            PropertyDescriptor p = PropertyUtils.getPropertyDescriptor(obj, propertyName);
            setProperty(obj, p, value);
        }
    }

    /**
     * 直接调用对象方法, 无视private/protected修饰符.
     * 用于一次性调用的情况，否则应使用getAccessibleMethod()函数获得Method后反复调用. 同时匹配方法名+参数类型，
     */
    public static Object invokeMethod(final Object obj, final String methodName, final Class<?>[] parameterTypes,
                                      final Object[] args) {
        Method method = getAccessibleMethod(obj, methodName, parameterTypes);
        if (method == null) {
            throw new IllegalArgumentException("Could not find method [" + methodName + "] on target [" + obj + "]");
        }

        try {
            return method.invoke(obj, args);
        } catch (Exception e) {
            throw convertReflectionExceptionToUnchecked(e);
        }
    }

    /**
     * 直接调用对象方法, 无视private/protected修饰符，
     * 用于一次性调用的情况，否则应使用getAccessibleMethodByName()函数获得Method后反复调用.
     * 只匹配函数名，如果有多个同名函数调用第一个。
     */
    public static Object invokeMethodByName(final Object obj, final String methodName, final Object[] args) {
        Method method = getAccessibleMethodByName(obj, methodName);
        if (method == null) {
            throw new IllegalArgumentException("Could not find method [" + methodName + "] on target [" + obj + "]");
        }

        try {
            return method.invoke(obj, args);
        } catch (Exception e) {
            throw convertReflectionExceptionToUnchecked(e);
        }
    }

    /**
     * 循环向上转型, 获取对象的DeclaredField, 并强制设置为可访问. 如向上转型到Object仍无法找到, 返回null.
     */
    public static Field getAccessibleField(final Object obj, final String fieldName) {
        return getAccessibleField(obj.getClass(), fieldName);
    }

    /**
     * 循环向上转型, 获取对象的DeclaredField, 并强制设置为可访问. 如向上转型到Object仍无法找到, 返回null.
     */
    public static Field getAccessibleField(final Class<?> cls, final String fieldName) {
        Validate.notNull(cls, "cls can't be null");
        Validate.notBlank(fieldName, "fieldName can't be blank");
        for (Class<?> superClass = cls; superClass != Object.class; superClass = superClass
                .getSuperclass()) {
            try {
                Field field = superClass.getDeclaredField(fieldName);
                makeAccessible(field);
                return field;
            } catch (NoSuchFieldException e) {// NOSONAR
                // Field不在当前类定义,继续向上转型
                continue;// new add
            }
        }
        return null;
    }

    /**
     * 循环向上转型, 获取对象的DeclaredMethod,并强制设置为可访问. 如向上转型到Object仍无法找到, 返回null.
     * 匹配函数名+参数类型。 用于方法需要被多次调用的情况. 先使用本函数先取得Method,然后调用Method.invoke(Object obj,
     * Object... args)
     */
    public static Method getAccessibleMethod(final Object obj, final String methodName,
                                             final Class<?>... parameterTypes) {
        Validate.notNull(obj, "object can't be null");
        Validate.notBlank(methodName, "methodName can't be blank");

        for (Class<?> searchType = obj.getClass(); searchType != Object.class; searchType = searchType
                .getSuperclass()) {
            try {
                Method method = searchType.getDeclaredMethod(methodName, parameterTypes);
                makeAccessible(method);
                return method;
            } catch (NoSuchMethodException e) {
                // Method不在当前类定义,继续向上转型
                continue;// new add
            }
        }
        return null;
    }

    public static Method getAccessibleMethodByName(final Object obj, final String methodName) {
        return getAccessibleMethodClazzByName(Reflections.getTargetClass(obj), methodName);
    }

    /**
     * 循环向上转型, 获取对象的DeclaredMethod,并强制设置为可访问. 如向上转型到Object仍无法找到, 返回null. 只匹配函数名。
     * 用于方法需要被多次调用的情况. 先使用本函数先取得Method,然后调用Method.invoke(Object obj, Object...
     * args)
     */
    public static Method getAccessibleMethodClazzByName(final Class<?> clazz, final String methodName) {
        Validate.notNull(clazz, "object can't be null");
        Validate.notBlank(methodName, "methodName can't be blank");

        for (Class<?> searchType = clazz; searchType != Object.class; searchType = searchType
                .getSuperclass()) {
            Method[] methods = searchType.getDeclaredMethods();
            for (Method method : methods) {
                if (method.getName().equals(methodName)) {
                    makeAccessible(method);
                    return method;
                }
            }
        }
        return null;
    }


    /**
     * 改变private/protected的方法为public，尽量不调用实际改动的语句，避免JDK的SecurityManager抱怨。
     */
    public static void makeAccessible(Method method) {
        if ((!Modifier.isPublic(method.getModifiers()) || !Modifier.isPublic(method.getDeclaringClass().getModifiers()))
                && !method.isAccessible()) {
            method.setAccessible(true);
        }
    }

    /**
     * 改变private/protected的成员变量为public，尽量不调用实际改动的语句，避免JDK的SecurityManager抱怨。
     */
    public static void makeAccessible(Field field) {
        if ((!Modifier.isPublic(field.getModifiers()) || !Modifier.isPublic(field.getDeclaringClass().getModifiers())
                || Modifier.isFinal(field.getModifiers())) && !field.isAccessible()) {
            field.setAccessible(true);
        }
    }

    /**
     * 通过反射, 获得Class定义中声明的泛型参数的类型, 注意泛型必须定义在父类处 如无法找到, 返回Object.class. eg.
     * public UserDao extends HibernateDao<User>
     *
     * @param clazz The class to introspect
     * @return the first generic declaration, or Object.class if cannot be
     * determined
     */
    @SuppressWarnings("unchecked")
    public static <T> Class<T> getClassGenricType(final Class clazz) {
        return getClassGenricType(clazz, 0);
    }

    /**
     * 通过反射, 获得Class定义中声明的父类的泛型参数的类型. 如无法找到, 返回Object.class. 如public UserDao
     * extends HibernateDao<User,Long>
     *
     * @param clazz clazz The class to introspect
     * @param index the Index of the generic ddeclaration,start from 0.
     * @return the index generic declaration, or Object.class if cannot be
     * determined
     */
    public static Class getClassGenricType(final Class clazz, final int index) {

        Type genType = clazz.getGenericSuperclass();

        if (!(genType instanceof ParameterizedType)) {
            logger.warn(clazz.getSimpleName() + "'s superclass not ParameterizedType");
            return Object.class;
        }

        Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

        if (index >= params.length || index < 0) {
            logger.warn("Index: " + index + ", Size of " + clazz.getSimpleName() + "'s Parameterized Type: "
                    + params.length);
            return Object.class;
        }
        if (!(params[index] instanceof Class)) {
            logger.warn(clazz.getSimpleName() + " not set the actual class on superclass generic parameter");
            return Object.class;
        }

        return (Class) params[index];
    }

    public static Class<?> getUserClass(Object instance) {
        Assert.notNull(instance, "Instance must not be null");
        Class clazz = instance.getClass();
        if (clazz != null && clazz.getName().contains(CGLIB_CLASS_SEPARATOR)) {
            Class<?> superClass = clazz.getSuperclass();
            if (superClass != null && !Object.class.equals(superClass)) {
                return superClass;
            }
        }
        return clazz;

    }

    /**
     * 将反射时的checked exception转换为unchecked exception.
     */
    public static RuntimeException convertReflectionExceptionToUnchecked(Exception e) {
        if (e instanceof IllegalAccessException || e instanceof IllegalArgumentException
                || e instanceof NoSuchMethodException) {
            return new IllegalArgumentException(e);
        } else if (e instanceof InvocationTargetException) {
            return new RuntimeException(((InvocationTargetException) e).getTargetException());
        } else if (e instanceof RuntimeException) {
            return (RuntimeException) e;
        }
        return new RuntimeException("Unexpected Checked Exception.", e);
    }

    /**
     * 获取对象属性所包含的指定注解（含get方法）
     *
     * @param cls
     * @param pName
     * @param annotationClass
     * @return
     */
    public static <T extends Annotation> T getAnnotationByClazz(Class<?> cls, String pName, Class<T> annotationClass) {
        try {
            Object obj = cls.newInstance();
            return getAnnotation(obj, pName, annotationClass);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return null;
    }

    /**
     * 获取对象属性所包含的指定注解（含get方法）
     *
     * @param obj
     * @param pName
     * @param annotationClass
     * @return
     */
    public static <T extends Annotation> T getAnnotation(Object obj, String pName, Class<T> annotationClass) {
        if (annotationClass == null || obj == null)
            throw new NullPointerException();
        T an = null;
        Class<?> temp = obj.getClass();
        while (an == null && checkClassIsBase(temp.toString())) {
            try {
                an = temp.getDeclaredField(pName).getAnnotation(annotationClass);
            } catch (Exception e) {
                // logger.debug(e.getMessage());
            }
            try {
                if (an == null)
                    an = temp.getDeclaredMethod(PublicUtil.toAppendStr(GETTER_PREFIX, StringUtil.capitalize(pName)))
                            .getAnnotation(annotationClass);
            } catch (Exception e) {
                // logger.debug(e.getMessage());
            }
            temp = temp.getSuperclass();
        }
        return an;
    }

    /**
     * 创建对象，注入指定属性值
     *
     * @param cls
     * @param fields
     * @param value
     * @param <T>
     * @return
     */
    @SuppressWarnings("unchecked")
    public static <T> T createObj(Class<T> cls, List<String> fields, Object... value) {
        Object obj = null;
        try {
            obj = updateObj(cls.newInstance(), fields, value);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (T) obj;
    }

    /**
     * 更新对象，注入指定属性值
     *
     * @param obj
     * @param fields
     * @param value
     * @return
     */
    @SuppressWarnings("unchecked")
    public static <T> T updateObj(Object obj, List<String> fields, Object... value) {
        try {
            if (obj != null) {
                if (PublicUtil.isNotEmpty(fields) && PublicUtil.isNotEmpty(value) && value.length == fields.size()) {
                    for (int i = 0; i < fields.size(); i++) {
                        setFieldValue(obj, fields.get(i), value[i]);
                    }
                } else {
                    logger.warn("obj {} fields {} value {}", obj, fields, value);
                }
            } else {
                logger.warn("obj is null");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (T) obj;
    }

    /**
     * 获取对象属性所包含的指定注解（含get方法）
     *
     * @param objClass
     * @param pName
     * @param annotationClass
     * @return
     */
    public static <T extends Annotation> T getClassAnnotation(Class<?> objClass, String pName,
                                                              Class<T> annotationClass) {
        if (annotationClass == null || objClass == null)
            throw new NullPointerException();
        T an = null;
        Class<?> temp = objClass;
        while (an == null && !temp.toString().contains("java.lang.Object")) {
            try {
                an = temp.getDeclaredField(pName).getAnnotation(annotationClass);
            } catch (Exception e) {
                // logger.debug(e.getMessage());
            }
            try {
                if (an == null)
                    an = temp.getDeclaredMethod(PublicUtil.toAppendStr(GETTER_PREFIX, StringUtil.capitalize(pName)))
                            .getAnnotation(annotationClass);
            } catch (Exception e) {
                // logger.debug(e.getMessage());
            }
            temp = temp.getSuperclass();
        }
        return an;
    }

    /**
     * 获取方法的参数名称
     *
     * @param className
     * @param methodName
     * @return
     */
    public static List<String> getMethodParameterList(String className, String methodName) {
        try {
            ClassPool pool = ClassPool.getDefault();
            ClassClassPath classPath = new ClassClassPath(Reflections.class);
            pool.insertClassPath(classPath);
            CtClass cc = pool.get(className);
            CtMethod cm = cc.getDeclaredMethod(methodName);
            // 使用javaassist的反射方法获取方法的参数名
            MethodInfo methodInfo = cm.getMethodInfo();
            CodeAttribute codeAttribute = methodInfo.getCodeAttribute();
            LocalVariableAttribute attr = (LocalVariableAttribute) codeAttribute
                    .getAttribute(LocalVariableAttribute.tag);
            if (attr == null) {
                // exception
            }
            String[] paramNames = new String[cm.getParameterTypes().length];
            int pos = Modifier.isStatic(cm.getModifiers()) ? 0 : 1;
            for (int i = 0; i < paramNames.length; i++) {
                paramNames[i] = attr.variableName(i + pos);
                System.out.println(attr.getName());
            }
            List<String> rs = Lists.newArrayList(paramNames);
            return rs;
        } catch (NotFoundException e) {
            logger.error(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    /**
     * 获取方法的参数名称
     *
     * @param clazz
     * @param methodName
     * @return
     */
    public static List<String> getMethodParameterList(Class<?> clazz, String methodName) {
        return getMethodParameterList(clazz.getName(), methodName);
    }

    /**
     * 获取方法的参数名称和类型
     *
     * @param clazz
     * @param methodName
     * @return
     */
    public static List<Map<String, Object>> getMethodParameter(Class<?> clazz, String methodName) {
        return getMethodParameter(clazz.getName(), methodName);
    }

    /**
     * 获取方法的参数名称和类型
     *
     * @param className
     * @param methodName
     * @return
     */
    public static List<Map<String, Object>> getMethodParameter(String className, String methodName) {
        try {
            List<Map<String, Object>> rs = Lists.newArrayList();
            ClassPool pool = ClassPool.getDefault();
            ClassClassPath classPath = new ClassClassPath(Reflections.class);
            pool.insertClassPath(classPath);
            CtClass cc = pool.get(className);
            CtMethod cm = cc.getDeclaredMethod(methodName);
            // 使用javaassist的反射方法获取方法的参数名
            MethodInfo methodInfo = cm.getMethodInfo();
            CodeAttribute codeAttribute = methodInfo.getCodeAttribute();
            LocalVariableAttribute attr = (LocalVariableAttribute) codeAttribute
                    .getAttribute(LocalVariableAttribute.tag);
            if (attr == null) {
                // exception
            }
            Class clazz = Class.forName(className);
            Method[] methods = clazz.getDeclaredMethods();
            Class[] params = null;
            for (Method method : methods) {
                if (method.getName().equals(methodName)
                        && method.getParameterTypes().length == cm.getParameterTypes().length) {
                    params = method.getParameterTypes();
                }
            }
            if (params != null) {
                String[] paramNames = new String[cm.getParameterTypes().length];
                int pos = Modifier.isStatic(cm.getModifiers()) ? 0 : 1;
                Map<String, Object> map = null;
                for (int i = 0; i < paramNames.length; i++) {
                    map = Maps.newHashMap();
                    map.put("name", attr.variableName(i + pos));
                    map.put("type", params[i]);
                    rs.add(map);
                }
            }
            return rs;
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    /**
     * 是否为基础类型 @Title: isWrapClass @Description:
     *
     * @param clz
     * @return 设定文件
     * boolean 返回类型 @throws
     */
    public static boolean isWrapClass(Class clz) {
        try {
            return ((Class) clz.getField("TYPE").get(null)).isPrimitive();
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 可获取spring动态代理对象class
     *
     * @param candidate
     * @return
     */
    public static Class getTargetClass(Object candidate) {
        if (!org.springframework.aop.support.AopUtils.isJdkDynamicProxy(candidate)) {
            return org.springframework.aop.support.AopUtils.getTargetClass(candidate);
        }

        return getTargetClassFromJdkDynamicAopProxy(candidate);
    }

    private static Class getTargetClassFromJdkDynamicAopProxy(Object candidate) {
        try {
            InvocationHandler invocationHandler = Proxy.getInvocationHandler(candidate);
            if (!invocationHandler.getClass().getName().equals(CLASS_JDK_DYNAMIC_AOP_PROXY)) {
                // 在目前的spring版本，这处永远不会执行，除非以后spring的dynamic proxy实现变掉
                logger.warn("the invocationHandler of JdkDynamicProxy isn`t the instance of {}",
                        CLASS_JDK_DYNAMIC_AOP_PROXY);
                return candidate.getClass();
            }
            AdvisedSupport advised = (AdvisedSupport) new DirectFieldAccessor(invocationHandler)
                    .getPropertyValue(ADVISED_FIELD_NAME);
            Class targetClass = advised.getTargetClass();
            if (Proxy.isProxyClass(targetClass)) {
                // 目标类还是代理，递归
                Object target = advised.getTargetSource().getTarget();
                return getTargetClassFromJdkDynamicAopProxy(target);
            }
            return targetClass;
        } catch (Exception e) {
            logger.info("get target class from {}", CLASS_JDK_DYNAMIC_AOP_PROXY, e);
            return candidate.getClass();
        }
    }

    public static PropertyDescriptor[] getPropertiesDescriptor(Object obj) {
        return getPropertiesDescriptor(obj, Object.class);
    }

    /**
     * 内省class
     *
     * @param obj   内省对象
     * @param clazz 内省最高层级
     * @return
     */
    public static PropertyDescriptor[] getPropertiesDescriptor(Object obj,
                                                               Class<?> clazz) {
        BeanInfo beanInfo = null;
        Class<?> objClass = null;
        if (obj instanceof Class<?>) {
            objClass = (Class<?>) obj;
        } else {
            objClass = obj.getClass();
        }
        try {
            beanInfo = Introspector.getBeanInfo(objClass, clazz);
        } catch (IntrospectionException e) {
            e.printStackTrace();
        }
        return beanInfo.getPropertyDescriptors();
    }

    public static Object getFieldValue(Object obj, Field field) {
        field.setAccessible(true);
        Object value = null;
        try {
            value = field.get(obj);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return value;
    }

    /**
     * 获取字段泛型
     *
     * @param field 指定字段
     * @param index 第几个泛型
     * @return
     */
    public static Class<?> getGenericClass(Field field, int index) {
        Type type = field.getGenericType();
        if (type instanceof ParameterizedType) {
            ParameterizedType parameterizedType = (ParameterizedType) type;
            Type[] types = parameterizedType.getActualTypeArguments();
            return (Class<?>) types[index];
        }
        return null;
    }

    /**
     * 在目标clazz中获取类型为fieldClass的字段
     *
     * @param clazz
     * @param fieldClass
     * @return
     * @throws NoSuchFieldException
     */
    public static Field[] getDeclaredFieldByType(Class<?> clazz,
                                                 Class<?> fieldClass) throws NoSuchFieldException {
        Field[] fields = clazz.getDeclaredFields();
        List<Field> listResult = new ArrayList<Field>();
        for (Field field : fields) {
            if (fieldClass.isAssignableFrom(field.getClass())) {
                listResult.add(field);
            }
        }
        if (listResult == null || listResult.size() == 0) {
            throw new NoSuchFieldException();
        } else {
            Field[] rt = new Field[listResult.size()];
            return listResult.toArray(rt);
        }
    }

    /**
     * 在目标clazz中获取类型为fieldClass<E extent genericeType>的字段
     *
     * @param clazz
     * @param fieldClass
     * @param genericType
     * @return
     * @throws NoSuchFieldException
     */
    public static Field[] getDeclaredFieldByType(Class<?> clazz,
                                                 Class<?> fieldClass, Class<?> genericType)
            throws NoSuchFieldException {
        Field[] fields = clazz.getDeclaredFields();
        List<Field> listResult = new ArrayList<Field>();
        for (Field field : fields) {
            if (fieldClass.isAssignableFrom(field.getType())) {
                Type type = field.getGenericType();
                if (type instanceof ParameterizedType) {
                    ParameterizedType parameterizedType = (ParameterizedType) type;
                    Class<?> genericClass = (Class<?>) parameterizedType
                            .getActualTypeArguments()[0];
                    if (genericClass == genericType) {
                        listResult.add(field);
                    }
                }
            }
        }
        if (listResult == null || listResult.size() == 0) {
            throw new NoSuchFieldException();
        } else {
            Field[] rt = new Field[listResult.size()];
            return listResult.toArray(rt);
        }
    }

    /**
     * 获取class上的注解
     *
     * @param clazz
     * @param annotationClass
     * @return
     */
    public static <T extends Annotation> T getAnnotation(Class<?> clazz,
                                                         Class<T> annotationClass) {
        return clazz.getAnnotation(annotationClass);
    }

    public static boolean hasAnnotation(Class<?> clazz,
                                        Class<? extends Annotation> annotationClass) {
        return clazz.isAnnotationPresent(annotationClass);
    }

    /**
     * Attempt to find a {@link Method} on the supplied class with the supplied
     * name and no parameters. Searches all superclasses up to {@code Object}.
     * <p>
     * Returns {@code null} if no {@link Method} can be found.
     *
     * @param clazz the class to introspect
     * @param name  the name of the method
     * @return the Method object, or {@code null} if none found
     */
    public static Method getMethod(Class<?> clazz, String name) {
        return getMethod(clazz, name, new Class<?>[0]);
    }

    /**
     * Attempt to find a {@link Method} on the supplied class with the supplied
     * name and parameter types. Searches all superclasses up to {@code Object}.
     * <p>
     * Returns {@code null} if no {@link Method} can be found.
     *
     * @param clazz      the class to introspect
     * @param name       the name of the method
     * @param paramTypes the parameter types of the method (may be {@code null} to
     *                   indicate any signature)
     * @return the Method object, or {@code null} if none found
     */
    public static Method getMethod(Class<?> clazz, String name,
                                   Class<?>... paramTypes) {
        Assert.notNull(clazz, "Class must not be null");
        Assert.notNull(name, "Method name must not be null");
        Class<?> searchType = clazz;
        while (searchType != null) {
            Method[] methods = (searchType.isInterface() ? searchType
                    .getMethods() : searchType.getDeclaredMethods());
            for (Method method : methods) {
                if (name.equals(method.getName())
                        && (paramTypes == null || Arrays.equals(paramTypes,
                        method.getParameterTypes()))) {
                    return method;
                }
            }
            searchType = searchType.getSuperclass();
        }
        return null;
    }


    /**
     * Invoke the specified {@link Method} against the supplied target object
     * with the supplied arguments. The target object can be {@code null} when
     * invoking a static {@link Method}.
     * <p>
     * Thrown exceptions are handled via a call to
     * {@link #handleReflectionException}.
     *
     * @param method the method to invoke
     * @param target the target object to invoke the method on
     * @param args   the invocation arguments (may be {@code null})
     * @return the invocation result, if any
     */
    public static Object invokeMethod(Method method, Object target,
                                      Object... args) {
        try {
            return method.invoke(target, args);
        } catch (Exception ex) {
            handleReflectionException(ex);
        }
        throw new IllegalStateException("Should never get here");
    }

    /**
     * Handle the given reflection exception. Should only be called if no
     * checked exception is expected to be thrown by the target method.
     * <p>
     * Throws the underlying RuntimeException or Error in case of an
     * InvocationTargetException with such a root cause. Throws an
     * IllegalStateException with an appropriate message else.
     *
     * @param ex the reflection exception to handle
     */
    public static void handleReflectionException(Exception ex) {
        if (ex instanceof NoSuchMethodException) {
            throw new IllegalStateException("没有找到指定名称的method: "
                    + ex.getMessage());
        }
        if (ex instanceof IllegalAccessException) {
            throw new IllegalStateException("无权访问指定的method: " + ex.getMessage());
        }
        if (ex instanceof InvocationTargetException) {
            handleInvocationTargetException((InvocationTargetException) ex);
        }
        if (ex instanceof RuntimeException) {
            throw (RuntimeException) ex;
        }
        throw new UndeclaredThrowableException(ex);
    }

    public static void handleInvocationTargetException(
            InvocationTargetException ex) {
        rethrowRuntimeException(ex.getTargetException());
    }

    /**
     * Rethrow the given {@link Throwable exception}, which is presumably the
     * <em>target exception</em> of an {@link InvocationTargetException}. Should
     * only be called if no checked exception is expected to be thrown by the
     * target method.
     * <p>
     * Rethrows the underlying exception cast to an {@link RuntimeException} or
     * {@link Error} if appropriate; otherwise, throws an
     * {@link IllegalStateException}.
     *
     * @param ex the exception to rethrow
     * @throws RuntimeException the rethrown exception
     */
    public static void rethrowRuntimeException(Throwable ex) {
        if (ex instanceof RuntimeException) {
            throw (RuntimeException) ex;
        }
        if (ex instanceof Error) {
            throw (Error) ex;
        }
        throw new UndeclaredThrowableException(ex);
    }

    // Bean --> Map 1: 利用Introspector和PropertyDescriptor 将Bean --> Map
    public static Map<String, ? extends Object> bean2Map(Object obj) {

        if (obj == null) {
            return null;
        }
        Map<String, Object> map = new HashMap<>();
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();

                // 过滤class属性
                if (!key.equals("class")) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    Object value = getter.invoke(obj);

                    map.put(key, value);
                }

            }
        } catch (Exception e) {
            logger.error("=============Bean转Map异常================{}", e);
        }
        return map;
    }

    // Map --> Bean 1: 利用Introspector,PropertyDescriptor实现 Map --> Bean
    public static void map2Bean(Map<String, Object> map, Object obj) {

        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();

            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();

                if (map.containsKey(key)) {
                    Object value = map.get(key);
                    if (value != null) {
                        value = ConvertUtils.convert(value, property.getPropertyType());//类型转换,引用类型需要在监听器里面注册转换
                    }
                    // 得到property对应的setter方法
                    Method setter = property.getWriteMethod();
                    setter.invoke(obj, value);
                }
            }
        } catch (Exception e) {
            logger.error("=============Map转Bean异常================{}", e);
        }
        return;
    }

    public static void main(String[] args) {
        System.out.println(getMethodParameter("com.albedo.java.modules.sys.controller.AreaController", "findTreeData"));
    }

}
