package com.albedo.java.plugins.database.mybatis.conditions;


import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.plugins.database.mybatis.conditions.query.LbqWrapper;
import com.albedo.java.plugins.database.mybatis.conditions.query.QueryWrap;
import com.albedo.java.plugins.database.mybatis.conditions.update.LbuWrapper;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Map;


/**
 * Wrappers 工具类， 该方法的主要目的是为了 缩短代码长度
 *
 * @author zuihou
 * @date 2019/06/14
 */
public final class Wraps {
    /** 开始时间 */
    public static final String ST = "_st";
    /** 结束时间 */
    public static final String ED = "_ed";
    /** 等于 */
    public static final String EQ = "_eq";
    /** 不等于 */
    public static final String NE = "_ne";
    /** 大于等于 */
    public static final String GE = "_ge";
    /** 大于 */
    public static final String GT = "_gt";
    /** 小于 */
    public static final String LT = "_lt";
    /** 小于等于 */
    public static final String LE = "_le";
    /** 模糊 */
    public static final String LIKE = "_like";
    /** 左模糊 */
    public static final String LIKE_LEFT = "_likeLeft";
    /** 右模糊 */
    public static final String LIKE_RIGHT = "_likeRight";

    private Wraps() {
        // ignore
    }

    /**
     * 获取 QueryWrap&lt;T&gt;
     *
     * @param <T> 实体类泛型
     * @return QueryWrapper&lt;T&gt;
     */
    public static <T> QueryWrap<T> q() {
        return new QueryWrap<>();
    }

    /**
     * 获取 QueryWrap&lt;T&gt;
     *
     * @param entity 实体类
     * @param <T>    实体类泛型
     * @return QueryWrapper&lt;T&gt;
     */
    public static <T> QueryWrap<T> q(T entity) {
        return new QueryWrap<>(entity);
    }

    /**
     * 获取 HyLambdaQueryWrapper&lt;T&gt;
     *
     * @param <T> 实体类泛型
     * @return LambdaQueryWrapper&lt;T&gt;
     */
    public static <T> LbqWrapper<T> lbQ() {
        return new LbqWrapper<>();
    }

    /**
     * 获取 HyLambdaQueryWrapper&lt;T&gt;
     *
     * @param entity 实体类
     * @param <T>    实体类泛型
     * @return LambdaQueryWrapper&lt;T&gt;
     */
    public static <T> LbqWrapper<T> lbQ(T entity) {
        return new LbqWrapper<>(entity);
    }

    /**
     * 获取 HyLambdaQueryWrapper&lt;T&gt;
     *
     * @param <T> 实体类泛型
     * @return LambdaUpdateWrapper&lt;T&gt;
     */
    public static <T> LbuWrapper<T> lbU() {
        return new LbuWrapper<>();
    }

    /**
     * 获取 HyLambdaQueryWrapper&lt;T&gt;
     *
     * @param entity 实体类
     * @param <T>    实体类泛型
     * @return LambdaUpdateWrapper&lt;T&gt;
     */
    public static <T> LbuWrapper<T> lbU(T entity) {
        return new LbuWrapper<>(entity);
    }


    public static <Entity> LbqWrapper<Entity> lbq(Entity model, Map<String, Object> extra, Class<Entity> modelClazz) {
        return q(model, extra, modelClazz).lambda();
    }

    /**
     * 构建查询条件
     * 1. 若model不为空，则将model中不为空的参数拼接到sql中；
     * 2. 若extra中有 _st、_ed、_ge、_gt、_le、_lt、_eq、_ne、_like、_likeLeft、_likeRigth 等结尾的参数，在sql中拼接为相应的查询条件
     *
     * @param model      model 条件对象实例
     * @param extra      extra 扩展参数
     * @param modelClazz modelClazz 条件对象类型
     * @return top.tangyh.basic.database.mybatis.conditions.query.QueryWrap<Entity>
     * @author zuihou
     * @date 2021/8/26 8:47 下午
     * @create [2021/8/26 8:47 下午 ] [tangyh] [初始创建]
     */
    public static <Entity> QueryWrap<Entity> q(Entity model, Map<String, Object> extra, Class<Entity> modelClazz) {
        QueryWrap<Entity> wrapper = model != null ? Wraps.q(model) : Wraps.q();

        if (MapUtil.isNotEmpty(extra)) {
            //拼装区间
            for (Map.Entry<String, Object> field : extra.entrySet()) {
                String key = field.getKey();
                Object value = field.getValue();
                if (ObjectUtil.isEmpty(value)) {
                    continue;
                }
                if (key.endsWith(ST)) {
                    String beanField = StrUtil.subBefore(key, ST, true);
                    wrapper.ge(getDbField(beanField, modelClazz), DateUtil.getStartTime(value.toString()));
                } else if (key.endsWith(ED)) {
                    String beanField = StrUtil.subBefore(key, ED, true);
                    wrapper.le(getDbField(beanField, modelClazz), DateUtil.getEndTime(value.toString()));
                } else if (key.endsWith(GE)) {
                    String beanField = StrUtil.subBefore(key, GE, true);
                    wrapper.ge(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(GT)) {
                    String beanField = StrUtil.subBefore(key, GT, true);
                    wrapper.gt(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(LT)) {
                    String beanField = StrUtil.subBefore(key, LT, true);
                    wrapper.lt(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(LE)) {
                    String beanField = StrUtil.subBefore(key, LE, true);
                    wrapper.le(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(NE)) {
                    String beanField = StrUtil.subBefore(key, NE, true);
                    wrapper.ne(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(EQ)) {
                    String beanField = StrUtil.subBefore(key, EQ, true);
                    wrapper.eq(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(LIKE)) {
                    String beanField = StrUtil.subBefore(key, LIKE, true);
                    wrapper.like(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(LIKE_LEFT)) {
                    String beanField = StrUtil.subBefore(key, LIKE_LEFT, true);
                    wrapper.likeLeft(getDbField(beanField, modelClazz), value);
                } else if (key.endsWith(LIKE_RIGHT)) {
                    String beanField = StrUtil.subBefore(key, LIKE_RIGHT, true);
                    wrapper.likeRight(getDbField(beanField, modelClazz), value);
                }
            }
        }
        return wrapper;
    }

    /**
     * 根据 bean字段 反射出 数据库字段
     *
     * @param beanField 字段
     * @param clazz     类型
     * @return 数据库字段名
     */
    public static String getDbField(String beanField, Class<?> clazz) {
        ArgumentAssert.notNull(clazz, "实体类不能为空");
        ArgumentAssert.notEmpty(beanField, "字段名不能为空");
        Field field = ReflectUtil.getField(clazz, beanField);
        ArgumentAssert.notNull(field, "在类：{}中找不到属性：{}", clazz.getSimpleName(), beanField);

        TableField tf = field.getAnnotation(TableField.class);
        if (tf != null && StrUtil.isNotEmpty(tf.value())) {
            return tf.value();
        }
        TableId ti = field.getAnnotation(TableId.class);
        if (ti != null && StrUtil.isNotEmpty(ti.value())) {
            return ti.value();
        }
        throw BizException.wrap("{}.{} 未标记 @TableField 或 @TableId", clazz.getSimpleName(), beanField);
    }


    /**
     * 替换 实体对象中类型为String 类型的参数，并将% 和 _ 符号转义
     *
     * @param source 源对象
     * @return 最新源对象
     */
    public static <T> T replace(Object source) {
        if (source == null) {
            return null;
        }
        Object target = source;

        Class<?> srcClass = source.getClass();
        Field[] fields = ReflectUtil.getFields(srcClass);
        for (Field field : fields) {
            Object classValue = ReflectUtil.getFieldValue(source, field);
            if (classValue == null) {
                continue;
            }
            //final 和 static 字段跳过
            if (Modifier.isFinal(field.getModifiers()) || Modifier.isStatic(field.getModifiers())) {
                continue;
            }


            if (!(classValue instanceof String)) {
                continue;
            }
            String srcValue = (String) classValue;
            if (srcValue.contains(StrPool.PERCENT) || srcValue.contains(StrPool.UNDERSCORE)) {
                String tarValue = StringUtil.keywordConvert(srcValue);
                ReflectUtil.setFieldValue(target, field, tarValue);
            }
        }
        return (T) target;
    }


}
